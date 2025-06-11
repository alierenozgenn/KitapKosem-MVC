package com.kitapkosem.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kitapkosem.dao.BookDAO;
import com.kitapkosem.dao.CategoryDAO;
import com.kitapkosem.dao.ReviewDAO;
import com.kitapkosem.model.Book;
import com.kitapkosem.model.Category;
import com.kitapkosem.model.Review;
import com.kitapkosem.model.User;

@WebServlet("/book/*")
public class BookController extends HttpServlet {
    private BookDAO bookDAO;
    private CategoryDAO categoryDAO;
    private ReviewDAO reviewDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
        categoryDAO = new CategoryDAO();
        reviewDAO = new ReviewDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            listBooks(request, response);
            return;
        }
        
        if (pathInfo.equals("/add")) {
            showAddBookPage(request, response);
        } else if (pathInfo.startsWith("/detail/")) {
            showBookDetail(request, response);
        } else if (pathInfo.equals("/search")) {
            searchBooks(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        if (pathInfo.equals("/add")) {
            handleAddBook(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    private void listBooks(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String categoryParam = request.getParameter("category");
        List<Book> books;
        
        if (categoryParam != null && !categoryParam.trim().isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryParam);
                books = bookDAO.getBooksByCategory(categoryId);
            } catch (NumberFormatException e) {
                books = bookDAO.getAllBooks();
            }
        } else {
            books = bookDAO.getAllBooks();
        }
        
        List<Category> categories = categoryDAO.getAllCategories();
        
        request.setAttribute("books", books);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/views/book-list.jsp").forward(request, response);
    }
    
    private void searchBooks(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String searchTerm = request.getParameter("q");
        List<Book> books;
        
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            books = bookDAO.searchBooks(searchTerm.trim());
        } else {
            books = bookDAO.getAllBooks();
        }
        
        List<Category> categories = categoryDAO.getAllCategories();
        
        request.setAttribute("books", books);
        request.setAttribute("categories", categories);
        request.setAttribute("searchTerm", searchTerm);
        request.getRequestDispatcher("/WEB-INF/views/book-list.jsp").forward(request, response);
    }
    
    private void showBookDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        String bookIdStr = pathInfo.substring("/detail/".length());
        
        try {
            int bookId = Integer.parseInt(bookIdStr);
            Book book = bookDAO.findById(bookId);
            
            if (book == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            
            List<Review> reviews = reviewDAO.getReviewsByBook(bookId);
            
            // Kullanıcının bu kitaba yorum yapıp yapmadığını kontrol et
            HttpSession session = request.getSession(false);
            boolean canReview = false;
            if (session != null && session.getAttribute("userId") != null) {
                int userId = (Integer) session.getAttribute("userId");
                canReview = !reviewDAO.hasUserReviewedBook(userId, bookId);
            }
            
            request.setAttribute("book", book);
            request.setAttribute("reviews", reviews);
            request.setAttribute("canReview", canReview);
            request.getRequestDispatcher("/WEB-INF/views/book-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    
    private void showAddBookPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Giriş kontrolü
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
        
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/views/add-book.jsp").forward(request, response);
    }
    
    private void handleAddBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Giriş kontrolü
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
        
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String description = request.getParameter("description");
        String categoryIdStr = request.getParameter("categoryId");
        
        // Validation
        if (title == null || title.trim().isEmpty() ||
            author == null || author.trim().isEmpty() ||
            description == null || description.trim().isEmpty() ||
            categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            
            request.setAttribute("error", "Tüm alanlar gereklidir.");
            showAddBookPage(request, response);
            return;
        }
        
        try {
            int categoryId = Integer.parseInt(categoryIdStr);
            User user = (User) session.getAttribute("user");
            
            Book newBook = new Book();
            newBook.setTitle(title.trim());
            newBook.setAuthor(author.trim());
            newBook.setDescription(description.trim());
            newBook.setCategoryId(categoryId);
            newBook.setAddedBy(user.getId());
            
            if (bookDAO.createBook(newBook)) {
                // Başarılı ekleme
                response.sendRedirect(request.getContextPath() + "/book/detail/" + newBook.getId());
            } else {
                // Ekleme hatası
                request.setAttribute("error", "Kitap eklenirken bir hata oluştu.");
                showAddBookPage(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Geçersiz kategori seçimi.");
            showAddBookPage(request, response);
        }
    }
}

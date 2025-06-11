package com.kitapkosem.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kitapkosem.dao.BookDAO;
import com.kitapkosem.dao.CategoryDAO;
import com.kitapkosem.model.Book;
import com.kitapkosem.model.Category;

@WebServlet("")
public class HomeController extends HttpServlet {
    private BookDAO bookDAO;
    private CategoryDAO categoryDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
        categoryDAO = new CategoryDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // En son eklenen kitapları getir
        List<Book> recentBooks = bookDAO.getAllBooks();
        
        // Kategorileri getir
        List<Category> categories = categoryDAO.getAllCategories();
        
        request.setAttribute("books", recentBooks);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}

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
import com.kitapkosem.dao.ReviewDAO;
import com.kitapkosem.model.Review;
import com.kitapkosem.model.User;

@WebServlet("/review/*")
public class ReviewController extends HttpServlet {
    private ReviewDAO reviewDAO;
    private BookDAO bookDAO;
    
    @Override
    public void init() throws ServletException {
        reviewDAO = new ReviewDAO();
        bookDAO = new BookDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Kullanıcının yorumlarını listele
            showUserReviews(request, response);
            return;
        }
        
        if (pathInfo.startsWith("/delete/")) {
            handleDeleteReview(request, response);
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
            handleAddReview(request, response);
        } else if (pathInfo.startsWith("/delete/")) {
            handleDeleteReview(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    private void handleAddReview(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Giriş kontrolü
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
        
        String bookIdStr = request.getParameter("bookId");
        String ratingStr = request.getParameter("rating");
        String comment = request.getParameter("comment");
        
        // Validation
        if (bookIdStr == null || bookIdStr.trim().isEmpty() ||
            ratingStr == null || ratingStr.trim().isEmpty() ||
            comment == null || comment.trim().isEmpty()) {
            
            request.setAttribute("error", "Tüm alanlar gereklidir.");
            response.sendRedirect(request.getContextPath() + "/book/detail/" + bookIdStr + "?error=missing_fields");
            return;
        }
        
        try {
            int bookId = Integer.parseInt(bookIdStr);
            int rating = Integer.parseInt(ratingStr);
            User user = (User) session.getAttribute("user");
            
            // Rating validation
            if (rating < 1 || rating > 5) {
                response.sendRedirect(request.getContextPath() + "/book/detail/" + bookId + "?error=invalid_rating");
                return;
            }
            
            // Comment validation
            if (comment.trim().length() < 10) {
                response.sendRedirect(request.getContextPath() + "/book/detail/" + bookId + "?error=short_comment");
                return;
            }
            
            // Kitabın var olup olmadığını kontrol et
            if (bookDAO.findById(bookId) == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            
            // Kullanıcının daha önce yorum yapıp yapmadığını kontrol et
            if (reviewDAO.hasUserReviewedBook(user.getId(), bookId)) {
                response.sendRedirect(request.getContextPath() + "/book/detail/" + bookId + "?error=already_reviewed");
                return;
            }
            
            // Yeni yorum oluştur
            Review newReview = new Review();
            newReview.setBookId(bookId);
            newReview.setUserId(user.getId());
            newReview.setComment(comment.trim());
            newReview.setRating(rating);
            
            if (reviewDAO.createReview(newReview)) {
                // Başarılı ekleme
                System.out.println("✅ Yeni yorum eklendi: Kullanıcı=" + user.getUsername() + ", Kitap ID=" + bookId + ", Puan=" + rating);
                response.sendRedirect(request.getContextPath() + "/book/detail/" + bookId + "?success=review_added");
            } else {
                // Ekleme hatası
                response.sendRedirect(request.getContextPath() + "/book/detail/" + bookId + "?error=review_failed");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/book/detail/" + bookIdStr + "?error=invalid_data");
        }
    }
    
    private void handleDeleteReview(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Giriş kontrolü
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
        
        String pathInfo = request.getPathInfo();
        String reviewIdStr = pathInfo.substring("/delete/".length());
        
        try {
            int reviewId = Integer.parseInt(reviewIdStr);
            User user = (User) session.getAttribute("user");
            
            if (reviewDAO.deleteReview(reviewId, user.getId())) {
                // Başarılı silme
                System.out.println("✅ Yorum silindi: ID=" + reviewId + ", Kullanıcı=" + user.getUsername());
                response.sendRedirect(request.getContextPath() + "/user/profile?success=review_deleted#reviews");
            } else {
                // Silme hatası (yorum bulunamadı veya kullanıcı yetkisiz)
                response.sendRedirect(request.getContextPath() + "/user/profile?error=delete_failed#reviews");
            }
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    
    private void showUserReviews(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Giriş kontrolü
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        List<Review> userReviews = reviewDAO.getReviewsByUser(user.getId());
        
        request.setAttribute("reviews", userReviews);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/views/user-reviews.jsp").forward(request, response);
    }
}

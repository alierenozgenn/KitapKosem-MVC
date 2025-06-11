package com.kitapkosem.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.kitapkosem.model.Review;
import com.kitapkosem.util.DatabaseConnection;

public class ReviewDAO {
    
    // Yorum ekleme
    public boolean createReview(Review review) {
        String sql = "INSERT INTO reviews (book_id, user_id, comment, rating) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, review.getBookId());
            stmt.setInt(2, review.getUserId());
            stmt.setString(3, review.getComment());
            stmt.setInt(4, review.getRating());
            
            int result = stmt.executeUpdate();
            
            if (result > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        review.setId(generatedKeys.getInt(1));
                    }
                }
                System.out.println("✅ Yorum başarıyla eklendi: Kitap ID=" + review.getBookId());
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Yorum ekleme hatası: " + e.getMessage());
        }
        return false;
    }
    
    // Kitaba ait yorumları listele
    public List<Review> getReviewsByBook(int bookId) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.id, r.book_id, b.title as book_title, b.author as book_author, " +
                     "r.user_id, u.username, r.comment, r.rating, r.created_at " +
                     "FROM reviews r " +
                     "JOIN books b ON r.book_id = b.id " +
                     "JOIN users u ON r.user_id = u.id " +
                     "WHERE r.book_id = ? " +
                     "ORDER BY r.created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, bookId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setId(rs.getInt("id"));
                    review.setBookId(rs.getInt("book_id"));
                    review.setBookTitle(rs.getString("book_title"));
                    review.setBookAuthor(rs.getString("book_author"));
                    review.setUserId(rs.getInt("user_id"));
                    review.setUsername(rs.getString("username"));
                    review.setComment(rs.getString("comment"));
                    review.setRating(rs.getInt("rating"));
                    review.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    reviews.add(review);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Kitap yorumları listeleme hatası: " + e.getMessage());
        }
        return reviews;
    }
    
    // Kullanıcının yorumlarını listele
    public List<Review> getReviewsByUser(int userId) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.id, r.book_id, b.title as book_title, b.author as book_author, " +
                     "r.user_id, u.username, r.comment, r.rating, r.created_at " +
                     "FROM reviews r " +
                     "JOIN books b ON r.book_id = b.id " +
                     "JOIN users u ON r.user_id = u.id " +
                     "WHERE r.user_id = ? " +
                     "ORDER BY r.created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setId(rs.getInt("id"));
                    review.setBookId(rs.getInt("book_id"));
                    review.setBookTitle(rs.getString("book_title"));
                    review.setBookAuthor(rs.getString("book_author"));
                    review.setUserId(rs.getInt("user_id"));
                    review.setUsername(rs.getString("username"));
                    review.setComment(rs.getString("comment"));
                    review.setRating(rs.getInt("rating"));
                    review.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    reviews.add(review);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Kullanıcı yorumları listeleme hatası: " + e.getMessage());
        }
        return reviews;
    }
    
    // Yorum silme (kullanıcı kendi yorumunu silebilir)
    public boolean deleteReview(int reviewId, int userId) {
        String sql = "DELETE FROM reviews WHERE id = ? AND user_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, reviewId);
            stmt.setInt(2, userId);
            
            int result = stmt.executeUpdate();
            
            if (result > 0) {
                System.out.println("✅ Yorum başarıyla silindi: ID=" + reviewId);
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Yorum silme hatası: " + e.getMessage());
        }
        return false;
    }
    
    // Kullanıcının belirli bir kitaba yorum yapıp yapmadığını kontrol et
    public boolean hasUserReviewedBook(int userId, int bookId) {
        String sql = "SELECT COUNT(*) FROM reviews WHERE user_id = ? AND book_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, bookId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Yorum kontrol hatası: " + e.getMessage());
        }
        return false;
    }
    
    // Test metodu
    public static void main(String[] args) {
        ReviewDAO reviewDAO = new ReviewDAO();
        
        System.out.println("🔄 ReviewDAO test ediliyor...");
        
        // Kitap 1'in yorumlarını listele
        List<Review> bookReviews = reviewDAO.getReviewsByBook(1);
        System.out.println("📝 Kitap 1 için yorum sayısı: " + bookReviews.size());
        
        for (Review review : bookReviews) {
            System.out.println("👤 " + review.getUsername() + " | ⭐ " + review.getRating() + 
                              " | 💬 " + review.getComment());
        }
        
        // Kullanıcı 2'nin yorumlarını listele
        System.out.println("\n👤 Kullanıcı 2'nin yorumları:");
        List<Review> userReviews = reviewDAO.getReviewsByUser(2);
        for (Review review : userReviews) {
            System.out.println("📖 " + review.getBookTitle() + " | ⭐ " + review.getRating() + 
                              " | 💬 " + review.getComment());
        }
    }
}

package com.kitapkosem.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.kitapkosem.model.Book;
import com.kitapkosem.util.DatabaseConnection;

public class BookDAO {
    
    // Kitap ekleme
    public boolean createBook(Book book) {
        String sql = "INSERT INTO books (title, author, description, category_id, added_by) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setString(3, book.getDescription());
            stmt.setInt(4, book.getCategoryId());
            stmt.setInt(5, book.getAddedBy());
            
            int result = stmt.executeUpdate();
            
            if (result > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        book.setId(generatedKeys.getInt(1));
                    }
                }
                System.out.println("✅ Kitap başarıyla eklendi: " + book.getTitle());
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Kitap ekleme hatası: " + e.getMessage());
        }
        return false;
    }
    
    // Tüm kitapları listele (detaylarla birlikte)
    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.id, b.title, b.author, b.description, b.category_id, c.name as category_name, " +
                     "b.added_by, u.username as added_by_username, b.created_at, " +
                     "COUNT(r.id) as review_count, COALESCE(AVG(r.rating), 0) as average_rating " +
                     "FROM books b " +
                     "LEFT JOIN categories c ON b.category_id = c.id " +
                     "LEFT JOIN users u ON b.added_by = u.id " +
                     "LEFT JOIN reviews r ON b.id = r.book_id " +
                     "GROUP BY b.id, b.title, b.author, b.description, b.category_id, c.name, b.added_by, u.username, b.created_at " +
                     "ORDER BY b.created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt("id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setDescription(rs.getString("description"));
                book.setCategoryId(rs.getInt("category_id"));
                book.setCategoryName(rs.getString("category_name"));
                book.setAddedBy(rs.getInt("added_by"));
                book.setAddedByUsername(rs.getString("added_by_username"));
                book.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                book.setReviewCount(rs.getInt("review_count"));
                book.setAverageRating(rs.getDouble("average_rating"));
                books.add(book);
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Kitap listeleme hatası: " + e.getMessage());
        }
        return books;
    }
    
    // Kitap arama (başlık veya yazar)
    public List<Book> searchBooks(String searchTerm) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.id, b.title, b.author, b.description, b.category_id, c.name as category_name, " +
                     "b.added_by, u.username as added_by_username, b.created_at, " +
                     "COUNT(r.id) as review_count, COALESCE(AVG(r.rating), 0) as average_rating " +
                     "FROM books b " +
                     "LEFT JOIN categories c ON b.category_id = c.id " +
                     "LEFT JOIN users u ON b.added_by = u.id " +
                     "LEFT JOIN reviews r ON b.id = r.book_id " +
                     "WHERE b.title LIKE ? OR b.author LIKE ? " +
                     "GROUP BY b.id, b.title, b.author, b.description, b.category_id, c.name, b.added_by, u.username, b.created_at " +
                     "ORDER BY b.created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + searchTerm + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Book book = new Book();
                    book.setId(rs.getInt("id"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setDescription(rs.getString("description"));
                    book.setCategoryId(rs.getInt("category_id"));
                    book.setCategoryName(rs.getString("category_name"));
                    book.setAddedBy(rs.getInt("added_by"));
                    book.setAddedByUsername(rs.getString("added_by_username"));
                    book.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    book.setReviewCount(rs.getInt("review_count"));
                    book.setAverageRating(rs.getDouble("average_rating"));
                    books.add(book);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Kitap arama hatası: " + e.getMessage());
        }
        return books;
    }
    
    // Kategori ID'ye göre kitapları listele
    public List<Book> getBooksByCategory(int categoryId) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.id, b.title, b.author, b.description, b.category_id, c.name as category_name, " +
                     "b.added_by, u.username as added_by_username, b.created_at, " +
                     "COUNT(r.id) as review_count, COALESCE(AVG(r.rating), 0) as average_rating " +
                     "FROM books b " +
                     "LEFT JOIN categories c ON b.category_id = c.id " +
                     "LEFT JOIN users u ON b.added_by = u.id " +
                     "LEFT JOIN reviews r ON b.id = r.book_id " +
                     "WHERE b.category_id = ? " +
                     "GROUP BY b.id, b.title, b.author, b.description, b.category_id, c.name, b.added_by, u.username, b.created_at " +
                     "ORDER BY b.created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, categoryId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Book book = new Book();
                    book.setId(rs.getInt("id"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setDescription(rs.getString("description"));
                    book.setCategoryId(rs.getInt("category_id"));
                    book.setCategoryName(rs.getString("category_name"));
                    book.setAddedBy(rs.getInt("added_by"));
                    book.setAddedByUsername(rs.getString("added_by_username"));
                    book.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    book.setReviewCount(rs.getInt("review_count"));
                    book.setAverageRating(rs.getDouble("average_rating"));
                    books.add(book);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Kategori kitapları listeleme hatası: " + e.getMessage());
        }
        return books;
    }
    
    // Kullanıcının eklediği kitapları listele
    public List<Book> getBooksByUser(int userId) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.id, b.title, b.author, b.description, b.category_id, c.name as category_name, " +
                     "b.added_by, u.username as added_by_username, b.created_at, " +
                     "COUNT(r.id) as review_count, COALESCE(AVG(r.rating), 0) as average_rating " +
                     "FROM books b " +
                     "LEFT JOIN categories c ON b.category_id = c.id " +
                     "LEFT JOIN users u ON b.added_by = u.id " +
                     "LEFT JOIN reviews r ON b.id = r.book_id " +
                     "WHERE b.added_by = ? " +
                     "GROUP BY b.id, b.title, b.author, b.description, b.category_id, c.name, b.added_by, u.username, b.created_at " +
                     "ORDER BY b.created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Book book = new Book();
                    book.setId(rs.getInt("id"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setDescription(rs.getString("description"));
                    book.setCategoryId(rs.getInt("category_id"));
                    book.setCategoryName(rs.getString("category_name"));
                    book.setAddedBy(rs.getInt("added_by"));
                    book.setAddedByUsername(rs.getString("added_by_username"));
                    book.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    book.setReviewCount(rs.getInt("review_count"));
                    book.setAverageRating(rs.getDouble("average_rating"));
                    books.add(book);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Kullanıcı kitapları listeleme hatası: " + e.getMessage());
        }
        return books;
    }
    
    // ID ile kitap bulma
    public Book findById(int id) {
        String sql = "SELECT b.id, b.title, b.author, b.description, b.category_id, c.name as category_name, " +
                     "b.added_by, u.username as added_by_username, b.created_at, " +
                     "COUNT(r.id) as review_count, COALESCE(AVG(r.rating), 0) as average_rating " +
                     "FROM books b " +
                     "LEFT JOIN categories c ON b.category_id = c.id " +
                     "LEFT JOIN users u ON b.added_by = u.id " +
                     "LEFT JOIN reviews r ON b.id = r.book_id " +
                     "WHERE b.id = ? " +
                     "GROUP BY b.id, b.title, b.author, b.description, b.category_id, c.name, b.added_by, u.username, b.created_at";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Book book = new Book();
                    book.setId(rs.getInt("id"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setDescription(rs.getString("description"));
                    book.setCategoryId(rs.getInt("category_id"));
                    book.setCategoryName(rs.getString("category_name"));
                    book.setAddedBy(rs.getInt("added_by"));
                    book.setAddedByUsername(rs.getString("added_by_username"));
                    book.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    book.setReviewCount(rs.getInt("review_count"));
                    book.setAverageRating(rs.getDouble("average_rating"));
                    return book;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Kitap bulma hatası: " + e.getMessage());
        }
        return null;
    }
    
    // Test metodu
    public static void main(String[] args) {
        BookDAO bookDAO = new BookDAO();
        
        System.out.println("🔄 BookDAO test ediliyor...");
        
        // Tüm kitapları listele
        List<Book> books = bookDAO.getAllBooks();
        System.out.println("📚 Toplam kitap sayısı: " + books.size());
        
        for (Book book : books) {
            System.out.println("📖 " + book.getTitle() + " - " + book.getAuthor() + 
                              " | Kategori: " + book.getCategoryName() + 
                              " | Puan: " + String.format("%.1f", book.getAverageRating()) + 
                              " | Yorum: " + book.getReviewCount());
        }
        
        // Kitap arama testi
        System.out.println("\n🔍 'Dune' araması:");
        List<Book> searchResults = bookDAO.searchBooks("Dune");
        for (Book book : searchResults) {
            System.out.println("📖 " + book.getTitle() + " - " + book.getAuthor());
        }
    }
}

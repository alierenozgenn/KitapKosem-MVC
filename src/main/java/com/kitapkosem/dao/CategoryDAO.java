package com.kitapkosem.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.kitapkosem.model.Category;
import com.kitapkosem.util.DatabaseConnection;

public class CategoryDAO {
    
    // Kategori ekleme
    public boolean createCategory(Category category) {
        String sql = "INSERT INTO categories (name, description) VALUES (?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, category.getName());
            stmt.setString(2, category.getDescription());
            
            int result = stmt.executeUpdate();
            
            if (result > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        category.setId(generatedKeys.getInt(1));
                    }
                }
                System.out.println("✅ Kategori başarıyla oluşturuldu: " + category.getName());
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Kategori oluşturma hatası: " + e.getMessage());
        }
        return false;
    }
    
    // Tüm kategorileri listele
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT id, name, description, created_at FROM categories ORDER BY name";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                category.setDescription(rs.getString("description"));
                category.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                categories.add(category);
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Kategori listeleme hatası: " + e.getMessage());
        }
        return categories;
    }
    
    // ID ile kategori bulma
    public Category findById(int id) {
        String sql = "SELECT id, name, description, created_at FROM categories WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Category category = new Category();
                    category.setId(rs.getInt("id"));
                    category.setName(rs.getString("name"));
                    category.setDescription(rs.getString("description"));
                    category.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    return category;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Kategori bulma hatası: " + e.getMessage());
        }
        return null;
    }
    
    // İsim ile kategori bulma
    public Category findByName(String name) {
        String sql = "SELECT id, name, description, created_at FROM categories WHERE name = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, name);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Category category = new Category();
                    category.setId(rs.getInt("id"));
                    category.setName(rs.getString("name"));
                    category.setDescription(rs.getString("description"));
                    category.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    return category;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Kategori bulma hatası: " + e.getMessage());
        }
        return null;
    }
    
    // Test metodu
    public static void main(String[] args) {
        CategoryDAO categoryDAO = new CategoryDAO();
        
        System.out.println("🔄 CategoryDAO test ediliyor...");
        
        // Kategorileri listele
        List<Category> categories = categoryDAO.getAllCategories();
        System.out.println("📚 Toplam kategori sayısı: " + categories.size());
        
        for (Category category : categories) {
            System.out.println("📖 " + category.getName() + " - " + category.getDescription());
        }
    }
}

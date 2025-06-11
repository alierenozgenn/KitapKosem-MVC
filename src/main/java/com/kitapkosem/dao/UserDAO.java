package com.kitapkosem.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.kitapkosem.model.User;
import com.kitapkosem.util.DatabaseConnection;
import com.kitapkosem.util.PasswordUtil;

public class UserDAO {
    
    // Kullanıcı oluşturma
    public boolean createUser(User user) {
        String sql = "INSERT INTO users (username, email, password, full_name) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getFullName());
            
            int result = stmt.executeUpdate();
            
            if (result > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        user.setId(generatedKeys.getInt(1));
                    }
                }
                System.out.println("✅ Kullanıcı başarıyla oluşturuldu: " + user.getUsername());
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Kullanıcı oluşturma hatası: " + e.getMessage());
        }
        return false;
    }
    
    // Kullanıcı adına göre kullanıcı bulma
    public User findByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setFullName(rs.getString("full_name"));
                    user.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    return user;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Kullanıcı bulma hatası: " + e.getMessage());
        }
        return null;
    }
    
    // ID'ye göre kullanıcı bulma
    public User findById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setFullName(rs.getString("full_name"));
                    user.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    return user;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Kullanıcı bulma hatası: " + e.getMessage());
        }
        return null;
    }
    
    // Kullanıcı adı veya email var mı kontrolü
    public boolean isUsernameOrEmailExists(String username, String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ? OR email = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            stmt.setString(2, email);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Kullanıcı kontrolü hatası: " + e.getMessage());
        }
        return false;
    }
    
    // Email var mı kontrolü
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Email kontrolü hatası: " + e.getMessage());
        }
        return false;
    }
    
    // Kullanıcı güncelleme
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET email = ?, password = ?, full_name = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getFullName());
            stmt.setInt(4, user.getId());
            
            int result = stmt.executeUpdate();
            
            if (result > 0) {
                System.out.println("✅ Kullanıcı başarıyla güncellendi: " + user.getUsername());
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Kullanıcı güncelleme hatası: " + e.getMessage());
        }
        return false;
    }
    
    // Kullanıcı silme
    public boolean deleteUser(int id) {
        String sql = "DELETE FROM users WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            int result = stmt.executeUpdate();
            
            if (result > 0) {
                System.out.println("✅ Kullanıcı başarıyla silindi: ID=" + id);
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Kullanıcı silme hatası: " + e.getMessage());
        }
        return false;
    }
    
    // Tüm kullanıcıları listeleme
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                users.add(user);
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Kullanıcı listeleme hatası: " + e.getMessage());
        }
        return users;
    }
    
    // Test metodu
    public static void main(String[] args) {
        UserDAO userDAO = new UserDAO();
        
        System.out.println("🔄 UserDAO test ediliyor...");
        
        // Yeni kullanıcı oluştur
        User newUser = new User();
        newUser.setUsername("testuser");
        newUser.setEmail("test@example.com");
        newUser.setPassword(PasswordUtil.hashPassword("password123"));
        newUser.setFullName("Test User");
        
        boolean created = userDAO.createUser(newUser);
        System.out.println("👤 Kullanıcı oluşturuldu: " + created);
        
        if (created) {
            // Kullanıcıyı bul
            User foundUser = userDAO.findByUsername("testuser");
            System.out.println("👤 Kullanıcı bulundu: " + (foundUser != null ? foundUser.getUsername() : "null"));
            
            // Kullanıcıyı güncelle
            if (foundUser != null) {
                foundUser.setFullName("Updated Test User");
                boolean updated = userDAO.updateUser(foundUser);
                System.out.println("👤 Kullanıcı güncellendi: " + updated);
                
                // Kullanıcıyı sil
                boolean deleted = userDAO.deleteUser(foundUser.getId());
                System.out.println("👤 Kullanıcı silindi: " + deleted);
            }
        }
        
        // Tüm kullanıcıları listele
        List<User> allUsers = userDAO.getAllUsers();
        System.out.println("👥 Toplam kullanıcı sayısı: " + allUsers.size());
        
        for (User user : allUsers) {
            System.out.println("👤 " + user.getUsername() + " - " + user.getEmail());
        }
    }
}

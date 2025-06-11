package com.kitapkosem.util;

import java.sql.Connection;
import java.sql.SQLException;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

public class DatabaseConnection {
    private static HikariDataSource dataSource;
    
    static {
        try {
            HikariConfig config = new HikariConfig();
            // MySQL 8.0 için güncellenmiş JDBC URL
            config.setJdbcUrl("jdbc:mysql://localhost:3306/kitapkosem?" +
                "useSSL=false&" +
                "serverTimezone=Turkey&" +
                "characterEncoding=UTF-8&" +
                "allowPublicKeyRetrieval=true&" +
                "useUnicode=true");
                
            // kitapkosem_user kullanıcısı ile bağlan
            config.setUsername("kitapkosem_user");
            config.setPassword("kitapkosem123");
            
            config.setDriverClassName("com.mysql.cj.jdbc.Driver");
            
            // Connection Pool ayarları
            config.setMaximumPoolSize(20);
            config.setMinimumIdle(5);
            config.setConnectionTimeout(30000);
            config.setIdleTimeout(600000);
            config.setMaxLifetime(1800000);
            
            // Ek MySQL 8.0 ayarları
            config.addDataSourceProperty("cachePrepStmts", "true");
            config.addDataSourceProperty("prepStmtCacheSize", "250");
            config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
            
            dataSource = new HikariDataSource(config);
            System.out.println("✅ Veritabanı bağlantı havuzu başarıyla oluşturuldu!");
            
        } catch (Exception e) {
            System.err.println("❌ Veritabanı bağlantı hatası: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            throw new SQLException("Veritabanı bağlantı havuzu başlatılamadı!");
        }
        return dataSource.getConnection();
    }
    
    public static void closeDataSource() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
            System.out.println("✅ Veritabanı bağlantı havuzu kapatıldı.");
        }
    }
    
    // Test metodu
    public static void testConnection() {
        try (Connection conn = getConnection()) {
            System.out.println("✅ Veritabanı bağlantısı başarılı!");
            System.out.println("📊 Bağlantı bilgisi: " + conn.getMetaData().getURL());
            System.out.println("👤 Kullanıcı: " + conn.getMetaData().getUserName());
            
            // Basit bir sorgu test et
            var stmt = conn.createStatement();
            var rs = stmt.executeQuery("SELECT COUNT(*) as user_count FROM users");
            if (rs.next()) {
                System.out.println("👥 Kullanıcı sayısı: " + rs.getInt("user_count"));
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Veritabanı bağlantı testi başarısız: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Test için main metodu
    public static void main(String[] args) {
        System.out.println("🔄 Veritabanı bağlantısı test ediliyor...");
        testConnection();
        
        // Bağlantı havuzu bilgilerini göster
        if (dataSource != null && !dataSource.isClosed()) {
            System.out.println("📊 Aktif bağlantı sayısı: " + dataSource.getHikariPoolMXBean().getActiveConnections());
            System.out.println("📊 Toplam bağlantı sayısı: " + dataSource.getHikariPoolMXBean().getTotalConnections());
        }
        
        closeDataSource();
    }
}

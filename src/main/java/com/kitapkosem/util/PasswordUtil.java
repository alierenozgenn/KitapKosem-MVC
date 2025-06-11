package com.kitapkosem.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {
    
    // Şifreyi hashle
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
    }
    
    // Şifreyi doğrula
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (Exception e) {
            System.err.println("Şifre doğrulama hatası: " + e.getMessage());
            return false;
        }
    }
    
    // Test metodu
    public static void main(String[] args) {
        String password = "123456";
        String hashed = hashPassword(password);
        
        System.out.println("Orijinal şifre: " + password);
        System.out.println("Hash'lenmiş şifre: " + hashed);
        System.out.println("Doğrulama: " + verifyPassword(password, hashed));
        System.out.println("Yanlış şifre doğrulama: " + verifyPassword("yanlış", hashed));
    }
}

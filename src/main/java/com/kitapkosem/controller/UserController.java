package com.kitapkosem.controller;

import com.kitapkosem.dao.BookDAO;
import com.kitapkosem.dao.ReviewDAO;
import com.kitapkosem.dao.UserDAO;
import com.kitapkosem.model.Book;
import com.kitapkosem.model.Review;
import com.kitapkosem.model.User;
import com.kitapkosem.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/user/*")
public class UserController extends HttpServlet {
    private UserDAO userDAO;
    private BookDAO bookDAO;
    private ReviewDAO reviewDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        bookDAO = new BookDAO();
        reviewDAO = new ReviewDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Ana sayfa yönlendirmesi
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
        
        switch (pathInfo) {
            case "/login":
                showLoginPage(request, response);
                break;
            case "/register":
                showRegisterPage(request, response);
                break;
            case "/logout":
                handleLogout(request, response);
                break;
            case "/profile":
                showProfile(request, response);
                break;
            case "/edit":
                showEditProfile(request, response);
                break;
            default:
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
        
        switch (pathInfo) {
            case "/login":
                handleLogin(request, response);
                break;
            case "/register":
                handleRegister(request, response);
                break;
            case "/update-profile":
                handleUpdateProfile(request, response);
                break;
            case "/change-password":
                handleChangePassword(request, response);
                break;
            case "/delete-account":
                handleDeleteAccount(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    private void showLoginPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }
    
    private void showRegisterPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }
    
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validation
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Kullanıcı adı ve şifre gereklidir.");
            showLoginPage(request, response);
            return;
        }
        
        // Kullanıcıyı bul
        User user = userDAO.findByUsername(username.trim());
        
        if (user != null && PasswordUtil.verifyPassword(password, user.getPassword())) {
            // Başarılı giriş
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUsername());
            
            System.out.println("✅ Kullanıcı giriş yaptı: " + user.getUsername());
            
            // Ana sayfaya yönlendir
            response.sendRedirect(request.getContextPath() + "/");
        } else {
            // Hatalı giriş
            request.setAttribute("error", "Kullanıcı adı veya şifre hatalı.");
            showLoginPage(request, response);
        }
    }
    
    private void handleRegister(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");
        
        // Validation
        if (username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Tüm alanlar gereklidir.");
            showRegisterPage(request, response);
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Şifreler eşleşmiyor.");
            showRegisterPage(request, response);
            return;
        }
        
        if (password.length() < 6) {
            request.setAttribute("error", "Şifre en az 6 karakter olmalıdır.");
            showRegisterPage(request, response);
            return;
        }
        
        // Kullanıcı adı veya email kontrolü
        if (userDAO.isUsernameOrEmailExists(username.trim(), email.trim())) {
            request.setAttribute("error", "Bu kullanıcı adı veya email zaten kullanılıyor.");
            showRegisterPage(request, response);
            return;
        }
        
        // Yeni kullanıcı oluştur
        User newUser = new User();
        newUser.setUsername(username.trim());
        newUser.setEmail(email.trim());
        newUser.setPassword(PasswordUtil.hashPassword(password));
        newUser.setFullName(fullName.trim());
        
        if (userDAO.createUser(newUser)) {
            // Başarılı kayıt
            request.setAttribute("success", "Kayıt başarılı! Şimdi giriş yapabilirsiniz.");
            showLoginPage(request, response);
        } else {
            // Kayıt hatası
            request.setAttribute("error", "Kayıt sırasında bir hata oluştu.");
            showRegisterPage(request, response);
        }
    }
    
    private void handleLogout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            String username = (String) session.getAttribute("username");
            session.invalidate();
            System.out.println("✅ Kullanıcı çıkış yaptı: " + username);
        }
        
        response.sendRedirect(request.getContextPath() + "/");
    }
    
    private void showProfile(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        // Kullanıcının kitaplarını getir
        List<Book> userBooks = bookDAO.getBooksByUser(user.getId());
        request.setAttribute("userBooks", userBooks);
        
        // Kullanıcının yorumlarını getir
        List<Review> userReviews = reviewDAO.getReviewsByUser(user.getId());
        request.setAttribute("userReviews", userReviews);
        
        // Kullanıcı istatistiklerini hesapla
        Map<String, Object> userStats = new HashMap<>();
        userStats.put("bookCount", userBooks.size());
        userStats.put("reviewCount", userReviews.size());
        
        // Ortalama puanı hesapla
        double totalRating = 0;
        for (Review review : userReviews) {
            totalRating += review.getRating();
        }
        double averageRating = userReviews.isEmpty() ? 0 : totalRating / userReviews.size();
        userStats.put("averageRating", averageRating);
        
        request.setAttribute("userStats", userStats);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }
    
    private void showEditProfile(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/views/edit-profile.jsp").forward(request, response);
    }
    
    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        
        // Validation
        if (fullName == null || fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Ad Soyad ve E-posta alanları gereklidir.");
            showEditProfile(request, response);
            return;
        }
        
        // Email kontrolü (başka kullanıcı tarafından kullanılıyor mu)
        if (!email.equals(user.getEmail()) && userDAO.isEmailExists(email.trim())) {
            request.setAttribute("error", "Bu e-posta adresi başka bir kullanıcı tarafından kullanılıyor.");
            showEditProfile(request, response);
            return;
        }
        
        // Kullanıcı bilgilerini güncelle
        user.setFullName(fullName.trim());
        user.setEmail(email.trim());
        
        if (userDAO.updateUser(user)) {
            // Başarılı güncelleme
            session.setAttribute("user", user); // Session'daki kullanıcı bilgilerini güncelle
            request.setAttribute("success", "Profil bilgileriniz başarıyla güncellendi.");
            response.sendRedirect(request.getContextPath() + "/user/profile?success=profile_updated");
        } else {
            // Güncelleme hatası
            request.setAttribute("error", "Profil güncellenirken bir hata oluştu.");
            showEditProfile(request, response);
        }
    }
    
    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");
        
        // Validation
        if (currentPassword == null || currentPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmNewPassword == null || confirmNewPassword.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user/profile?error=missing_fields#settings");
            return;
        }
        
        if (!PasswordUtil.verifyPassword(currentPassword, user.getPassword())) {
            response.sendRedirect(request.getContextPath() + "/user/profile?error=wrong_password#settings");
            return;
        }
        
        if (newPassword.length() < 6) {
            response.sendRedirect(request.getContextPath() + "/user/profile?error=password_too_short#settings");
            return;
        }
        
        if (!newPassword.equals(confirmNewPassword)) {
            response.sendRedirect(request.getContextPath() + "/user/profile?error=passwords_dont_match#settings");
            return;
        }
        
        // Şifreyi güncelle
        user.setPassword(PasswordUtil.hashPassword(newPassword));
        
        if (userDAO.updateUser(user)) {
            // Başarılı güncelleme
            session.setAttribute("user", user); // Session'daki kullanıcı bilgilerini güncelle
            response.sendRedirect(request.getContextPath() + "/user/profile?success=password_changed#settings");
        } else {
            // Güncelleme hatası
            response.sendRedirect(request.getContextPath() + "/user/profile?error=update_failed#settings");
        }
    }
    
    private void handleDeleteAccount(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validation
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user/profile?error=password_required#settings");
            return;
        }
        
        if (!PasswordUtil.verifyPassword(confirmPassword, user.getPassword())) {
            response.sendRedirect(request.getContextPath() + "/user/profile?error=wrong_password#settings");
            return;
        }
        
        // Kullanıcıyı sil
        if (userDAO.deleteUser(user.getId())) {
            // Başarılı silme
            session.invalidate(); // Oturumu sonlandır
            response.sendRedirect(request.getContextPath() + "/?success=account_deleted");
        } else {
            // Silme hatası
            response.sendRedirect(request.getContextPath() + "/user/profile?error=delete_failed#settings");
        }
    }
}

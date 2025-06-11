package com.kitapkosem.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthenticationFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Başlangıç ayarları
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        // Kullanıcı giriş yapmış mı kontrol et
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        
        if (!isLoggedIn) {
            // Giriş yapmamış kullanıcıyı login sayfasına yönlendir
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/user/login");
            return;
        }
        
        // Giriş yapmış kullanıcı, devam et
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // Cleanup kod buraya
    }
}

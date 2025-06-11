package com.kitapkosem.model;

import java.time.LocalDateTime;

public class Review {
    private int id;
    private int bookId;
    private String bookTitle; // JOIN için
    private String bookAuthor; // JOIN için
    private int userId;
    private String username; // JOIN için
    private String comment;
    private int rating;
    private LocalDateTime createdAt;
    
    // Constructors
    public Review() {}
    
    public Review(int bookId, int userId, String comment, int rating) {
        this.bookId = bookId;
        this.userId = userId;
        this.comment = comment;
        this.rating = rating;
    }
    
    // Full constructor
    public Review(int id, int bookId, String bookTitle, String bookAuthor, 
                  int userId, String username, String comment, int rating, LocalDateTime createdAt) {
        this.id = id;
        this.bookId = bookId;
        this.bookTitle = bookTitle;
        this.bookAuthor = bookAuthor;
        this.userId = userId;
        this.username = username;
        this.comment = comment;
        this.rating = rating;
        this.createdAt = createdAt;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getBookId() {
        return bookId;
    }
    
    public void setBookId(int bookId) {
        this.bookId = bookId;
    }
    
    public String getBookTitle() {
        return bookTitle;
    }
    
    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }
    
    public String getBookAuthor() {
        return bookAuthor;
    }
    
    public void setBookAuthor(String bookAuthor) {
        this.bookAuthor = bookAuthor;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getComment() {
        return comment;
    }
    
    public void setComment(String comment) {
        this.comment = comment;
    }
    
    public int getRating() {
        return rating;
    }
    
    public void setRating(int rating) {
        this.rating = rating;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    // toString method
    @Override
    public String toString() {
        return "Review{" +
                "id=" + id +
                ", bookTitle='" + bookTitle + '\'' +
                ", username='" + username + '\'' +
                ", comment='" + comment + '\'' +
                ", rating=" + rating +
                ", createdAt=" + createdAt +
                '}';
    }
}

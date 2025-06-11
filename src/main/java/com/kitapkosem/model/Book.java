package com.kitapkosem.model;

import java.time.LocalDateTime;

public class Book {
    private int id;
    private String title;
    private String author;
    private String description;
    private int categoryId;
    private String categoryName; // JOIN için
    private int addedBy;
    private String addedByUsername; // JOIN için
    private LocalDateTime createdAt;
    
    // İstatistik alanları (VIEW'dan gelecek)
    private int reviewCount;
    private double averageRating;
    
    // Constructors
    public Book() {}
    
    public Book(String title, String author, String description, int categoryId, int addedBy) {
        this.title = title;
        this.author = author;
        this.description = description;
        this.categoryId = categoryId;
        this.addedBy = addedBy;
    }
    
    // Full constructor
    public Book(int id, String title, String author, String description, int categoryId, 
                String categoryName, int addedBy, String addedByUsername, LocalDateTime createdAt,
                int reviewCount, double averageRating) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.description = description;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.addedBy = addedBy;
        this.addedByUsername = addedByUsername;
        this.createdAt = createdAt;
        this.reviewCount = reviewCount;
        this.averageRating = averageRating;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getAuthor() {
        return author;
    }
    
    public void setAuthor(String author) {
        this.author = author;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public int getCategoryId() {
        return categoryId;
    }
    
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    
    public String getCategoryName() {
        return categoryName;
    }
    
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    
    public int getAddedBy() {
        return addedBy;
    }
    
    public void setAddedBy(int addedBy) {
        this.addedBy = addedBy;
    }
    
    public String getAddedByUsername() {
        return addedByUsername;
    }
    
    public void setAddedByUsername(String addedByUsername) {
        this.addedByUsername = addedByUsername;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public int getReviewCount() {
        return reviewCount;
    }
    
    public void setReviewCount(int reviewCount) {
        this.reviewCount = reviewCount;
    }
    
    public double getAverageRating() {
        return averageRating;
    }
    
    public void setAverageRating(double averageRating) {
        this.averageRating = averageRating;
    }
    
    // toString method
    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", author='" + author + '\'' +
                ", categoryName='" + categoryName + '\'' +
                ", addedByUsername='" + addedByUsername + '\'' +
                ", reviewCount=" + reviewCount +
                ", averageRating=" + averageRating +
                ", createdAt=" + createdAt +
                '}';
    }
}

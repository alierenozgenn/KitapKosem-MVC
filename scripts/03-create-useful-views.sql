-- Veritabanını seç
USE kitapkosem;

-- Kitap detayları ve istatistikleri için view
CREATE VIEW book_details AS
SELECT 
    b.id,
    b.title,
    b.author,
    b.description,
    c.name as category_name,
    u.username as added_by_username,
    u.full_name as added_by_fullname,
    b.created_at,
    COUNT(r.id) as review_count,
    COALESCE(ROUND(AVG(r.rating), 1), 0) as average_rating
FROM books b
LEFT JOIN categories c ON b.category_id = c.id
LEFT JOIN users u ON b.added_by = u.id
LEFT JOIN reviews r ON b.id = r.book_id
GROUP BY b.id, b.title, b.author, b.description, c.name, u.username, u.full_name, b.created_at;

-- Popüler kitaplar view (en çok yorum alan ve yüksek puan alan)
CREATE VIEW popular_books AS
SELECT 
    bd.*,
    CASE 
        WHEN bd.review_count >= 3 AND bd.average_rating >= 4.0 THEN 'Çok Popüler'
        WHEN bd.review_count >= 2 AND bd.average_rating >= 3.5 THEN 'Popüler'
        WHEN bd.review_count >= 1 THEN 'Yeni'
        ELSE 'Henüz Değerlendirilmemiş'
    END as popularity_status
FROM book_details bd
ORDER BY bd.review_count DESC, bd.average_rating DESC;

-- Kullanıcı aktivite özeti
CREATE VIEW user_activity AS
SELECT 
    u.id,
    u.username,
    u.full_name,
    COUNT(DISTINCT b.id) as books_added,
    COUNT(DISTINCT r.id) as reviews_written,
    COALESCE(ROUND(AVG(r.rating), 1), 0) as avg_rating_given
FROM users u
LEFT JOIN books b ON u.id = b.added_by
LEFT JOIN reviews r ON u.id = r.user_id
GROUP BY u.id, u.username, u.full_name;

-- Test sorguları
SELECT 'En Popüler Kitaplar' as Baslik;
SELECT title, author, review_count, average_rating, popularity_status 
FROM popular_books 
LIMIT 5;

SELECT 'En Aktif Kullanıcılar' as Baslik;
SELECT username, full_name, books_added, reviews_written 
FROM user_activity 
WHERE books_added > 0 OR reviews_written > 0
ORDER BY (books_added + reviews_written) DESC;

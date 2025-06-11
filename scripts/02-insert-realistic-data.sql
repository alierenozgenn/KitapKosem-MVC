-- Veritabanını seç
USE kitapkosem;

-- Kategoriler ekle (Türkiye'deki popüler kategoriler)
INSERT INTO categories (name, description) VALUES
('Roman', 'Türk ve dünya edebiyatından romanlar'),
('Kişisel Gelişim', 'Motivasyon ve kişisel gelişim kitapları'),
('Tarih', 'Tarih ve biyografi kitapları'),
('Bilim Kurgu', 'Bilim kurgu ve fantastik romanlar'),
('Çocuk Kitapları', 'Çocuk ve gençlik kitapları'),
('Felsefe', 'Felsefe ve düşünce kitapları'),
('Şiir', 'Şiir ve edebiyat kitapları');

-- Test kullanıcıları ekle (şifre: 123456)
INSERT INTO users (username, email, password, full_name) VALUES
('admin', 'admin@kitapkosem.com', 'e10adc3949ba59abbe56e057f20f883e', 'Site Yöneticisi'),
('ahmet_okur', 'ahmet@email.com', 'e10adc3949ba59abbe56e057f20f883e', 'Ahmet Okur'),
('zeynep_k', 'zeynep@email.com', 'e10adc3949ba59abbe56e057f20f883e', 'Zeynep Kaya'),
('mehmet123', 'mehmet@email.com', 'e10adc3949ba59abbe56e057f20f883e', 'Mehmet Demir'),
('ayse_yazar', 'ayse@email.com', 'e10adc3949ba59abbe56e057f20f883e', 'Ayşe Yılmaz');

-- Güncel ve popüler kitaplar ekle
INSERT INTO books (title, author, description, category_id, added_by) VALUES
('Tutunamayanlar', 'Oğuz Atay', 'Türk edebiyatının en önemli romanlarından biri. Modern insanın yabancılaşmasını anlatan derin bir eser.', 1, 1),
('Saatleri Ayarlama Enstitüsü', 'Ahmet Hamdi Tanpınar', 'Doğu-Batı sentezi üzerine kurulu felsefi roman. Türk modernleşmesinin eleştirel bir analizi.', 1, 2),
('Atomic Habits', 'James Clear', 'Küçük alışkanlık değişikliklerinin nasıl büyük sonuçlar doğurduğunu anlatan pratik rehber.', 2, 3),
('Dune', 'Frank Herbert', 'Bilim kurgu edebiyatının başyapıtlarından biri. Çöl gezegeni Arrakis\'te geçen epik hikaye.', 4, 1),
('Küçük Prens', 'Antoine de Saint-Exupéry', 'Çocuklar ve yetişkinler için yazılmış evrensel bir masal. Dostluk ve sevgi üzerine.', 5, 4),
('Meditations', 'Marcus Aurelius', 'Stoik felsefenin temel metinlerinden biri. Kişisel gelişim için değerli öğütler.', 6, 2),
('İnsan Ne İle Yaşar', 'Lev Tolstoy', 'Tolstoy\'un kısa hikayelerinden oluşan koleksiyon. İnsani değerler üzerine düşündürücü öyküler.', 1, 5),
('Sapiens', 'Yuval Noah Harari', 'İnsanlık tarihine farklı bir bakış açısı getiren çığır açan eser.', 3, 3),
('Foundation', 'Isaac Asimov', 'Galaktik İmparatorluk\'un çöküşü ve yeniden doğuşu. Bilim kurgunun klasikleri.', 4, 1),
('Zen ve Motosiklet Bakım Sanatı', 'Robert M. Pirsig', 'Felsefe ve teknoloji arasındaki ilişkiyi sorgulayan özgün eser.', 6, 4);

-- Gerçekçi yorumlar ve puanlar ekle
INSERT INTO reviews (book_id, user_id, comment, rating) VALUES
(1, 2, 'Oğuz Atay\'ın dil kullanımı muhteşem. Ağır ama değer bir roman.', 5),
(1, 3, 'İlk okuyuşta anlamakta zorlandım ama ikinci okuyuşta çok etkilendim.', 4),
(2, 1, 'Tanpınar\'ın üslubu benzersiz. Türk edebiyatının zirvesi.', 5),
(3, 4, 'Hayatımı değiştiren kitap. Alışkanlıklarımı tamamen yeniden düzenledim.', 5),
(3, 5, 'Çok pratik öneriler var. Uygulaması kolay ve etkili.', 4),
(4, 2, 'Bilim kurgu severler için mükemmel. Dünya kurgusu harika.', 5),
(4, 3, 'Başlangıçta yavaş ilerliyor ama sonra çok sürükleyici oluyor.', 4),
(5, 1, 'Çocukluğumdan beri en sevdiğim kitap. Her yaşta okunmalı.', 5),
(5, 4, 'Basit gibi görünüyor ama çok derin mesajları var.', 5),
(6, 5, 'Stoik felsefe hakkında çok şey öğrendim. Günlük hayatta uygulanabilir.', 4),
(7, 2, 'Tolstoy\'un hikaye anlatma yeteneği muhteşem.', 4),
(8, 3, 'İnsanlık tarihine bambaşka bir perspektif. Çok öğretici.', 5),
(9, 1, 'Asimov\'un hayal gücü sınırsız. Bilim kurgu klasiği.', 4),
(10, 4, 'Felsefe ve günlük yaşamı harmanlayan özgün bir yaklaşım.', 4);

-- Kontrol sorguları
SELECT 'Kullanıcı Sayısı' as Tablo, COUNT(*) as Adet FROM users
UNION ALL
SELECT 'Kategori Sayısı', COUNT(*) FROM categories
UNION ALL
SELECT 'Kitap Sayısı', COUNT(*) FROM books
UNION ALL
SELECT 'Yorum Sayısı', COUNT(*) FROM reviews;

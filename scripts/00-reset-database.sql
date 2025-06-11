-- Mevcut veritabanını tamamen sil ve yeniden oluştur
DROP DATABASE IF EXISTS kitapkosem;

-- KitapKöşem veritabanını yeniden oluştur
CREATE DATABASE kitapkosem 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_turkish_ci;

-- Kullanıcıyı yeniden oluştur (varsa sil)
DROP USER IF EXISTS 'kitapkosem_user'@'localhost';
CREATE USER 'kitapkosem_user'@'localhost' IDENTIFIED BY 'kitapkosem123';

-- Kullanıcıya veritabanı üzerinde tam yetki ver
GRANT ALL PRIVILEGES ON kitapkosem.* TO 'kitapkosem_user'@'localhost';
FLUSH PRIVILEGES;

-- Veritabanını seç
USE kitapkosem;

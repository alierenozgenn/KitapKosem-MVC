# KitapKöşem Proje Raporu

## 1. Proje Özeti

### 1.1 Proje Adı
KitapKöşem: Online Kitap İnceleme ve Puanlama Sistemi

### 1.2 Proje Amacı
Bu proje, kullanıcıların kitapları inceleyebileceği, puanlayabileceği ve yorum yapabileceği bir web platformu oluşturmayı amaçlamaktadır. Proje kapsamında HTML, CSS, Bootstrap ile modern arayüzler, Java Servlet ve JSP ile MVC mimarisine uygun backend geliştirme ve JDBC ile veritabanı işlemleri uygulanmıştır.

### 1.3 Hedef Kitle
- Kitap severler
- Okuma önerileri arayan kullanıcılar
- Kitap hakkında görüş paylaşmak isteyen okuyucular

## 2. Kullanıcı Senaryoları

### 2.1 Ziyaretçi Senaryosu (Giriş Yapmamış Kullanıcı)
**Senaryo:** Mehmet, yeni kitap önerileri arayan bir öğrenci
1. Ana sayfaya girer
2. Kitap listesini inceler
3. Arama çubuğunu kullanarak "bilim kurgu" arar
4. Dune kitabının detayına girer
5. Yorumları okur ve ortalama puanı görür
6. Yorum yapmak için giriş yapması gerektiğini fark eder
7. Kayıt olur veya giriş yapar

### 2.2 Kayıtlı Kullanıcı Senaryosu
**Senaryo:** Ayşe, aktif bir kitap okuyucusu
1. Kullanıcı adı ve şifresi ile giriş yapar
2. Profil sayfasında istatistiklerini görür
3. Yeni okuduğu "Atomic Habits" kitabını sisteme ekler
4. Daha önce okuduğu "Küçük Prens" kitabına 5 yıldız verir
5. Detaylı bir yorum yazar
6. Kendi eklediği kitapları profil sayfasında görür
7. Daha sonra yorumunu düzenlemek ister ve siler

### 2.3 Aktif Kullanıcı Senaryosu
**Senaryo:** Ahmet, çok sayıda kitap ekleyen ve yorum yapan kullanıcı
1. Giriş yapar
2. Kategorilere göre kitapları filtreler
3. Roman kategorisindeki kitapları inceler
4. "Tutunamayanlar" kitabına detaylı bir analiz yorumu yazar
5. Profil sayfasında tüm aktivitelerini görür
6. Kendi eklediği kitaplardan birini düzenler
7. Artık beğenmediği bir yorumunu siler

## 3. MVC Yapısı Açıklaması

### 3.1 Model (Model)
**Konum:** \`com.kitapkosem.model\` paketi

**Sınıflar:**
- \`User.java\` - Kullanıcı bilgilerini temsil eder
- \`Book.java\` - Kitap bilgilerini temsil eder
- \`Review.java\` - Yorum ve puan bilgilerini temsil eder
- \`Category.java\` - Kategori bilgilerini temsil eder

**Özellikler:**
- POJO (Plain Old Java Object) yapısında
- Getter/Setter metodları
- Veritabanı tablolarıyla birebir eşleşen alanlar
- İş mantığından bağımsız veri yapıları

### 3.2 View (Görünüm)
**Konum:** \`/WEB-INF/views/\` klasörü

**JSP Sayfaları:**
- \`book-list.jsp\` - Kitap listeleme sayfası
- \`book-detail.jsp\` - Kitap detay sayfası
- \`add-book.jsp\` - Kitap ekleme formu
- \`login.jsp\` - Giriş sayfası
- \`register.jsp\` - Kayıt sayfası
- \`profile.jsp\` - Kullanıcı profil sayfası
- \`layout/header.jsp\` - Ortak header
- \`layout/footer.jsp\` - Ortak footer

**Özellikler:**
- Bootstrap 5 ile responsive tasarım
- JSTL (JSP Standard Tag Library) kullanımı
- Modern ve kullanıcı dostu arayüz
- Mobil uyumlu tasarım

### 3.3 Controller (Kontrolcü)
**Konum:** \`com.kitapkosem.controller\` paketi

**Servlet Sınıfları:**
- \`BookController.java\` - Kitap işlemleri (/book/*)
- \`UserController.java\` - Kullanıcı işlemleri (/user/*)
- \`ReviewController.java\` - Yorum işlemleri (/review/*)

**Özellikler:**
- HTTP isteklerini karşılar (GET/POST)
- İş mantığını yönetir
- Model ve View arasında köprü görevi görür
- URL routing ve parametre yönetimi

### 3.4 Data Access Object (DAO)
**Konum:** \`com.kitapkosem.dao\` paketi

**DAO Sınıfları:**
- \`UserDAO.java\` - Kullanıcı veritabanı işlemleri
- \`BookDAO.java\` - Kitap veritabanı işlemleri
- \`ReviewDAO.java\` - Yorum veritabanı işlemleri
- \`CategoryDAO.java\` - Kategori veritabanı işlemleri

**Özellikler:**
- JDBC ile veritabanı bağlantısı
- PreparedStatement ile SQL Injection koruması
- CRUD (Create, Read, Update, Delete) işlemleri
- Connection pooling desteği

## 4. Veritabanı Modeli

### 4.1 Tablolar ve İlişkiler

#### users Tablosu
- \`id\` (PK) - Kullanıcı kimliği
- \`username\` - Kullanıcı adı (UNIQUE)
- \`email\` - E-posta adresi (UNIQUE)
- \`password\` - Şifre (MD5 hash)
- \`full_name\` - Ad soyad
- \`created_at\` - Kayıt tarihi

#### categories Tablosu
- \`id\` (PK) - Kategori kimliği
- \`name\` - Kategori adı
- \`description\` - Kategori açıklaması
- \`created_at\` - Oluşturulma tarihi

#### books Tablosu
- \`id\` (PK) - Kitap kimliği
- \`title\` - Kitap başlığı
- \`author\` - Yazar adı
- \`description\` - Kitap açıklaması
- \`category_id\` (FK) - Kategori referansı
- \`added_by\` (FK) - Ekleyen kullanıcı referansı
- \`created_at\` - Eklenme tarihi

#### reviews Tablosu
- \`id\` (PK) - Yorum kimliği
- \`book_id\` (FK) - Kitap referansı
- \`user_id\` (FK) - Kullanıcı referansı
- \`comment\` - Yorum metni
- \`rating\` - Puan (1-5)
- \`created_at\` - Yorum tarihi

### 4.2 İlişkiler
- **users → books:** Bir kullanıcı birden fazla kitap ekleyebilir (1:N)
- **users → reviews:** Bir kullanıcı birden fazla yorum yapabilir (1:N)
- **categories → books:** Bir kategoride birden fazla kitap olabilir (1:N)
- **books → reviews:** Bir kitap birden fazla yorum alabilir (1:N)
- **Unique Constraint:** Bir kullanıcı aynı kitaba sadece bir yorum yapabilir

### 4.3 İndeksler
- \`idx_username\` - Hızlı kullanıcı arama
- \`idx_email\` - E-posta kontrolü
- \`idx_title\` - Kitap başlığı arama
- \`idx_author\` - Yazar arama
- \`idx_rating\` - Puan bazlı sıralama

## 5. Teknik Özellikler

### 5.1 Güvenlik
- **Şifre Güvenliği:** MD5 hash ile şifreleme
- **SQL Injection Koruması:** PreparedStatement kullanımı
- **Session Yönetimi:** Güvenli oturum kontrolü
- **Input Validasyonu:** Form verilerinin kontrolü

### 5.2 Performans
- **Veritabanı İndeksleri:** Hızlı sorgular için optimizasyon
- **Connection Pooling:** Veritabanı bağlantı yönetimi
- **Lazy Loading:** Gerektiğinde veri yükleme
- **Caching:** Session bazlı önbellekleme

### 5.3 Kullanıcı Deneyimi
- **Responsive Tasarım:** Mobil uyumlu arayüz
- **AJAX Desteği:** Sayfa yenilenmeden işlemler
- **Form Validasyonu:** Anlık hata kontrolü
- **Loading States:** İşlem durumu gösterimi

## 6. Sonuç ve Değerlendirme

### 6.1 Başarılan Hedefler
✅ MVC mimarisine uygun geliştirme
✅ Modern ve responsive arayüz tasarımı
✅ Güvenli kullanıcı yönetimi
✅ Etkili veritabanı tasarımı
✅ Kullanıcı dostu deneyim

### 6.2 Öğrenilen Teknolojiler
- Java Servlet API
- JSP ve JSTL
- JDBC ile veritabanı işlemleri
- Bootstrap CSS framework
- MySQL veritabanı yönetimi
- MVC tasarım deseni

### 6.3 Gelecek Geliştirmeler
- REST API desteği
- Gelişmiş arama filtreleri
- Sosyal medya entegrasyonu
- E-posta bildirimleri
- Kitap önerisi algoritması

Bu proje, modern web geliştirme teknikleri kullanılarak başarıyla tamamlanmış ve tüm hedeflenen işlevsellikler gerçekleştirilmiştir.

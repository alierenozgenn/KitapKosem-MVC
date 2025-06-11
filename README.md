# KitapKöşem - Online Kitap İnceleme ve Puanlama Sistemi

## Proje Hakkında
KitapKöşem, kullanıcıların kitapları inceleyebileceği, puanlayabileceği ve yorum yapabileceği bir web uygulamasıdır. Java Servlet, JSP ve MySQL teknolojileri kullanılarak MVC mimarisine uygun olarak geliştirilmiştir.

## Özellikler
- ✅ Kullanıcı kayıt ve giriş sistemi
- ✅ Kitap ekleme, listeleme ve arama
- ✅ Kitap detaylarını görüntüleme
- ✅ Yorum ve puan verme (1-5 yıldız)
- ✅ Ortalama puan hesaplama
- ✅ Puan dağılımı gösterimi
- ✅ Kendi yorumlarını silme
- ✅ Responsive tasarım (Bootstrap)

## Teknolojiler
- **Backend:** Java 8+, Servlet API 4.0
- **Frontend:** HTML5, CSS3, Bootstrap 5, JSP
- **Veritabanı:** MySQL 8.0
- **Sunucu:** Apache Tomcat 9.0+
- **IDE:** Eclipse/IntelliJ IDEA

## Kurulum Talimatları

### 1. Gereksinimler
- Java JDK 8 veya üzeri
- Apache Tomcat 9.0 veya üzeri
- MySQL 8.0 veya üzeri
- Eclipse IDE (önerilen)

### 2. Veritabanı Kurulumu
\`\`\`sql
-- MySQL'e root kullanıcısı ile bağlanın
mysql -u root -p

-- Veritabanı backup dosyasını çalıştırın
source kitapkosem_database_backup.sql
\`\`\`

### 3. Proje Kurulumu
1. Projeyi Eclipse'e import edin
2. \`src/main/webapp/WEB-INF/lib\` klasörüne gerekli JAR dosyalarını ekleyin:
   - mysql-connector-java-8.0.33.jar
   - jstl-1.2.jar
3. \`DatabaseConnection.java\` dosyasında veritabanı bağlantı bilgilerini kontrol edin

### 4. Tomcat Konfigürasyonu
1. Eclipse'te Tomcat server ekleyin
2. Projeyi Tomcat'e deploy edin
3. Server'ı başlatın

### 5. Uygulama Erişimi
- URL: \`http://localhost:8080/kitapkosem\`
- Test kullanıcıları:
  - Kullanıcı adı: \`admin\`, Şifre: \`123456\`
  - Kullanıcı adı: \`ahmet_okur\`, Şifre: \`123456\`

## Proje Yapısı
\`\`\`
kitapkosem/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/kitapkosem/
│       │       ├── controller/     # Servlet Controller'lar
│       │       ├── dao/            # Data Access Objects
│       │       ├── model/          # Model sınıfları
│       │       └── util/           # Yardımcı sınıflar
│       └── webapp/
│           ├── WEB-INF/
│           │   ├── views/          # JSP sayfaları
│           │   └── web.xml         # Web konfigürasyonu
│           ├── css/                # CSS dosyaları
│           ├── js/                 # JavaScript dosyaları
│           └── images/             # Resim dosyaları
└── database/
    └── kitapkosem_database_backup.sql
\`\`\`

## Kullanım Kılavuzu

### Yeni Kullanıcı Kaydı
1. Ana sayfada "Kayıt Ol" butonuna tıklayın
2. Gerekli bilgileri doldurun
3. "Kayıt Ol" butonuna tıklayın

### Kitap Ekleme
1. Giriş yapın
2. "Kitap Ekle" butonuna tıklayın
3. Kitap bilgilerini doldurun
4. "Kitap Ekle" butonuna tıklayın

### Yorum Yapma
1. Kitap detay sayfasına gidin
2. Puan verin (1-5 yıldız)
3. Yorumunuzu yazın
4. "Yorum Gönder" butonuna tıklayın

## Veritabanı Modeli
- **users:** Kullanıcı bilgileri
- **categories:** Kitap kategorileri
- **books:** Kitap bilgileri
- **reviews:** Yorumlar ve puanlar

## Güvenlik
- Şifreler MD5 ile hashlenir
- SQL Injection koruması (PreparedStatement)
- Session yönetimi
- Input validasyonu

## Katkıda Bulunma
1. Fork yapın
2. Feature branch oluşturun
3. Değişikliklerinizi commit edin
4. Pull request gönderin

## Lisans
Bu proje eğitim amaçlı geliştirilmiştir.

## İletişim
- Geliştirici: [Adınız]
- E-posta: [email@domain.com]
- GitHub: [github.com/username]
\`\`\`

## 3. Proje Raporu

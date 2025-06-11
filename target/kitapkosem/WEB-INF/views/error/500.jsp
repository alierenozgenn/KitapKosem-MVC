<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8 text-center">
            <div class="error-container py-5">
                <div class="error-code">500</div>
                <h1 class="fw-bold mb-4">Sunucu Hatası</h1>
                
                <div class="error-image mb-4">
                    <i class="bi bi-exclamation-triangle display-1 text-danger"></i>
                </div>
                
                <p class="lead mb-4">
                    Üzgünüz, bir şeyler ters gitti. Sunucuda beklenmeyen bir hata oluştu.
                </p>
                
                <div class="error-actions">
                    <a href="${pageContext.request.contextPath}/" class="btn btn-gradient-primary btn-lg me-3">
                        <i class="bi bi-house"></i> Ana Sayfa
                    </a>
                    <button onclick="window.location.reload()" class="btn btn-outline-primary btn-lg">
                        <i class="bi bi-arrow-clockwise"></i> Tekrar Dene
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row mt-4">
        <div class="col-md-8 mx-auto">
            <div class="card card-modern p-4">
                <div class="card-body">
                    <h5 class="fw-bold mb-3">
                        <i class="bi bi-info-circle"></i> Ne Yapabilirsiniz?
                    </h5>
                    <ul class="mb-0">
                        <li class="mb-2">Sayfayı yenilemeyi deneyin</li>
                        <li class="mb-2">Tarayıcı önbelleğini temizleyin</li>
                        <li class="mb-2">Ana sayfaya dönün ve tekrar deneyin</li>
                        <li class="mb-2">Birkaç dakika sonra tekrar deneyin</li>
                        <li>Sorun devam ederse lütfen site yöneticisiyle iletişime geçin</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row mt-4">
        <div class="col-md-8 mx-auto">
            <div class="card bg-light border-0 p-4">
                <div class="card-body">
                    <h6 class="fw-bold mb-3">
                        <i class="bi bi-bug"></i> Teknik Detaylar
                    </h6>
                    <p class="mb-0 small">
                        Hata Kodu: 500 Internal Server Error<br>
                        Zaman: <%= new java.util.Date() %><br>
                        Tarayıcı: <%= request.getHeader("User-Agent") %>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .error-container {
        padding: 40px 0;
    }
    
    .error-code {
        font-size: 120px;
        font-weight: 800;
        background: linear-gradient(135deg, #f5576c 0%, #f093fb 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        line-height: 1;
        margin-bottom: 20px;
        text-shadow: 2px 2px 10px rgba(245, 87, 108, 0.3);
    }
    
    .error-image {
        margin: 30px 0;
        animation: pulse 2s ease-in-out infinite;
    }
    
    @keyframes pulse {
        0% { transform: scale(1); }
        50% { transform: scale(1.1); }
        100% { transform: scale(1); }
    }
</style>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

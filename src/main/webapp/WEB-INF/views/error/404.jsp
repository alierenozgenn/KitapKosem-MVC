<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8 text-center">
            <div class="error-container py-5">
                <div class="error-code">404</div>
                <h1 class="fw-bold mb-4">Sayfa Bulunamadı</h1>
                
                <div class="error-image mb-4">
                    <i class="bi bi-search display-1 text-primary"></i>
                </div>
                
                <p class="lead mb-4">
                    Aradığınız sayfa bulunamadı veya taşınmış olabilir.
                </p>
                
                <div class="error-actions">
                    <a href="${pageContext.request.contextPath}/" class="btn btn-gradient-primary btn-lg me-3">
                        <i class="bi bi-house"></i> Ana Sayfa
                    </a>
                    <a href="${pageContext.request.contextPath}/book/" class="btn btn-outline-primary btn-lg">
                        <i class="bi bi-book"></i> Kitapları Keşfet
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row mt-4">
        <div class="col-md-8 mx-auto">
            <div class="card card-modern p-4">
                <div class="card-body">
                    <h5 class="fw-bold mb-3">
                        <i class="bi bi-question-circle"></i> Yardımcı Olabilecek Bağlantılar
                    </h5>
                    <div class="row">
                        <div class="col-md-6">
                            <ul class="list-unstyled">
                                <li class="mb-2">
                                    <i class="bi bi-arrow-right text-primary me-2"></i>
                                    <a href="${pageContext.request.contextPath}/">Ana Sayfa</a>
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-arrow-right text-primary me-2"></i>
                                    <a href="${pageContext.request.contextPath}/book/">Tüm Kitaplar</a>
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-arrow-right text-primary me-2"></i>
                                    <a href="${pageContext.request.contextPath}/book/add">Kitap Ekle</a>
                                </li>
                            </ul>
                        </div>
                        <div class="col-md-6">
                            <ul class="list-unstyled">
                                <li class="mb-2">
                                    <i class="bi bi-arrow-right text-primary me-2"></i>
                                    <a href="${pageContext.request.contextPath}/user/profile">Profilim</a>
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-arrow-right text-primary me-2"></i>
                                    <a href="${pageContext.request.contextPath}/review/">Yorumlarım</a>
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-arrow-right text-primary me-2"></i>
                                    <a href="javascript:history.back()">Önceki Sayfa</a>
                                </li>
                            </ul>
                        </div>
                    </div>
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
        background: var(--primary-gradient);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        line-height: 1;
        margin-bottom: 20px;
        text-shadow: 2px 2px 10px rgba(102, 126, 234, 0.3);
    }
    
    .error-image {
        margin: 30px 0;
        animation: float 3s ease-in-out infinite;
    }
    
    @keyframes float {
        0% { transform: translateY(0px); }
        50% { transform: translateY(-20px); }
        100% { transform: translateY(0px); }
    }
</style>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
    <div class="row">
        <div class="col-lg-8 mx-auto">
            <div class="card card-modern p-4">
                <div class="card-body">
                    <h3 class="fw-bold mb-4">
                        <i class="bi bi-pencil-square"></i> Profil Düzenle
                    </h3>
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            <i class="bi bi-exclamation-triangle-fill"></i> ${error}
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty success}">
                        <div class="alert alert-success" role="alert">
                            <i class="bi bi-check-circle-fill"></i> ${success}
                        </div>
                    </c:if>
                    
                    <form action="${pageContext.request.contextPath}/user/update-profile" method="post">
                        <div class="mb-3">
                            <label for="username" class="form-label">Kullanıcı Adı</label>
                            <input type="text" class="form-control search-box" id="username" name="username" 
                                   value="${user.username}" readonly>
                            <div class="form-text">Kullanıcı adı değiştirilemez</div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="fullName" class="form-label">Ad Soyad</label>
                            <input type="text" class="form-control search-box" id="fullName" name="fullName" 
                                   value="${user.fullName}" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="email" class="form-label">E-posta</label>
                            <input type="email" class="form-control search-box" id="email" name="email" 
                                   value="${user.email}" required>
                        </div>
                        
                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left"></i> Geri Dön
                            </a>
                            <button type="submit" class="btn btn-gradient-primary">
                                <i class="bi bi-save"></i> Değişiklikleri Kaydet
                            </button>
                        </div>
                    </form>
                    
                    <hr class="my-4">
                    
                    <h4 class="fw-bold mb-3">
                        <i class="bi bi-lock"></i> Şifre Değiştir
                    </h4>
                    
                    <form action="${pageContext.request.contextPath}/user/change-password" method="post">
                        <div class="mb-3">
                            <label for="currentPassword" class="form-label">Mevcut Şifre</label>
                            <input type="password" class="form-control search-box" id="currentPassword" name="currentPassword" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">Yeni Şifre</label>
                            <input type="password" class="form-control search-box" id="newPassword" name="newPassword" required>
                            <div class="form-text">En az 6 karakter olmalıdır</div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="confirmNewPassword" class="form-label">Yeni Şifre Tekrar</label>
                            <input type="password" class="form-control search-box" id="confirmNewPassword" name="confirmNewPassword" required>
                        </div>
                        
                        <div class="d-flex justify-content-end">
                            <button type="submit" class="btn btn-gradient-primary">
                                <i class="bi bi-lock"></i> Şifreyi Değiştir
                            </button>
                        </div>
                    </form>
                    
                    <hr class="my-4">
                    
                    <h4 class="fw-bold mb-3 text-danger">
                        <i class="bi bi-exclamation-triangle"></i> Hesabı Sil
                    </h4>
                    
                    <p class="text-muted">Bu işlem geri alınamaz. Tüm kitaplarınız, yorumlarınız ve kişisel bilgileriniz silinecektir.</p>
                    
                    <button class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteAccountModal">
                        <i class="bi bi-trash"></i> Hesabımı Sil
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Delete Account Modal -->
<div class="modal fade" id="deleteAccountModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title fw-bold text-danger">
                    <i class="bi bi-exclamation-triangle"></i> Hesabı Sil
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Hesabınızı silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.</p>
                <p>Tüm kitaplarınız, yorumlarınız ve kişisel bilgileriniz silinecektir.</p>
                
                <form id="deleteAccountForm" action="${pageContext.request.contextPath}/user/delete-account" method="post">
                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">Şifrenizi Girin</label>
                        <input type="password" class="form-control search-box" 
                               id="confirmPassword" name="confirmPassword" required>
                    </div>
                    
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" id="confirmDelete" required>
                        <label class="form-check-label" for="confirmDelete">
                            Hesabımı silmek istediğimi onaylıyorum
                        </label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">İptal</button>
                <button type="submit" form="deleteAccountForm" class="btn btn-danger">Hesabımı Sil</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

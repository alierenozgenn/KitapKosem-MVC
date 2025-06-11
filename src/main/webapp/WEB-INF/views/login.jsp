<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container">
    <div class="row justify-content-center align-items-center" style="min-height: 80vh;">
        <div class="col-md-6 col-lg-5">
            <div class="card card-modern p-4">
                <div class="card-body">
                    <!-- Header -->
                    <div class="text-center mb-4">
                        <div class="mb-3">
                            <i class="bi bi-book-half display-4" style="background: var(--primary-gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent;"></i>
                        </div>
                        <h2 class="fw-bold mb-2">Giriş Yap</h2>
                        <p class="text-muted">KitapKöşem hesabınıza giriş yapın</p>
                    </div>

                    <!-- Alert Messages -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="bi bi-check-circle"></i> ${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Login Form -->
                    <form action="${pageContext.request.contextPath}/user/login" method="post" id="loginForm">
                        <div class="mb-3">
                            <label for="username" class="form-label fw-semibold">
                                <i class="bi bi-person"></i> Kullanıcı Adı
                            </label>
                            <input type="text" class="form-control form-control-lg search-box" 
                                   id="username" name="username" required
                                   placeholder="Kullanıcı adınızı girin">
                        </div>

                        <div class="mb-4">
                            <label for="password" class="form-label fw-semibold">
                                <i class="bi bi-lock"></i> Şifre
                            </label>
                            <div class="input-group">
                                <input type="password" class="form-control form-control-lg search-box" 
                                       id="password" name="password" required
                                       placeholder="Şifrenizi girin" style="border-radius: 25px 0 0 25px;">
                                <button class="btn btn-outline-secondary" type="button" id="togglePassword" 
                                        style="border-radius: 0 25px 25px 0; border-left: none;">
                                    <i class="bi bi-eye" id="toggleIcon"></i>
                                </button>
                            </div>
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-gradient-primary btn-lg">
                                <i class="bi bi-box-arrow-in-right"></i> Giriş Yap
                            </button>
                        </div>
                    </form>

                    <!-- Divider -->
                    <div class="text-center mb-3">
                        <hr class="my-4">
                        <span class="text-muted bg-white px-3">veya</span>
                    </div>

                    <!-- Register Link -->
                    <div class="text-center">
                        <p class="mb-0">Hesabınız yok mu?</p>
                        <a href="${pageContext.request.contextPath}/user/register" 
                           class="btn btn-gradient-secondary btn-lg mt-2">
                            <i class="bi bi-person-plus"></i> Kayıt Ol
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Password toggle functionality
    document.getElementById('togglePassword').addEventListener('click', function() {
        const password = document.getElementById('password');
        const toggleIcon = document.getElementById('toggleIcon');
        
        if (password.type === 'password') {
            password.type = 'text';
            toggleIcon.classList.remove('bi-eye');
            toggleIcon.classList.add('bi-eye-slash');
        } else {
            password.type = 'password';
            toggleIcon.classList.remove('bi-eye-slash');
            toggleIcon.classList.add('bi-eye');
        }
    });

    // Form validation
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value;
        
        if (!username || !password) {
            e.preventDefault();
            alert('Lütfen tüm alanları doldurun!');
        }
    });
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

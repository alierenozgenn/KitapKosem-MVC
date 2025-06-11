<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container">
    <div class="row justify-content-center align-items-center" style="min-height: 80vh;">
        <div class="col-md-8 col-lg-6">
            <div class="card card-modern p-4">
                <div class="card-body">
                    <!-- Header -->
                    <div class="text-center mb-4">
                        <div class="mb-3">
                            <i class="bi bi-person-plus display-4" style="background: var(--secondary-gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent;"></i>
                        </div>
                        <h2 class="fw-bold mb-2">Kayıt Ol</h2>
                        <p class="text-muted">KitapKöşem ailesine katılın ve kitap dünyasını keşfedin</p>
                    </div>

                    <!-- Alert Messages -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Register Form -->
                    <form action="${pageContext.request.contextPath}/user/register" method="post" id="registerForm">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="fullName" class="form-label fw-semibold">
                                    <i class="bi bi-person-badge"></i> Ad Soyad
                                </label>
                                <input type="text" class="form-control form-control-lg search-box" 
                                       id="fullName" name="fullName" required
                                       placeholder="Adınız ve soyadınız"
                                       value="${param.fullName}">
                            </div>

                            <div class="col-md-6 mb-3">
                                <label for="username" class="form-label fw-semibold">
                                    <i class="bi bi-person"></i> Kullanıcı Adı
                                </label>
                                <input type="text" class="form-control form-control-lg search-box" 
                                       id="username" name="username" required
                                       placeholder="Kullanıcı adınız"
                                       value="${param.username}">
                                <div class="form-text">En az 3 karakter olmalıdır</div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label fw-semibold">
                                <i class="bi bi-envelope"></i> E-posta Adresi
                            </label>
                            <input type="email" class="form-control form-control-lg search-box" 
                                   id="email" name="email" required
                                   placeholder="ornek@email.com"
                                   value="${param.email}">
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="password" class="form-label fw-semibold">
                                    <i class="bi bi-lock"></i> Şifre
                                </label>
                                <div class="input-group">
                                    <input type="password" class="form-control form-control-lg search-box" 
                                           id="password" name="password" required
                                           placeholder="Şifreniz" style="border-radius: 25px 0 0 25px;">
                                    <button class="btn btn-outline-secondary" type="button" id="togglePassword" 
                                            style="border-radius: 0 25px 25px 0; border-left: none;">
                                        <i class="bi bi-eye" id="toggleIcon"></i>
                                    </button>
                                </div>
                                <div class="form-text">En az 6 karakter olmalıdır</div>
                            </div>

                            <div class="col-md-6 mb-4">
                                <label for="confirmPassword" class="form-label fw-semibold">
                                    <i class="bi bi-lock-fill"></i> Şifre Tekrar
                                </label>
                                <input type="password" class="form-control form-control-lg search-box" 
                                       id="confirmPassword" name="confirmPassword" required
                                       placeholder="Şifrenizi tekrar girin">
                                <div id="passwordMatch" class="form-text"></div>
                            </div>
                        </div>

                        <!-- Password Strength Indicator -->
                        <div class="mb-3">
                            <div class="progress" style="height: 5px;">
                                <div class="progress-bar" id="passwordStrength" role="progressbar" style="width: 0%"></div>
                            </div>
                            <small id="passwordStrengthText" class="text-muted"></small>
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-gradient-secondary btn-lg" id="submitBtn">
                                <i class="bi bi-person-plus"></i> Kayıt Ol
                            </button>
                        </div>
                    </form>

                    <!-- Divider -->
                    <div class="text-center mb-3">
                        <hr class="my-4">
                        <span class="text-muted bg-white px-3">veya</span>
                    </div>

                    <!-- Login Link -->
                    <div class="text-center">
                        <p class="mb-0">Zaten hesabınız var mı?</p>
                        <a href="${pageContext.request.contextPath}/user/login" 
                           class="btn btn-gradient-primary btn-lg mt-2">
                            <i class="bi bi-box-arrow-in-right"></i> Giriş Yap
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

    // Password strength checker
    document.getElementById('password').addEventListener('input', function() {
        const password = this.value;
        const strengthBar = document.getElementById('passwordStrength');
        const strengthText = document.getElementById('passwordStrengthText');
        
        let strength = 0;
        let text = '';
        let color = '';
        
        if (password.length >= 6) strength += 25;
        if (password.match(/[a-z]/)) strength += 25;
        if (password.match(/[A-Z]/)) strength += 25;
        if (password.match(/[0-9]/)) strength += 25;
        
        if (strength < 25) {
            text = 'Çok zayıf';
            color = 'bg-danger';
        } else if (strength < 50) {
            text = 'Zayıf';
            color = 'bg-warning';
        } else if (strength < 75) {
            text = 'Orta';
            color = 'bg-info';
        } else {
            text = 'Güçlü';
            color = 'bg-success';
        }
        
        strengthBar.style.width = strength + '%';
        strengthBar.className = 'progress-bar ' + color;
        strengthText.textContent = text;
    });

    // Password match checker
    document.getElementById('confirmPassword').addEventListener('input', function() {
        const password = document.getElementById('password').value;
        const confirmPassword = this.value;
        const matchDiv = document.getElementById('passwordMatch');
        const submitBtn = document.getElementById('submitBtn');
        
        if (confirmPassword === '') {
            matchDiv.textContent = '';
            matchDiv.className = 'form-text';
        } else if (password === confirmPassword) {
            matchDiv.textContent = '✓ Şifreler eşleşiyor';
            matchDiv.className = 'form-text text-success';
            submitBtn.disabled = false;
        } else {
            matchDiv.textContent = '✗ Şifreler eşleşmiyor';
            matchDiv.className = 'form-text text-danger';
            submitBtn.disabled = true;
        }
    });

    // Form validation
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        const fullName = document.getElementById('fullName').value.trim();
        const username = document.getElementById('username').value.trim();
        const email = document.getElementById('email').value.trim();
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        
        if (!fullName || !username || !email || !password || !confirmPassword) {
            e.preventDefault();
            alert('Lütfen tüm alanları doldurun!');
            return;
        }
        
        if (username.length < 3) {
            e.preventDefault();
            alert('Kullanıcı adı en az 3 karakter olmalıdır!');
            return;
        }
        
        if (password.length < 6) {
            e.preventDefault();
            alert('Şifre en az 6 karakter olmalıdır!');
            return;
        }
        
        if (password !== confirmPassword) {
            e.preventDefault();
            alert('Şifreler eşleşmiyor!');
            return;
        }
    });
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

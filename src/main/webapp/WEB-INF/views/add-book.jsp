<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <!-- Page Header -->
            <div class="text-center mb-4">
                <h1 class="fw-bold">
                    <i class="bi bi-plus-circle"></i> Yeni Kitap Ekle
                </h1>
                <p class="text-muted">KitapKöşem'e yeni bir kitap ekleyin ve diğer okuyucularla paylaşın</p>
            </div>

            <!-- Add Book Form -->
            <div class="card card-modern p-4">
                <div class="card-body">
                    <!-- Alert Messages -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/book/add" method="post" id="addBookForm">
                        <div class="row">
                            <!-- Book Title -->
                            <div class="col-md-8 mb-3">
                                <label for="title" class="form-label fw-semibold">
                                    <i class="bi bi-book"></i> Kitap Adı *
                                </label>
                                <input type="text" class="form-control form-control-lg search-box" 
                                       id="title" name="title" required
                                       placeholder="Kitabın tam adını girin"
                                       value="${param.title}">
                                <div class="form-text">Kitabın orijinal adını yazın</div>
                            </div>

                            <!-- Category -->
                            <div class="col-md-4 mb-3">
                                <label for="categoryId" class="form-label fw-semibold">
                                    <i class="bi bi-bookmark"></i> Kategori *
                                </label>
                                <select class="form-select form-select-lg search-box" id="categoryId" name="categoryId" required>
                                    <option value="">Kategori seçin</option>
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.id}" ${param.categoryId eq category.id ? 'selected' : ''}>
                                            ${category.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <!-- Author -->
                        <div class="mb-3">
                            <label for="author" class="form-label fw-semibold">
                                <i class="bi bi-person"></i> Yazar *
                            </label>
                            <input type="text" class="form-control form-control-lg search-box" 
                                   id="author" name="author" required
                                   placeholder="Yazarın adı ve soyadı"
                                   value="${param.author}">
                            <div class="form-text">Birden fazla yazar varsa virgülle ayırın</div>
                        </div>

                        <!-- Description -->
                        <div class="mb-4">
                            <label for="description" class="form-label fw-semibold">
                                <i class="bi bi-journal-text"></i> Kitap Açıklaması *
                            </label>
                            <textarea class="form-control search-box" id="description" name="description" 
                                      rows="6" required
                                      placeholder="Kitap hakkında detaylı bilgi verin. Konusu, türü, öne çıkan özellikleri...">${param.description}</textarea>
                            <div class="form-text">
                                <span id="charCount">0</span> / 1000 karakter
                                <small class="text-muted ms-2">En az 50 karakter yazın</small>
                            </div>
                        </div>

                        <!-- Guidelines -->
                        <div class="alert alert-info mb-4">
                            <h6 class="fw-bold mb-2">
                                <i class="bi bi-info-circle"></i> Kitap Ekleme Kuralları
                            </h6>
                            <ul class="mb-0 small">
                                <li>Kitap daha önce eklenmemiş olmalıdır</li>
                                <li>Açıklama en az 50 karakter olmalıdır</li>
                                <li>Doğru kategori seçimi yapın</li>
                                <li>Yazar adını doğru yazın</li>
                                <li>Uygunsuz içerik paylaşmayın</li>
                            </ul>
                        </div>

                        <!-- Form Actions -->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-gradient-primary btn-lg">
                                        <i class="bi bi-plus-circle"></i> Kitabı Ekle
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="d-grid">
                                    <a href="${pageContext.request.contextPath}/book/" class="btn btn-outline-secondary btn-lg">
                                        <i class="bi bi-arrow-left"></i> İptal Et
                                    </a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Tips Section -->
            <div class="row mt-4">
                <div class="col-md-6">
                    <div class="card bg-light border-0 p-3">
                        <h6 class="fw-bold mb-2">
                            <i class="bi bi-lightbulb"></i> İpuçları
                        </h6>
                        <ul class="small mb-0">
                            <li>Kitabın kapak resmini eklemek için gelecek güncellemeleri bekleyin</li>
                            <li>ISBN numarası ekleme özelliği yakında gelecek</li>
                            <li>Kitap hakkında objektif bilgi verin</li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card bg-light border-0 p-3">
                        <h6 class="fw-bold mb-2">
                            <i class="bi bi-award"></i> Katkı Puanları
                        </h6>
                        <ul class="small mb-0">
                            <li>Her kitap ekleme: +10 puan</li>
                            <li>Kaliteli açıklama: +5 bonus</li>
                            <li>İlk 10 kitap: +20 bonus</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const descriptionTextarea = document.getElementById('description');
        const charCountSpan = document.getElementById('charCount');
        const form = document.getElementById('addBookForm');
        
        // Character counter
        function updateCharCount() {
            const length = descriptionTextarea.value.length;
            charCountSpan.textContent = length;
            
            if (length < 50) {
                charCountSpan.className = 'text-danger fw-bold';
            } else if (length > 900) {
                charCountSpan.className = 'text-warning fw-bold';
            } else {
                charCountSpan.className = 'text-success fw-bold';
            }
        }
        
        descriptionTextarea.addEventListener('input', updateCharCount);
        updateCharCount(); // Initial count
        
        // Form validation
        form.addEventListener('submit', function(e) {
            const title = document.getElementById('title').value.trim();
            const author = document.getElementById('author').value.trim();
            const description = descriptionTextarea.value.trim();
            const categoryId = document.getElementById('categoryId').value;
            
            if (!title || title.length < 2) {
                e.preventDefault();
                alert('Kitap adı en az 2 karakter olmalıdır!');
                return;
            }
            
            if (!author || author.length < 2) {
                e.preventDefault();
                alert('Yazar adı en az 2 karakter olmalıdır!');
                return;
            }
            
            if (!description || description.length < 50) {
                e.preventDefault();
                alert('Açıklama en az 50 karakter olmalıdır!');
                return;
            }
            
            if (description.length > 1000) {
                e.preventDefault();
                alert('Açıklama en fazla 1000 karakter olabilir!');
                return;
            }
            
            if (!categoryId) {
                e.preventDefault();
                alert('Lütfen bir kategori seçin!');
                return;
            }
            
            // Show loading state
            const submitBtn = form.querySelector('button[type="submit"]');
            submitBtn.innerHTML = '<i class="bi bi-hourglass-split"></i> Ekleniyor...';
            submitBtn.disabled = true;
        });
        
        // Auto-save to localStorage (draft feature)
        function saveDraft() {
            const draft = {
                title: document.getElementById('title').value,
                author: document.getElementById('author').value,
                description: descriptionTextarea.value,
                categoryId: document.getElementById('categoryId').value
            };
            localStorage.setItem('bookDraft', JSON.stringify(draft));
        }
        
        function loadDraft() {
            const draft = localStorage.getItem('bookDraft');
            if (draft && !document.getElementById('title').value) {
                const data = JSON.parse(draft);
                if (confirm('Kaydedilmiş taslak bulundu. Yüklemek ister misiniz?')) {
                    document.getElementById('title').value = data.title || '';
                    document.getElementById('author').value = data.author || '';
                    descriptionTextarea.value = data.description || '';
                    document.getElementById('categoryId').value = data.categoryId || '';
                    updateCharCount();
                }
            }
        }
        
        // Auto-save every 30 seconds
        setInterval(saveDraft, 30000);
        
        // Load draft on page load
        loadDraft();
        
        // Clear draft on successful submit
        form.addEventListener('submit', function() {
            setTimeout(() => {
                localStorage.removeItem('bookDraft');
            }, 1000);
        });
    });
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

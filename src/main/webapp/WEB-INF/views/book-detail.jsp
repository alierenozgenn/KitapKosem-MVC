<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
<!-- Book Header -->
<div class="row mb-4">
    <div class="col-12">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Ana Sayfa</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/book/">Kitaplar</a></li>
                <li class="breadcrumb-item active">${book.title}</li>
            </ol>
        </nav>
    </div>
</div>

<!-- Book Details -->
<div class="row mb-5">
    <div class="col-lg-8">
        <div class="card card-modern p-4">
            <div class="card-body">
                <!-- Book Info Header -->
                <div class="d-flex justify-content-between align-items-start mb-4">
                    <div class="flex-grow-1">
                        <div class="d-flex align-items-center mb-2">
                            <span class="badge badge-modern me-3">${book.categoryName}</span>
                            <div class="rating-stars">
                                <c:forEach begin="1" end="5" var="star">
                                    <i class="bi ${star <= book.averageRating ? 'bi-star-fill' : 'bi-star'} fs-5"></i>
                                </c:forEach>
                                <span class="ms-2 fw-bold">
                                    <fmt:formatNumber value="${book.averageRating}" pattern="#.#"/>
                                </span>
                                <small class="text-muted ms-1">(${book.reviewCount} değerlendirme)</small>
                            </div>
                        </div>
                        
                        <h1 class="fw-bold mb-2">${book.title}</h1>
                        <h4 class="text-muted mb-3">
                            <i class="bi bi-person"></i> ${book.author}
                        </h4>
                    </div>
                </div>

                <!-- Book Description -->
                <div class="mb-4">
                    <h5 class="fw-bold mb-3">
                        <i class="bi bi-journal-text"></i> Kitap Hakkında
                    </h5>
                    <p class="lead">${book.description}</p>
                </div>

                <!-- Book Meta Info -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="card bg-light border-0 p-3">
                            <h6 class="fw-bold mb-2">
                                <i class="bi bi-info-circle"></i> Kitap Bilgileri
                            </h6>
                            <ul class="list-unstyled mb-0">
                                <li><strong>Kategori:</strong> ${book.categoryName}</li>
                                <li><strong>Ekleyen:</strong> ${book.addedByUsername}</li>
                                <li><strong>Eklenme Tarihi:</strong> 
                                    ${book.createdAt.toString().substring(0,10).replace('-', '.')}
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card bg-light border-0 p-3">
                            <h6 class="fw-bold mb-2">
                                <i class="bi bi-graph-up"></i> İstatistikler
                            </h6>
                            <ul class="list-unstyled mb-0">
                                <li><strong>Ortalama Puan:</strong> 
                                    <fmt:formatNumber value="${book.averageRating}" pattern="#.#"/> / 5.0
                                </li>
                                <li><strong>Toplam Yorum:</strong> ${book.reviewCount}</li>
                                <li><strong>Popülerlik:</strong> 
                                    <c:choose>
                                        <c:when test="${book.reviewCount >= 5}">
                                            <span class="badge bg-success">Çok Popüler</span>
                                        </c:when>
                                        <c:when test="${book.reviewCount >= 2}">
                                            <span class="badge bg-primary">Popüler</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Yeni</span>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Review Form Sidebar -->
    <div class="col-lg-4">
        <c:choose>
            <c:when test="${not empty sessionScope.user and canReview}">
                <div class="card card-modern p-3 mb-4">
                    <div class="card-body">
                        <h5 class="fw-bold mb-3">
                            <i class="bi bi-chat-dots"></i> Yorum Yap
                        </h5>
                        <form action="${pageContext.request.contextPath}/review/add" method="post" id="reviewForm">
                            <input type="hidden" name="bookId" value="${book.id}">
                            
                            <!-- Rating -->
                            <div class="mb-3">
                                <label for="ratingInput" class="form-label fw-semibold">Puanınız</label>
                                <div class="rating-input">
                                    <c:forEach begin="1" end="5" var="star">
                                        <i class="bi bi-star rating-star" data-rating="${star}"></i>
                                    </c:forEach>
                                </div>
                                <input type="hidden" name="rating" id="ratingInput" required>
                            </div>
                            
                            <!-- Comment -->
                            <div class="mb-3">
                                <label for="comment" class="form-label fw-semibold">Yorumunuz</label>
                                <textarea class="form-control search-box" id="comment" name="comment" 
                                          rows="4" placeholder="Bu kitap hakkındaki düşüncelerinizi paylaşın..." required></textarea>
                            </div>
                            
                            <div class="d-grid">
                                <button type="submit" class="btn btn-gradient-primary">
                                    <i class="bi bi-send"></i> Yorum Gönder
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </c:when>
            <c:when test="${not empty sessionScope.user and not canReview}">
                <div class="card card-modern p-3 mb-4">
                    <div class="card-body text-center">
                        <i class="bi bi-check-circle display-4 text-success mb-3"></i>
                        <h6 class="fw-bold">Yorumunuz Alındı</h6>
                        <p class="text-muted mb-0">Bu kitap için zaten yorum yapmışsınız.</p>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card card-modern p-3 mb-4">
                    <div class="card-body text-center">
                        <i class="bi bi-person-plus display-4 text-primary mb-3"></i>
                        <h6 class="fw-bold">Yorum Yapmak İçin</h6>
                        <p class="text-muted mb-3">Giriş yapmanız gerekiyor</p>
                        <a href="${pageContext.request.contextPath}/user/login" class="btn btn-gradient-primary btn-sm">
                            <i class="bi bi-box-arrow-in-right"></i> Giriş Yap
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Quick Stats -->
        <div class="card card-modern p-3">
            <div class="card-body">
                <h6 class="fw-bold mb-3">
                    <i class="bi bi-bar-chart"></i> Puan Dağılımı
                </h6>
                <!-- FIX: Negatif adım değeri kullanmak yerine 5'ten 1'e doğru manuel olarak listeleyeceğiz -->
                <c:forEach var="star" items="5,4,3,2,1">
                    <div class="d-flex align-items-center mb-2">
                        <span class="me-2">${star}</span>
                        <i class="bi bi-star-fill text-warning me-2"></i>
                        <div class="progress flex-grow-1 me-2 rating-progress">
                            <div class="progress-bar bg-warning rating-bar-${star}"></div>
                        </div>
                        <small class="text-muted">0</small>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<!-- Reviews Section -->
<div class="row">
    <div class="col-12">
        <div class="card card-modern p-4">
            <div class="card-body">
                <h4 class="fw-bold mb-4">
                    <i class="bi bi-chat-dots"></i> Yorumlar (${reviews.size()})
                </h4>
                
                <c:choose>
                    <c:when test="${empty reviews}">
                        <div class="text-center py-5">
                            <i class="bi bi-chat display-1 text-muted mb-3"></i>
                            <h5 class="text-muted">Henüz Yorum Yok</h5>
                            <p class="text-muted">Bu kitap için ilk yorumu siz yapın!</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="review" items="${reviews}" varStatus="status">
                            <div class="review-item ${not status.last ? 'border-bottom' : ''} pb-4 ${not status.last ? 'mb-4' : ''}">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <div class="d-flex align-items-center">
                                        <div class="avatar-circle me-3">
                                            <i class="bi bi-person-fill"></i>
                                        </div>
                                        <div>
                                            <h6 class="fw-bold mb-0">${review.username}</h6>
                                            <small class="text-muted">
                                                ${review.createdAt.toString().substring(0,10).replace('-', '.')}
                                            </small>
                                        </div>
                                    </div>
                                    <div class="rating-stars">
                                        <c:forEach begin="1" end="5" var="star">
                                            <i class="bi ${star <= review.rating ? 'bi-star-fill' : 'bi-star'}"></i>
                                        </c:forEach>
                                    </div>
                                </div>
                                <p class="mb-0">${review.comment}</p>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
</div>

<!-- CSS Styles -->
<style>
.avatar-circle {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
}

.rating-star {
    font-size: 1.5rem;
    color: #ddd;
    cursor: pointer;
    transition: color 0.2s ease;
    margin-right: 5px;
}

.rating-star:hover,
.rating-star.active {
    color: #ffc107;
}

.rating-input {
    margin: 10px 0;
}

.rating-progress {
    height: 8px;
}

.rating-bar-5 { width: 20%; }
.rating-bar-4 { width: 15%; }
.rating-bar-3 { width: 10%; }
.rating-bar-2 { width: 5%; }
.rating-bar-1 { width: 2%; }
</style>

<!-- JavaScript -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Rating system
    const ratingStars = document.querySelectorAll('.rating-star');
    const ratingInput = document.getElementById('ratingInput');
    
    ratingStars.forEach(star => {
        star.addEventListener('click', function() {
            const rating = this.dataset.rating;
            ratingInput.value = rating;
            
            // Update visual feedback
            ratingStars.forEach((s, index) => {
                if (index < rating) {
                    s.classList.remove('bi-star');
                    s.classList.add('bi-star-fill');
                    s.style.color = '#ffc107';
                } else {
                    s.classList.remove('bi-star-fill');
                    s.classList.add('bi-star');
                    s.style.color = '#ddd';
                }
            });
        });
        
        star.addEventListener('mouseover', function() {
            const rating = this.dataset.rating;
            ratingStars.forEach((s, index) => {
                if (index < rating) {
                    s.style.color = '#ffc107';
                } else {
                    s.style.color = '#ddd';
                }
            });
        });
        
        star.addEventListener('mouseleave', function() {
            const currentRating = ratingInput.value;
            ratingStars.forEach((s, index) => {
                if (index < currentRating) {
                    s.style.color = '#ffc107';
                } else {
                    s.style.color = '#ddd';
                }
            });
        });
    });

    // Form validation
    const reviewForm = document.getElementById('reviewForm');
    if (reviewForm) {
        reviewForm.addEventListener('submit', function(e) {
            const rating = ratingInput.value;
            const comment = document.getElementById('comment').value.trim();
            
            if (!rating) {
                e.preventDefault();
                alert('Lütfen bir puan verin!');
                return;
            }
            
            if (!comment) {
                e.preventDefault();
                alert('Lütfen yorumunuzu yazın!');
                return;
            }
            
            if (comment.length < 10) {
                e.preventDefault();
                alert('Yorumunuz en az 10 karakter olmalıdır!');
                return;
            }
        });
    }
});
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

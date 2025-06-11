<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="fw-bold">
                        <i class="bi bi-chat-dots"></i> Yorumlarım
                    </h1>
                    <p class="text-muted mb-0">
                        Toplam ${reviews.size()} yorum yaptınız
                    </p>
                </div>
                
                <a href="${pageContext.request.contextPath}/user/profile#reviews" class="btn btn-gradient-primary">
                    <i class="bi bi-person"></i> Profilime Dön
                </a>
            </div>
        </div>
    </div>

    <!-- Alert Messages -->
    <c:if test="${not empty param.success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle"></i> 
            <c:choose>
                <c:when test="${param.success eq 'review_deleted'}">
                    Yorum başarıyla silindi.
                </c:when>
                <c:otherwise>
                    İşlem başarıyla tamamlandı.
                </c:otherwise>
            </c:choose>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle"></i> 
            <c:choose>
                <c:when test="${param.error eq 'delete_failed'}">
                    Yorum silinemedi. Lütfen tekrar deneyin.
                </c:when>
                <c:otherwise>
                    Bir hata oluştu. Lütfen tekrar deneyin.
                </c:otherwise>
            </c:choose>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Reviews List -->
    <div class="row">
        <c:choose>
            <c:when test="${empty reviews}">
                <div class="col-12">
                    <div class="card card-modern text-center p-5">
                        <div class="card-body">
                            <i class="bi bi-chat display-1 text-muted mb-3"></i>
                            <h3 class="fw-bold text-muted">Henüz Yorum Yapmamışsınız</h3>
                            <p class="text-muted mb-4">
                                Kitaplar hakkında düşüncelerinizi paylaşmak için yorum yapabilirsiniz.
                            </p>
                            <a href="${pageContext.request.contextPath}/book/" class="btn btn-gradient-primary btn-lg">
                                <i class="bi bi-book"></i> Kitapları İncele
                            </a>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="review" items="${reviews}">
                    <div class="col-md-6 mb-4">
                        <div class="card card-modern h-100">
                            <div class="card-body d-flex flex-column">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <h5 class="fw-bold mb-0">${review.bookTitle}</h5>
                                    <div class="rating-stars">
                                        <c:forEach begin="1" end="5" var="star">
                                            <i class="bi ${star <= review.rating ? 'bi-star-fill' : 'bi-star'}"></i>
                                        </c:forEach>
                                    </div>
                                </div>
                                
                                <p class="text-muted mb-2">
                                    <i class="bi bi-person"></i> ${review.bookAuthor}
                                </p>
                                
                                <p class="card-text flex-grow-1">${review.comment}</p>
                                
                                <div class="mt-auto">
                                    <hr class="my-3">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <small class="text-muted">
                                            <i class="bi bi-calendar"></i> 
                                            ${review.createdAt.toString().substring(0,16).replace('T', ' ').replace('-', '.')}
                                        </small>
                                        <div>
                                            <a href="${pageContext.request.contextPath}/book/detail/${review.bookId}" 
                                               class="btn btn-outline-primary btn-sm me-2">
                                                <i class="bi bi-eye"></i> Kitabı Gör
                                            </a>
                                            <button class="btn btn-outline-danger btn-sm" 
                                                    data-review-id="${review.id}"
                                                    onclick="confirmDeleteReview(this.getAttribute('data-review-id'))">
                                                <i class="bi bi-trash"></i> Sil
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
    // Confirm review deletion
    function confirmDeleteReview(reviewId) {
        if (confirm('Bu yorumu silmek istediğinizden emin misiniz?')) {
            var contextPath = '${pageContext.request.contextPath}';
            window.location.href = contextPath + '/review/delete/' + reviewId;
        }
    }
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

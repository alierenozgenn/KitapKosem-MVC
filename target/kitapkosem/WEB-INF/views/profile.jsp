<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
    <div class="row">
        <!-- Profil Bilgileri -->
        <div class="col-lg-4 mb-4">
            <div class="card card-modern p-4">
                <div class="card-body">
                    <div class="text-center mb-4">
                        <div class="avatar-circle-large mx-auto mb-3">
                            <i class="bi bi-person-fill display-4"></i>
                        </div>
                        <h4 class="fw-bold">${user.username}</h4>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-9">
                            <p class="text-muted mb-0">
                                <i class="bi bi-envelope"></i> ${user.email}
                            </p>
                            <p class="text-muted mb-0">
                                <i class="bi bi-calendar"></i> Üyelik: 
                                ${user.createdAt.toString().substring(0,10).replace('-', '.')}
                            </p>
                        </div>
                        <div class="col-md-3 text-md-end mt-3 mt-md-0">
                            <a href="${pageContext.request.contextPath}/user/edit" class="btn btn-sm btn-outline-primary">
                                <i class="bi bi-pencil"></i> Düzenle
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="card card-modern p-4 mt-4">
                <div class="card-body">
                    <h5 class="fw-bold mb-3">
                        <i class="bi bi-graph-up"></i> İstatistikler
                    </h5>
                    <div class="row text-center">
                        <div class="col-4">
                            <div class="stat-circle mx-auto mb-2">
                                <i class="bi bi-book"></i>
                            </div>
                            <h6 class="fw-bold mb-0">${userStats.bookCount}</h6>
                            <small class="text-muted">Kitap</small>
                        </div>
                        <div class="col-4">
                            <div class="stat-circle mx-auto mb-2">
                                <i class="bi bi-chat-dots"></i>
                            </div>
                            <h6 class="fw-bold mb-0">${userStats.reviewCount}</h6>
                            <small class="text-muted">Yorum</small>
                        </div>
                        <div class="col-4">
                            <div class="stat-circle mx-auto mb-2">
                                <i class="bi bi-star"></i>
                            </div>
                            <h6 class="fw-bold mb-0">
                                <fmt:formatNumber value="${userStats.averageRating}" pattern="#.#"/>
                            </h6>
                            <small class="text-muted">Ort. Puan</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Kullanıcı Aktiviteleri -->
        <div class="col-lg-8">
            <div class="card card-modern p-4">
                <div class="card-body">
                    <ul class="nav nav-tabs mb-4" id="profileTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="books-tab" data-bs-toggle="tab" data-bs-target="#books" type="button" role="tab" aria-controls="books" aria-selected="true">
                                <i class="bi bi-book"></i> Kitaplarım
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" data-bs-target="#reviews" type="button" role="tab" aria-controls="reviews" aria-selected="false">
                                <i class="bi bi-chat-dots"></i> Yorumlarım
                            </button>
                        </li>
                    </ul>
                    
                    <div class="tab-content" id="profileTabsContent">
                        <!-- Kitaplar Tab -->
                        <div class="tab-pane fade show active" id="books" role="tabpanel" aria-labelledby="books-tab">
                            <c:choose>
                                <c:when test="${empty userBooks}">
                                    <div class="text-center py-5">
                                        <i class="bi bi-book display-1 text-muted mb-3"></i>
                                        <h5 class="text-muted">Henüz Kitap Eklememişsiniz</h5>
                                        <p class="text-muted">Kütüphaneye katkıda bulunmak için kitap ekleyebilirsiniz.</p>
                                        <a href="${pageContext.request.contextPath}/book/add" class="btn btn-gradient-primary">
                                            <i class="bi bi-plus-circle"></i> Kitap Ekle
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <h5 class="fw-bold mb-0">Eklediğiniz Kitaplar</h5>
                                        <a href="${pageContext.request.contextPath}/book/add" class="btn btn-sm btn-gradient-primary">
                                            <i class="bi bi-plus-circle"></i> Kitap Ekle
                                        </a>
                                    </div>
                                    
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Kitap</th>
                                                    <th>Kategori</th>
                                                    <th>Eklenme Tarihi</th>
                                                    <th>Puan</th>
                                                    <th>İşlemler</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="book" items="${userBooks}">
                                                    <tr>
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/book/detail/${book.id}" class="fw-bold text-decoration-none">
                                                                ${book.title}
                                                            </a>
                                                            <div class="text-muted small">${book.author}</div>
                                                        </td>
                                                        <td>${book.categoryName}</td>
                                                        <td>${book.createdAt.toString().substring(0,10).replace('-', '.')}</td>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <i class="bi bi-star-fill text-warning me-1"></i>
                                                                <fmt:formatNumber value="${book.averageRating}" pattern="#.#"/>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/book/edit/${book.id}" class="btn btn-sm btn-outline-primary me-1">
                                                                <i class="bi bi-pencil"></i>
                                                            </a>
                                                            <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteModal${book.id}">
                                                                <i class="bi bi-trash"></i>
                                                            </button>
                                                            
                                                            <!-- Delete Modal -->
                                                            <div class="modal fade" id="deleteModal${book.id}" tabindex="-1" aria-labelledby="deleteModalLabel${book.id}" aria-hidden="true">
                                                                <div class="modal-dialog">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title" id="deleteModalLabel${book.id}">Kitabı Sil</h5>
                                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <p>"${book.title}" kitabını silmek istediğinizden emin misiniz?</p>
                                                                            <p class="text-danger">Bu işlem geri alınamaz!</p>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">İptal</button>
                                                                            <form action="${pageContext.request.contextPath}/book/delete/${book.id}" method="post">
                                                                                <button type="submit" class="btn btn-danger">Sil</button>
                                                                            </form>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <!-- Yorumlar Tab -->
                        <div class="tab-pane fade" id="reviews" role="tabpanel" aria-labelledby="reviews-tab">
                            <c:choose>
                                <c:when test="${empty userReviews}">
                                    <div class="text-center py-5">
                                        <i class="bi bi-chat-dots display-1 text-muted mb-3"></i>
                                        <h5 class="text-muted">Henüz Yorum Yapmamışsınız</h5>
                                        <p class="text-muted">Kitaplar hakkında düşüncelerinizi paylaşabilirsiniz.</p>
                                        <a href="${pageContext.request.contextPath}/book/" class="btn btn-gradient-primary">
                                            <i class="bi bi-book"></i> Kitaplara Göz At
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <h5 class="fw-bold mb-3">Yaptığınız Yorumlar</h5>
                                    
                                    <c:forEach var="review" items="${userReviews}" varStatus="status">
                                        <div class="review-item ${not status.last ? 'border-bottom' : ''} pb-4 ${not status.last ? 'mb-4' : ''}">
                                            <div class="d-flex justify-content-between align-items-start mb-2">
                                                <div>
                                                    <a href="${pageContext.request.contextPath}/book/detail/${review.bookId}" class="fw-bold text-decoration-none">
                                                        ${review.bookTitle}
                                                    </a>
                                                    <div class="text-muted small">
                                                        <i class="bi bi-person"></i> ${review.bookAuthor}
                                                    </div>
                                                </div>
                                                <div>
                                                    <div class="rating-stars">
                                                        <c:forEach begin="1" end="5" var="star">
                                                            <i class="bi ${star <= review.rating ? 'bi-star-fill' : 'bi-star'} text-warning"></i>
                                                        </c:forEach>
                                                    </div>
                                                    <div class="text-muted small text-end">
                                                        ${review.createdAt.toString().substring(0,10).replace('-', '.')}
                                                    </div>
                                                </div>
                                            </div>
                                            <p class="mb-0">${review.comment}</p>
                                            <div class="mt-2 text-end">
                                                <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteReviewModal${review.id}">
                                                    <i class="bi bi-trash"></i> Yorumu Sil
                                                </button>
                                                
                                                <!-- Delete Review Modal -->
                                                <div class="modal fade" id="deleteReviewModal${review.id}" tabindex="-1" aria-labelledby="deleteReviewModalLabel${review.id}" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="deleteReviewModalLabel${review.id}">Yorumu Sil</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <p>"${review.bookTitle}" kitabına yaptığınız yorumu silmek istediğinizden emin misiniz?</p>
                                                                <p class="text-danger">Bu işlem geri alınamaz!</p>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">İptal</button>
                                                                <form action="${pageContext.request.contextPath}/review/delete/${review.id}" method="post">
                                                                    <button type="submit" class="btn btn-danger">Sil</button>
                                                                </form>
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
                </div>
            </div>
        </div>
    </div>
</div>

<!-- CSS Styles -->
<style>
.avatar-circle-large {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
}

.stat-circle {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 1.2rem;
}

.nav-tabs .nav-link {
    color: #6c757d;
    border: none;
    border-bottom: 2px solid transparent;
    padding: 0.5rem 1rem;
}

.nav-tabs .nav-link.active {
    color: #764ba2;
    background: none;
    border-bottom: 2px solid #764ba2;
}

.nav-tabs .nav-link:hover {
    border-color: transparent;
    border-bottom: 2px solid #764ba2;
}

.review-item {
    transition: all 0.2s ease;
}

.review-item:hover {
    background-color: rgba(0, 0, 0, 0.01);
}
</style>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

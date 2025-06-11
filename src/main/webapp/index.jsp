<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<!-- Hero Section -->
<div class="hero-section text-center">
    <div class="container">
        <h1 class="display-4 fw-bold mb-4">
            <i class="bi bi-book-half"></i> KitapKöşem'e Hoş Geldiniz!
        </h1>
        <p class="lead mb-4">
            Kitapları keşfedin, inceleyin ve diğer okuyucularla deneyimlerinizi paylaşın
        </p>
        <div class="row justify-content-center">
            <div class="col-md-6">
                <form action="${pageContext.request.contextPath}/book/search" method="get" class="mb-4">
                    <div class="input-group input-group-lg">
                        <input type="text" class="form-control search-box" name="q" 
                               placeholder="Hangi kitabı arıyorsunuz?" style="border-radius: 25px 0 0 25px;">
                        <button class="btn btn-gradient-secondary" type="submit" style="border-radius: 0 25px 25px 0;">
                            <i class="bi bi-search"></i> Ara
                        </button>
                    </div>
                </form>
            </div>
        </div>
        
        <c:if test="${empty sessionScope.user}">
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/user/register" class="btn btn-gradient-secondary btn-lg me-3">
                    <i class="bi bi-person-plus"></i> Hemen Kayıt Ol
                </a>
                <a href="${pageContext.request.contextPath}/user/login" class="btn btn-outline-light btn-lg">
                    <i class="bi bi-box-arrow-in-right"></i> Giriş Yap
                </a>
            </div>
        </c:if>
    </div>
</div>

<!-- Main Content -->
<div class="container">
    <!-- Stats Section -->
    <div class="row mb-5">
        <div class="col-md-4 mb-3">
            <div class="card card-modern text-center p-4">
                <div class="card-body">
                    <i class="bi bi-book display-4 text-primary mb-3"></i>
                    <h3 class="fw-bold">${books.size()}</h3>
                    <p class="text-muted mb-0">Toplam Kitap</p>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card card-modern text-center p-4">
                <div class="card-body">
                    <i class="bi bi-people display-4 text-success mb-3"></i>
                    <h3 class="fw-bold">1000+</h3>
                    <p class="text-muted mb-0">Aktif Okuyucu</p>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card card-modern text-center p-4">
                <div class="card-body">
                    <i class="bi bi-chat-dots display-4 text-warning mb-3"></i>
                    <h3 class="fw-bold">5000+</h3>
                    <p class="text-muted mb-0">Kitap İncelemesi</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Categories Section -->
    <div class="row mb-5">
        <div class="col-12">
            <h2 class="text-center mb-4 fw-bold">Kategoriler</h2>
            <div class="row">
                <c:forEach var="category" items="${categories}">
                    <div class="col-md-3 col-sm-6 mb-3">
                        <a href="${pageContext.request.contextPath}/book/?category=${category.id}" 
                           class="text-decoration-none">
                            <div class="card card-modern text-center p-3 h-100">
                                <div class="card-body">
                                    <i class="bi bi-bookmark display-6 text-primary mb-2"></i>
                                    <h6 class="fw-bold">${category.name}</h6>
                                    <small class="text-muted">${category.description}</small>
                                </div>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <!-- Recent Books Section -->
    <div class="row">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold">Son Eklenen Kitaplar</h2>
                <a href="${pageContext.request.contextPath}/book/" class="btn btn-gradient-primary">
                    <i class="bi bi-arrow-right"></i> Tümünü Gör
                </a>
            </div>
            
            <div class="row">
                <c:forEach var="book" items="${books}" begin="0" end="7">
                    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                        <div class="card card-modern h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <span class="badge badge-modern">${book.categoryName}</span>
                                    <div class="rating-stars">
                                        <c:forEach begin="1" end="5" var="star">
                                            <i class="bi ${star <= book.averageRating ? 'bi-star-fill' : 'bi-star'}"></i>
                                        </c:forEach>
                                        <small class="text-muted ms-1">(${book.reviewCount})</small>
                                    </div>
                                </div>
                                
                                <h6 class="card-title fw-bold">${book.title}</h6>
                                <p class="text-muted small mb-2">
                                    <i class="bi bi-person"></i> ${book.author}
                                </p>
                                <p class="card-text small text-muted">
                                    ${book.description.length() > 100 ? 
                                      book.description.substring(0, 100).concat('...') : 
                                      book.description}
                                </p>
                                
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <small class="text-muted">
                                        <i class="bi bi-person-plus"></i> ${book.addedByUsername}
                                    </small>
                                    <a href="${pageContext.request.contextPath}/book/detail/${book.id}" 
                                       class="btn btn-gradient-primary btn-sm">
                                        <i class="bi bi-eye"></i> İncele
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

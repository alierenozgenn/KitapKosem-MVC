<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
    <!-- Hero Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card card-modern p-4 bg-gradient-primary text-white">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-lg-8">
                            <h1 class="display-4 fw-bold mb-3">Kitap Köşem</h1>
                            <p class="lead mb-4">Kitapları keşfedin, yorumlayın ve kütüphaneye katkıda bulunun.</p>
                            <div class="d-flex flex-wrap gap-2">
                                <a href="#books" class="btn btn-light btn-lg">
                                    <i class="bi bi-book"></i> Kitaplara Göz At
                                </a>
                                <c:if test="${not empty sessionScope.user}">
                                    <a href="${pageContext.request.contextPath}/book/add" class="btn btn-outline-light btn-lg">
                                        <i class="bi bi-plus-circle"></i> Kitap Ekle
                                    </a>
                                </c:if>
                            </div>
                        </div>
                        <div class="col-lg-4 d-none d-lg-block">
                            <div class="hero-image text-center">
                                <i class="bi bi-book display-1 text-white-50"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Search and Filter Section -->
    <div class="row mb-4">
        <div class="col-md-8">
            <form action="${pageContext.request.contextPath}/book/search" method="get" class="d-flex">
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0">
                        <i class="bi bi-search"></i>
                    </span>
                    <input type="text" name="q" class="form-control search-box border-start-0" placeholder="Kitap veya yazar ara..." value="${searchTerm}">
                    <button type="submit" class="btn btn-gradient-primary">Ara</button>
                </div>
            </form>
        </div>
        <div class="col-md-4 mt-3 mt-md-0">
            <select class="form-select search-box" id="categoryFilter" onchange="filterByCategory(this.value)">
                <option value="">Tüm Kategoriler</option>
                <c:forEach var="category" items="${categories}">
                    <option value="${category.id}" ${param.category eq category.id ? 'selected' : ''}>
                        ${category.name}
                    </option>
                </c:forEach>
            </select>
        </div>
    </div>
    
    <!-- Books Section -->
    <div class="row mb-4" id="books">
        <div class="col-12">
            <div class="card card-modern p-4">
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty searchTerm}">
                            <h4 class="fw-bold mb-4">
                                <i class="bi bi-search"></i> "${searchTerm}" için Arama Sonuçları
                                <span class="badge bg-primary">${books.size()} sonuç</span>
                            </h4>
                        </c:when>
                        <c:when test="${not empty param.category}">
                            <c:forEach var="category" items="${categories}">
                                <c:if test="${category.id eq param.category}">
                                    <h4 class="fw-bold mb-4">
                                        <i class="bi bi-grid"></i> ${category.name} Kategorisi
                                        <span class="badge bg-primary">${books.size()} kitap</span>
                                    </h4>
                                </c:if>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <h4 class="fw-bold mb-4">
                                <i class="bi bi-book"></i> Tüm Kitaplar
                                <span class="badge bg-primary">${books.size()} kitap</span>
                            </h4>
                        </c:otherwise>
                    </c:choose>
                    
                    <c:choose>
                        <c:when test="${empty books}">
                            <div class="text-center py-5">
                                <i class="bi bi-search display-1 text-muted mb-3"></i>
                                <h5 class="text-muted">Sonuç Bulunamadı</h5>
                                <p class="text-muted">Farklı anahtar kelimelerle tekrar arayabilir veya tüm kitaplara göz atabilirsiniz.</p>
                                <a href="${pageContext.request.contextPath}/book/" class="btn btn-gradient-primary">
                                    <i class="bi bi-book"></i> Tüm Kitaplar
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                                <c:forEach var="book" items="${books}">
                                    <div class="col">
                                        <div class="card h-100 book-card">
                                            <div class="card-body">
                                                <span class="badge badge-modern mb-2">${book.categoryName}</span>
                                                <h5 class="card-title fw-bold mb-1">${book.title}</h5>
                                                <h6 class="card-subtitle mb-3 text-muted">${book.author}</h6>
                                                <p class="card-text mb-3">
                                                    ${book.description.length() > 100 ? book.description.substring(0, 100).concat('...') : book.description}
                                                </p>
                                                <div class="d-flex align-items-center mb-3">
                                                    <div class="rating-stars me-2">
                                                        <c:forEach begin="1" end="5" var="star">
                                                            <i class="bi ${star <= book.averageRating ? 'bi-star-fill' : 'bi-star'} text-warning"></i>
                                                        </c:forEach>
                                                    </div>
                                                    <span class="fw-bold">
                                                        <fmt:formatNumber value="${book.averageRating}" pattern="#.#"/>
                                                    </span>
                                                    <span class="text-muted ms-1">(${book.reviewCount})</span>
                                                </div>
                                            </div>
                                            <div class="card-footer bg-white border-top-0 d-flex justify-content-between align-items-center">
                                                <small class="text-muted">
                                                    <i class="bi bi-person-plus"></i> ${book.addedByUsername}
                                                    <br>
                                                    <i class="bi bi-calendar"></i> 
                                                    ${book.createdAt.toString().substring(0,10).replace('-', '.')}
                                                </small>
                                                <a href="${pageContext.request.contextPath}/book/detail/${book.id}" 
                                                   class="btn btn-gradient-primary">
                                                    <i class="bi bi-eye"></i> İncele
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- CSS Styles -->
<style>
.book-card {
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    border: none;
    box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
}

.book-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
}

.badge-modern {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    font-weight: 500;
    padding: 0.35em 0.65em;
    border-radius: 0.25rem;
}

.search-box {
    border-radius: 0.5rem;
    padding: 0.75rem 1rem;
}

.rating-stars {
    line-height: 1;
}
</style>

<!-- JavaScript -->
<script>
function filterByCategory(categoryId) {
    if (categoryId) {
        window.location.href = "${pageContext.request.contextPath}/book/?category=" + categoryId;
    } else {
        window.location.href = "${pageContext.request.contextPath}/book/";
    }
}
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

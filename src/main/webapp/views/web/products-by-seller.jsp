<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh Sách Sản Phẩm Theo Cửa Hàng - Đề 05</title>
    <style>
        .seller-header {
            background: linear-gradient(135deg, #e0f2fe 0%, #f0fdf4 100%);
            border-left: 5px solid #0284c7;
            padding: 14px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }
        .product-card {
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            transition: all 0.3s ease;
            background: #ffffff;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px -8px rgba(0, 0, 0, 0.15);
            border-color: #38bdf8;
        }
        .product-img-wrapper {
            height: 200px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8fafc;
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
        }
        .product-img {
            max-height: 100%;
            max-width: 100%;
            object-fit: cover;
            transition: transform 0.4s ease;
        }
        .product-card:hover .product-img {
            transform: scale(1.05);
        }
        .product-title-link {
            color: #0f172a;
            text-decoration: none;
            font-weight: 600;
            font-size: 1.05rem;
            transition: color 0.2s;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .product-title-link:hover {
            color: #0284c7;
            text-decoration: underline;
        }
        .price-tag {
            color: #e11d48;
            font-weight: 700;
            font-size: 1.15rem;
        }
    </style>
</head>
<body>
    <div class="container my-4">

        <div class="p-4 mb-4 rounded-4 shadow-sm text-white" style="background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);">
            <h2 class="fw-bold mb-2"><i class="fa-solid fa-shop me-2"></i>Sản Phẩm Theo Cửa Hàng (Seller)</h2>
            <p class="mb-0 text-light opacity-90">Hiển thị toàn bộ danh sách sản phẩm được phân loại và gom nhóm theo từng Seller (Mã đề 05 - MSSV: 24110388)</p>
        </div>

        <c:choose>
            <c:when test="${empty sellersWithProducts}">
                <div class="alert alert-info text-center py-5 shadow-sm rounded-3">
                    <i class="fa-solid fa-box-open fs-1 text-secondary mb-3 d-block"></i>
                    <h5>Hiện tại chưa có cửa hàng hoặc sản phẩm nào trong hệ thống!</h5>
                </div>
            </c:when>
            <c:otherwise>

                <c:forEach items="${sellersWithProducts}" var="seller">
                    <section class="seller-group mb-5">

                        <div class="seller-header d-flex justify-content-between align-items-center flex-wrap gap-2">
                            <div class="d-flex align-items-center gap-3">
                                <img src="${empty seller.images ? 'https://placehold.co/80x80?text=Shop' : (seller.images.startsWith('http') ? seller.images : (seller.images.startsWith(pageContext.request.contextPath) ? seller.images : (seller.images.startsWith('/') ? pageContext.request.contextPath.concat(seller.images) : pageContext.request.contextPath.concat('/uploads/').concat(seller.images))))}"
                                     alt="${seller.sellername}" class="rounded-circle border shadow-sm" style="width: 48px; height: 48px; object-fit: cover;">
                                <div>
                                    <h4 class="mb-0 fw-bold text-dark">
                                        Mã cửa hàng: ${seller.sellerId} - ${seller.sellername}
                                    </h4>
                                    <c:choose>
                                        <c:when test="${seller.status == 1}">
                                            <span class="badge bg-success-subtle text-success border border-success-subtle mt-1">
                                                <i class="fa-solid fa-door-open me-1"></i>Đang mở cửa
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger-subtle text-danger border border-danger-subtle mt-1">
                                                <i class="fa-solid fa-door-closed me-1"></i>Tạm đóng cửa
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:if test="${not empty sessionScope.account and (sessionScope.account.seller != null and sessionScope.account.seller.sellerId == seller.sellerId or sessionScope.account.role.roleId == 1)}">
                                        <a href="${pageContext.request.contextPath}/seller/shop?id=${seller.sellerId}" class="badge bg-warning-subtle text-warning-emphasis border border-warning-subtle text-decoration-none mt-1 ms-1">
                                            <i class="fa-solid fa-pen-to-square me-1"></i>Cài đặt cửa hàng
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                            <span class="badge bg-primary rounded-pill px-3 py-2 fs-6">
                                ${seller.products != null ? seller.products.size() : 0} sản phẩm
                            </span>
                        </div>

                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
                            <c:choose>
                                <c:when test="${empty seller.products}">
                                    <div class="col-12">
                                        <p class="text-muted fst-italic ps-3">Cửa hàng này hiện chưa đăng sản phẩm nào.</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${seller.products}" var="p">
                                        <div class="col">
                                            <div class="product-card">

                                                <div class="product-img-wrapper">
                                                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.productId}">
                                                        <img src="${empty p.images ? 'https://placehold.co/300x200?text=Product' : (p.images.startsWith('http') ? p.images : (p.images.startsWith(pageContext.request.contextPath) ? p.images : (p.images.startsWith('/') ? pageContext.request.contextPath.concat(p.images) : pageContext.request.contextPath.concat('/uploads/').concat(p.images))))}"
                                                             class="product-img" alt="${p.productName}">
                                                    </a>
                                                </div>

                                                <div class="p-3 d-flex flex-column flex-grow-1">

                                                    <h5 class="mb-2">
                                                        <a href="${pageContext.request.contextPath}/product-detail?id=${p.productId}"
                                                           class="product-title-link" title="${p.productName}">
                                                            ${p.productName}
                                                        </a>
                                                    </h5>

                                                    <div class="text-muted small mb-1">
                                                        <i class="fa-solid fa-barcode me-1"></i> Mã sản phẩm:
                                                        <strong class="text-dark">${p.productCode != null ? p.productCode : p.productId}</strong>
                                                    </div>

                                                    <div class="text-muted small mb-2">
                                                        <i class="fa-solid fa-tag me-1 text-primary"></i> Danh mục:
                                                        <span class="badge bg-light text-dark border">
                                                            ${p.category != null ? p.category.categoryName : 'Chưa phân loại'}
                                                        </span>
                                                    </div>

                                                    <div class="mt-auto pt-2 border-top d-flex justify-content-between align-items-center">
                                                        <div>
                                                            <div class="text-secondary small" style="font-size: 0.75rem;">Giá bán</div>
                                                            <div class="price-tag">
                                                                <fmt:formatNumber value="${p.price}" pattern="#,###"/> đ
                                                            </div>
                                                        </div>
                                                        <div class="text-end">
                                                            <div class="text-secondary small" style="font-size: 0.75rem;">Số lượng</div>
                                                            <span class="badge ${p.amount > 0 ? 'bg-info-subtle text-info-emphasis' : 'bg-danger-subtle text-danger'} fw-semibold">
                                                                Amount: ${p.amount}
                                                            </span>
                                                        </div>
                                                    </div>

                                                    <div class="d-flex gap-2 mt-3">
                                                        <a href="${pageContext.request.contextPath}/product-detail?id=${p.productId}"
                                                           class="btn btn-outline-secondary btn-sm flex-grow-1 rounded-pill">
                                                            <i class="fa-solid fa-circle-info me-1"></i> Chi tiết
                                                        </a>
                                                        <c:choose>
                                                            <c:when test="${p.amount != null and p.amount > 0}">
                                                                <a href="${pageContext.request.contextPath}/cart?action=add&productId=${p.productId}&quantity=1"
                                                                   class="btn btn-primary btn-sm rounded-pill px-3" title="Thêm vào giỏ hàng">
                                                                    <i class="fa-solid fa-cart-plus"></i>
                                                                </a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button class="btn btn-light btn-sm rounded-pill px-3 text-muted border" disabled title="Hết hàng">
                                                                    <i class="fa-solid fa-ban"></i>
                                                                </button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </section>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>

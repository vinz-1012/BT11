<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi Tiết Sản Phẩm: ${product.productName} - Đề 05</title>
    <style>
        .product-gallery {
            background-color: #ffffff;
            border-radius: 16px;
            padding: 24px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            text-align: center;
        }
        .main-product-img {
            max-width: 100%;
            max-height: 420px;
            object-fit: contain;
            border-radius: 12px;
        }
        .product-meta-card {
            background-color: #ffffff;
            border-radius: 16px;
            padding: 32px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }
        .price-highlight {
            font-size: 2rem;
            color: #e11d48;
            font-weight: 800;
        }
    </style>
</head>
<body>
    <div class="container my-4">

        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang Chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products-by-seller" class="text-decoration-none">Sản Phẩm</a></li>
                <li class="breadcrumb-item active" aria-current="page">${product.productName}</li>
            </ol>
        </nav>

        <div class="row g-4">

            <div class="col-lg-5">
                <div class="product-gallery">
                    <img src="${empty product.images ? 'https://placehold.co/500x400?text=Product' : (product.images.startsWith('http') ? product.images : (product.images.startsWith(pageContext.request.contextPath) ? product.images : (product.images.startsWith('/') ? pageContext.request.contextPath.concat(product.images) : pageContext.request.contextPath.concat('/uploads/').concat(product.images))))}"
                         alt="${product.productName}" class="main-product-img img-fluid">
                </div>
            </div>

            <div class="col-lg-7">
                <div class="product-meta-card">

                    <h2 class="fw-bold text-dark mb-3">${product.productName}</h2>

                    <div class="d-flex flex-wrap gap-3 mb-3">
                        <div class="badge bg-secondary-subtle text-secondary-emphasis px-3 py-2 fs-6">
                            <i class="fa-solid fa-barcode me-1"></i> Mã sản phẩm:
                            <strong>${product.productCode != null ? product.productCode : product.productId}</strong>
                        </div>
                        <div class="badge bg-primary-subtle text-primary px-3 py-2 fs-6">
                            <i class="fa-solid fa-layer-group me-1"></i> Danh mục:
                            <strong>${product.category != null ? product.category.categoryName : 'Không có'}</strong>
                        </div>
                        <c:if test="${product.seller != null}">
                            <div class="badge bg-warning-subtle text-warning-emphasis px-3 py-2 fs-6">
                                <i class="fa-solid fa-store me-1"></i> Cửa hàng:
                                <strong>${product.seller.sellername} (Mã: ${product.seller.sellerId})</strong>
                            </div>
                        </c:if>
                    </div>

                    <div class="p-3 my-3 rounded-3 bg-light border">
                        <span class="text-muted d-block small">Giá bán chính thức:</span>
                        <span class="price-highlight">
                            <fmt:formatNumber value="${product.price}" pattern="#,###"/> VNĐ
                        </span>
                    </div>

                    <div class="row g-3 my-2">
                        <div class="col-sm-6">
                            <div class="p-3 border rounded-3 bg-white">
                                <div class="text-muted small"><i class="fa-solid fa-cubes-stacked me-1 text-info"></i> Số lượng tồn kho (Amount)</div>
                                <div class="fs-4 fw-bold text-primary mt-1">${product.amount}</div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="p-3 border rounded-3 bg-white">
                                <div class="text-muted small"><i class="fa-solid fa-boxes-packing me-1 text-success"></i> Kho hàng (Stock)</div>
                                <div class="fs-4 fw-bold text-success mt-1">${product.stock != null ? product.stock : product.amount}</div>
                            </div>
                        </div>
                    </div>

                    <div class="my-4">
                        <h5 class="fw-bold text-dark border-bottom pb-2">
                            <i class="fa-solid fa-align-left text-primary me-2"></i>Mô tả chi tiết sản phẩm
                        </h5>
                        <div class="text-secondary leading-relaxed p-3 bg-light rounded-3">
                            <c:choose>
                                <c:when test="${not empty product.description}">
                                    ${product.description}
                                </c:when>
                                <c:otherwise>
                                    <span class="fst-italic text-muted">Chưa có thông tin mô tả chi tiết cho sản phẩm này.</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <c:choose>
                        <c:when test="${product.amount != null and product.amount > 0}">
                            <form action="${pageContext.request.contextPath}/cart" method="post" class="mt-4">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productId" value="${product.productId}">

                                <div class="d-flex align-items-center gap-3 mb-4">
                                    <span class="fw-semibold text-dark">Số lượng chọn mua:</span>
                                    <div class="input-group" style="width: 140px;">
                                        <button class="btn btn-outline-secondary" type="button" onclick="let input = document.getElementById('buyQty'); let val = parseInt(input.value); if(val > 1) input.value = val - 1;">
                                            <i class="fa-solid fa-minus"></i>
                                        </button>
                                        <input type="number" id="buyQty" name="quantity" class="form-control text-center fw-bold" value="1" min="1" max="${product.amount}">
                                        <button class="btn btn-outline-secondary" type="button" onclick="let input = document.getElementById('buyQty'); let val = parseInt(input.value); if(val < ${product.amount}) input.value = val + 1;">
                                            <i class="fa-solid fa-plus"></i>
                                        </button>
                                    </div>
                                    <span class="text-muted small">Có sẵn: <strong class="text-primary">${product.amount}</strong> sản phẩm</span>
                                </div>

                                <div class="d-flex gap-3 pt-2 flex-wrap">
                                    <a href="${pageContext.request.contextPath}/products-by-seller" class="btn btn-outline-secondary px-4 py-2 rounded-pill">
                                        <i class="fa-solid fa-arrow-left me-2"></i>Quay lại danh sách
                                    </a>
                                    <button type="submit" class="btn btn-outline-primary px-4 py-2 rounded-pill shadow-sm fw-semibold">
                                        <i class="fa-solid fa-cart-plus me-2"></i>Thêm vào giỏ hàng
                                    </button>
                                    <button type="submit" name="redirect" value="checkout" class="btn btn-danger px-4 py-2 rounded-pill shadow-sm fw-bold">
                                        <i class="fa-solid fa-bolt me-2"></i>Mua ngay (COD)
                                    </button>
                                </div>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-danger d-flex align-items-center mt-4 rounded-3" role="alert">
                                <i class="fa-solid fa-triangle-exclamation fs-4 me-3"></i>
                                <div>
                                    <strong>Sản phẩm tạm thời hết hàng!</strong><br>
                                    Vui lòng quay lại sau hoặc liên hệ với cửa hàng để biết thêm chi tiết.
                                </div>
                            </div>
                            <div class="pt-2">
                                <a href="${pageContext.request.contextPath}/products-by-seller" class="btn btn-outline-secondary px-4 py-2 rounded-pill">
                                    <i class="fa-solid fa-arrow-left me-2"></i>Quay lại danh sách
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

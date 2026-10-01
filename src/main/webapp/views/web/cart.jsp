<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Giỏ Hàng Của Bạn - Đề 05 (24110388)</title>
    <style>
        .cart-table th {
            background-color: #f1f5f9;
            color: #334155;
            font-weight: 600;
            padding: 14px 16px;
            border-bottom: 2px solid #e2e8f0;
        }
        .cart-table td {
            padding: 16px;
            vertical-align: middle;
        }
        .qty-btn {
            width: 34px;
            height: 34px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            border-radius: 6px;
            border: 1px solid #cbd5e1;
            background-color: #f8fafc;
            color: #1e293b;
            transition: all 0.2s ease;
            text-decoration: none;
        }
        .qty-btn:hover:not(.disabled) {
            background-color: #0284c7;
            color: #fff;
            border-color: #0284c7;
        }
        .qty-btn.disabled {
            opacity: 0.4;
            cursor: not-allowed;
            pointer-events: none;
        }
        .qty-input {
            width: 55px;
            text-align: center;
            font-weight: 600;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            height: 34px;
        }
        .summary-card {
            background: #ffffff;
            border-radius: 14px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            padding: 24px;
        }
        .empty-cart-box {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            padding: 60px 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container my-4">

        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang Chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products-by-seller" class="text-decoration-none">Sản Phẩm</a></li>
                <li class="breadcrumb-item active" aria-current="page">Giỏ Hàng</li>
            </ol>
        </nav>

        <c:if test="${not empty sessionScope.cartSuccess}">
            <div class="alert alert-success alert-dismissible fade show shadow-sm d-flex align-items-center mb-4" role="alert">
                <i class="fa-solid fa-circle-check fs-5 me-2"></i>
                <div>${sessionScope.cartSuccess}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="cartSuccess" scope="session" />
        </c:if>

        <c:if test="${not empty sessionScope.cartWarning}">
            <div class="alert alert-warning alert-dismissible fade show shadow-sm d-flex align-items-center mb-4" role="alert">
                <i class="fa-solid fa-triangle-exclamation fs-5 me-2"></i>
                <div>${sessionScope.cartWarning}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="cartWarning" scope="session" />
        </c:if>

        <c:choose>
            <c:when test="${empty sessionScope.cart or sessionScope.cart.isEmpty()}">
                <div class="empty-cart-box">
                    <div class="mb-3 text-secondary">
                        <i class="fa-solid fa-cart-arrow-down" style="font-size: 5rem; color: #94a3b8;"></i>
                    </div>
                    <h3 class="fw-bold text-dark mb-2">Giỏ hàng của bạn đang trống!</h3>
                    <p class="text-muted mb-4">Hãy khám phá các sản phẩm chất lượng từ các cửa hàng và thêm vào giỏ nhé.</p>
                    <a href="${pageContext.request.contextPath}/products-by-seller" class="btn btn-primary px-4 py-2 rounded-pill shadow-sm">
                        <i class="fa-solid fa-bag-shopping me-2"></i>Khám phá mua sắm ngay
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4">
                    <div class="col-lg-8">
                        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center border-bottom">
                                <h5 class="mb-0 fw-bold text-dark">
                                    <i class="fa-solid fa-cart-shopping text-primary me-2"></i>Các mặt hàng đã chọn (${sessionScope.cartCount} món)
                                </h5>
                                <a href="${pageContext.request.contextPath}/cart?action=clear"
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa toàn bộ sản phẩm khỏi giỏ hàng?')"
                                   class="btn btn-outline-danger btn-sm rounded-pill px-3">
                                    <i class="fa-solid fa-trash-can me-1"></i>Xóa tất cả
                                </a>
                            </div>
                            <div class="table-responsive">
                                <table class="table cart-table align-middle mb-0">
                                    <thead>
                                        <tr>
                                            <th scope="col" style="min-width: 250px;">Sản phẩm</th>
                                            <th scope="col" class="text-center" style="min-width: 120px;">Đơn giá</th>
                                            <th scope="col" class="text-center" style="min-width: 160px;">Số lượng</th>
                                            <th scope="col" class="text-end" style="min-width: 130px;">Thành tiền</th>
                                            <th scope="col" class="text-center" style="width: 50px;"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${sessionScope.cart.values()}" var="item">
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center gap-3">
                                                        <img src="${empty item.product.images ? 'https://placehold.co/80x80?text=Product' : (item.product.images.startsWith('http') ? item.product.images : (item.product.images.startsWith(pageContext.request.contextPath) ? item.product.images : (item.product.images.startsWith('/') ? pageContext.request.contextPath.concat(item.product.images) : pageContext.request.contextPath.concat('/uploads/').concat(item.product.images))))}"
                                                             alt="${item.product.productName}"
                                                             class="rounded-3 border" style="width: 65px; height: 65px; object-fit: cover;">
                                                        <div>
                                                            <a href="${pageContext.request.contextPath}/product-detail?id=${item.product.productId}"
                                                               class="fw-semibold text-dark text-decoration-none d-block text-truncate" style="max-width: 220px;" title="${item.product.productName}">
                                                                ${item.product.productName}
                                                            </a>
                                                            <div class="text-muted small">
                                                                <i class="fa-solid fa-store me-1 text-secondary"></i>${item.product.seller != null ? item.product.seller.sellername : 'Cửa hàng'}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="text-center fw-medium text-secondary">
                                                    <fmt:formatNumber value="${item.unitPrice}" pattern="#,###"/> đ
                                                </td>
                                                <td class="text-center">
                                                    <div class="d-flex align-items-center justify-content-center gap-1">
                                                        <a href="${pageContext.request.contextPath}/cart?action=update&productId=${item.product.productId}&change=dec"
                                                           class="qty-btn ${item.quantity <= 1 ? 'disabled' : ''}" title="Giảm số lượng">
                                                            <i class="fa-solid fa-minus"></i>
                                                        </a>
                                                        <form action="${pageContext.request.contextPath}/cart" method="post" class="d-inline m-0">
                                                            <input type="hidden" name="action" value="update">
                                                            <input type="hidden" name="productId" value="${item.product.productId}">
                                                            <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.amount}"
                                                                   class="qty-input" onchange="this.form.submit()">
                                                        </form>
                                                        <a href="${pageContext.request.contextPath}/cart?action=update&productId=${item.product.productId}&change=inc"
                                                           class="qty-btn ${item.quantity >= item.product.amount ? 'disabled' : ''}" title="Tăng số lượng">
                                                            <i class="fa-solid fa-plus"></i>
                                                        </a>
                                                    </div>
                                                    <div class="small text-muted mt-1" style="font-size: 0.75rem;">
                                                        Tồn kho: <strong class="text-primary">${item.product.amount}</strong>
                                                    </div>
                                                </td>
                                                <td class="text-end fw-bold text-danger">
                                                    <fmt:formatNumber value="${item.totalPrice}" pattern="#,###"/> đ
                                                </td>
                                                <td class="text-center">
                                                    <a href="${pageContext.request.contextPath}/cart?action=delete&productId=${item.product.productId}"
                                                       onclick="return confirm('Bạn có muốn xóa sản phẩm này khỏi giỏ hàng?')"
                                                       class="text-danger p-2 fs-6" title="Xóa sản phẩm">
                                                        <i class="fa-solid fa-xmark"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="card-footer bg-light py-3 d-flex justify-content-between align-items-center flex-wrap gap-2">
                                <a href="${pageContext.request.contextPath}/products-by-seller" class="btn btn-outline-secondary rounded-pill px-3">
                                    <i class="fa-solid fa-arrow-left me-1"></i>Tiếp tục mua hàng
                                </a>
                                <span class="text-muted small">
                                    Số lượng giới hạn từ <strong>1</strong> đến số lượng tồn kho (Amount) của từng sản phẩm.
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="summary-card">
                            <h5 class="fw-bold text-dark border-bottom pb-3 mb-3">
                                <i class="fa-solid fa-receipt me-2 text-primary"></i>Tóm Tắt Đơn Hàng
                            </h5>

                            <div class="d-flex justify-content-between mb-2 text-secondary">
                                <span>Tổng số lượng:</span>
                                <span class="fw-bold text-dark">${sessionScope.cartCount} sản phẩm</span>
                            </div>

                            <div class="d-flex justify-content-between mb-2 text-secondary">
                                <span>Tiền hàng:</span>
                                <span class="fw-semibold text-dark">
                                    <fmt:formatNumber value="${sessionScope.cartTotal}" pattern="#,###"/> đ
                                </span>
                            </div>

                            <div class="d-flex justify-content-between mb-2 text-secondary">
                                <span>Phí vận chuyển:</span>
                                <span class="badge bg-success-subtle text-success">Miễn phí giao hàng</span>
                            </div>

                            <div class="d-flex justify-content-between mb-3 text-secondary">
                                <span>Phương thức:</span>
                                <span class="badge bg-primary-subtle text-primary">COD (Nhận hàng trả tiền)</span>
                            </div>

                            <hr class="my-3">

                            <div class="d-flex justify-content-between align-items-baseline mb-4">
                                <span class="fs-6 fw-semibold text-dark">Tổng thanh toán:</span>
                                <span class="fs-4 fw-bold text-danger">
                                    <fmt:formatNumber value="${sessionScope.cartTotal}" pattern="#,###"/> đ
                                </span>
                            </div>

                            <div class="d-grid gap-2">
                                <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary btn-lg rounded-pill fw-semibold shadow">
                                    <i class="fa-solid fa-truck-fast me-2"></i>Thanh toán đơn hàng COD
                                </a>
                            </div>

                            <div class="mt-4 p-3 bg-light rounded-3 border small text-muted">
                                <div class="d-flex align-items-center gap-2 mb-1 text-dark fw-semibold">
                                    <i class="fa-solid fa-shield-halved text-success"></i>Mua sắm an toàn & tiện lợi
                                </div>
                                <div>Kiểm tra hàng trước khi thanh toán cho nhân viên giao hàng COD. Đổi trả nếu có lỗi từ nhà sản xuất.</div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lịch Sử Đơn Hàng Của Tôi - Đề 05 (24110388)</title>
    <style>
        .order-history-card {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            padding: 28px;
        }
        .order-card {
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 16px;
            background-color: #f8fafc;
            transition: all 0.2s ease;
        }
        .order-card:hover {
            border-color: #38bdf8;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
    </style>
</head>
<body>
    <div class="container my-4" style="max-width: 960px;">

        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang Chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">Đơn Mua Của Tôi</li>
            </ol>
        </nav>

        <div class="order-history-card">
            <h4 class="fw-bold text-dark border-bottom pb-3 mb-4">
                <i class="fa-solid fa-clipboard-list text-primary me-2"></i>Lịch Sử Đặt Hàng Của Tôi
            </h4>

            <c:choose>
                <c:when test="${empty orders}">
                    <div class="text-center py-5">
                        <i class="fa-solid fa-box-open fs-1 text-secondary mb-3 d-block"></i>
                        <h5 class="fw-semibold">Bạn chưa có đơn đặt hàng nào!</h5>
                        <p class="text-muted">Hãy thêm sản phẩm vào giỏ hàng và tiến hành đặt hàng ngay nhé.</p>
                        <a href="${pageContext.request.contextPath}/products-by-seller" class="btn btn-primary rounded-pill px-4 py-2 mt-2">
                            <i class="fa-solid fa-bag-shopping me-1"></i>Khám phá mua sắm ngay
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${orders}" var="order">
                        <div class="order-card">
                            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 border-bottom pb-2 mb-3">
                                <div>
                                    <span class="fw-bold text-dark me-2">Mã đơn: <span class="text-primary">${order.cartId}</span></span>
                                    <span class="text-muted small">
                                        <i class="fa-regular fa-clock me-1"></i><fmt:formatDate value="${order.buyDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                    </span>
                                </div>
                                <div>
                                    <c:choose>
                                        <c:when test="${order.status == 1}">
                                            <span class="badge bg-warning-subtle text-warning-emphasis border border-warning-subtle">
                                                <i class="fa-solid fa-truck-ramp-box me-1"></i>Đang xử lý giao hàng COD
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary-subtle text-secondary border">
                                                <i class="fa-solid fa-check me-1"></i>Đã hoàn thành
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                    <a href="${pageContext.request.contextPath}/order-success?id=${order.cartId}" class="btn btn-sm btn-outline-primary ms-2 rounded-pill">
                                        <i class="fa-solid fa-eye me-1"></i>Xem chi tiết
                                    </a>
                                </div>
                            </div>

                            <c:if test="${not empty order.cartItems}">
                                <div class="table-responsive">
                                    <table class="table table-sm align-middle mb-0">
                                        <tbody>
                                            <c:forEach items="${order.cartItems}" var="ci">
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center gap-2">
                                                            <img src="${ci.product != null and not empty ci.product.images ? (ci.product.images.startsWith('http') ? ci.product.images : (ci.product.images.startsWith(pageContext.request.contextPath) ? ci.product.images : (ci.product.images.startsWith('/') ? pageContext.request.contextPath.concat(ci.product.images) : pageContext.request.contextPath.concat('/uploads/').concat(ci.product.images)))) : 'https://placehold.co/40x40?text=Product'}"
                                                                 class="rounded border" style="width: 40px; height: 40px; object-fit: cover;">
                                                            <div>
                                                                <span class="fw-medium text-dark">${ci.product != null ? ci.product.productName : 'Sản phẩm'}</span>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="text-center text-muted">
                                                        Số lượng: <strong>${ci.quantity}</strong>
                                                    </td>
                                                    <td class="text-end fw-semibold text-danger">
                                                        <fmt:formatNumber value="${ci.unitPrice != null ? ci.unitPrice * ci.quantity : 0}" pattern="#,###"/> đ
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</body>
</html>

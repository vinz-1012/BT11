<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thanh Toán Đơn Hàng COD - Đề 05 (24110388)</title>
    <style>
        .checkout-card {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            padding: 28px;
        }
        .payment-method-box {
            border: 2px solid #0284c7;
            background-color: #f0f9ff;
            border-radius: 12px;
            padding: 16px;
            cursor: pointer;
        }
        .order-item-thumb {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
        }
    </style>
</head>
<body>
    <div class="container my-4">

        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang Chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cart" class="text-decoration-none">Giỏ Hàng</a></li>
                <li class="breadcrumb-item active" aria-current="page">Thanh Toán Đơn Hàng (COD)</li>
            </ol>
        </nav>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show shadow-sm d-flex align-items-center mb-4" role="alert">
                <i class="fa-solid fa-circle-exclamation fs-5 me-2"></i>
                <div>${error}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/checkout" method="post">
            <div class="row g-4">

                <div class="col-lg-7">
                    <div class="checkout-card mb-4">
                        <h4 class="fw-bold text-dark mb-3">
                            <i class="fa-solid fa-location-dot text-primary me-2"></i>Thông Tin Giao Hàng (COD)
                        </h4>
                        <p class="text-muted small mb-4">Vui lòng cung cấp thông tin chính xác để nhân viên giao hàng liên hệ giao hàng tận nơi và thu tiền.</p>

                        <div class="mb-3">
                            <label for="recipientName" class="form-label fw-semibold">Họ và tên người nhận <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="recipientName" name="recipientName"
                                   value="${sessionScope.account.fullname != null ? sessionScope.account.fullname : sessionScope.account.username}" required>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="phone" class="form-label fw-semibold">Số điện thoại liên hệ <span class="text-danger">*</span></label>
                                <input type="tel" class="form-control" id="phone" name="phone"
                                       value="${sessionScope.account.phone}" placeholder="Ví dụ: 0901234567" required>
                            </div>
                            <div class="col-md-6">
                                <label for="email" class="form-label fw-semibold">Địa chỉ Email</label>
                                <input type="email" class="form-control" id="email" name="email"
                                       value="${sessionScope.account.email}" placeholder="example@domain.com">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="shippingAddress" class="form-label fw-semibold">Địa chỉ nhận hàng chi tiết <span class="text-danger">*</span></label>
                            <textarea class="form-control" id="shippingAddress" name="shippingAddress" rows="3"
                                      placeholder="Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành phố..." required></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="notes" class="form-label fw-semibold">Ghi chú cho người giao hàng (Tùy chọn)</label>
                            <textarea class="form-control" id="notes" name="notes" rows="2"
                                      placeholder="Ví dụ: Giao vào giờ hành chính, gọi trước khi giao..."></textarea>
                        </div>
                    </div>

                    <div class="checkout-card">
                        <h5 class="fw-bold text-dark mb-3">
                            <i class="fa-solid fa-money-bill-wave text-success me-2"></i>Phương Thức Thanh Toán
                        </h5>

                        <div class="payment-method-box d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center gap-3">
                                <input class="form-check-input fs-5 m-0" type="radio" name="paymentMethod" id="codMethod" value="Thanh toán khi nhận hàng (COD)" checked>
                                <div>
                                    <label class="form-check-label fw-bold text-dark cursor-pointer d-block" for="codMethod">
                                        Thanh toán khi nhận hàng (COD - Cash On Delivery)
                                    </label>
                                    <span class="text-muted small">Người mua kiểm tra hàng và thanh toán tiền mặt trực tiếp cho nhân viên giao hàng khi nhận được gói hàng.</span>
                                </div>
                            </div>
                            <i class="fa-solid fa-hand-holding-dollar fs-2 text-primary"></i>
                        </div>
                    </div>
                </div>

                <div class="col-lg-5">
                    <div class="checkout-card">
                        <div class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-3">
                            <h5 class="fw-bold text-dark mb-0">
                                <i class="fa-solid fa-bag-shopping text-primary me-2"></i>Đơn Hàng Của Bạn
                            </h5>
                            <a href="${pageContext.request.contextPath}/cart" class="text-decoration-none small text-primary fw-semibold">
                                <i class="fa-solid fa-pen me-1"></i>Sửa giỏ hàng
                            </a>
                        </div>

                        <div class="order-items-list mb-3" style="max-height: 280px; overflow-y: auto;">
                            <c:forEach items="${sessionScope.cart.values()}" var="item">
                                <div class="d-flex align-items-center justify-content-between py-2 border-bottom">
                                    <div class="d-flex align-items-center gap-2">
                                        <img src="${empty item.product.images ? 'https://placehold.co/60x60?text=Product' : (item.product.images.startsWith('http') ? item.product.images : (item.product.images.startsWith(pageContext.request.contextPath) ? item.product.images : (item.product.images.startsWith('/') ? pageContext.request.contextPath.concat(item.product.images) : pageContext.request.contextPath.concat('/uploads/').concat(item.product.images))))}"
                                             alt="${item.product.productName}" class="order-item-thumb">
                                        <div>
                                            <div class="fw-semibold text-dark text-truncate" style="max-width: 170px;" title="${item.product.productName}">
                                                ${item.product.productName}
                                            </div>
                                            <div class="text-muted small">
                                                Số lượng: <strong class="text-primary">${item.quantity}</strong> x <fmt:formatNumber value="${item.unitPrice}" pattern="#,###"/> đ
                                            </div>
                                        </div>
                                    </div>
                                    <div class="fw-bold text-danger text-end">
                                        <fmt:formatNumber value="${item.totalPrice}" pattern="#,###"/> đ
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="d-flex justify-content-between mb-2 text-secondary">
                            <span>Tạm tính tiền hàng:</span>
                            <span class="fw-semibold text-dark">
                                <fmt:formatNumber value="${sessionScope.cartTotal}" pattern="#,###"/> đ
                            </span>
                        </div>

                        <div class="d-flex justify-content-between mb-2 text-secondary">
                            <span>Phí giao hàng:</span>
                            <span class="badge bg-success-subtle text-success">Miễn phí giao hàng</span>
                        </div>

                        <div class="d-flex justify-content-between mb-3 text-secondary">
                            <span>Hình thức thanh toán:</span>
                            <span class="badge bg-primary-subtle text-primary">COD</span>
                        </div>

                        <hr class="my-3">

                        <div class="d-flex justify-content-between align-items-baseline mb-4">
                            <span class="fs-6 fw-bold text-dark">Tổng tiền thanh toán:</span>
                            <span class="fs-4 fw-bold text-danger">
                                <fmt:formatNumber value="${sessionScope.cartTotal}" pattern="#,###"/> đ
                            </span>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary btn-lg rounded-pill fw-bold shadow">
                                <i class="fa-solid fa-check me-2"></i>Xác nhận đặt hàng COD
                            </button>
                            <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary rounded-pill">
                                <i class="fa-solid fa-arrow-left me-1"></i>Quay lại giỏ hàng
                            </a>
                        </div>
                    </div>
                </div>

            </div>
        </form>

    </div>
</body>
</html>

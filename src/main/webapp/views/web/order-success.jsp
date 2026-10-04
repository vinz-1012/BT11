<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đặt Hàng Thành Công - Đề 05 (24110388)</title>
    <style>
        .success-card {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            padding: 36px;
        }
        .success-icon-wrapper {
            width: 80px;
            height: 80px;
            background-color: #dcfce7;
            color: #16a34a;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 2.8rem;
            margin-bottom: 20px;
        }
        .order-meta-box {
            background-color: #f8fafc;
            border: 1px dashed #cbd5e1;
            border-radius: 12px;
            padding: 20px;
        }
    </style>
</head>
<body>
    <div class="container my-4" style="max-width: 900px;">

        <div class="success-card">
            <div class="text-center mb-4">
                <div class="success-icon-wrapper">
                    <i class="fa-solid fa-check"></i>
                </div>
                <h2 class="fw-bold text-dark">Đặt Hàng Thành Công!</h2>
                <p class="text-muted">
                    Cảm ơn bạn đã mua sắm. Đơn hàng của bạn đã được tiếp nhận và nhân viên sẽ tiến hành liên hệ, giao hàng bằng hình thức COD (Thanh toán khi nhận hàng).
                </p>
                <div class="badge bg-primary-subtle text-primary fs-6 px-3 py-2">
                    Mã đơn hàng: <strong>${receipt.orderId}</strong>
                </div>
            </div>

            <div class="order-meta-box mb-4">
                <h5 class="fw-bold text-dark border-bottom pb-2 mb-3">
                    <i class="fa-solid fa-truck-ramp-box text-primary me-2"></i>Thông Tin Giao Nhận COD
                </h5>
                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="text-muted small">Người nhận hàng:</div>
                        <div class="fw-bold text-dark">${receipt.recipientName}</div>
                    </div>
                    <div class="col-md-6">
                        <div class="text-muted small">Số điện thoại liên hệ:</div>
                        <div class="fw-bold text-dark">${receipt.recipientPhone}</div>
                    </div>
                    <div class="col-md-6">
                        <div class="text-muted small">Địa chỉ nhận hàng:</div>
                        <div class="fw-semibold text-dark">${receipt.shippingAddress}</div>
                    </div>
                    <div class="col-md-6">
                        <div class="text-muted small">Phương thức thanh toán:</div>
                        <div class="badge bg-warning-subtle text-warning-emphasis">
                            <i class="fa-solid fa-money-bill-wave me-1"></i>${receipt.paymentMethod}
                        </div>
                    </div>
                    <c:if test="${not empty receipt.notes}">
                        <div class="col-12">
                            <div class="text-muted small">Ghi chú giao hàng:</div>
                            <div class="fst-italic text-secondary">${receipt.notes}</div>
                        </div>
                    </c:if>
                    <div class="col-md-6">
                        <div class="text-muted small">Thời gian đặt hàng:</div>
                        <div class="text-dark">
                            <fmt:formatDate value="${receipt.orderDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="text-muted small">Trạng thái đơn hàng:</div>
                        <div class="${receipt.statusBadgeClass} px-3 py-1 fs-6">
                            <i class="fa-solid fa-clock-rotate-left me-1"></i>${receipt.statusName}
                        </div>
                    </div>
                </div>
            </div>

            <div class="mb-4">
                <h5 class="fw-bold text-dark border-bottom pb-2 mb-3">
                    <i class="fa-solid fa-list-check text-primary me-2"></i>Chi Tiết Mặt Hàng
                </h5>
                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Sản phẩm</th>
                                <th class="text-center">Đơn giá</th>
                                <th class="text-center">Số lượng</th>
                                <th class="text-end">Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${receipt.items}" var="item">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center gap-3">
                                            <img src="${empty item.product.images ? 'https://placehold.co/60x60?text=Product' : (item.product.images.startsWith('http') ? item.product.images : (item.product.images.startsWith(pageContext.request.contextPath) ? item.product.images : (item.product.images.startsWith('/') ? pageContext.request.contextPath.concat(item.product.images) : pageContext.request.contextPath.concat('/uploads/').concat(item.product.images))))}"
                                                 alt="${item.product.productName}"
                                                 class="rounded-2 border" style="width: 50px; height: 50px; object-fit: cover;">
                                            <div>
                                                <div class="fw-semibold text-dark">${item.product.productName}</div>
                                                <div class="text-muted small">
                                                    Mã SP: ${item.product.productCode != null ? item.product.productCode : item.product.productId}
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="text-center">
                                        <fmt:formatNumber value="${item.unitPrice}" pattern="#,###"/> đ
                                    </td>
                                    <td class="text-center fw-bold text-primary">
                                        ${item.quantity}
                                    </td>
                                    <td class="text-end fw-bold text-danger">
                                        <fmt:formatNumber value="${item.totalPrice}" pattern="#,###"/> đ
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="3" class="text-end fw-semibold">Phí vận chuyển COD:</td>
                                <td class="text-end text-success fw-semibold">Miễn phí</td>
                            </tr>
                            <tr class="table-light">
                                <td colspan="3" class="text-end fs-5 fw-bold text-dark">Tổng tiền thanh toán (khi nhận hàng):</td>
                                <td class="text-end fs-5 fw-bold text-danger">
                                    <fmt:formatNumber value="${receipt.totalAmount}" pattern="#,###"/> đ
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>

            <div class="d-flex justify-content-center gap-3 flex-wrap pt-2">
                <a href="${pageContext.request.contextPath}/products-by-seller" class="btn btn-primary px-4 py-2 rounded-pill shadow-sm">
                    <i class="fa-solid fa-bag-shopping me-2"></i>Tiếp tục mua hàng
                </a>
                <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-outline-secondary px-4 py-2 rounded-pill">
                    <i class="fa-solid fa-clipboard-list me-2"></i>Xem đơn mua của tôi
                </a>
                <button type="button" class="btn btn-light border px-4 py-2 rounded-pill" onclick="window.print()">
                    <i class="fa-solid fa-print me-2"></i>In hóa đơn
                </button>
            </div>
        </div>

    </div>
</body>
</html>

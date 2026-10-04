<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lịch Sử Đơn Hàng Của Tôi - Đề 05 (24110388)</title>
    <style>
        .order-history-container {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            padding: 24px;
        }
        .status-tabs-wrapper {
            overflow-x: auto;
            white-space: nowrap;
            border-bottom: 2px solid #e2e8f0;
            padding-bottom: 2px;
            margin-bottom: 24px;
            display: flex;
            gap: 8px;
        }
        .status-tab-item {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 10px 16px;
            text-decoration: none;
            color: #64748b;
            font-weight: 600;
            font-size: 0.95rem;
            border-radius: 8px;
            transition: all 0.2s ease;
            position: relative;
        }
        .status-tab-item:hover {
            color: #0284c7;
            background-color: #f0f9ff;
        }
        .status-tab-item.active {
            color: #0284c7;
            background-color: #e0f2fe;
            border-bottom: 3px solid #0284c7;
        }
        .status-tab-badge {
            font-size: 0.75rem;
            padding: 2px 7px;
            border-radius: 10px;
        }
        .order-card {
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            background-color: #ffffff;
            margin-bottom: 20px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .order-card:hover {
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            border-color: #38bdf8;
        }
        .order-card-header {
            background-color: #f8fafc;
            padding: 14px 20px;
            border-bottom: 1px solid #e2e8f0;
        }
        .order-card-body {
            padding: 18px 20px;
        }
        .order-card-footer {
            background-color: #f8fafc;
            padding: 14px 20px;
            border-top: 1px solid #e2e8f0;
        }
        .order-timeline-stepper {
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: relative;
            padding: 15px 10px;
            margin-bottom: 15px;
            background-color: #f8fafc;
            border-radius: 10px;
        }
        .stepper-step {
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
            z-index: 2;
            flex: 1;
            text-align: center;
        }
        .stepper-icon {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.85rem;
            background-color: #e2e8f0;
            color: #64748b;
            margin-bottom: 6px;
            transition: all 0.3s ease;
        }
        .stepper-step.completed .stepper-icon {
            background-color: #10b981;
            color: #ffffff;
        }
        .stepper-step.current .stepper-icon {
            background-color: #0284c7;
            color: #ffffff;
            box-shadow: 0 0 0 4px rgba(2, 132, 199, 0.2);
        }
        .stepper-label {
            font-size: 0.75rem;
            color: #64748b;
            font-weight: 500;
        }
        .stepper-step.completed .stepper-label,
        .stepper-step.current .stepper-label {
            color: #0f172a;
            font-weight: 700;
        }
        .sql-guide-box {
            background: linear-gradient(135deg, #eff6ff 0%, #f0fdf4 100%);
            border: 1px dashed #38bdf8;
            border-radius: 12px;
            padding: 16px 20px;
            margin-bottom: 24px;
        }
    </style>
</head>
<body>
    <div class="container my-4" style="max-width: 1050px;">

        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang Chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">Lịch Sử Đơn Hàng</li>
            </ol>
        </nav>

        <div class="order-history-container">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-3">
                <h4 class="fw-bold text-dark mb-0">
                    <i class="fa-solid fa-clock-rotate-left text-primary me-2"></i>Lịch Sử Đặt Hàng Của Tôi
                </h4>
                <a href="${pageContext.request.contextPath}/products-by-seller" class="btn btn-outline-primary btn-sm rounded-pill px-3">
                    <i class="fa-solid fa-cart-plus me-1"></i>Tiếp tục mua hàng
                </a>
            </div>

            <div class="status-tabs-wrapper">
                <a href="${pageContext.request.contextPath}/my-orders"
                   class="status-tab-item ${selectedStatus == null or selectedStatus == 0 ? 'active' : ''}">
                    <span>Tất cả</span>
                    <span class="status-tab-badge bg-secondary-subtle text-dark">${totalOrdersCount}</span>
                </a>
                <a href="${pageContext.request.contextPath}/my-orders?status=1"
                   class="status-tab-item ${selectedStatus == 1 ? 'active' : ''}">
                    <i class="fa-solid fa-file-invoice"></i>
                    <span>Đơn hàng mới</span>
                    <c:if test="${not empty statusCounts[1] and statusCounts[1] > 0}">
                        <span class="status-tab-badge bg-primary text-white">${statusCounts[1]}</span>
                    </c:if>
                </a>
                <a href="${pageContext.request.contextPath}/my-orders?status=2"
                   class="status-tab-item ${selectedStatus == 2 ? 'active' : ''}">
                    <i class="fa-solid fa-clipboard-check"></i>
                    <span>Đã xác nhận</span>
                    <c:if test="${not empty statusCounts[2] and statusCounts[2] > 0}">
                        <span class="status-tab-badge bg-info text-white">${statusCounts[2]}</span>
                    </c:if>
                </a>
                <a href="${pageContext.request.contextPath}/my-orders?status=3"
                   class="status-tab-item ${selectedStatus == 3 ? 'active' : ''}">
                    <i class="fa-solid fa-boxes-packing"></i>
                    <span>Chuẩn bị hàng</span>
                    <c:if test="${not empty statusCounts[3] and statusCounts[3] > 0}">
                        <span class="status-tab-badge bg-warning text-dark">${statusCounts[3]}</span>
                    </c:if>
                </a>
                <a href="${pageContext.request.contextPath}/my-orders?status=4"
                   class="status-tab-item ${selectedStatus == 4 ? 'active' : ''}">
                    <i class="fa-solid fa-truck"></i>
                    <span>Vận chuyển</span>
                    <c:if test="${not empty statusCounts[4] and statusCounts[4] > 0}">
                        <span class="status-tab-badge bg-secondary text-white">${statusCounts[4]}</span>
                    </c:if>
                </a>
                <a href="${pageContext.request.contextPath}/my-orders?status=5"
                   class="status-tab-item ${selectedStatus == 5 ? 'active' : ''}">
                    <i class="fa-solid fa-motorcycle"></i>
                    <span>Giao hàng</span>
                    <c:if test="${not empty statusCounts[5] and statusCounts[5] > 0}">
                        <span class="status-tab-badge bg-primary text-white">${statusCounts[5]}</span>
                    </c:if>
                </a>
                <a href="${pageContext.request.contextPath}/my-orders?status=6"
                   class="status-tab-item ${selectedStatus == 6 ? 'active' : ''}">
                    <i class="fa-solid fa-circle-check"></i>
                    <span>Đã giao</span>
                    <c:if test="${not empty statusCounts[6] and statusCounts[6] > 0}">
                        <span class="status-tab-badge bg-success text-white">${statusCounts[6]}</span>
                    </c:if>
                </a>
                <a href="${pageContext.request.contextPath}/my-orders?status=7"
                   class="status-tab-item ${selectedStatus == 7 ? 'active' : ''}">
                    <i class="fa-solid fa-circle-xmark"></i>
                    <span>Đơn hàng hủy</span>
                    <c:if test="${not empty statusCounts[7] and statusCounts[7] > 0}">
                        <span class="status-tab-badge bg-danger text-white">${statusCounts[7]}</span>
                    </c:if>
                </a>
                <a href="${pageContext.request.contextPath}/my-orders?status=8"
                   class="status-tab-item ${selectedStatus == 8 ? 'active' : ''}">
                    <i class="fa-solid fa-arrow-rotate-left"></i>
                    <span>Đơn hàng hoàn</span>
                    <c:if test="${not empty statusCounts[8] and statusCounts[8] > 0}">
                        <span class="status-tab-badge bg-dark text-white">${statusCounts[8]}</span>
                    </c:if>
                </a>
            </div>

            <c:choose>
                <c:when test="${empty orders}">
                    <div class="text-center py-5">
                        <i class="fa-solid fa-box-open fs-1 text-secondary mb-3 d-block"></i>
                        <h5 class="fw-semibold text-dark">Chưa có đơn hàng nào trong mục này!</h5>
                        <p class="text-muted">
                            <c:choose>
                                <c:when test="${selectedStatus != null and selectedStatus > 0}">
                                    Hiện không có đơn hàng nào thuộc trạng thái bạn vừa chọn.
                                </c:when>
                                <c:otherwise>
                                    Bạn chưa có đơn đặt hàng nào trong hệ thống.
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-outline-secondary rounded-pill px-4 py-2 me-2">
                            <i class="fa-solid fa-list me-1"></i>Xem tất cả đơn
                        </a>
                        <a href="${pageContext.request.contextPath}/products-by-seller" class="btn btn-primary rounded-pill px-4 py-2">
                            <i class="fa-solid fa-bag-shopping me-1"></i>Khám phá mua sắm ngay
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${orders}" var="order">
                        <div class="order-card">
                            <div class="order-card-header d-flex justify-content-between align-items-center flex-wrap gap-2">
                                <div class="d-flex align-items-center gap-3">
                                    <span class="badge bg-light text-dark border px-2 py-1">
                                        <i class="fa-solid fa-hashtag me-1 text-primary"></i>${order.cartId}
                                    </span>
                                    <span class="text-muted small">
                                        <i class="fa-regular fa-calendar-days me-1"></i>
                                        <fmt:formatDate value="${order.buyDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                    </span>
                                </div>
                                <div>
                                    <span class="${order.statusBadgeClass} px-3 py-2 fs-6 rounded-pill fw-semibold">
                                        <i class="${order.statusIcon} me-1"></i>${order.statusName}
                                    </span>
                                </div>
                            </div>

                            <div class="order-card-body">

                                <c:choose>
                                    <c:when test="${order.status == 7}">
                                        <div class="alert alert-danger py-2 px-3 mb-3 d-flex align-items-center gap-2 rounded-3 small">
                                            <i class="fa-solid fa-circle-xmark fs-5"></i>
                                            <div><strong>Đơn hàng đã hủy:</strong> Đơn hàng này đã bị hủy bỏ và không tiếp tục giao hàng.</div>
                                        </div>
                                    </c:when>
                                    <c:when test="${order.status == 8}">
                                        <div class="alert alert-dark py-2 px-3 mb-3 d-flex align-items-center gap-2 rounded-3 small">
                                            <i class="fa-solid fa-arrow-rotate-left fs-5"></i>
                                            <div><strong>Đơn hàng hoàn:</strong> Đơn hàng đã được tiếp nhận và xử lý trả hàng / hoàn tiền.</div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="curSt" value="${order.status != null and order.status > 0 ? order.status : 1}"/>
                                        <div class="order-timeline-stepper">
                                            <div class="stepper-step ${curSt > 1 ? 'completed' : (curSt == 1 ? 'current' : '')}">
                                                <div class="stepper-icon"><i class="fa-solid fa-file-invoice"></i></div>
                                                <span class="stepper-label">Đơn mới</span>
                                            </div>
                                            <div class="stepper-step ${curSt > 2 ? 'completed' : (curSt == 2 ? 'current' : '')}">
                                                <div class="stepper-icon"><i class="fa-solid fa-clipboard-check"></i></div>
                                                <span class="stepper-label">Đã xác nhận</span>
                                            </div>
                                            <div class="stepper-step ${curSt > 3 ? 'completed' : (curSt == 3 ? 'current' : '')}">
                                                <div class="stepper-icon"><i class="fa-solid fa-boxes-packing"></i></div>
                                                <span class="stepper-label">Chuẩn bị hàng</span>
                                            </div>
                                            <div class="stepper-step ${curSt > 4 ? 'completed' : (curSt == 4 ? 'current' : '')}">
                                                <div class="stepper-icon"><i class="fa-solid fa-truck"></i></div>
                                                <span class="stepper-label">Vận chuyển</span>
                                            </div>
                                            <div class="stepper-step ${curSt > 5 ? 'completed' : (curSt == 5 ? 'current' : '')}">
                                                <div class="stepper-icon"><i class="fa-solid fa-motorcycle"></i></div>
                                                <span class="stepper-label">Giao hàng</span>
                                            </div>
                                            <div class="stepper-step ${curSt >= 6 ? 'completed current' : ''}">
                                                <div class="stepper-icon"><i class="fa-solid fa-circle-check"></i></div>
                                                <span class="stepper-label">Đã giao</span>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <c:if test="${not empty order.cartItems}">
                                    <div class="table-responsive">
                                        <table class="table align-middle mb-0">
                                            <tbody>
                                                <c:forEach items="${order.cartItems}" var="ci">
                                                    <tr>
                                                        <td style="width: 60px;">
                                                            <img src="${ci.product != null and not empty ci.product.images ? (ci.product.images.startsWith('http') ? ci.product.images : (ci.product.images.startsWith(pageContext.request.contextPath) ? ci.product.images : (ci.product.images.startsWith('/') ? pageContext.request.contextPath.concat(ci.product.images) : pageContext.request.contextPath.concat('/uploads/').concat(ci.product.images)))) : 'https://placehold.co/50x50?text=Product'}"
                                                                 class="rounded-3 border" style="width: 50px; height: 50px; object-fit: cover;" alt="${ci.product != null ? ci.product.productName : ''}">
                                                        </td>
                                                        <td>
                                                            <div class="fw-semibold text-dark">${ci.product != null ? ci.product.productName : 'Sản phẩm'}</div>
                                                            <div class="text-muted small">
                                                                <c:if test="${ci.product != null and ci.product.category != null}">
                                                                    <span class="me-2"><i class="fa-solid fa-tag me-1 text-secondary"></i>${ci.product.category.categoryName}</span>
                                                                </c:if>
                                                                <c:if test="${ci.product != null and ci.product.seller != null}">
                                                                    <span><i class="fa-solid fa-store me-1 text-secondary"></i>${ci.product.seller.sellername}</span>
                                                                </c:if>
                                                            </div>
                                                        </td>
                                                        <td class="text-center text-muted">
                                                            Số lượng: <strong class="text-primary">${ci.quantity}</strong>
                                                        </td>
                                                        <td class="text-end fw-bold text-danger">
                                                            <fmt:formatNumber value="${ci.unitPrice != null ? ci.unitPrice * ci.quantity : 0}" pattern="#,###"/> đ
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:if>
                            </div>

                            <div class="order-card-footer d-flex justify-content-between align-items-center flex-wrap gap-2">
                                <div class="d-flex align-items-center gap-2">
                                    <span class="text-muted small">Phương thức:</span>
                                    <span class="badge bg-primary-subtle text-primary">Thanh toán COD</span>
                                </div>
                                <div class="d-flex align-items-center gap-3">
                                    <div class="text-end">
                                        <span class="text-secondary small d-block">Tổng tiền đơn hàng:</span>
                                        <span class="fs-5 fw-bold text-danger">
                                            <fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/> đ
                                        </span>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/order-success?id=${order.cartId}" class="btn btn-outline-primary btn-sm rounded-pill px-3 py-2 fw-semibold">
                                        <i class="fa-solid fa-receipt me-1"></i>Hóa đơn chi tiết
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</body>
</html>

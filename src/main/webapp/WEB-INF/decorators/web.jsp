<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title">Trang Web Mua Sắm - Đề 05</sitemesh:write></title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8fafc;
            color: #1e293b;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .navbar-custom {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.15);
        }
        .navbar-custom .navbar-brand {
            font-weight: 700;
            color: #38bdf8 !important;
            letter-spacing: -0.5px;
        }
        .navbar-custom .nav-link {
            color: #e2e8f0 !important;
            font-weight: 500;
            padding: 0.5rem 1rem;
            transition: all 0.2s ease;
            border-radius: 6px;
        }
        .navbar-custom .nav-link:hover, .navbar-custom .nav-link.active {
            color: #38bdf8 !important;
            background-color: rgba(255, 255, 255, 0.08);
        }
        .nav-admin-badge {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            color: #fff !important;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(245, 158, 11, 0.4);
        }
        .footer-custom {
            background-color: #0f172a;
            color: #94a3b8;
            padding: 24px 0;
            margin-top: auto;
            border-top: 1px solid #1e293b;
        }
        .footer-highlight {
            color: #38bdf8;
            font-weight: 600;
        }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home">
                <i class="fa-solid fa-store text-info fs-4"></i>
                <span>ShopDe05 <span class="badge bg-primary text-white fs-6">24110388</span></span>
            </a>

            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="fa-solid fa-house me-1"></i> Trang Chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/products-by-seller">
                            <i class="fa-solid fa-boxes-stacked me-1"></i> Sản phẩm
                        </a>
                    </li>

                    <c:if test="${not empty sessionScope.account and sessionScope.account.role.roleId == 1}">
                        <li class="nav-item ms-lg-2">
                            <a class="nav-link nav-admin-badge" href="${pageContext.request.contextPath}/admin/home">
                                <i class="fa-solid fa-shield-halved me-1"></i> Trang quản trị
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${not empty sessionScope.account and sessionScope.account.seller != null}">
                        <li class="nav-item ms-lg-2">
                            <a class="nav-link text-warning fw-semibold" href="${pageContext.request.contextPath}/seller/shop">
                                <i class="fa-solid fa-store me-1"></i> Cửa Hàng Của Tôi (${sessionScope.account.seller.sellername})
                            </a>
                        </li>
                    </c:if>
                </ul>

                <ul class="navbar-nav ms-auto align-items-lg-center">
                    <li class="nav-item me-lg-2">
                        <a class="nav-link position-relative px-3" href="${pageContext.request.contextPath}/cart" title="Giỏ hàng của bạn">
                            <i class="fa-solid fa-cart-shopping fs-5 text-info"></i>
                            <span class="d-none d-lg-inline ms-1">Giỏ hàng</span>
                            <c:if test="${not empty sessionScope.cartCount and sessionScope.cartCount > 0}">
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger shadow-sm" style="font-size: 0.7rem;">
                                    ${sessionScope.cartCount}
                                </span>
                            </c:if>
                        </a>
                    </li>
                    <c:choose>
                        <c:when test="${empty sessionScope.account}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                    <i class="fa-solid fa-right-to-bracket me-1"></i> Đăng nhập
                                </a>
                            </li>
                            <li class="nav-item ms-lg-2">
                                <a class="btn btn-primary btn-sm px-3 rounded-pill fw-semibold shadow-sm" href="${pageContext.request.contextPath}/register">
                                    <i class="fa-solid fa-user-plus me-1"></i> Đăng ký
                                </a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle d-flex align-items-center gap-2" href="#" role="button" data-bs-toggle="dropdown">
                                    <img src="${empty sessionScope.account.images ? 'https://placehold.co/100x100?text=User' : (sessionScope.account.images.startsWith('http') ? sessionScope.account.images : (sessionScope.account.images.startsWith(pageContext.request.contextPath) ? sessionScope.account.images : (sessionScope.account.images.startsWith('/') ? pageContext.request.contextPath.concat(sessionScope.account.images) : pageContext.request.contextPath.concat('/uploads/').concat(sessionScope.account.images))))}"
                                         class="rounded-circle border border-info" style="width: 32px; height: 32px; object-fit: cover;" alt="Avatar">
                                    <span>${sessionScope.account.fullname != null ? sessionScope.account.fullname : sessionScope.account.username}</span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                                    <li class="px-3 py-2 text-muted small border-bottom">
                                        Vai trò: <strong class="text-primary">${sessionScope.account.role.roleName}</strong>
                                    </li>
                                    <li>
                                        <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/cart">
                                            <i class="fa-solid fa-cart-shopping text-primary me-2"></i> Giỏ hàng của tôi
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/my-orders">
                                            <i class="fa-solid fa-clipboard-list text-info me-2"></i> Đơn mua của tôi
                                        </a>
                                    </li>
                                    <c:if test="${sessionScope.account.role.roleId == 1}">
                                        <li>
                                            <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/admin/home">
                                                <i class="fa-solid fa-gauge-high text-warning me-2"></i> Bảng điều khiển Admin
                                            </a>
                                        </li>
                                    </c:if>
                                    <c:if test="${not empty sessionScope.account.seller}">
                                        <li>
                                            <a class="dropdown-item py-2 text-warning-emphasis fw-semibold" href="${pageContext.request.contextPath}/seller/shop">
                                                <i class="fa-solid fa-store text-warning me-2"></i> Cài đặt Cửa hàng (${sessionScope.account.seller.sellername})
                                            </a>
                                        </li>
                                    </c:if>
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <a class="dropdown-item py-2 text-danger" href="${pageContext.request.contextPath}/logout">
                                            <i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <main class="py-4">
        <sitemesh:write property="body"/>
    </main>

    <footer class="footer-custom">
        <div class="container text-center">
            <div class="fs-6 py-1">
                Họ tên: <span class="footer-highlight">Nguyễn Tấn Vĩnh</span> |
                MSSV: <span class="footer-highlight">24110388</span> |
                Mã đề: <span class="footer-highlight">05</span>
            </div>
            <div class="text-secondary small mt-1">
                Bài thi thực hành Lập Trình Web - Jakarta EE 10 / Tomcat 11 / Hibernate 6
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

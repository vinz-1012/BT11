<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title">Quản Trị Hệ Thống - Đề 05</sitemesh:write></title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f1f5f9;
            color: #0f172a;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .admin-sidebar {
            width: 260px;
            background: #0f172a;
            color: #f8fafc;
            min-height: calc(100vh - 60px);
            transition: all 0.3s;
        }
        .admin-sidebar .nav-link {
            color: #94a3b8;
            font-weight: 500;
            padding: 0.8rem 1.25rem;
            border-radius: 8px;
            margin: 4px 12px;
            display: flex;
            align-items: center;
            gap: 12px;
            transition: all 0.2s;
        }
        .admin-sidebar .nav-link:hover, .admin-sidebar .nav-link.active {
            color: #ffffff;
            background-color: #1e293b;
            border-left: 4px solid #38bdf8;
        }
        .admin-navbar {
            background-color: #ffffff;
            border-bottom: 1px solid #e2e8f0;
            padding: 0.75rem 1.5rem;
        }
        .admin-footer {
            background-color: #0f172a;
            color: #94a3b8;
            padding: 16px 0;
            margin-top: auto;
            border-top: 1px solid #1e293b;
        }
        .footer-highlight {
            color: #38bdf8;
            font-weight: 600;
        }
        .card-custom {
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>

    <header class="admin-navbar d-flex justify-content-between align-items-center sticky-top shadow-sm">
        <div class="d-flex align-items-center gap-3">
            <span class="fs-5 fw-bold text-primary">
                <i class="fa-solid fa-shield-halved text-warning me-2"></i>ADMIN DASHBOARD - 24110388
            </span>
        </div>
        <div class="d-flex align-items-center gap-3">
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary btn-sm" target="_blank">
                <i class="fa-solid fa-globe me-1"></i> Xem Trang Chủ
            </a>
            <div class="d-flex align-items-center gap-2 border-start ps-3">
                <img src="${empty sessionScope.account.images ? 'https://placehold.co/100x100?text=Admin' : (sessionScope.account.images.startsWith('http') ? sessionScope.account.images : (sessionScope.account.images.startsWith(pageContext.request.contextPath) ? sessionScope.account.images : (sessionScope.account.images.startsWith('/') ? pageContext.request.contextPath.concat(sessionScope.account.images) : pageContext.request.contextPath.concat('/uploads/').concat(sessionScope.account.images))))}"
                     class="rounded-circle border" style="width: 36px; height: 36px; object-fit: cover;" alt="Avatar">
                <div>
                    <div class="fw-semibold small">${sessionScope.account.fullname != null ? sessionScope.account.fullname : 'Quản Trị Viên'}</div>
                    <span class="badge bg-danger small" style="font-size: 0.7rem;">ADMINISTRATOR</span>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm ms-2" title="Đăng xuất">
                <i class="fa-solid fa-right-from-bracket"></i>
            </a>
        </div>
    </header>

    <div class="d-flex flex-grow-1">

        <aside class="admin-sidebar p-2 flex-shrink-0">
            <div class="px-3 py-3 text-secondary text-uppercase fw-bold small" style="letter-spacing: 0.05em;">
                Quản Trị Hệ Thống
            </div>
            <nav class="nav flex-column">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/home">
                    <i class="fa-solid fa-chart-line text-info"></i> Tổng quan
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">
                    <i class="fa-solid fa-layer-group text-primary"></i> Quản lý Danh mục
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/products">
                    <i class="fa-solid fa-box text-success"></i> Quản lý Sản phẩm
                </a>
                <hr class="border-secondary my-3">
                <a class="nav-link" href="${pageContext.request.contextPath}/home">
                    <i class="fa-solid fa-arrow-left text-warning"></i> Về Website
                </a>
                <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">
                    <i class="fa-solid fa-power-off"></i> Đăng xuất
                </a>
            </nav>
        </aside>

        <main class="flex-grow-1 p-4 bg-light overflow-auto">
            <div class="container-fluid">
                <sitemesh:write property="body"/>
            </div>
        </main>
    </div>

    <footer class="admin-footer">
        <div class="container text-center">
            <div class="fs-6 py-1">
                Họ tên: <span class="footer-highlight">Nguyễn Tấn Vĩnh</span> |
                MSSV: <span class="footer-highlight">24110388</span> |
                Mã đề: <span class="footer-highlight">05</span>
            </div>
            <div class="text-secondary small mt-1">
                Hệ thống Quản Trị - Môn Lập Trình Web - Đề số 05
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

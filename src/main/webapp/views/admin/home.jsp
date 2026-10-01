<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bảng Điều Khiển Quản Trị - Đề 05</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold mb-1 text-dark">Tổng Quan Hệ Thống</h3>
            <p class="text-muted small mb-0">Hệ thống quản trị CSDL DB_De05 - Sinh viên: 24110388</p>
        </div>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-outline-primary btn-sm rounded-pill">
                <i class="fa-solid fa-plus me-1"></i> Thêm Danh Mục
            </a>
            <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-primary btn-sm rounded-pill">
                <i class="fa-solid fa-plus me-1"></i> Thêm Sản Phẩm
            </a>
        </div>
    </div>

    <div class="row g-4 mb-4">
        <div class="col-md-4">
            <div class="card card-custom p-4 bg-white border-0 shadow-sm">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="text-secondary small fw-semibold text-uppercase">Tổng Danh Mục</div>
                        <div class="fs-2 fw-bold text-primary mt-1">${totalCategories}</div>
                    </div>
                    <div class="bg-primary-subtle text-primary p-3 rounded-circle">
                        <i class="fa-solid fa-layer-group fs-3"></i>
                    </div>
                </div>
                <div class="mt-3 pt-3 border-top">
                    <a href="${pageContext.request.contextPath}/admin/categories" class="text-decoration-none small text-primary fw-semibold">
                        Quản lý danh mục <i class="fa-solid fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card card-custom p-4 bg-white border-0 shadow-sm">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="text-secondary small fw-semibold text-uppercase">Tổng Sản Phẩm</div>
                        <div class="fs-2 fw-bold text-success mt-1">${totalProducts}</div>
                    </div>
                    <div class="bg-success-subtle text-success p-3 rounded-circle">
                        <i class="fa-solid fa-boxes-stacked fs-3"></i>
                    </div>
                </div>
                <div class="mt-3 pt-3 border-top">
                    <a href="${pageContext.request.contextPath}/admin/products" class="text-decoration-none small text-success fw-semibold">
                        Quản lý sản phẩm <i class="fa-solid fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card card-custom p-4 bg-white border-0 shadow-sm">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="text-secondary small fw-semibold text-uppercase">Cửa Hàng (Sellers)</div>
                        <div class="fs-2 fw-bold text-warning-emphasis mt-1">${totalSellers}</div>
                    </div>
                    <div class="bg-warning-subtle text-warning p-3 rounded-circle">
                        <i class="fa-solid fa-store fs-3"></i>
                    </div>
                </div>
                <div class="mt-3 pt-3 border-top">
                    <a href="${pageContext.request.contextPath}/products-by-seller" target="_blank" class="text-decoration-none small text-warning-emphasis fw-semibold">
                        Xem trang gom nhóm Seller <i class="fa-solid fa-arrow-up-right-from-square ms-1"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

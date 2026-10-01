<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng Nhập Tài Khoản - Đề 05</title>
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-5 col-lg-4">
                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-body p-4">
                        <div class="text-center mb-4">
                            <div class="bg-primary-subtle text-primary rounded-circle d-inline-flex align-items-center justify-content-center mb-2" style="width: 60px; height: 60px;">
                                <i class="fa-solid fa-user-lock fs-3"></i>
                            </div>
                            <h3 class="fw-bold text-dark">Đăng Nhập</h3>
                            <p class="text-muted small">Nhập tài khoản để trải nghiệm hệ thống</p>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger py-2 small rounded-3" role="alert">
                                <i class="fa-solid fa-triangle-exclamation me-1"></i> ${error}
                                <c:if test="${not empty unverifiedEmail}">
                                    <div class="mt-2 text-end">
                                        <a href="${pageContext.request.contextPath}/verify-otp?email=${unverifiedEmail}" class="btn btn-sm btn-outline-danger py-0">Nhập mã OTP ngay</a>
                                    </div>
                                </c:if>
                            </div>
                        </c:if>

                        <c:if test="${not empty message}">
                            <div class="alert alert-success py-2 small rounded-3" role="alert">
                                <i class="fa-solid fa-circle-check me-1"></i> ${message}
                            </div>
                        </c:if>
                        <c:if test="${param.msg eq 'logged_out'}">
                            <div class="alert alert-info py-2 small rounded-3" role="alert">
                                <i class="fa-solid fa-info-circle me-1"></i> Bạn đã đăng xuất an toàn!
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/login" method="post">
                            <div class="mb-3">
                                <label for="username" class="form-label fw-semibold small">Tên đăng nhập</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-user text-muted"></i></span>
                                    <input type="text" class="form-control border-start-0 ps-0" id="username" name="username" placeholder="Nhập username" required autofocus>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="password" class="form-label fw-semibold small">Mật khẩu</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-lock text-muted"></i></span>
                                    <input type="password" class="form-control border-start-0 ps-0" id="password" name="password" placeholder="Nhập mật khẩu" required>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-primary w-100 py-2 rounded-pill fw-semibold shadow-sm mb-3">
                                <i class="fa-solid fa-right-to-bracket me-2"></i>Đăng Nhập
                            </button>
                        </form>

                        <div class="text-center small text-muted">
                            Chưa có tài khoản?
                            <a href="${pageContext.request.contextPath}/register" class="text-primary fw-semibold text-decoration-none">
                                Đăng ký ngay
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

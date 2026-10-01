<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Đăng Ký Tài Khoản Mới - Đề 05</title>
        </head>

        <body>
            <div class="container py-5">
                <div class="row justify-content-center">
                    <div class="col-md-6 col-lg-5">
                        <div class="card shadow-sm border-0 rounded-4">
                            <div class="card-body p-4">
                                <div class="text-center mb-4">
                                    <div class="bg-success-subtle text-success rounded-circle d-inline-flex align-items-center justify-content-center mb-2"
                                        style="width: 60px; height: 60px;">
                                        <i class="fa-solid fa-user-plus fs-3"></i>
                                    </div>
                                    <h3 class="fw-bold text-dark">Tạo Tài Khoản</h3>
                                    <p class="text-muted small">Đăng ký tài khoản để nhận mã kích hoạt OTP qua Email</p>
                                </div>

                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger py-2 small rounded-3" role="alert">
                                        <i class="fa-solid fa-triangle-exclamation me-1"></i> ${error}
                                    </div>
                                </c:if>

                                <form action="${pageContext.request.contextPath}/register" method="post"
                                    enctype="multipart/form-data">
                                    <div class="mb-3">
                                        <label for="username" class="form-label fw-semibold small">Tên đăng nhập <span
                                                class="text-danger">*</span></label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-light border-end-0"><i
                                                    class="fa-solid fa-user text-muted"></i></span>
                                            <input type="text" class="form-control border-start-0 ps-0" id="username"
                                                name="username" required>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="password" class="form-label fw-semibold small">Mật khẩu <span
                                                class="text-danger">*</span></label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-light border-end-0"><i
                                                    class="fa-solid fa-key text-muted"></i></span>
                                            <input type="password" class="form-control border-start-0 ps-0"
                                                id="password" name="password" required>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="email" class="form-label fw-semibold small">Email nhận OTP <span
                                                class="text-danger">*</span></label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-light border-end-0"><i
                                                    class="fa-solid fa-envelope text-muted"></i></span>
                                            <input type="email" class="form-control border-start-0 ps-0" id="email"
                                                name="email" placeholder="vd: example@gmail.com" required>
                                        </div>
                                        <div class="form-text text-muted" style="font-size: 0.75rem;">Mã xác thực 6 số
                                            sẽ được gửi trực tiếp đến địa chỉ email này.</div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="fullname" class="form-label fw-semibold small">Họ và tên</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-light border-end-0"><i
                                                    class="fa-solid fa-id-card text-muted"></i></span>
                                            <input type="text" class="form-control border-start-0 ps-0" id="fullname"
                                                name="fullname">
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="phone" class="form-label fw-semibold small">Số điện thoại</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-light border-end-0"><i
                                                    class="fa-solid fa-phone text-muted"></i></span>
                                            <input type="tel" class="form-control border-start-0 ps-0" id="phone"
                                                name="phone">
                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <label for="imageFile" class="form-label fw-semibold small">Ảnh đại diện
                                            (Avatar)</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-light"><i
                                                    class="fa-solid fa-image text-muted"></i></span>
                                            <input type="file" class="form-control" id="imageFile" name="imageFile"
                                                accept="image/*">
                                        </div>
                                        <div class="form-text text-muted" style="font-size: 0.75rem;">Tải ảnh đại diện
                                            cá nhân lưu trữ trên hệ thống.</div>
                                    </div>

                                    <button type="submit"
                                        class="btn btn-success w-100 py-2 rounded-pill fw-semibold shadow-sm mb-3">
                                        <i class="fa-solid fa-paper-plane me-2"></i>Đăng Ký & Nhận Mã OTP
                                    </button>
                                </form>

                                <div class="text-center small text-muted">
                                    Đã có tài khoản?
                                    <a href="${pageContext.request.contextPath}/login"
                                        class="text-primary fw-semibold text-decoration-none">
                                        Đăng nhập ngay
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>

        </html>
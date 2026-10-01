<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Xác Thực Mã OTP - Đề 05</title>
        </head>

        <body>
            <div class="container py-5">
                <div class="row justify-content-center">
                    <div class="col-md-5 col-lg-4">
                        <div class="card shadow-sm border-0 rounded-4">
                            <div class="card-body p-4 text-center">
                                <div class="bg-warning-subtle text-warning-emphasis rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                                    style="width: 68px; height: 68px;">
                                    <i class="fa-solid fa-shield-cat fs-2"></i>
                                </div>
                                <h3 class="fw-bold text-dark mb-1">Xác Thực OTP</h3>
                                <p class="text-muted small mb-4">Vui lòng nhập mã OTP gồm 6 chữ số đã được gửi qua email
                                    để kích hoạt tài khoản của bạn</p>

                                <c:if test="${not empty message}">
                                    <div class="alert alert-info py-2 small text-start rounded-3" role="alert">
                                        <i class="fa-solid fa-circle-info me-1"></i> ${message}
                                    </div>
                                </c:if>

                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger py-2 small text-start rounded-3" role="alert">
                                        <i class="fa-solid fa-triangle-exclamation me-1"></i> ${error}
                                    </div>
                                </c:if>

                                <form action="${pageContext.request.contextPath}/verify-otp" method="post"
                                    class="text-start">
                                    <div class="mb-3">
                                        <label for="email" class="form-label fw-semibold small">Địa chỉ Email đã đăng
                                            ký</label>
                                        <input type="email" class="form-control" id="email" name="email"
                                            value="${email}" placeholder="vd: example@gmail.com" required readonly>
                                    </div>

                                    <div class="mb-4">
                                        <label for="otp" class="form-label fw-semibold small">Mã xác thực OTP (6
                                            số)</label>
                                        <input type="text"
                                            class="form-control form-control-lg text-center fw-bold letter-spacing-2"
                                            id="otp" name="otp" maxlength="6" pattern="[0-9]{6}" required autofocus
                                            style="letter-spacing: 0.5em; font-size: 1.5rem;">
                                        <div class="form-text text-muted text-center mt-2 small">
                                            <i class="fa-solid fa-circle-question me-1"></i> Kiểm tra hộp thư Đến hoặc
                                            thư mục Spam/Rác (hoặc xem log Terminal/Console của máy chủ).
                                        </div>
                                    </div>

                                    <button type="submit"
                                        class="btn btn-warning w-100 py-2 rounded-pill fw-semibold shadow-sm mb-3">
                                        <i class="fa-solid fa-check-double me-2"></i>Xác Nhận & Kích Hoạt
                                    </button>
                                </form>

                                <div class="text-center small text-muted">
                                    <a href="${pageContext.request.contextPath}/login"
                                        class="text-secondary text-decoration-none">
                                        <i class="fa-solid fa-arrow-left me-1"></i>Quay lại trang Đăng nhập
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>

        </html>
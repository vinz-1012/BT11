<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cài Đặt Cửa Hàng - Đề 05</title>
</head>
<body>
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-7 col-md-9">
                <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                    <div class="d-flex align-items-center justify-content-between mb-4 pb-3 border-bottom">
                        <div class="d-flex align-items-center gap-3">
                            <div class="bg-warning-subtle text-warning p-3 rounded-circle">
                                <i class="fa-solid fa-store fs-4"></i>
                            </div>
                            <div>
                                <h4 class="fw-bold text-dark mb-1">Cài Đặt Cửa Hàng (Seller)</h4>
                                <p class="text-muted small mb-0">Quản lý tên gian hàng và trạng thái đóng / mở cửa kinh doanh</p>
                            </div>
                        </div>
                        <a href="${pageContext.request.contextPath}/products-by-seller" class="btn btn-outline-primary btn-sm rounded-pill">
                            <i class="fa-solid fa-eye me-1"></i> Xem trên Web
                        </a>
                    </div>

                    <c:if test="${not empty message}">
                        <div class="alert alert-success py-2 small rounded-3 mb-3">
                            <i class="fa-solid fa-circle-check me-1"></i> ${message}
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger py-2 small rounded-3 mb-3">
                            <i class="fa-solid fa-triangle-exclamation me-1"></i> ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/seller/shop" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="sellerId" value="${seller.sellerId}">

                        <div class="mb-3">
                            <label class="form-label small fw-semibold text-muted">Mã Cửa Hàng (sellerId)</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-hashtag text-muted"></i></span>
                                <input type="text" class="form-control border-start-0 ps-0 bg-light" value="${seller.sellerId}" readonly>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="sellername" class="form-label small fw-semibold">Tên Cửa Hàng <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-shop text-muted"></i></span>
                                <input type="text" class="form-control border-start-0 ps-0" id="sellername" name="sellername" 
                                       value="${seller.sellername}" placeholder="Nhập tên mới cho cửa hàng..." required autofocus>
                            </div>
                            <div class="form-text small text-muted">Tên cửa hàng sẽ hiển thị cho khách hàng tại trang danh sách sản phẩm.</div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label small fw-semibold">Trạng Thái Đóng / Mở Cửa</label>
                            <div class="p-3 border rounded-3 bg-light">
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="radio" name="status" id="status1" value="1" 
                                           ${(empty seller.status or seller.status == 1) ? 'checked' : ''}>
                                    <label class="form-check-label fw-bold text-success" for="status1">
                                        <i class="fa-solid fa-door-open me-1"></i> Đang mở cửa đón khách (Hoạt động bình thường)
                                    </label>
                                    <div class="text-muted small ps-4">Sản phẩm của cửa hàng sẽ hiển thị sẵn sàng bán cho người mua.</div>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="status" id="status0" value="0" 
                                           ${seller.status == 0 ? 'checked' : ''}>
                                    <label class="form-check-label fw-bold text-danger" for="status0">
                                        <i class="fa-solid fa-door-closed me-1"></i> Tạm đóng cửa / Nghỉ bán
                                    </label>
                                    <div class="text-muted small ps-4">Cửa hàng tạm ngưng phục vụ, khách hàng sẽ thấy biển báo tạm đóng cửa.</div>
                                </div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label small fw-semibold">Hình Ảnh / Logo Cửa Hàng</label>
                            <div class="input-group mb-2">
                                <span class="input-group-text bg-light"><i class="fa-solid fa-image text-muted"></i></span>
                                <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*">
                            </div>
                            <c:if test="${not empty seller.images}">
                                <div class="d-flex align-items-center gap-3 p-2 bg-light rounded" style="max-width: 300px;">
                                    <img src="${seller.images.startsWith('http') ? seller.images : (seller.images.startsWith('/') ? pageContext.request.contextPath.concat(seller.images) : pageContext.request.contextPath.concat('/uploads/').concat(seller.images))}" 
                                         alt="${seller.sellername}" class="rounded-circle border" style="width: 50px; height: 50px; object-fit: cover;">
                                    <div class="small text-muted">Logo hiện tại của cửa hàng</div>
                                </div>
                            </c:if>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-warning px-4 py-2 rounded-pill fw-semibold shadow-sm">
                                <i class="fa-solid fa-floppy-disk me-1"></i> Lưu Cài Đặt Cửa Hàng
                            </button>
                            <a href="${pageContext.request.contextPath}/products-by-seller" class="btn btn-light px-4 py-2 rounded-pill">
                                Hủy bỏ
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

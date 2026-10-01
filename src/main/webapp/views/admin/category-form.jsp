<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${isEdit ? 'Cập Nhật Danh Mục' : 'Thêm Mới Danh Mục'} - Đề 05</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                <div class="d-flex align-items-center justify-content-between mb-4 pb-2 border-bottom">
                    <h4 class="fw-bold text-dark mb-0">
                        <i class="fa-solid ${isEdit ? 'fa-pen-to-square text-warning' : 'fa-plus text-primary'} me-2"></i>
                        ${isEdit ? 'Cập Nhật Danh Mục' : 'Thêm Danh Mục Mới'}
                    </h4>
                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-outline-secondary btn-sm rounded-pill">
                        <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
                    </a>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-2 small rounded-3 mb-3">
                        <i class="fa-solid fa-triangle-exclamation me-1"></i> ${error}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/category/${isEdit ? 'edit' : 'add'}" method="post" enctype="multipart/form-data">
                    <c:if test="${isEdit}">
                        <input type="hidden" name="categoryId" value="${category.categoryId}">
                        <div class="mb-3">
                            <label class="form-label small fw-semibold text-muted">Mã Danh Mục (ID)</label>
                            <input type="text" class="form-control bg-light" value="${category.categoryId}" readonly>
                        </div>
                    </c:if>

                    <div class="mb-3">
                        <label for="categoryName" class="form-label small fw-semibold">Tên Danh Mục <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="categoryName" name="categoryName"
                               value="${category.categoryName}" placeholder="Nhập tên danh mục..." required autofocus>
                    </div>

                    <div class="mb-3">
                        <label for="imageFile" class="form-label small fw-semibold">Tải Lên File Ảnh (Lưu vào /uploads)</label>
                        <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*">
                        <div class="form-text small text-muted">Chọn ảnh từ máy tính (ảnh sẽ lưu vào <code>/uploads</code>).</div>
                    </div>

                    <div class="mb-3">
                        <label for="images" class="form-label small fw-semibold">Hoặc Link Hình Ảnh (URL)</label>
                        <input type="text" class="form-control" id="images" name="images"
                               value="${category.images}" placeholder="https://placehold.co/150x150?text=...">
                        <div class="form-text small text-muted">Nếu không chọn file từ máy tính, bạn có thể dán link ảnh tại đây.</div>
                        <c:if test="${not empty category.images}">
                            <div class="mt-2 p-2 bg-light rounded text-center" style="max-width: 150px;">
                                <img src="${category.images.startsWith('http') ? category.images : (category.images.startsWith('/') ? pageContext.request.contextPath.concat(category.images) : pageContext.request.contextPath.concat('/uploads/').concat(category.images))}"
                                     alt="Preview" class="img-thumbnail" style="max-height: 100px; object-fit: cover;">
                                <div class="small text-muted mt-1">Ảnh hiện tại</div>
                            </div>
                        </c:if>
                    </div>

                    <div class="mb-4">
                        <label class="form-label small fw-semibold">Trạng Thái</label>
                        <div class="d-flex gap-4">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="status" id="status1" value="1"
                                       ${(empty category.status or category.status == 1) ? 'checked' : ''}>
                                <label class="form-check-label text-success fw-medium" for="status1">
                                    <i class="fa-solid fa-circle-check me-1"></i>Hoạt động
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="status" id="status0" value="0"
                                       ${category.status == 0 ? 'checked' : ''}>
                                <label class="form-check-label text-danger fw-medium" for="status0">
                                    <i class="fa-solid fa-circle-xmark me-1"></i>Tạm khóa
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary px-4 rounded-pill fw-semibold shadow-sm">
                            <i class="fa-solid fa-floppy-disk me-1"></i> ${isEdit ? 'Lưu Thay Đổi' : 'Thêm Danh Mục'}
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-light px-4 rounded-pill">
                            Hủy bỏ
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>

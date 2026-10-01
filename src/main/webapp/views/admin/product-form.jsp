<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${isEdit ? 'Cập Nhật Sản Phẩm' : 'Thêm Mới Sản Phẩm'} - Đề 05</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                <div class="d-flex align-items-center justify-content-between mb-4 pb-2 border-bottom">
                    <h4 class="fw-bold text-dark mb-0">
                        <i class="fa-solid ${isEdit ? 'fa-pen-to-square text-warning' : 'fa-plus text-success'} me-2"></i>
                        ${isEdit ? 'Cập Nhật Sản Phẩm' : 'Thêm Sản Phẩm Mới'}
                    </h4>
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary btn-sm rounded-pill">
                        <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
                    </a>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-2 small rounded-3 mb-3">
                        <i class="fa-solid fa-triangle-exclamation me-1"></i> ${error}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/product/${isEdit ? 'edit' : 'add'}" method="post" enctype="multipart/form-data">
                    <c:if test="${isEdit}">
                        <input type="hidden" name="productId" value="${product.productId}">
                        <div class="mb-3">
                            <label class="form-label small fw-semibold text-muted">Mã Hệ Thống (productId)</label>
                            <input type="text" class="form-control bg-light" value="${product.productId}" readonly>
                        </div>
                    </c:if>

                    <div class="row g-3 mb-3">
                        <div class="col-md-8">
                            <label for="productName" class="form-label small fw-semibold">Tên Sản Phẩm <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="productName" name="productName"
                                   value="${product.productName}" placeholder="Nhập tên sản phẩm..." required autofocus>
                        </div>
                        <div class="col-md-4">
                            <label for="productCode" class="form-label small fw-semibold">Mã Code Sản Phẩm (Số)</label>
                            <input type="number" class="form-control" id="productCode" name="productCode"
                                   value="${product.productCode}" placeholder="Ví dụ: 1001">
                        </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label for="categoryId" class="form-label small fw-semibold">Danh Mục</label>
                            <select class="form-select" id="categoryId" name="categoryId">
                                <option value="">-- Chọn danh mục --</option>
                                <c:forEach items="${categoryList}" var="cat">
                                    <option value="${cat.categoryId}" ${product.category != null and product.category.categoryId == cat.categoryId ? 'selected' : ''}>
                                        ${cat.categoryName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="sellerId" class="form-label small fw-semibold">Cửa Hàng (Seller)</label>
                            <select class="form-select" id="sellerId" name="sellerId">
                                <option value="">-- Chọn người bán/cửa hàng --</option>
                                <c:forEach items="${sellerList}" var="sel">
                                    <option value="${sel.sellerId}" ${product.seller != null and product.seller.sellerId == sel.sellerId ? 'selected' : ''}>
                                        Mã ${sel.sellerId} - ${sel.sellername}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-4">
                            <label for="price" class="form-label small fw-semibold">Giá Bán (VNĐ)</label>
                            <input type="number" step="1000" class="form-control" id="price" name="price"
                                   value="${product.price}" placeholder="250000">
                        </div>
                        <div class="col-md-4">
                            <label for="amount" class="form-label small fw-semibold">Số Lượng (Amount)</label>
                            <input type="number" class="form-control" id="amount" name="amount"
                                   value="${product.amount}" placeholder="10">
                        </div>
                        <div class="col-md-4">
                            <label for="stock" class="form-label small fw-semibold">Kho Hàng (Stock)</label>
                            <input type="number" class="form-control" id="stock" name="stock"
                                   value="${product.stock}" placeholder="10">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Hình Ảnh Sản Phẩm</label>
                        <div class="input-group mb-2">
                            <span class="input-group-text bg-light"><i class="fa-solid fa-cloud-arrow-up text-primary"></i></span>
                            <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*">
                        </div>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="fa-solid fa-link text-muted"></i></span>
                            <input type="text" class="form-control" id="images" name="images"
                                   value="${product.images}" placeholder="Hoặc dán URL: https://placehold.co/300x200">
                        </div>
                        <div class="form-text small text-muted">Chọn tệp ảnh từ máy tính (lưu vào <code>uploads/</code>) hoặc nhập link ảnh trực tuyến.</div>
                        <c:if test="${not empty product.images}">
                            <div class="mt-2 p-2 bg-light rounded text-center" style="max-width: 200px;">
                                <img src="${product.images.startsWith('http') ? product.images : (product.images.startsWith('/') ? pageContext.request.contextPath.concat(product.images) : pageContext.request.contextPath.concat('/uploads/').concat(product.images))}"
                                     alt="Preview" class="img-thumbnail" style="max-height: 120px; object-fit: cover;">
                                <div class="small text-muted mt-1">Ảnh hiện tại</div>
                            </div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label for="description" class="form-label small fw-semibold">Mô Tả Chi Tiết (Description)</label>
                        <textarea class="form-control" id="description" name="description" rows="3"
                                  placeholder="Mô tả công dụng, tính năng nổi bật...">${product.description}</textarea>
                    </div>

                    <div class="mb-4">
                        <label class="form-label small fw-semibold">Trạng Thái Kinh Doanh</label>
                        <div class="d-flex gap-4">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="status" id="status1" value="1"
                                       ${(empty product.status or product.status == 1) ? 'checked' : ''}>
                                <label class="form-check-label text-success fw-medium" for="status1">
                                    <i class="fa-solid fa-circle-check me-1"></i>Đang kinh doanh
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="status" id="status0" value="0"
                                       ${product.status == 0 ? 'checked' : ''}>
                                <label class="form-check-label text-danger fw-medium" for="status0">
                                    <i class="fa-solid fa-circle-xmark me-1"></i>Tạm dừng kinh doanh
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-success px-4 rounded-pill fw-semibold shadow-sm">
                            <i class="fa-solid fa-floppy-disk me-1"></i> ${isEdit ? 'Lưu Thay Đổi' : 'Thêm Sản Phẩm'}
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-light px-4 rounded-pill">
                            Hủy bỏ
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>

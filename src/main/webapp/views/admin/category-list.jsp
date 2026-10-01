<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Quản Lý Danh Mục (Phân Trang) - Đề 05</title>
        </head>

        <body>
            <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
                <div>
                    <h3 class="fw-bold mb-1 text-dark">Quản Lý Danh Mục (Category)</h3>

                </div>
                <a href="${pageContext.request.contextPath}/admin/category/add"
                    class="btn btn-primary rounded-pill px-3 shadow-sm">
                    <i class="fa-solid fa-plus me-1"></i> Thêm Mới Danh Mục
                </a>
            </div>

            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show py-2 rounded-3 shadow-sm" role="alert">
                    <i class="fa-solid fa-circle-check me-2"></i> ${message}
                    <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show py-2 rounded-3 shadow-sm" role="alert">
                    <i class="fa-solid fa-triangle-exclamation me-2"></i> ${error}
                    <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card border-0 shadow-sm rounded-4 overflow-hidden mb-4">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light text-secondary">
                            <tr>
                                <th class="ps-4" style="width: 100px;">Mã DM</th>
                                <th style="width: 100px;">Hình ảnh</th>
                                <th>Tên Danh Mục</th>
                                <th style="width: 140px;">Trạng Thái</th>
                                <th class="text-end pe-4" style="width: 180px;">Hành Động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty categoryList}">
                                    <tr>
                                        <td colspan="5" class="text-center py-4 text-muted fst-italic">
                                            Không có dữ liệu danh mục nào!
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${categoryList}" var="cat">
                                        <tr>
                                            <td class="ps-4 fw-bold text-secondary">#${cat.categoryId}</td>
                                            <td>
                                                <img src="${empty cat.images ? 'https://placehold.co/100x100?text=Category' : (cat.images.startsWith('http') ? cat.images : (cat.images.startsWith(pageContext.request.contextPath) ? cat.images : (cat.images.startsWith('/') ? pageContext.request.contextPath.concat(cat.images) : pageContext.request.contextPath.concat('/uploads/').concat(cat.images))))}"
                                                    alt="${cat.categoryName}" class="rounded-3 border"
                                                    style="width: 50px; height: 50px; object-fit: cover;">
                                            </td>
                                            <td>
                                                <span class="fw-semibold text-dark">${cat.categoryName}</span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${cat.status == 1}">
                                                        <span
                                                            class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1">
                                                            <i class="fa-solid fa-check me-1"></i>Hoạt động
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span
                                                            class="badge bg-secondary-subtle text-secondary px-2 py-1">
                                                            <i class="fa-solid fa-lock me-1"></i>Tạm khóa
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-end pe-4">
                                                <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cat.categoryId}"
                                                    class="btn btn-outline-warning btn-sm me-1 rounded-pill"
                                                    title="Chỉnh sửa">
                                                    <i class="fa-solid fa-pen-to-square"></i> Sửa
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cat.categoryId}"
                                                    class="btn btn-outline-danger btn-sm rounded-pill" title="Xóa"
                                                    onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục #${cat.categoryId} - ${cat.categoryName}?');">
                                                    <i class="fa-solid fa-trash"></i> Xóa
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                <div class="d-flex align-items-center gap-3">
                    <div class="text-muted small">
                        Hiển thị trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong> (Tổng cộng: ${totalItems} danh mục)
                    </div>
                    <div class="d-flex align-items-center gap-1">
                        <label for="pageSizeSelect" class="small text-muted mb-0">Hiển thị:</label>
                        <select id="pageSizeSelect" class="form-select form-select-sm" style="width: auto;" onchange="changePageSize(this.value)">
                            <option value="3" ${pageSize == 3 ? 'selected' : ''}>3 / trang</option>
                            <option value="6" ${pageSize == 6 ? 'selected' : ''}>6 / trang</option>
                            <option value="10" ${pageSize == 10 ? 'selected' : ''}>10 / trang</option>
                        </select>
                    </div>
                </div>
                <nav aria-label="Page navigation">
                    <ul class="pagination pagination-sm mb-0">
                        <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                            <a class="page-link"
                                href="${pageContext.request.contextPath}/admin/categories?page=${currentPage - 1}&size=${pageSize}"
                                aria-label="Previous">
                                <span aria-hidden="true">&laquo; Previous</span>
                            </a>
                        </li>

                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link"
                                    href="${pageContext.request.contextPath}/admin/categories?page=${i}&size=${pageSize}">${i}</a>
                            </li>
                        </c:forEach>

                        <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                            <a class="page-link"
                                href="${pageContext.request.contextPath}/admin/categories?page=${currentPage + 1}&size=${pageSize}"
                                aria-label="Next">
                                <span aria-hidden="true">Next &raquo;</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>

            <script>
                function changePageSize(size) {
                    window.location.href = '${pageContext.request.contextPath}/admin/categories?page=1&size=' + size;
                }
            </script>
        </body>

        </html>
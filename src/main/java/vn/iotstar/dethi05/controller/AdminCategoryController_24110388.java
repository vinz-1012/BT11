package vn.iotstar.dethi05.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.dethi05.entity.Category_24110388;
import vn.iotstar.dethi05.service.ICategoryService_24110388;
import vn.iotstar.dethi05.service.impl.CategoryService_24110388;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import vn.iotstar.dethi05.util.UploadUtil_24110388;

import java.io.IOException;
import java.util.List;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
@WebServlet(urlPatterns = {
    "/admin/categories",
    "/admin/category/add",
    "/admin/category/edit",
    "/admin/category/delete"
})
public class AdminCategoryController_24110388 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ICategoryService_24110388 categoryService = new CategoryService_24110388();
    private static final int PAGE_SIZE = 4;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.endsWith("/admin/category/add")) {
            req.setAttribute("category", new Category_24110388());
            req.setAttribute("isEdit", false);
            req.getRequestDispatcher("/views/admin/category-form.jsp").forward(req, resp);
        } else if (uri.endsWith("/admin/category/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Category_24110388 category = categoryService.findById(id);
            req.setAttribute("category", category);
            req.setAttribute("isEdit", true);
            req.getRequestDispatcher("/views/admin/category-form.jsp").forward(req, resp);
        } else if (uri.endsWith("/admin/category/delete")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                categoryService.delete(id);
                resp.sendRedirect(req.getContextPath() + "/admin/categories?msg=deleted");
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect(req.getContextPath() + "/admin/categories?error=delete_failed");
            }
        } else {

            int page = 1;
            String pageParam = req.getParameter("page");
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam.trim());
                    if (page < 1) page = 1;
                } catch (NumberFormatException ignored) {}
            }

            int pageSize = 3;
            String sizeParam = req.getParameter("size");
            if (sizeParam != null && !sizeParam.trim().isEmpty()) {
                try {
                    int parsedSize = Integer.parseInt(sizeParam.trim());
                    if (parsedSize == 3 || parsedSize == 6 || parsedSize == 10) {
                        pageSize = parsedSize;
                    }
                } catch (NumberFormatException ignored) {}
            }

            int totalItems = categoryService.count();
            int totalPages = (int) Math.ceil((double) totalItems / pageSize);
            if (totalPages == 0) totalPages = 1;
            if (page > totalPages) page = totalPages;

            List<Category_24110388> categoryList = categoryService.findPaginated(page, pageSize);

            req.setAttribute("categoryList", categoryList);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("totalItems", totalItems);
            req.setAttribute("pageSize", pageSize);

            String msg = req.getParameter("msg");
            if ("created".equals(msg)) req.setAttribute("message", "Thêm mới danh mục thành công!");
            if ("updated".equals(msg)) req.setAttribute("message", "Cập nhật danh mục thành công!");
            if ("deleted".equals(msg)) req.setAttribute("message", "Đã xóa danh mục thành công!");
            String error = req.getParameter("error");
            if ("delete_failed".equals(error)) req.setAttribute("error", "Không thể xóa danh mục này do đang có ràng buộc sản phẩm!");

            req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        String name = req.getParameter("categoryName");
        String images = req.getParameter("images");
        String statusStr = req.getParameter("status");
        int status = (statusStr != null && statusStr.equals("1")) ? 1 : 0;

        try {
            Part filePart = req.getPart("imageFile");
            String uploadedFileName = UploadUtil_24110388.saveUploadFile(filePart, getServletContext());
            if (uploadedFileName != null) {
                images = "/uploads/" + uploadedFileName;
            }
        } catch (Exception e) {
            System.err.println(">> Lỗi nhận file upload category: " + e.getMessage());
        }

        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("error", "Tên danh mục không được để trống!");
            req.getRequestDispatcher("/views/admin/category-form.jsp").forward(req, resp);
            return;
        }

        if (images == null || images.trim().isEmpty()) {
            images = "https://placehold.co/150x150?text=" + name.replaceAll("\\s+", "+");
        }

        if (uri.endsWith("/admin/category/add")) {
            Category_24110388 cat = new Category_24110388();
            cat.setCategoryName(name.trim());
            cat.setImages(images.trim());
            cat.setStatus(status);

            categoryService.insert(cat);
            resp.sendRedirect(req.getContextPath() + "/admin/categories?msg=created");
        } else if (uri.endsWith("/admin/category/edit")) {
            int id = Integer.parseInt(req.getParameter("categoryId"));
            Category_24110388 cat = categoryService.findById(id);
            if (cat != null) {
                cat.setCategoryName(name.trim());
                cat.setImages(images.trim());
                cat.setStatus(status);
                categoryService.update(cat);
                resp.sendRedirect(req.getContextPath() + "/admin/categories?msg=updated");
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/categories?error=not_found");
            }
        }
    }
}

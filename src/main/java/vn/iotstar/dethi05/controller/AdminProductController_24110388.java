package vn.iotstar.dethi05.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.dethi05.entity.Category_24110388;
import vn.iotstar.dethi05.entity.Product_24110388;
import vn.iotstar.dethi05.entity.Seller_24110388;
import vn.iotstar.dethi05.service.ICategoryService_24110388;
import vn.iotstar.dethi05.service.IProductService_24110388;
import vn.iotstar.dethi05.service.ISellerService_24110388;
import vn.iotstar.dethi05.service.impl.CategoryService_24110388;
import vn.iotstar.dethi05.service.impl.ProductService_24110388;
import vn.iotstar.dethi05.service.impl.SellerService_24110388;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import vn.iotstar.dethi05.util.UploadUtil_24110388;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
@WebServlet(urlPatterns = {
    "/admin/products",
    "/admin/product/add",
    "/admin/product/edit",
    "/admin/product/delete"
})
public class AdminProductController_24110388 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IProductService_24110388 productService = new ProductService_24110388();
    private final ICategoryService_24110388 categoryService = new CategoryService_24110388();
    private final ISellerService_24110388 sellerService = new SellerService_24110388();

    private static final int PAGE_SIZE = 5;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.endsWith("/admin/product/add")) {
            req.setAttribute("product", new Product_24110388());
            req.setAttribute("categoryList", categoryService.findAll());
            req.setAttribute("sellerList", sellerService.findAll());
            req.setAttribute("isEdit", false);
            req.getRequestDispatcher("/views/admin/product-form.jsp").forward(req, resp);
        } else if (uri.endsWith("/admin/product/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product_24110388 product = productService.findById(id);
            req.setAttribute("product", product);
            req.setAttribute("categoryList", categoryService.findAll());
            req.setAttribute("sellerList", sellerService.findAll());
            req.setAttribute("isEdit", true);
            req.getRequestDispatcher("/views/admin/product-form.jsp").forward(req, resp);
        } else if (uri.endsWith("/admin/product/delete")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                productService.delete(id);
                resp.sendRedirect(req.getContextPath() + "/admin/products?msg=deleted");
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect(req.getContextPath() + "/admin/products?error=delete_failed");
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

            int totalItems = productService.count();
            int totalPages = (int) Math.ceil((double) totalItems / pageSize);
            if (totalPages == 0) totalPages = 1;
            if (page > totalPages) page = totalPages;

            List<Product_24110388> productList = productService.findPaginated(page, pageSize);

            req.setAttribute("productList", productList);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("totalItems", totalItems);
            req.setAttribute("pageSize", pageSize);

            String msg = req.getParameter("msg");
            if ("created".equals(msg)) req.setAttribute("message", "Thêm mới sản phẩm thành công!");
            if ("updated".equals(msg)) req.setAttribute("message", "Cập nhật sản phẩm thành công!");
            if ("deleted".equals(msg)) req.setAttribute("message", "Đã xóa sản phẩm thành công!");
            String error = req.getParameter("error");
            if ("delete_failed".equals(error)) req.setAttribute("error", "Không thể xóa sản phẩm do có đơn hàng liên quan!");

            req.getRequestDispatcher("/views/admin/product-list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        String name = req.getParameter("productName");
        String codeStr = req.getParameter("productCode");
        String categoryIdStr = req.getParameter("categoryId");
        String sellerIdStr = req.getParameter("sellerId");
        String description = req.getParameter("description");
        String priceStr = req.getParameter("price");
        String amountStr = req.getParameter("amount");
        String stockStr = req.getParameter("stock");
        String images = req.getParameter("images");
        String statusStr = req.getParameter("status");

        try {
            Part filePart = req.getPart("imageFile");
            String uploadedFileName = UploadUtil_24110388.saveUploadFile(filePart, getServletContext());
            if (uploadedFileName != null) {
                images = "/uploads/" + uploadedFileName;
            }
        } catch (Exception e) {
            System.err.println(">> Lỗi nhận file upload product: " + e.getMessage());
        }

        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("error", "Tên sản phẩm không được để trống!");
            req.setAttribute("categoryList", categoryService.findAll());
            req.setAttribute("sellerList", sellerService.findAll());
            req.getRequestDispatcher("/views/admin/product-form.jsp").forward(req, resp);
            return;
        }

        Long productCode = null;
        if (codeStr != null && !codeStr.trim().isEmpty()) {
            try { productCode = Long.parseLong(codeStr.trim()); } catch (NumberFormatException ignored) {}
        }

        Double price = 0.0;
        if (priceStr != null && !priceStr.trim().isEmpty()) {
            try { price = Double.parseDouble(priceStr.trim()); } catch (NumberFormatException ignored) {}
        }

        Integer amount = 0;
        if (amountStr != null && !amountStr.trim().isEmpty()) {
            try { amount = Integer.parseInt(amountStr.trim()); } catch (NumberFormatException ignored) {}
        }

        Integer stock = 0;
        if (stockStr != null && !stockStr.trim().isEmpty()) {
            try { stock = Integer.parseInt(stockStr.trim()); } catch (NumberFormatException ignored) {}
        }

        int status = (statusStr != null && statusStr.equals("1")) ? 1 : 0;

        Category_24110388 category = null;
        if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
            category = categoryService.findById(Integer.parseInt(categoryIdStr.trim()));
        }

        Seller_24110388 seller = null;
        if (sellerIdStr != null && !sellerIdStr.trim().isEmpty()) {
            seller = sellerService.findById(Integer.parseInt(sellerIdStr.trim()));
        }

        if (images == null || images.trim().isEmpty()) {
            images = "https://placehold.co/300x200?text=" + name.replaceAll("\\s+", "+");
        }

        if (uri.endsWith("/admin/product/add")) {
            Product_24110388 prod = new Product_24110388();
            prod.setProductName(name.trim());
            prod.setProductCode(productCode);
            prod.setCategory(category);
            prod.setSeller(seller);
            prod.setDescription(description);
            prod.setPrice(price);
            prod.setAmount(amount);
            prod.setStock(stock);
            prod.setImages(images.trim());
            prod.setStatus(status);
            prod.setWishlist(0);
            prod.setCreateDate(LocalDate.now());

            productService.insert(prod);
            resp.sendRedirect(req.getContextPath() + "/admin/products?msg=created");
        } else if (uri.endsWith("/admin/product/edit")) {
            int id = Integer.parseInt(req.getParameter("productId"));
            Product_24110388 prod = productService.findById(id);
            if (prod != null) {
                prod.setProductName(name.trim());
                prod.setProductCode(productCode);
                prod.setCategory(category);
                prod.setSeller(seller);
                prod.setDescription(description);
                prod.setPrice(price);
                prod.setAmount(amount);
                prod.setStock(stock);
                prod.setImages(images.trim());
                prod.setStatus(status);

                productService.update(prod);
                resp.sendRedirect(req.getContextPath() + "/admin/products?msg=updated");
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/products?error=not_found");
            }
        }
    }
}

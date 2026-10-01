package vn.iotstar.dethi05.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.dethi05.entity.Product_24110388;
import vn.iotstar.dethi05.service.IProductService_24110388;
import vn.iotstar.dethi05.service.impl.ProductService_24110388;

import java.io.IOException;

@WebServlet(urlPatterns = {"/product-detail"})
public class ProductDetailController_24110388 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IProductService_24110388 productService = new ProductService_24110388();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/products-by-seller");
            return;
        }

        try {
            int productId = Integer.parseInt(idParam.trim());
            Product_24110388 product = productService.findById(productId);

            if (product == null) {
                resp.sendRedirect(req.getContextPath() + "/products-by-seller");
                return;
            }

            req.setAttribute("product", product);
            req.getRequestDispatcher("/views/web/product-detail.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/products-by-seller");
        }
    }
}

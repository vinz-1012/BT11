package vn.iotstar.dethi05.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.dethi05.service.ICategoryService_24110388;
import vn.iotstar.dethi05.service.IProductService_24110388;
import vn.iotstar.dethi05.service.ISellerService_24110388;
import vn.iotstar.dethi05.service.impl.CategoryService_24110388;
import vn.iotstar.dethi05.service.impl.ProductService_24110388;
import vn.iotstar.dethi05.service.impl.SellerService_24110388;

import java.io.IOException;

@WebServlet(urlPatterns = {"/admin/home", "/admin"})
public class AdminHomeController_24110388 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ICategoryService_24110388 categoryService = new CategoryService_24110388();
    private final IProductService_24110388 productService = new ProductService_24110388();
    private final ISellerService_24110388 sellerService = new SellerService_24110388();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int totalCategories = categoryService.count();
        int totalProducts = productService.count();
        int totalSellers = sellerService.findAll().size();

        req.setAttribute("totalCategories", totalCategories);
        req.setAttribute("totalProducts", totalProducts);
        req.setAttribute("totalSellers", totalSellers);

        req.getRequestDispatcher("/views/admin/home.jsp").forward(req, resp);
    }
}

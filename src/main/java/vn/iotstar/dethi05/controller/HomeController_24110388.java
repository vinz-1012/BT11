package vn.iotstar.dethi05.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.dethi05.entity.Seller_24110388;
import vn.iotstar.dethi05.service.ISellerService_24110388;
import vn.iotstar.dethi05.service.impl.SellerService_24110388;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/home", "/products-by-seller"})
public class HomeController_24110388 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ISellerService_24110388 sellerService = new SellerService_24110388();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        List<Seller_24110388> sellersWithProducts = sellerService.findAllWithProducts();

        req.setAttribute("sellersWithProducts", sellersWithProducts);
        req.getRequestDispatcher("/views/web/products-by-seller.jsp").forward(req, resp);
    }
}

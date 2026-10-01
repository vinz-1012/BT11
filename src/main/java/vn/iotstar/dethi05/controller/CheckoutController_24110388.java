package vn.iotstar.dethi05.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.dethi05.entity.*;
import vn.iotstar.dethi05.service.ICartService_24110388;
import vn.iotstar.dethi05.service.IProductService_24110388;
import vn.iotstar.dethi05.service.impl.CartService_24110388;
import vn.iotstar.dethi05.service.impl.ProductService_24110388;

import java.io.IOException;
import java.util.*;

@WebServlet(urlPatterns = {"/checkout", "/order-success", "/my-orders"})
public class CheckoutController_24110388 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ICartService_24110388 cartService = new CartService_24110388();
    private final IProductService_24110388 productService = new ProductService_24110388();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        HttpSession session = req.getSession();

        if ("/checkout".equals(path)) {
            Users_24110388 user = (Users_24110388) session.getAttribute("account");
            if (user == null) {
                session.setAttribute("loginMessage", "Vui lòng đăng nhập tài khoản để tiến hành đặt hàng COD!");
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            @SuppressWarnings("unchecked")
            Map<Integer, CartItemModel_24110388> cart = (Map<Integer, CartItemModel_24110388>) session.getAttribute("cart");
            if (cart == null || cart.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/cart");
                return;
            }

            req.getRequestDispatcher("/views/web/checkout.jsp").forward(req, resp);
        } else if ("/order-success".equals(path)) {
            String orderId = req.getParameter("id");
            if (orderId == null || orderId.trim().isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/home");
                return;
            }

            OrderReceipt_24110388 lastOrder = (OrderReceipt_24110388) session.getAttribute("lastOrder");
            if (lastOrder != null && orderId.equals(lastOrder.getOrderId())) {
                req.setAttribute("receipt", lastOrder);
            } else {
                Cart_24110388 cart = cartService.findById(orderId);
                if (cart == null) {
                    resp.sendRedirect(req.getContextPath() + "/home");
                    return;
                }
                List<CartItem_24110388> dbItems = cartService.findItemsByCartId(orderId);
                List<CartItemModel_24110388> itemModels = new ArrayList<>();
                double total = 0.0;
                for (CartItem_24110388 ci : dbItems) {
                    CartItemModel_24110388 m = new CartItemModel_24110388(ci.getProduct(), ci.getQuantity());
                    m.setUnitPrice(ci.getUnitPrice() != null ? ci.getUnitPrice() : 0.0);
                    itemModels.add(m);
                    total += m.getTotalPrice();
                }

                OrderReceipt_24110388 receipt = new OrderReceipt_24110388(
                        cart.getCartId(),
                        cart.getBuyDate(),
                        cart.getUser() != null ? (cart.getUser().getFullname() != null ? cart.getUser().getFullname() : cart.getUser().getUsername()) : "Khách hàng",
                        cart.getUser() != null ? cart.getUser().getPhone() : "",
                        cart.getUser() != null ? cart.getUser().getEmail() : "",
                        "Giao hàng tận nơi (COD)",
                        "",
                        "Thanh toán khi nhận hàng (COD)",
                        itemModels,
                        total
                );
                req.setAttribute("receipt", receipt);
            }

            req.getRequestDispatcher("/views/web/order-success.jsp").forward(req, resp);
        } else if ("/my-orders".equals(path)) {
            Users_24110388 user = (Users_24110388) session.getAttribute("account");
            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }
            List<Cart_24110388> myOrders = cartService.findByUserId(user.getUserId());
            req.setAttribute("orders", myOrders);
            req.getRequestDispatcher("/views/web/my-orders.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users_24110388 user = (Users_24110388) session.getAttribute("account");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        @SuppressWarnings("unchecked")
        Map<Integer, CartItemModel_24110388> cart = (Map<Integer, CartItemModel_24110388>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        req.setCharacterEncoding("UTF-8");
        String recipientName = req.getParameter("recipientName");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String shippingAddress = req.getParameter("shippingAddress");
        String notes = req.getParameter("notes");
        String paymentMethod = req.getParameter("paymentMethod");

        if (recipientName == null || recipientName.trim().isEmpty()) {
            recipientName = user.getFullname() != null ? user.getFullname() : user.getUsername();
        }
        if (phone == null || phone.trim().isEmpty()) {
            phone = user.getPhone() != null ? user.getPhone() : "";
        }
        if (email == null || email.trim().isEmpty()) {
            email = user.getEmail() != null ? user.getEmail() : "";
        }

        if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập địa chỉ nhận hàng chi tiết để giao hàng COD!");
            req.getRequestDispatcher("/views/web/checkout.jsp").forward(req, resp);
            return;
        }

        if (phone.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập số điện thoại người nhận hàng!");
            req.getRequestDispatcher("/views/web/checkout.jsp").forward(req, resp);
            return;
        }

        for (CartItemModel_24110388 item : cart.values()) {
            Product_24110388 currentDbProduct = productService.findById(item.getProduct().getProductId());
            if (currentDbProduct == null || (currentDbProduct.getAmount() != null && currentDbProduct.getAmount() < item.getQuantity())) {
                int available = currentDbProduct != null && currentDbProduct.getAmount() != null ? currentDbProduct.getAmount() : 0;
                req.setAttribute("error", "Sản phẩm \"" + item.getProduct().getProductName() + "\" không đủ số lượng tồn kho (chỉ còn " + available + "). Vui lòng điều chỉnh lại giỏ hàng!");
                req.getRequestDispatcher("/views/web/checkout.jsp").forward(req, resp);
                return;
            }
        }

        try {
            String cartId = "DH" + System.currentTimeMillis();
            Date now = new Date();
            Cart_24110388 orderCart = new Cart_24110388(cartId, user, now, 1);

            List<CartItem_24110388> orderItems = new ArrayList<>();
            List<CartItemModel_24110388> receiptItems = new ArrayList<>();
            double totalAmount = 0.0;

            for (CartItemModel_24110388 item : cart.values()) {
                String cartItemId = "CI" + System.currentTimeMillis() + "_" + item.getProduct().getProductId();
                CartItem_24110388 entityItem = new CartItem_24110388(
                        cartItemId,
                        item.getQuantity(),
                        item.getUnitPrice(),
                        item.getProduct(),
                        orderCart
                );
                orderItems.add(entityItem);
                receiptItems.add(new CartItemModel_24110388(item.getProduct(), item.getQuantity()));
                totalAmount += item.getTotalPrice();
            }

            cartService.saveOrder(orderCart, orderItems);

            OrderReceipt_24110388 receipt = new OrderReceipt_24110388(
                    cartId,
                    now,
                    recipientName,
                    phone,
                    email,
                    shippingAddress,
                    notes,
                    (paymentMethod != null && !paymentMethod.isEmpty()) ? paymentMethod : "Thanh toán khi nhận hàng (COD)",
                    receiptItems,
                    totalAmount
            );

            session.setAttribute("lastOrder", receipt);

            cart.clear();
            session.removeAttribute("cartCount");
            session.removeAttribute("cartTotal");

            resp.sendRedirect(req.getContextPath() + "/order-success?id=" + cartId);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Đã xảy ra lỗi trong quá trình xử lý đơn hàng. Vui lòng thử lại!");
            req.getRequestDispatcher("/views/web/checkout.jsp").forward(req, resp);
        }
    }
}

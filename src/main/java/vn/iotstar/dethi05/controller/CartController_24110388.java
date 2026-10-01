package vn.iotstar.dethi05.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.dethi05.entity.CartItemModel_24110388;
import vn.iotstar.dethi05.entity.Product_24110388;
import vn.iotstar.dethi05.service.IProductService_24110388;
import vn.iotstar.dethi05.service.impl.ProductService_24110388;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet(urlPatterns = {"/cart", "/cart/add", "/cart/update", "/cart/delete", "/cart/clear"})
public class CartController_24110388 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IProductService_24110388 productService = new ProductService_24110388();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        String action = req.getParameter("action");
        if (action == null) {
            if ("/cart/add".equals(path)) action = "add";
            else if ("/cart/update".equals(path)) action = "update";
            else if ("/cart/delete".equals(path)) action = "delete";
            else if ("/cart/clear".equals(path)) action = "clear";
            else action = "view";
        }

        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        Map<Integer, CartItemModel_24110388> cart = (Map<Integer, CartItemModel_24110388>) session.getAttribute("cart");
        if (cart == null) {
            cart = new LinkedHashMap<>();
            session.setAttribute("cart", cart);
        }

        switch (action) {
            case "add":
                addToCart(req, resp, session, cart);
                break;
            case "update":
                updateCart(req, resp, session, cart);
                break;
            case "delete":
                deleteFromCart(req, resp, session, cart);
                break;
            case "clear":
                clearCart(req, resp, session, cart);
                break;
            case "view":
            default:
                updateCartMetrics(session, cart);
                req.getRequestDispatcher("/views/web/cart.jsp").forward(req, resp);
                break;
        }
    }

    private void addToCart(HttpServletRequest req, HttpServletResponse resp, HttpSession session, Map<Integer, CartItemModel_24110388> cart) throws IOException {
        try {
            int productId = Integer.parseInt(req.getParameter("productId"));
            int quantity = 1;
            String qtyParam = req.getParameter("quantity");
            if (qtyParam != null && !qtyParam.trim().isEmpty()) {
                quantity = Integer.parseInt(qtyParam.trim());
            }
            if (quantity < 1) quantity = 1;

            Product_24110388 product = productService.findById(productId);
            if (product != null) {
                int maxStock = product.getAmount() != null ? product.getAmount() : 0;
                if (maxStock <= 0) {
                    session.setAttribute("cartWarning", "Sản phẩm \"" + product.getProductName() + "\" hiện tại đã hết hàng!");
                    resp.sendRedirect(req.getContextPath() + "/cart");
                    return;
                }

                CartItemModel_24110388 existingItem = cart.get(productId);
                int currentQtyInCart = existingItem != null ? existingItem.getQuantity() : 0;
                int targetQty = currentQtyInCart + quantity;

                if (targetQty > maxStock) {
                    targetQty = maxStock;
                    session.setAttribute("cartWarning", "Số lượng sản phẩm \"" + product.getProductName() + "\" trong giỏ hàng đã được điều chỉnh về mức tối đa tồn kho (" + maxStock + ").");
                } else {
                    session.setAttribute("cartSuccess", "Đã thêm \"" + product.getProductName() + "\" vào giỏ hàng thành công!");
                }

                if (existingItem != null) {
                    existingItem.setQuantity(targetQty);
                } else {
                    cart.put(productId, new CartItemModel_24110388(product, targetQty));
                }

                updateCartMetrics(session, cart);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        String redirect = req.getParameter("redirect");
        if ("checkout".equalsIgnoreCase(redirect)) {
            resp.sendRedirect(req.getContextPath() + "/checkout");
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    private void updateCart(HttpServletRequest req, HttpServletResponse resp, HttpSession session, Map<Integer, CartItemModel_24110388> cart) throws IOException {
        try {
            int productId = Integer.parseInt(req.getParameter("productId"));
            CartItemModel_24110388 item = cart.get(productId);

            if (item != null) {
                Product_24110388 product = productService.findById(productId);
                int maxStock = product != null && product.getAmount() != null ? product.getAmount() : item.getQuantity();

                String changeType = req.getParameter("change");
                int newQty = item.getQuantity();

                if ("inc".equalsIgnoreCase(changeType)) {
                    newQty++;
                } else if ("dec".equalsIgnoreCase(changeType)) {
                    newQty--;
                } else {
                    String qtyParam = req.getParameter("quantity");
                    if (qtyParam != null && !qtyParam.trim().isEmpty()) {
                        newQty = Integer.parseInt(qtyParam.trim());
                    }
                }

                if (newQty > maxStock) {
                    newQty = maxStock;
                    session.setAttribute("cartWarning", "Số lượng yêu cầu vượt quá tồn kho. Đã tự động điều chỉnh về số lượng tối đa: " + maxStock);
                } else if (newQty < 1) {
                    newQty = 1;
                    session.setAttribute("cartWarning", "Số lượng tối thiểu của sản phẩm trong giỏ hàng là 1.");
                } else {
                    session.setAttribute("cartSuccess", "Cập nhật số lượng thành công!");
                }

                item.setQuantity(newQty);
                updateCartMetrics(session, cart);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void deleteFromCart(HttpServletRequest req, HttpServletResponse resp, HttpSession session, Map<Integer, CartItemModel_24110388> cart) throws IOException {
        try {
            int productId = Integer.parseInt(req.getParameter("productId"));
            CartItemModel_24110388 removed = cart.remove(productId);
            if (removed != null) {
                session.setAttribute("cartSuccess", "Đã xóa \"" + removed.getProduct().getProductName() + "\" khỏi giỏ hàng.");
            }
            updateCartMetrics(session, cart);
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void clearCart(HttpServletRequest req, HttpServletResponse resp, HttpSession session, Map<Integer, CartItemModel_24110388> cart) throws IOException {
        cart.clear();
        updateCartMetrics(session, cart);
        session.setAttribute("cartSuccess", "Đã xóa toàn bộ giỏ hàng.");
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void updateCartMetrics(HttpSession session, Map<Integer, CartItemModel_24110388> cart) {
        int count = 0;
        double total = 0.0;
        for (CartItemModel_24110388 item : cart.values()) {
            count += item.getQuantity();
            total += item.getTotalPrice();
        }
        session.setAttribute("cartCount", count);
        session.setAttribute("cartTotal", total);
    }
}

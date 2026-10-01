package vn.iotstar.dethi05.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.dethi05.entity.Seller_24110388;
import vn.iotstar.dethi05.entity.Users_24110388;
import vn.iotstar.dethi05.service.ISellerService_24110388;
import vn.iotstar.dethi05.service.impl.SellerService_24110388;
import vn.iotstar.dethi05.util.Constant_24110388;
import vn.iotstar.dethi05.util.UploadUtil_24110388;

import java.io.IOException;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 20
)
@WebServlet(urlPatterns = {"/seller/shop", "/seller/settings"})
public class SellerShopController_24110388 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ISellerService_24110388 sellerService = new SellerService_24110388();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Users_24110388 account = (session != null) ? (Users_24110388) session.getAttribute(Constant_24110388.SESSION_USER) : null;

        if (account == null) {
            resp.sendRedirect(req.getContextPath() + "/login?error=need_login");
            return;
        }

        Seller_24110388 seller = null;
        if (account.getSeller() != null) {
            seller = sellerService.findById(account.getSeller().getSellerId());
        } else if (account.getRole() != null && account.getRole().getRoleId() == 1) {
            String idStr = req.getParameter("id");
            int sellerId = (idStr != null && !idStr.trim().isEmpty()) ? Integer.parseInt(idStr.trim()) : 1;
            seller = sellerService.findById(sellerId);
        }

        if (seller == null) {
            resp.sendRedirect(req.getContextPath() + "/home?error=not_seller");
            return;
        }

        String msg = req.getParameter("msg");
        if ("updated".equals(msg)) {
            req.setAttribute("message", "Cập nhật thông tin cửa hàng thành công!");
        }

        req.setAttribute("seller", seller);
        req.getRequestDispatcher("/views/web/seller-shop.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Users_24110388 account = (session != null) ? (Users_24110388) session.getAttribute(Constant_24110388.SESSION_USER) : null;

        if (account == null) {
            resp.sendRedirect(req.getContextPath() + "/login?error=need_login");
            return;
        }

        int sellerId = 0;
        if (account.getSeller() != null) {
            sellerId = account.getSeller().getSellerId();
        } else if (account.getRole() != null && account.getRole().getRoleId() == 1) {
            String idStr = req.getParameter("sellerId");
            if (idStr != null && !idStr.trim().isEmpty()) {
                sellerId = Integer.parseInt(idStr.trim());
            }
        }

        if (sellerId <= 0) {
            resp.sendRedirect(req.getContextPath() + "/home?error=not_seller");
            return;
        }

        String sellername = req.getParameter("sellername");
        String statusStr = req.getParameter("status");
        int status = ("1".equals(statusStr)) ? 1 : 0;

        if (sellername == null || sellername.trim().isEmpty()) {
            req.setAttribute("error", "Tên cửa hàng không được để trống!");
            Seller_24110388 current = sellerService.findById(sellerId);
            req.setAttribute("seller", current);
            req.getRequestDispatcher("/views/web/seller-shop.jsp").forward(req, resp);
            return;
        }

        Seller_24110388 seller = sellerService.findById(sellerId);
        if (seller != null) {
            seller.setSellername(sellername.trim());
            seller.setStatus(status);

            try {
                Part filePart = req.getPart("imageFile");
                String uploaded = UploadUtil_24110388.saveUploadFile(filePart, getServletContext());
                if (uploaded != null) {
                    seller.setImages("/uploads/" + uploaded);
                }
            } catch (Exception e) {
                System.err.println("Lỗi upload ảnh seller: " + e.getMessage());
            }

            sellerService.update(seller);

            if (account.getSeller() != null && account.getSeller().getSellerId() == seller.getSellerId()) {
                account.setSeller(seller);
                session.setAttribute(Constant_24110388.SESSION_USER, account);
            }

            resp.sendRedirect(req.getContextPath() + "/seller/shop?msg=updated");
        } else {
            resp.sendRedirect(req.getContextPath() + "/seller/shop?error=not_found");
        }
    }
}

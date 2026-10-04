package vn.iotstar.dethi05.service;

import vn.iotstar.dethi05.entity.CartItem_24110388;
import vn.iotstar.dethi05.entity.Cart_24110388;

import java.util.List;

public interface ICartService_24110388 {
    void insertCart(Cart_24110388 cart);
    void insertCartItem(CartItem_24110388 cartItem);
    void saveOrder(Cart_24110388 cart, List<CartItem_24110388> items);
    Cart_24110388 findById(String cartId);
    List<Cart_24110388> findByUserId(int userId);
    List<Cart_24110388> findByUserIdAndStatus(int userId, int status);
    List<CartItem_24110388> findItemsByCartId(String cartId);
}

package vn.iotstar.dethi05.service.impl;

import vn.iotstar.dethi05.dao.ICartDao_24110388;
import vn.iotstar.dethi05.dao.impl.CartDao_24110388;
import vn.iotstar.dethi05.entity.CartItem_24110388;
import vn.iotstar.dethi05.entity.Cart_24110388;
import vn.iotstar.dethi05.service.ICartService_24110388;

import java.util.List;

public class CartService_24110388 implements ICartService_24110388 {

    private final ICartDao_24110388 cartDao = new CartDao_24110388();

    @Override
    public void insertCart(Cart_24110388 cart) {
        cartDao.insertCart(cart);
    }

    @Override
    public void insertCartItem(CartItem_24110388 cartItem) {
        cartDao.insertCartItem(cartItem);
    }

    @Override
    public void saveOrder(Cart_24110388 cart, List<CartItem_24110388> items) {
        cartDao.saveOrder(cart, items);
    }

    @Override
    public Cart_24110388 findById(String cartId) {
        return cartDao.findById(cartId);
    }

    @Override
    public List<Cart_24110388> findByUserId(int userId) {
        return cartDao.findByUserId(userId);
    }

    @Override
    public List<CartItem_24110388> findItemsByCartId(String cartId) {
        return cartDao.findItemsByCartId(cartId);
    }
}

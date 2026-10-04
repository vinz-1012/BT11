package vn.iotstar.dethi05.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.dethi05.config.JpaConfig_24110388;
import vn.iotstar.dethi05.dao.ICartDao_24110388;
import vn.iotstar.dethi05.entity.CartItem_24110388;
import vn.iotstar.dethi05.entity.Cart_24110388;
import vn.iotstar.dethi05.entity.Product_24110388;
import vn.iotstar.dethi05.entity.Users_24110388;

import java.util.List;

public class CartDao_24110388 implements ICartDao_24110388 {

    @Override
    public void insertCart(Cart_24110388 cart) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(cart);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void insertCartItem(CartItem_24110388 cartItem) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(cartItem);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void saveOrder(Cart_24110388 cart, List<CartItem_24110388> items) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            if (cart.getUser() != null) {
                Users_24110388 u = em.find(Users_24110388.class, cart.getUser().getUserId());
                cart.setUser(u);
            }
            cart.setCartItems(items);
            em.persist(cart);
            for (CartItem_24110388 item : items) {
                item.setCart(cart);
                if (item.getProduct() != null) {
                    Product_24110388 p = em.find(Product_24110388.class, item.getProduct().getProductId());
                    item.setProduct(p);
                    if (p != null) {
                        int currentAmount = p.getAmount() != null ? p.getAmount() : 0;
                        int newAmount = currentAmount - item.getQuantity();
                        p.setAmount(Math.max(newAmount, 0));

                        if (p.getStock() != null) {
                            int currentStock = p.getStock();
                            int newStock = currentStock - item.getQuantity();
                            p.setStock(Math.max(newStock, 0));
                        }
                        em.merge(p);
                    }
                }
                em.persist(item);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public Cart_24110388 findById(String cartId) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        try {
            TypedQuery<Cart_24110388> query = em.createQuery(
                    "SELECT DISTINCT c FROM Cart_24110388 c LEFT JOIN FETCH c.user u LEFT JOIN FETCH c.cartItems ci LEFT JOIN FETCH ci.product p WHERE c.cartId = :cartId",
                    Cart_24110388.class);
            query.setParameter("cartId", cartId);
            List<Cart_24110388> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Cart_24110388> findByUserId(int userId) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        try {
            TypedQuery<Cart_24110388> query = em.createQuery(
                    "SELECT DISTINCT c FROM Cart_24110388 c LEFT JOIN FETCH c.cartItems ci LEFT JOIN FETCH ci.product p WHERE c.user.userId = :userId ORDER BY c.buyDate DESC",
                    Cart_24110388.class);
            query.setParameter("userId", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Cart_24110388> findByUserIdAndStatus(int userId, int status) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        try {
            String jpql;
            if (status == 1) {
                jpql = "SELECT DISTINCT c FROM Cart_24110388 c LEFT JOIN FETCH c.cartItems ci LEFT JOIN FETCH ci.product p WHERE c.user.userId = :userId AND (c.status = 1 OR c.status = 0 OR c.status IS NULL) ORDER BY c.buyDate DESC";
            } else {
                jpql = "SELECT DISTINCT c FROM Cart_24110388 c LEFT JOIN FETCH c.cartItems ci LEFT JOIN FETCH ci.product p WHERE c.user.userId = :userId AND c.status = :status ORDER BY c.buyDate DESC";
            }
            TypedQuery<Cart_24110388> query = em.createQuery(jpql, Cart_24110388.class);
            query.setParameter("userId", userId);
            if (status != 1) {
                query.setParameter("status", status);
            }
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<CartItem_24110388> findItemsByCartId(String cartId) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        try {
            TypedQuery<CartItem_24110388> query = em.createQuery(
                    "SELECT ci FROM CartItem_24110388 ci LEFT JOIN FETCH ci.product p WHERE ci.cart.cartId = :cartId",
                    CartItem_24110388.class);
            query.setParameter("cartId", cartId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}

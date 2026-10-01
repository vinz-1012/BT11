package vn.iotstar.dethi05.entity;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "CartItem")
public class CartItem_24110388 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "cartItemId", length = 50, nullable = false)
    private String cartItemId;

    @Column(name = "quantity")
    private Integer quantity;

    @Column(name = "unitPrice")
    private Double unitPrice;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "productId")
    private Product_24110388 product;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cartId")
    private Cart_24110388 cart;

    public CartItem_24110388() {
    }

    public CartItem_24110388(String cartItemId, Integer quantity, Double unitPrice, Product_24110388 product, Cart_24110388 cart) {
        this.cartItemId = cartItemId;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.product = product;
        this.cart = cart;
    }

    public String getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(String cartItemId) {
        this.cartItemId = cartItemId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(Double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public Product_24110388 getProduct() {
        return product;
    }

    public void setProduct(Product_24110388 product) {
        this.product = product;
    }

    public Cart_24110388 getCart() {
        return cart;
    }

    public void setCart(Cart_24110388 cart) {
        this.cart = cart;
    }
}

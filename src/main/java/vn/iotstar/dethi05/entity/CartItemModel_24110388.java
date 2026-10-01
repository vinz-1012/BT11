package vn.iotstar.dethi05.entity;

import java.io.Serializable;

public class CartItemModel_24110388 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Product_24110388 product;
    private int quantity;
    private double unitPrice;

    public CartItemModel_24110388() {
    }

    public CartItemModel_24110388(Product_24110388 product, int quantity) {
        this.product = product;
        this.quantity = quantity;
        this.unitPrice = product.getPrice() != null ? product.getPrice() : 0.0;
    }

    public Product_24110388 getProduct() {
        return product;
    }

    public void setProduct(Product_24110388 product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public double getTotalPrice() {
        return unitPrice * quantity;
    }
}

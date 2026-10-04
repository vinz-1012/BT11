package vn.iotstar.dethi05.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "Cart")
public class Cart_24110388 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "cartId", length = 50, nullable = false)
    private String cartId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "userId")
    private Users_24110388 user;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "buyDate")
    private Date buyDate;

    @Column(name = "status")
    private Integer status;

    @OneToMany(mappedBy = "cart", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<CartItem_24110388> cartItems;

    public Cart_24110388() {
    }

    public Cart_24110388(String cartId, Users_24110388 user, Date buyDate, Integer status) {
        this.cartId = cartId;
        this.user = user;
        this.buyDate = buyDate;
        this.status = status;
    }

    public String getCartId() {
        return cartId;
    }

    public void setCartId(String cartId) {
        this.cartId = cartId;
    }

    public Users_24110388 getUser() {
        return user;
    }

    public void setUser(Users_24110388 user) {
        this.user = user;
    }

    public Date getBuyDate() {
        return buyDate;
    }

    public void setBuyDate(Date buyDate) {
        this.buyDate = buyDate;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public List<CartItem_24110388> getCartItems() {
        return cartItems;
    }

    public void setCartItems(List<CartItem_24110388> cartItems) {
        this.cartItems = cartItems;
    }

    public String getStatusName() {
        if (status == null) return "Đơn hàng mới";
        return switch (status) {
            case 1, 0 -> "Đơn hàng mới";
            case 2 -> "Đã xác nhận";
            case 3 -> "Chuẩn bị hàng";
            case 4 -> "Vận chuyển";
            case 5 -> "Giao hàng";
            case 6 -> "Đã giao";
            case 7 -> "Đơn hàng hủy";
            case 8 -> "Đơn hàng hoàn";
            default -> "Đơn hàng mới";
        };
    }

    public String getStatusBadgeClass() {
        if (status == null) return "badge bg-primary-subtle text-primary border border-primary-subtle";
        return switch (status) {
            case 1, 0 -> "badge bg-primary-subtle text-primary border border-primary-subtle";
            case 2 -> "badge bg-info-subtle text-info-emphasis border border-info-subtle";
            case 3 -> "badge bg-warning-subtle text-warning-emphasis border border-warning-subtle";
            case 4 -> "badge bg-secondary-subtle text-secondary-emphasis border border-secondary-subtle";
            case 5 -> "badge bg-primary text-white";
            case 6 -> "badge bg-success-subtle text-success border border-success-subtle";
            case 7 -> "badge bg-danger-subtle text-danger border border-danger-subtle";
            case 8 -> "badge bg-dark-subtle text-dark border border-dark-subtle";
            default -> "badge bg-secondary-subtle text-secondary";
        };
    }

    public String getStatusIcon() {
        if (status == null) return "fa-solid fa-file-invoice";
        return switch (status) {
            case 1, 0 -> "fa-solid fa-file-invoice";
            case 2 -> "fa-solid fa-clipboard-check";
            case 3 -> "fa-solid fa-boxes-packing";
            case 4 -> "fa-solid fa-truck";
            case 5 -> "fa-solid fa-motorcycle";
            case 6 -> "fa-solid fa-circle-check";
            case 7 -> "fa-solid fa-circle-xmark";
            case 8 -> "fa-solid fa-arrow-rotate-left";
            default -> "fa-solid fa-clock-rotate-left";
        };
    }

    public double getTotalAmount() {
        if (cartItems == null || cartItems.isEmpty()) return 0.0;
        double sum = 0.0;
        for (CartItem_24110388 item : cartItems) {
            if (item != null && item.getUnitPrice() != null && item.getQuantity() != null) {
                sum += item.getUnitPrice() * item.getQuantity();
            }
        }
        return sum;
    }
}

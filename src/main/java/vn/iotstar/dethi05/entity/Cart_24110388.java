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
}

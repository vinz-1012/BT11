package vn.iotstar.dethi05.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "Seller")
public class Seller_24110388 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "sellerId")
    private int sellerId;

    @Column(name = "sellername", length = 50, nullable = false)
    private String sellername;

    @Column(name = "images", length = 500)
    private String images;

    @Column(name = "status")
    private Integer status;

    @OneToMany(mappedBy = "seller", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Product_24110388> products;

    @OneToMany(mappedBy = "seller", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Users_24110388> users;

    public Seller_24110388() {
    }

    public Seller_24110388(int sellerId, String sellername, String images, Integer status) {
        this.sellerId = sellerId;
        this.sellername = sellername;
        this.images = images;
        this.status = status;
    }

    public int getSellerId() {
        return sellerId;
    }

    public void setSellerId(int sellerId) {
        this.sellerId = sellerId;
    }

    public String getSellername() {
        return sellername;
    }

    public void setSellername(String sellername) {
        this.sellername = sellername;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public List<Product_24110388> getProducts() {
        return products;
    }

    public void setProducts(List<Product_24110388> products) {
        this.products = products;
    }

    public List<Users_24110388> getUsers() {
        return users;
    }

    public void setUsers(List<Users_24110388> users) {
        this.users = users;
    }
}

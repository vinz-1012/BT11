package vn.iotstar.dethi05.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "Product")
public class Product_24110388 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "productId")
    private int productId;

    @Column(name = "productName", length = 200, nullable = false)
    private String productName;

    @Column(name = "productCode")
    private Long productCode;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "categoryId")
    private Category_24110388 category;

    @Column(name = "description", length = 500)
    private String description;

    @Column(name = "price")
    private Double price;

    @Column(name = "amount")
    private Integer amount;

    @Column(name = "stock")
    private Integer stock;

    @Column(name = "images", length = 500)
    private String images;

    @Column(name = "wishlist")
    private Integer wishlist;

    @Column(name = "status")
    private Integer status;

    @Column(name = "createDate")
    private LocalDate createDate;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "sellerId")
    private Seller_24110388 seller;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<CartItem_24110388> cartItems;

    public Product_24110388() {
    }

    public Product_24110388(int productId, String productName, Long productCode, Category_24110388 category,
                           String description, Double price, Integer amount, Integer stock, String images,
                           Integer wishlist, Integer status, LocalDate createDate, Seller_24110388 seller) {
        this.productId = productId;
        this.productName = productName;
        this.productCode = productCode;
        this.category = category;
        this.description = description;
        this.price = price;
        this.amount = amount;
        this.stock = stock;
        this.images = images;
        this.wishlist = wishlist;
        this.status = status;
        this.createDate = createDate;
        this.seller = seller;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Long getProductCode() {
        return productCode;
    }

    public void setProductCode(Long productCode) {
        this.productCode = productCode;
    }

    public Category_24110388 getCategory() {
        return category;
    }

    public void setCategory(Category_24110388 category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public Integer getWishlist() {
        return wishlist;
    }

    public void setWishlist(Integer wishlist) {
        this.wishlist = wishlist;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public LocalDate getCreateDate() {
        return createDate;
    }

    public void setCreateDate(LocalDate createDate) {
        this.createDate = createDate;
    }

    public Seller_24110388 getSeller() {
        return seller;
    }

    public void setSeller(Seller_24110388 seller) {
        this.seller = seller;
    }

    public List<CartItem_24110388> getCartItems() {
        return cartItems;
    }

    public void setCartItems(List<CartItem_24110388> cartItems) {
        this.cartItems = cartItems;
    }
}

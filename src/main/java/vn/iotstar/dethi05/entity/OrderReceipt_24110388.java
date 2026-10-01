package vn.iotstar.dethi05.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class OrderReceipt_24110388 implements Serializable {
    private static final long serialVersionUID = 1L;

    private String orderId;
    private Date orderDate;
    private String recipientName;
    private String recipientPhone;
    private String recipientEmail;
    private String shippingAddress;
    private String notes;
    private String paymentMethod;
    private List<CartItemModel_24110388> items;
    private double totalAmount;

    public OrderReceipt_24110388() {
    }

    public OrderReceipt_24110388(String orderId, Date orderDate, String recipientName, String recipientPhone,
                                 String recipientEmail, String shippingAddress, String notes,
                                 String paymentMethod, List<CartItemModel_24110388> items, double totalAmount) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.recipientName = recipientName;
        this.recipientPhone = recipientPhone;
        this.recipientEmail = recipientEmail;
        this.shippingAddress = shippingAddress;
        this.notes = notes;
        this.paymentMethod = paymentMethod;
        this.items = items;
        this.totalAmount = totalAmount;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getRecipientName() {
        return recipientName;
    }

    public void setRecipientName(String recipientName) {
        this.recipientName = recipientName;
    }

    public String getRecipientPhone() {
        return recipientPhone;
    }

    public void setRecipientPhone(String recipientPhone) {
        this.recipientPhone = recipientPhone;
    }

    public String getRecipientEmail() {
        return recipientEmail;
    }

    public void setRecipientEmail(String recipientEmail) {
        this.recipientEmail = recipientEmail;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public List<CartItemModel_24110388> getItems() {
        return items;
    }

    public void setItems(List<CartItemModel_24110388> items) {
        this.items = items;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
}

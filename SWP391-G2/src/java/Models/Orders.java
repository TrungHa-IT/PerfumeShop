/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.math.BigDecimal;
import java.sql.Date;

/**
 *
 * @author hatru
 */
public class Orders {

    private int orderID;
    private int accountID;
    private Date orderDate;
    private Double orderTotalPrice;
    private String orderContactName;
    private String orderPhone;
    private String email;
    private String orderAddress;
    private String PaymentMethod;
    private String orderNote;
    private int orderSoID;
    private int voucherID;

    public Orders() {
    }

    public Orders(int orderID, int accountID, Date orderDate, Double orderTotalPrice, String orderContactName, String orderPhone, String email, String orderAddress, String PaymentMethod, String orderNote, int orderSoID, int voucherID) {
        this.orderID = orderID;
        this.accountID = accountID;
        this.orderDate = orderDate;
        this.orderTotalPrice = orderTotalPrice;
        this.orderContactName = orderContactName;
        this.orderPhone = orderPhone;
        this.email = email;
        this.orderAddress = orderAddress;
        this.PaymentMethod = PaymentMethod;
        this.orderNote = orderNote;
        this.orderSoID = orderSoID;
        this.voucherID = voucherID;
    }

    public Orders(int accountID, Date orderDate, Double orderTotalPrice, String orderContactName, String orderPhone, String email, String orderAddress, String PaymentMethod, String orderNote, int orderSoID, int voucherID) {
        this.accountID = accountID;
        this.orderDate = orderDate;
        this.orderTotalPrice = orderTotalPrice;
        this.orderContactName = orderContactName;
        this.orderPhone = orderPhone;
        this.email = email;
        this.orderAddress = orderAddress;
        this.PaymentMethod = PaymentMethod;
        this.orderNote = orderNote;
        this.orderSoID = orderSoID;
        this.voucherID = voucherID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public Double getOrderTotalPrice() {
        return orderTotalPrice;
    }

    public void setOrderTotalPrice(Double orderTotalPrice) {
        this.orderTotalPrice = orderTotalPrice;
    }

    public String getOrderContactName() {
        return orderContactName;
    }

    public void setOrderContactName(String orderContactName) {
        this.orderContactName = orderContactName;
    }

    public String getOrderPhone() {
        return orderPhone;
    }

    public void setOrderPhone(String orderPhone) {
        this.orderPhone = orderPhone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getOrderAddress() {
        return orderAddress;
    }

    public void setOrderAddress(String orderAddress) {
        this.orderAddress = orderAddress;
    }

    public String getPaymentMethod() {
        return PaymentMethod;
    }

    public void setPaymentMethod(String PaymentMethod) {
        this.PaymentMethod = PaymentMethod;
    }

    public String getOrderNote() {
        return orderNote;
    }

    public void setOrderNote(String orderNote) {
        this.orderNote = orderNote;
    }

    public int getOrderSoID() {
        return orderSoID;
    }

    public void setOrderSoID(int orderSoID) {
        this.orderSoID = orderSoID;
    }

    public int getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(int voucherID) {
        this.voucherID = voucherID;
    }

    @Override
    public String toString() {
        return "Orders{" + "orderID=" + orderID + ", accountID=" + accountID + ", orderDate=" + orderDate + ", orderTotalPrice=" + orderTotalPrice + ", orderContactName=" + orderContactName + ", orderPhone=" + orderPhone + ", email=" + email + ", orderAddress=" + orderAddress + ", PaymentMethod=" + PaymentMethod + ", orderNote=" + orderNote + ", orderSoID=" + orderSoID + ", voucherID=" + voucherID + '}';
    }

   
}

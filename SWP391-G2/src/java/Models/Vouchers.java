/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author nguye
 */
import java.sql.Date;

public class Vouchers {

    private int voucherID;
    private String code;
    private double discount;
    private Date expiryDate;
    private Date startDate;
    private int quantity;
    private Date createAt;
    private int status;

    public Vouchers(String code) {
        this.code = code;
    }

    public Vouchers(int voucherID, String code, double discount, Date expiryDate, Date startDate, int quantity, Date createAt, int status) {
        this.voucherID = voucherID;
        this.code = code;
        this.discount = discount;
        this.expiryDate = expiryDate;
        this.startDate = startDate;
        this.quantity = quantity;
        this.createAt = createAt;
        this.status = status;
    }

    public Vouchers(String code, double discount, Date expiryDate, Date startDate, int quantity, Date createAt, int status) {
        this.code = code;
        this.discount = discount;
        this.expiryDate = expiryDate;
        this.startDate = startDate;
        this.quantity = quantity;
        this.createAt = createAt;
        this.status = status;
    }

    public Vouchers() {
    }

    public int getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(int voucherID) {
        this.voucherID = voucherID;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

}

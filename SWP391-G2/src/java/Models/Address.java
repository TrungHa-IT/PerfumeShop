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

public class Address {

    private int addressId;
    private int accountId;
    private String phone;
    private String addressLine;
    private String city;
    private String district;
    private String wards;
    private int status;
    private Date createdAt;

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddressLine() {
        return addressLine;
    }

    public void setAddressLine(String addressLine) {
        this.addressLine = addressLine;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getWards() {
        return wards;
    }

    public void setWards(String wards) {
        this.wards = wards;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Address() {
    }

    public Address(int accountId, String phone, String addressLine, String city, String district, String wards, int status, Date createdAt) {
        this.accountId = accountId;
        this.phone = phone;
        this.addressLine = addressLine;
        this.city = city;
        this.district = district;
        this.wards = wards;
        this.status = status;
        this.createdAt = createdAt;
    }

    public Address(int addressId, int accountId, String phone, String addressLine, String city, String district, String wards, int status, Date createdAt) {
        this.addressId = addressId;
        this.accountId = accountId;
        this.phone = phone;
        this.addressLine = addressLine;
        this.city = city;
        this.district = district;
        this.wards = wards;
        this.status = status;
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Address{" + "addressId=" + addressId + ", accountId=" + accountId + ", phone=" + phone + ", addressLine=" + addressLine + ", city=" + city + ", district=" + district + ", wards=" + wards + ", status=" + status + ", createdAt=" + createdAt + '}';
    }

}

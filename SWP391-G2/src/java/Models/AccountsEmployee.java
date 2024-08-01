/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.Date;

/**
 *
 * @author hatru
 */
public class AccountsEmployee {
    private int accountID;
    private String firstName;
    private String lastName;
    private String password;
    private String image;
    private int gender;
    private Date birthDay;
    private String email;
    private int status;
    private Date createDate;
    private int roleID;
    private String phone;
    private String address;

    public AccountsEmployee() {
    }

    public AccountsEmployee(int accountID, String firstName, String lastName, String password, String image, int gender, Date birthDay, String email, int status, Date createDate, int roleID, String phone, String address) {
        this.accountID = accountID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.password = password;
        this.image = image;
        this.gender = gender;
        this.birthDay = birthDay;
        this.email = email;
        this.status = status;
        this.createDate = createDate;
        this.roleID = roleID;
        this.phone = phone;
        this.address = address;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public Date getBirthDay() {
        return birthDay;
    }

    public void setBirthDay(Date birthDay) {
        this.birthDay = birthDay;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "AccountsEmployee{" + "accountID=" + accountID + ", firstName=" + firstName + ", lastName=" + lastName + ", password=" + password + ", image=" + image + ", gender=" + gender + ", birthDay=" + birthDay + ", email=" + email + ", status=" + status + ", createDate=" + createDate + ", roleID=" + roleID + ", phone=" + phone + ", address=" + address + '}';
    }
    
    
}
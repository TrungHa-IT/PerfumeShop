/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.Date;

/**
 *
 * @author ROG
 */
public class Products {

    private int productID;
    private String productName;
    private Date productCreateDate;
    private int productStatus;
    private String productImageUrl;
    private int brandID;
    private int categoryID;

    public Products(int productID, String productName, Date productCreateDate, int productStatus, String productImageUrl, int brandID, int categoryID) {
        this.productID = productID;
        this.productName = productName;
        this.productCreateDate = productCreateDate;
        this.productStatus = productStatus;
        this.productImageUrl = productImageUrl;
        this.brandID = brandID;
        this.categoryID = categoryID;
    }

    public Products(String productName, Date productCreateDate, int productStatus, String productImageUrl, int brandID, int categoryID) {
        this.productName = productName;
        this.productCreateDate = productCreateDate;
        this.productStatus = productStatus;
        this.productImageUrl = productImageUrl;
        this.brandID = brandID;
        this.categoryID = categoryID;
    }

    public Products() {
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Date getProductCreateDate() {
        return productCreateDate;
    }

    public void setProductCreateDate(Date productCreateDate) {
        this.productCreateDate = productCreateDate;
    }

    public int getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(int productStatus) {
        this.productStatus = productStatus;
    }

    public String getProductImageUrl() {
        return productImageUrl;
    }

    public void setProductImageUrl(String productImageUrl) {
        this.productImageUrl = productImageUrl;
    }

    public int getBrandID() {
        return brandID;
    }

    public void setBrandID(int brandID) {
        this.brandID = brandID;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public Products(int productID, String productName, int productStatus, String productImageUrl, int brandID, int categoryID) {
        this.productID = productID;
        this.productName = productName;
        this.productStatus = productStatus;
        this.productImageUrl = productImageUrl;
        this.brandID = brandID;
        this.categoryID = categoryID;
    }
    
}

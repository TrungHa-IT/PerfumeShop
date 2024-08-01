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
public class ProductDetail {

   private int productFullDetailID;
    private int pdProductID;
    private String productDescription;
    private Date productCreateDate;
    private int productStatus;
    private String productSize;
    private BigDecimal productPrice;
    private int productAvaiable;
    private String image;

    public ProductDetail() {
    }

    public int getProductFullDetailID() {
        return productFullDetailID;
    }

    public void setProductFullDetailID(int productFullDetailID) {
        this.productFullDetailID = productFullDetailID;
    }

    public int getPdProductID() {
        return pdProductID;
    }

    public void setPdProductID(int pdProductID) {
        this.pdProductID = pdProductID;
    }

    public String getProductDescription() {
        return productDescription;
    }

    public void setProductDescription(String productDescription) {
        this.productDescription = productDescription;
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

    public String getProductSize() {
        return productSize;
    }

    public void setProductSize(String productSize) {
        this.productSize = productSize;
    }

    public BigDecimal getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(BigDecimal productPrice) {
        this.productPrice = productPrice;
    }

    public int getProductAvaiable() {
        return productAvaiable;
    }

    public void setProductAvaiable(int productAvaiable) {
        this.productAvaiable = productAvaiable;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public ProductDetail(int pdProductID, String productDescription, Date productCreateDate, int productStatus, String productSize, BigDecimal productPrice, int productAvaiable, String image) {
        this.pdProductID = pdProductID;
        this.productDescription = productDescription;
        this.productCreateDate = productCreateDate;
        this.productStatus = productStatus;
        this.productSize = productSize;
        this.productPrice = productPrice;
        this.productAvaiable = productAvaiable;
        this.image = image;
    }

    public ProductDetail(int productFullDetailID, int pdProductID, String productDescription, Date productCreateDate, int productStatus, String productSize, BigDecimal productPrice, int productAvaiable, String image) {
        this.productFullDetailID = productFullDetailID;
        this.pdProductID = pdProductID;
        this.productDescription = productDescription;
        this.productCreateDate = productCreateDate;
        this.productStatus = productStatus;
        this.productSize = productSize;
        this.productPrice = productPrice;
        this.productAvaiable = productAvaiable;
        this.image = image;
    }

    public ProductDetail(int productFullDetailID, String productDescription, int productStatus, String productSize, BigDecimal productPrice, int productAvaiable, String image) {
        this.productFullDetailID = productFullDetailID;
        this.productDescription = productDescription;
        this.productStatus = productStatus;
        this.productSize = productSize;
        this.productPrice = productPrice;
        this.productAvaiable = productAvaiable;
        this.image = image;
    }
    
    
}

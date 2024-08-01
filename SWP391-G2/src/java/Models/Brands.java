/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author admin
 */
import java.sql.Date;

public class Brands {

    private int brandID;
    private String brandName;
    private String description;
    private Date createAt;
    private int status;

    public Brands(int brandID, String brandName, String description, Date createAt, int status) {
        this.brandID = brandID;
        this.brandName = brandName;
        this.description = description;
        this.createAt = createAt;
        this.status = status;
    }

    public Brands(String brandName, String description, Date createAt, int status) {
        this.brandName = brandName;
        this.description = description;
        this.createAt = createAt;
        this.status = status;
    }

    public Brands() {
    }

    public int getBrandID() {
        return brandID;
    }

    public void setBrandID(int brandID) {
        this.brandID = brandID;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.Date;

public class Categories {

    private int categoryID;
    private String categoryName;
    private String description;
    private Date createAt;
    private int status;

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
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

    public Categories() {
    }

    public Categories(String categoryName, String description, Date createAt, int status) {
        this.categoryName = categoryName;
        this.description = description;
        this.createAt = createAt;
        this.status = status;
    }

    public Categories(int categoryID, String categoryName, String description, Date createAt, int status) {
        this.categoryID = categoryID;
        this.categoryName = categoryName;
        this.description = description;
        this.createAt = createAt;
        this.status = status;
    }

}

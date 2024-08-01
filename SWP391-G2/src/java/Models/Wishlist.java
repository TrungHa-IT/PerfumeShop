/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.Date;

/**
 *
 * @author pna29
 */
public class Wishlist {
    private int wishlistID;
    private int accountID;
    private int productID;
    private Date dateAdded;

    public Wishlist() {
    }

    public Wishlist(int wishlistID, int accountID, int productID, Date dateAdded) {
        this.wishlistID = wishlistID;
        this.accountID = accountID;
        this.productID = productID;
        this.dateAdded = dateAdded;
    }

    public int getWishlistID() {
        return wishlistID;
    }

    public void setWishlistID(int wishlistID) {
        this.wishlistID = wishlistID;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public Date getDateAdded() {
        return dateAdded;
    }

    public void setDateAdded(Date dateAdded) {
        this.dateAdded = dateAdded;
    }
    
    
}

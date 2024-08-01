/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.math.BigDecimal;

/**
 *
 * @author hatru
 */
public class OrderDetail {

    private int odID;
    private int odOrderID;
    private int odProductID;
    private int odQuantity;
    private BigDecimal odPrice;
    private String odName;

    public OrderDetail() {
    }

    public OrderDetail(int odID, int odOrderID, int odProductID, int odQuantity, BigDecimal odPrice, String odName) {
        this.odID = odID;
        this.odOrderID = odOrderID;
        this.odProductID = odProductID;
        this.odQuantity = odQuantity;
        this.odPrice = odPrice;
        this.odName = odName;
    }

    public int getOdID() {
        return odID;
    }

    public void setOdID(int odID) {
        this.odID = odID;
    }

    public int getOdOrderID() {
        return odOrderID;
    }

    public void setOdOrderID(int odOrderID) {
        this.odOrderID = odOrderID;
    }

    public int getOdProductID() {
        return odProductID;
    }

    public void setOdProductID(int odProductID) {
        this.odProductID = odProductID;
    }

    public int getOdQuantity() {
        return odQuantity;
    }

    public void setOdQuantity(int odQuantity) {
        this.odQuantity = odQuantity;
    }

    public BigDecimal getOdPrice() {
        return odPrice;
    }

    public void setOdPrice(BigDecimal odPrice) {
        this.odPrice = odPrice;
    }

    public String getOdName() {
        return odName;
    }

    public void setOdName(String odName) {
        this.odName = odName;
    }

    

    
    

}

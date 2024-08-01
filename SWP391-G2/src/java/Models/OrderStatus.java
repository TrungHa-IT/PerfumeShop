/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author nguye
 */
public class OrderStatus {

    private int SOID;
    private String SOName;

    public OrderStatus() {
    }

    public OrderStatus(int SOID, String SOName) {
        this.SOID = SOID;
        this.SOName = SOName;
    }

    public int getSOID() {
        return SOID;
    }

    public void setSOID(int SOID) {
        this.SOID = SOID;
    }

    public String getSOName() {
        return SOName;
    }

    public void setSOName(String SOName) {
        this.SOName = SOName;
    }

}

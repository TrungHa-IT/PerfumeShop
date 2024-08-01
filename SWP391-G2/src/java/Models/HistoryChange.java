/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.Date;

/**
 *
 * @author nguye
 */
public class HistoryChange {

    private int accountId;
    private Date date;
    private String textChange;
    private String localChange;

    public HistoryChange() {
    }

    public HistoryChange(int accountId, Date date, String textChange, String localChange) {
        this.accountId = accountId;
        this.date = date;
        this.textChange = textChange;
        this.localChange = localChange;
    }

    public HistoryChange(Date date, String textChange, String localChange) {
        this.date = date;
        this.textChange = textChange;
        this.localChange = localChange;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getTextChange() {
        return textChange;
    }

    public void setTextChange(String textChange) {
        this.textChange = textChange;
    }

    public String getLocalChange() {
        return localChange;
    }

    public void setLocalChange(String localChange) {
        this.localChange = localChange;
    }

}

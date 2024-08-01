/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.Date;

/**
 *
 * @author admin
 */
public class FeedBacks {

    private int fbID;
    private int fbAccountID;
    private int fbProductID;
    private int fbStar;
    private String fbContent;
    private String fbImage;
    private Date fbDate;
    private int fbStatus;
    private String reply;

    public FeedBacks() {
    }

    public FeedBacks(int fbID, int fbAccountID, int fbProductID, int fbStar, String fbContent, String fbImage, Date fbDate, int fbStatus, String reply) {
        this.fbID = fbID;
        this.fbAccountID = fbAccountID;
        this.fbProductID = fbProductID;
        this.fbStar = fbStar;
        this.fbContent = fbContent;
        this.fbImage = fbImage;
        this.fbDate = fbDate;
        this.fbStatus = fbStatus;
        this.reply = reply;
    }

    public FeedBacks(int fbAccountID, int fbProductID, int fbStar, String fbContent, String fbImage, Date fbDate, int fbStatus, String reply) {
        this.fbAccountID = fbAccountID;
        this.fbProductID = fbProductID;
        this.fbStar = fbStar;
        this.fbContent = fbContent;
        this.fbImage = fbImage;
        this.fbDate = fbDate;
        this.fbStatus = fbStatus;
        this.reply = reply;
    }

    public int getFbID() {
        return fbID;
    }

    public void setFbID(int fbID) {
        this.fbID = fbID;
    }

    public int getFbAccountID() {
        return fbAccountID;
    }

    public void setFbAccountID(int fbAccountID) {
        this.fbAccountID = fbAccountID;
    }

    public int getFbProductID() {
        return fbProductID;
    }

    public void setFbProductID(int fbProductID) {
        this.fbProductID = fbProductID;
    }

    public int getFbStar() {
        return fbStar;
    }

    public void setFbStar(int fbStar) {
        this.fbStar = fbStar;
    }

    public String getFbContent() {
        return fbContent;
    }

    public void setFbContent(String fbContent) {
        this.fbContent = fbContent;
    }

    public String getFbImage() {
        return fbImage;
    }

    public void setFbImage(String fbImage) {
        this.fbImage = fbImage;
    }

    public Date getFbDate() {
        return fbDate;
    }

    public void setFbDate(Date fbDate) {
        this.fbDate = fbDate;
    }

    public int getFbStatus() {
        return fbStatus;
    }

    public void setFbStatus(int fbStatus) {
        this.fbStatus = fbStatus;
    }

    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }

}

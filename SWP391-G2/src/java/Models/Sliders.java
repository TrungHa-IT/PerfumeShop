/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.Date;

/**
 *
 * @author nguye
 */
public class Sliders {
   private int sliderID;
    private String sliderImage;
    private int sliderStatus;
    private String sliderTitle;
    private Date updateAt;
    private Integer accountId;

    public Sliders() {
    }

    public Sliders(int sliderID, String sliderImage, int sliderStatus, String sliderTitle, Date updateAt, Integer accountId) {
        this.sliderID = sliderID;
        this.sliderImage = sliderImage;
        this.sliderStatus = sliderStatus;
        this.sliderTitle = sliderTitle;
        this.updateAt = updateAt;
        this.accountId = accountId;
    }

    public int getSliderID() {
        return sliderID;
    }

    public void setSliderID(int sliderID) {
        this.sliderID = sliderID;
    }

    public String getSliderImage() {
        return sliderImage;
    }

    public void setSliderImage(String sliderImage) {
        this.sliderImage = sliderImage;
    }

    public int getSliderStatus() {
        return sliderStatus;
    }

    public void setSliderStatus(int sliderStatus) {
        this.sliderStatus = sliderStatus;
    }

    public String getSliderTitle() {
        return sliderTitle;
    }

    public void setSliderTitle(String sliderTitle) {
        this.sliderTitle = sliderTitle;
    }

    public Date getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Date updateAt) {
        this.updateAt = updateAt;
    }

    public Integer getAccountId() {
        return accountId;
    }

    public void setAccountId(Integer accountId) {
        this.accountId = accountId;
    }

    

  

   


}

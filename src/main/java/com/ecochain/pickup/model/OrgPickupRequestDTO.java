package com.ecochain.pickup.model;

import java.sql.Timestamp;

public class OrgPickupRequestDTO {
    private int pickupId;
    private String foodName;
    private String donorName;
    private String donorAddress;
    private String donorPhone;
    private String status;
    private Timestamp pickupTime;

    public OrgPickupRequestDTO() {}

    public int getPickupId() { return pickupId; }
    public void setPickupId(int pickupId) { this.pickupId = pickupId; }

    public String getFoodName() { return foodName; }
    public void setFoodName(String foodName) { this.foodName = foodName; }

    public String getDonorName() { return donorName; }
    public void setDonorName(String donorName) { this.donorName = donorName; }

    public String getDonorAddress() { return donorAddress; }
    public void setDonorAddress(String donorAddress) { this.donorAddress = donorAddress; }

    public String getDonorPhone() { return donorPhone; }
    public void setDonorPhone(String donorPhone) { this.donorPhone = donorPhone; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getPickupTime() { return pickupTime; }
    public void setPickupTime(Timestamp pickupTime) { this.pickupTime = pickupTime; }
}
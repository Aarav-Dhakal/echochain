package com.ecochain.pickup.model;

import java.sql.Timestamp;

public class PickupRequestDTO {
    private int pickupId;
    private String foodName;
    private String orgName;
    private double quantity;
    private String status;
    private Timestamp pickupTime;
    private String notes;

    public PickupRequestDTO() {}

    public int getPickupId() { return pickupId; }
    public void setPickupId(int pickupId) { this.pickupId = pickupId; }

    public String getFoodName() { return foodName; }
    public void setFoodName(String foodName) { this.foodName = foodName; }

    public String getOrgName() { return orgName; }
    public void setOrgName(String orgName) { this.orgName = orgName; }

    public double getQuantity() { return quantity; }
    public void setQuantity(double quantity) { this.quantity = quantity; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getPickupTime() { return pickupTime; }
    public void setPickupTime(Timestamp pickupTime) { this.pickupTime = pickupTime; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
}
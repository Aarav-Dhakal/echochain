package com.ecochain.pickup.model;

import java.sql.Timestamp;

public class Pickup {
    private int id;
    private int listingId;
    private int orgId;
    private double quantity;
    private Timestamp pickupTime;
    private String status;
    private String notes;

    public Pickup(int id, int listingId, int orgId, double quantity, Timestamp pickupTime, String status, String notes) {
        this.id = id;
        this.listingId = listingId;
        this.orgId = orgId;
        this.quantity = quantity;
        this.pickupTime = pickupTime;
        this.status = status;
        this.notes = notes;
    }

    public Pickup() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getListingId() {
        return listingId;
    }

    public void setListingId(int listingId) {
        this.listingId = listingId;
    }

    public int getOrgId() {
        return orgId;
    }

    public void setOrgId(int orgId) {
        this.orgId = orgId;
    }

    public double getQuantity() {
        return quantity;
    }

    public void setQuantity(double quantity) {
        this.quantity = quantity;
    }

    public Timestamp getPickupTime() {
        return pickupTime;
    }

    public void setPickupTime(Timestamp pickupTime) {
        this.pickupTime = pickupTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}
package com.ecochain.listing.model;

import java.util.Date;

public class Listing {
    private int id;
    private int donorId;
    private int categoryId;
    private String foodName;
    private double quantity;
    private String unit;
    private Date expiryDate;
    private String storageNotes;
    private String allergens;
    private String status;
    private String categoryName;

    public Listing(int id, int donorId, int categoryId, String foodName, double quantity, String unit, Date expiryDate, String storageNotes, String allergens, String status) {
        this.id = id;
        this.donorId = donorId;
        this.categoryId = categoryId;
        this.foodName = foodName;
        this.quantity = quantity;
        this.unit = unit;
        this.expiryDate = expiryDate;
        this.storageNotes = storageNotes;
        this.allergens = allergens;
        this.status = status;
    }

    public Listing() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getDonorId() {
        return donorId;
    }

    public void setDonorId(int donorId) {
        this.donorId = donorId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public double getQuantity() {
        return quantity;
    }

    public void setQuantity(double quantity) {
        this.quantity = quantity;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getStorageNotes() {
        return storageNotes;
    }

    public void setStorageNotes(String storageNotes) {
        this.storageNotes = storageNotes;
    }

    public String getAllergens() {
        return allergens;
    }

    public void setAllergens(String allergens) {
        this.allergens = allergens;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
}
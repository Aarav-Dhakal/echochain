package com.ecochain.feedback.model;

public class Feedback {
    private int id;
    private int pickupId;
    private int orgId;
    private int donorId;
    private int rating;
    private String comment;

    public Feedback(int id, int pickupId, int orgId, int donorId, int rating, String comment) {
        this.id = id;
        this.pickupId = pickupId;
        this.orgId = orgId;
        this.donorId = donorId;
        this.rating = rating;
        this.comment = comment;
    }

    public Feedback() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPickupId() {
        return pickupId;
    }

    public void setPickupId(int pickupId) {
        this.pickupId = pickupId;
    }

    public int getOrgId() {
        return orgId;
    }

    public void setOrgId(int orgId) {
        this.orgId = orgId;
    }

    public int getDonorId() {
        return donorId;
    }

    public void setDonorId(int donorId) {
        this.donorId = donorId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
}
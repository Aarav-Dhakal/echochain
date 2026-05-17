package com.ecochain.organization.model;

public class Organization {
    private int id;
    private int userId;
    private String orgName;
    private String address;
    private String phone;
    private String areaOfService;
    private String regCertificate;
    private double totalFoodReceived;

    public Organization(int id, int userId, String orgName, String address, String phone, String areaOfService, String regCertificate, double totalFoodReceived) {
        this.id = id;
        this.userId = userId;
        this.orgName = orgName;
        this.address = address;
        this.phone = phone;
        this.areaOfService = areaOfService;
        this.regCertificate = regCertificate;
        this.totalFoodReceived = totalFoodReceived;
    }

    public Organization() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAreaOfService() {
        return areaOfService;
    }

    public void setAreaOfService(String areaOfService) {
        this.areaOfService = areaOfService;
    }

    public String getRegCertificate() {
        return regCertificate;
    }

    public void setRegCertificate(String regCertificate) {
        this.regCertificate = regCertificate;
    }

    public double getTotalFoodReceived() {
        return totalFoodReceived;
    }

    public void setTotalFoodReceived(double totalFoodReceived) {
        this.totalFoodReceived = totalFoodReceived;
    }
}
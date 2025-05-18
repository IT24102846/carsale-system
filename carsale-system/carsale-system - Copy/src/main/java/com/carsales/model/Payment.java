package com.carsales.model;

public class Payment {
    private String id;
    private String userId;
    private double amount;
    private String status;


    public Payment() {
        this.status = "PENDING"; // Default value
    }

    public Payment(String id, String userId, double amount) {
        this.id = id;
        this.userId = userId;
        this.amount = amount;
        this.status = "PENDING";
    }

    public Payment(String id, String userId, double amount, String status) {
        this.id = id;
        this.userId = userId;
        this.amount = amount;
        this.status = status;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
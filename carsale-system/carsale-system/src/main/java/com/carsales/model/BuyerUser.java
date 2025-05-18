package com.carsales.model;

public class BuyerUser extends User {
    private String address;
    private String preferredPaymentMethod;

    // Constructors
    public BuyerUser() { super(); }

    public BuyerUser(String userId, String username, String password, String email,
                     String phoneNumber, String address, String preferredPaymentMethod) {
        super(userId, username, password, email, phoneNumber, "BUYER");
        this.address = address;
        this.preferredPaymentMethod = preferredPaymentMethod;
    }

    // Getters and Setters
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPreferredPaymentMethod() { return preferredPaymentMethod; }
    public void setPreferredPaymentMethod(String preferredPaymentMethod) {
        this.preferredPaymentMethod = preferredPaymentMethod;
    }

    // Polymorphism
    @Override
    public String displayDashboard() {
        return "Buyer Dashboard - " + getUsername();
    }

    // File operations
    @Override
    public String toFileString() {
        return super.toFileString() + "," + address + "," + preferredPaymentMethod;
    }

    public static BuyerUser fromFileString(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 8) {
            return new BuyerUser(parts[0], parts[1], parts[2], parts[3], parts[4], parts[6], parts[7]);
        }
        return null;
    }
}
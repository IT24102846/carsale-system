package com.carsales.model;

public class SellerUser extends User {
    private String address;
    private String bankAccount;


    // Constructors
    public SellerUser() { super(); }

    public SellerUser(String userId, String username, String password, String email,
                      String phoneNumber, String address, String bankAccount) {
        super(userId, username, password, email, phoneNumber, "SELLER");
        this.address = address;
        this.bankAccount = bankAccount;
    }

    // Getters and Setters
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getBankAccount() { return bankAccount; }
    public void setBankAccount(String bankAccount) { this.bankAccount = bankAccount; }

    // Polymorphism
    @Override
    public String displayDashboard() {
        return "Seller Dashboard - " + getUsername();
    }

    // File operations
    @Override
    public String toFileString() {
        return super.toFileString() + "," + address + "," + bankAccount;
    }

    public static SellerUser fromFileString(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 8) {
            return new SellerUser(parts[0], parts[1], parts[2], parts[3], parts[4], parts[6], parts[7]);
        }
        return null;
    }
}
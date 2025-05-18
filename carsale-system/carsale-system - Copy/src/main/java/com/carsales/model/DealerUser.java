package com.carsales.model;

public class DealerUser extends User {
    private String dealershipName;
    private String dealershipAddress;
    private String businessLicense;



    // Constructors
    public DealerUser() { super(); }

    public DealerUser(String userId, String username, String password, String email,
                      String phoneNumber, String dealershipName, String dealershipAddress,
                      String businessLicense) {
        super(userId, username, password, email, phoneNumber, "DEALER");
        this.dealershipName = dealershipName;
        this.dealershipAddress = dealershipAddress;
        this.businessLicense = businessLicense;
    }

    // Getters and Setters
    public String getDealershipName() { return dealershipName; }
    public void setDealershipName(String dealershipName) { this.dealershipName = dealershipName; }

    public String getDealershipAddress() { return dealershipAddress; }
    public void setDealershipAddress(String dealershipAddress) { this.dealershipAddress = dealershipAddress; }

    public String getBusinessLicense() { return businessLicense; }
    public void setBusinessLicense(String businessLicense) { this.businessLicense = businessLicense; }

    // Polymorphism
    @Override
    public String displayDashboard() {
        return "Dealer Dashboard - " + getUsername() + " (" + dealershipName + ")";
    }

    // File operations
    @Override
    public String toFileString() {
        return super.toFileString() + "," + dealershipName + "," + dealershipAddress + "," + businessLicense;
    }

    public static DealerUser fromFileString(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 9) {
            return new DealerUser(parts[0], parts[1], parts[2], parts[3], parts[4], parts[6], parts[7], parts[8]);
        }
        return null;
    }
}
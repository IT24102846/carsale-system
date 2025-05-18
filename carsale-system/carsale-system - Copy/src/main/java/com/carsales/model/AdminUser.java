package com.carsales.model;

public class AdminUser extends User {
    private String adminLevel;
    private String department;


    // Constructors
    public AdminUser() { super(); }

    public AdminUser(String userId, String username, String password, String email,
                     String phoneNumber, String adminLevel, String department) {
        super(userId, username, password, email, phoneNumber, "ADMIN");
        this.adminLevel = adminLevel;
        this.department = department;
    }

    // Getters and Setters
    public String getAdminLevel() { return adminLevel; }
    public void setAdminLevel(String adminLevel) { this.adminLevel = adminLevel; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    // Polymorphism
    @Override
    public String displayDashboard() {
        return "Admin Dashboard - " + getUsername() + " (" + adminLevel + ")";
    }

    // File operations
    @Override
    public String toFileString() {
        return super.toFileString() + "," + adminLevel + "," + department;
    }

    public static AdminUser fromFileString(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 8) {
            return new AdminUser(parts[0], parts[1], parts[2], parts[3], parts[4], parts[6], parts[7]);
        }
        return null;
    }
}
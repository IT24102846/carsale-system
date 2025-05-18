package com.carsales.model;

public class User {
    private String userId;
    private String username;
    private String password;
    private String email;
    private String phoneNumber;
    private String role;

    // Constructors
    public User() {}

    public User(String userId, String username, String password, String email, String phoneNumber, String role) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.role = role;
    }

    // Getters and Setters
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    // For polymorphism
    public String displayDashboard() {
        return "Default User Dashboard";
    }

    // File operations
    public String toFileString() {
        return userId + "," + username + "," + password + "," + email + "," + phoneNumber + "," + role;
    }

    public static User fromFileString(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 6) {
            return new User(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]);
        }
        return null;
    }
}
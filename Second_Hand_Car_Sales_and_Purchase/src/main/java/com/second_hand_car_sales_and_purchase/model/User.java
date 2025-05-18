package com.second_hand_car_sales_and_purchase.model;

public class User {
    private String id;
    private String username;
    private String email;
    private String password;
    private String role; // "user" or "admin"

    public User(String id, String username, String email, String password, String role) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.password = password;
        this.role = role;
    }

    public User() {}

    // Getters and setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    @Override
    public String toString() {
        return id + "," + username + "," + email + "," + password + "," + role;
    }

    public static User fromString(String line) {
        String[] parts = line.split(",");
        if (parts.length != 5) return null;
        return new User(parts[0], parts[1], parts[2], parts[3], parts[4]);
    }
}

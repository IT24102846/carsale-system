package com.carsales.dao;

import com.carsales.model.*;
import java.util.ArrayList;
import java.util.List;

public class UserDao extends FileDao<User> {

    public UserDao() {
        super("src/main/resources/data/users.txt");
    }

    @Override
    public User findById(String id) {
        List<String> lines = readAllLines();
        for (String line : lines) {
            User user = parseUserFromLine(line);
            if (user != null && user.getUserId().equals(id)) {
                return user;
            }
        }
        return null;

    }

    @Override
    public List<User> findAll() {
        List<String> lines = readAllLines();
        List<User> users = new ArrayList<>();

        for (String line : lines) {
            User user = parseUserFromLine(line);
            if (user != null) {
                users.add(user);
            }
        }
        return users;
    }

    public User findByUsername(String username) {
        List<String> lines = readAllLines();
        for (String line : lines) {
            User user = parseUserFromLine(line);
            if (user != null && user.getUsername().equals(username)) {
                return user;
            }
        }
        return null;
    }

    @Override
    public boolean save(User user) {
        // Check if user already exists
        if (findById(user.getUserId()) != null) {
            return false; // User already exists
        }

        List<String> lines = readAllLines();
        lines.add(user.toFileString());
        writeAllLines(lines);
        return true;
    }

    @Override
    public boolean update(User user) {
        List<String> lines = readAllLines();
        boolean updated = false;

        for (int i = 0; i < lines.size(); i++) {
            User existingUser = parseUserFromLine(lines.get(i));
            if (existingUser != null && existingUser.getUserId().equals(user.getUserId())) {
                lines.set(i, user.toFileString());
                updated = true;
                break;
            }
        }

        if (updated) {
            writeAllLines(lines);
        }
        return updated;
    }

    @Override
    public boolean deleteById(String id) {
        List<String> lines = readAllLines();
        boolean deleted = false;

        for (int i = 0; i < lines.size(); i++) {
            User existingUser = parseUserFromLine(lines.get(i));
            if (existingUser != null && existingUser.getUserId().equals(id)) {
                lines.remove(i);
                deleted = true;
                break;
            }
        }

        if (deleted) {
            writeAllLines(lines);
        }
        return deleted;
    }

    private User parseUserFromLine(String line) {
        String[] parts = line.split(",");
        if (parts.length < 6) {
            return null;
        }

        String role = parts[5];
        switch (role) {
            case "ADMIN":
                return AdminUser.fromFileString(line);
            case "BUYER":
                return BuyerUser.fromFileString(line);
            case "SELLER":
                return SellerUser.fromFileString(line);
            case "DEALER":
                return DealerUser.fromFileString(line);
            default:
                return User.fromFileString(line);
        }
    }
}
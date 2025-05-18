package com.danusha.root.dao;

import com.danusha.root.modal.User;
import com.danusha.root.utils.FileUtil;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

public class UserDao {
    // Create a new user
    public static void addUser(User user) {
        FileUtil.appendLine(user.toString());
    }

    // Get all users
    public static List<User> getAllUsers() {
        List<String> lines = FileUtil.readAllLines();
        return lines.stream()
                .map(User::fromString)
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
    }

    // Find user by ID
    public static User getUserById(String id) {
        return getAllUsers().stream()
                .filter(u -> u.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    // Find user by email (useful for login / duplicate check)
    public static User getUserByEmail(String email) {
        return getAllUsers().stream()
                .filter(u -> u.getEmail().equalsIgnoreCase(email))
                .findFirst()
                .orElse(null);
    }

    // Update user by ID
    public static boolean updateUser(User updatedUser) {
        List<User> users = getAllUsers();
        boolean found = false;

        for (int i = 0; i < users.size(); i++) {
            User u = users.get(i);
            if (u.getId().equals(updatedUser.getId())) {
                users.set(i, updatedUser);
                found = true;
                break;
            }
        }

        if (found) {
            List<String> lines = users.stream()
                    .map(User::toString)
                    .collect(Collectors.toList());
            FileUtil.writeAllLines(lines);
        }

        return found;
    }

    // Delete user by ID
    public static boolean deleteUser(String id) {
        List<User> users = getAllUsers();
        boolean removed = users.removeIf(u -> u.getId().equals(id));

        if (removed) {
            List<String> lines = users.stream()
                    .map(User::toString)
                    .collect(Collectors.toList());
            FileUtil.writeAllLines(lines);
        }

        return removed;
    }
}

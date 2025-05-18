package com.carsales.util;

import java.util.regex.Pattern;

public class ValidationUtil {

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^\\d{10}$");

    public static boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }

    public static boolean isValidPhone(String phone) {
        return phone != null && PHONE_PATTERN.matcher(phone).matches();
    }

    public static boolean isValidPassword(String password) {
        // Password must be at least 8 characters
        return password != null && password.length() >= 8;
    }

    public static boolean isValidPrice(double price) {
        return price > 0;
    }

    public static boolean isValidYear(int year) {
        int currentYear = java.time.Year.now().getValue();
        return year > 1900 && year <= currentYear;
    }
}
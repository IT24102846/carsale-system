package com.carsales.util;

import java.util.UUID;

public class IdGenerator {

    // Generate a new UUID
    public static String generateId() {
        return UUID.randomUUID().toString();
    }

    // Generate a shorter UUID (first 8 characters)
    public static String generateShortId() {
        return UUID.randomUUID().toString().substring(0, 8);
    }

    // Generate a numeric ID
    public static String generateNumericId(int length) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++) {
            sb.append((int) (Math.random() * 10));
        }
        return sb.toString();
    }
}
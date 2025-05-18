package com.second_hand_car_sales_and_purchase.util;

import java.io.*;
import java.nio.file.*;
import java.util.*;

public class FileUtil {
    private static final String USER_FILE = "C:\\Users\\User\\Desktop\\OOP-59\\Second_Hand_Car_Sales_and_Purchase\\src\\main\\webapp\\WEB-INF\\users.txt"; // <-- Adjust path as needed

    // Reads all lines from the file
    public static List<String> readAllLines() {
        try {
            File file = new File(USER_FILE);
            if (!file.exists()) file.createNewFile();
            return Files.readAllLines(Paths.get(USER_FILE));
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    // Writes all lines to the file
    public static void writeAllLines(List<String> lines) {
        try {
            Files.write(Paths.get(USER_FILE), lines);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Append a line to the file
    public static void appendLine(String line) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(USER_FILE, true))) {
            writer.write(line);
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

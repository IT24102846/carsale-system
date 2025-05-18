package com.danusha.root.utils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

public class FileUtil {
    private static final String USER_FILE = "C:\\Users\\User\\Desktop\\59\\user-managemnt\\user-managemnt\\data\\user.txt"; // <-- Adjust path as needed

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

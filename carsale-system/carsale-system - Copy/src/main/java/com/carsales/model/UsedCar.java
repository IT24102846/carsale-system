package com.carsales.model;

public class UsedCar extends Car {
    private String history;
    private int previousOwners;
    private boolean hasAccidentHistory;

    // Constructors
    public UsedCar() { super(); }

    public UsedCar(String carId, String brand, String model, int year, double price,
                   String condition, String color, double mileage, String sellerId,
                   boolean available, String imageUrl, String description,
                   String history, int previousOwners, boolean hasAccidentHistory) {
        super(carId, brand, model, year, price, condition, color, mileage, sellerId,
                available, imageUrl, description);
        this.history = history;
        this.previousOwners = previousOwners;
        this.hasAccidentHistory = hasAccidentHistory;
    }

    // Getters and Setters
    public String getHistory() { return history; }
    public void setHistory(String history) { this.history = history; }

    public int getPreviousOwners() { return previousOwners; }
    public void setPreviousOwners(int previousOwners) { this.previousOwners = previousOwners; }

    public boolean isHasAccidentHistory() { return hasAccidentHistory; }
    public void setHasAccidentHistory(boolean hasAccidentHistory) { this.hasAccidentHistory = hasAccidentHistory; }

    // Polymorphism
    @Override
    public String displayFormat() {
        return "USED - " + getYear() + " " + getBrand() + " " + getModel() + " (Owners: " + previousOwners + ")";
    }

    // File operations
    @Override
    public String toFileString() {
        return super.toFileString() + "," + history + "," + previousOwners + "," + hasAccidentHistory;
    }

    public static UsedCar fromFileString(String line) {
        try {
            String[] parts = line.split(",");
            if (parts.length >= 15) {
                return new UsedCar(
                        parts[0], parts[1], parts[2],
                        Integer.parseInt(parts[3]),
                        Double.parseDouble(parts[4]),
                        parts[5], parts[6],
                        Double.parseDouble(parts[7]),
                        parts[8],
                        Boolean.parseBoolean(parts[9]),
                        parts[10], parts[11],
                        parts[12],
                        Integer.parseInt(parts[13]),
                        Boolean.parseBoolean(parts[14])
                );
            }
            return null;
        } catch (Exception e) {
            System.err.println("Error parsing UsedCar: " + e.getMessage() + " - Line: " + line);
            return null;
        }
    }
}
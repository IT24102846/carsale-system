package com.carsales.model;

public class Car {
    private String carId;
    private String brand;
    private String model;
    private int year;
    private double price;
    private String condition;
    private String color;
    private double mileage;
    private String sellerId;
    private boolean available;
    private String imageUrl;
    private String description;

    // Default constructor
    public Car() {
    }

    // Parameterized constructor
    public Car(String carId, String brand, String model, int year, double price, String condition,
               String color, double mileage, String sellerId, boolean available, String imageUrl, String description) {
        this.carId = carId;
        this.brand = brand;
        this.model = model;
        this.year = year;
        this.price = price;
        this.condition = condition;
        this.color = color;
        this.mileage = mileage;
        this.sellerId = sellerId;
        this.available = available;
        this.imageUrl = imageUrl;
        this.description = description;
    }

    // Getters and Setters
    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public double getMileage() {
        return mileage;
    }

    public void setMileage(double mileage) {
        this.mileage = mileage;
    }

    public String getSellerId() {
        return sellerId;
    }

    public void setSellerId(String sellerId) {
        this.sellerId = sellerId;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    // For polymorphism - will be overridden by child classes
    public String displayFormat() {
        return year + " " + brand + " " + model;
    }

    // File operations
    public String toFileString() {
        return carId + "," + brand + "," + model + "," + year + "," + price + "," +
                condition + "," + color + "," + mileage + "," + sellerId + "," +
                available + "," + imageUrl + "," + description;
    }

    public static Car fromFileString(String line) {
        try {
            String[] parts = line.split(",");
            if (parts.length >= 12) {
                return new Car(
                        parts[0],                    // carId
                        parts[1],                    // brand
                        parts[2],                    // model
                        Integer.parseInt(parts[3]),  // year
                        Double.parseDouble(parts[4]), // price
                        parts[5],                    // condition
                        parts[6],                    // color
                        Double.parseDouble(parts[7]), // mileage
                        parts[8],                    // sellerId
                        Boolean.parseBoolean(parts[9]), // available
                        parts[10],                   // imageUrl
                        parts[11]                    // description
                );
            }
            return null;
        } catch (Exception e) {
            System.err.println("Error parsing Car: " + e.getMessage() + " - Line: " + line);
            return null;
        }
    }

    @Override
    public String toString() {
        return "Car{" +
                "carId='" + carId + '\'' +
                ", brand='" + brand + '\'' +
                ", model='" + model + '\'' +
                ", year=" + year +
                ", price=" + price +
                ", condition='" + condition + '\'' +
                ", available=" + available +
                '}';
    }
}
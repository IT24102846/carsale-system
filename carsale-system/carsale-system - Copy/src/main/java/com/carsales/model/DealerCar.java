package com.carsales.model;

public class DealerCar extends Car {
    private String dealershipId;
    private boolean hasWarranty;
    private int warrantyMonths;
    private boolean isFinancingAvailable;

    // Constructors
    public DealerCar() { super(); }

    public DealerCar(String carId, String brand, String model, int year, double price,
                     String condition, String color, double mileage, String sellerId,
                     boolean available, String imageUrl, String description,
                     String dealershipId, boolean hasWarranty, int warrantyMonths,
                     boolean isFinancingAvailable) {
        super(carId, brand, model, year, price, condition, color, mileage, sellerId,
                available, imageUrl, description);
        this.dealershipId = dealershipId;
        this.hasWarranty = hasWarranty;
        this.warrantyMonths = warrantyMonths;
        this.isFinancingAvailable = isFinancingAvailable;
    }

    // Getters and Setters
    public String getDealershipId() { return dealershipId; }
    public void setDealershipId(String dealershipId) { this.dealershipId = dealershipId; }

    public boolean isHasWarranty() { return hasWarranty; }
    public void setHasWarranty(boolean hasWarranty) { this.hasWarranty = hasWarranty; }

    public int getWarrantyMonths() { return warrantyMonths; }
    public void setWarrantyMonths(int warrantyMonths) { this.warrantyMonths = warrantyMonths; }

    public boolean isFinancingAvailable() { return isFinancingAvailable; }
    public void setFinancingAvailable(boolean financingAvailable) { isFinancingAvailable = financingAvailable; }

    // Polymorphism
    @Override
    public String displayFormat() {
        String warranty = hasWarranty ? " (Warranty: " + warrantyMonths + " months)" : " (No Warranty)";
        return "DEALER - " + getYear() + " " + getBrand() + " " + getModel() + warranty;
    }

    // File operations
    @Override
    public String toFileString() {
        return super.toFileString() + "," + dealershipId + "," + hasWarranty + "," +
                warrantyMonths + "," + isFinancingAvailable;
    }

    public static DealerCar fromFileString(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 16) {
            return new DealerCar(
                    parts[0], parts[1], parts[2],
                    Integer.parseInt(parts[3]),
                    Double.parseDouble(parts[4]),
                    parts[5], parts[6],
                    Double.parseDouble(parts[7]),
                    parts[8],
                    Boolean.parseBoolean(parts[9]),
                    parts[10], parts[11],
                    parts[12],
                    Boolean.parseBoolean(parts[13]),
                    Integer.parseInt(parts[14]),
                    Boolean.parseBoolean(parts[15])
            );
        }
        return null;
    }
}
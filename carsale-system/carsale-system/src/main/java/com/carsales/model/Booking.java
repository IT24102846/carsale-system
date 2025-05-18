package com.carsales.model;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.ParseException;

public class Booking {
    private String bookingId;
    private String carId;
    private String buyerId;
    private String sellerId;
    private Date bookingDate;
    private Date expectedDeliveryDate;
    private String status; // "PENDING", "CONFIRMED", "CANCELLED", "COMPLETED"
    private double amount;
    private String paymentMethod;
    private String notes;

    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    // Default constructor
    public Booking() {
    }

    // Parameterized constructor
    public Booking(String bookingId, String carId, String buyerId, String sellerId,
                   Date bookingDate, Date expectedDeliveryDate, String status, double amount,
                   String paymentMethod, String notes) {
        this.bookingId = bookingId;
        this.carId = carId;
        this.buyerId = buyerId;
        this.sellerId = sellerId;
        this.bookingDate = bookingDate;
        this.expectedDeliveryDate = expectedDeliveryDate;
        this.status = status;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.notes = notes;
    }

    // Getters and Setters
    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

    public String getBuyerId() {
        return buyerId;
    }

    public void setBuyerId(String buyerId) {
        this.buyerId = buyerId;
    }

    public String getSellerId() {
        return sellerId;
    }

    public void setSellerId(String sellerId) {
        this.sellerId = sellerId;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public Date getExpectedDeliveryDate() {
        return expectedDeliveryDate;
    }

    public void setExpectedDeliveryDate(Date expectedDeliveryDate) {
        this.expectedDeliveryDate = expectedDeliveryDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    // Helper method (Abstraction)
    public static boolean isCarAvailable(String carId) {
        // Placeholder
        return true;
    }

    // File operations
    public String toFileString() {
        return bookingId + "," + carId + "," + buyerId + "," + sellerId + "," +
                DATE_FORMAT.format(bookingDate) + "," + DATE_FORMAT.format(expectedDeliveryDate) + "," +
                status + "," + amount + "," + paymentMethod + "," + notes;
    }

    public static Booking fromFileString(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 10) {
            try {
                return new Booking(
                        parts[0],                         // bookingId
                        parts[1],                         // carId
                        parts[2],                         // buyerId
                        parts[3],                         // sellerId
                        DATE_FORMAT.parse(parts[4]),      // bookingDate
                        DATE_FORMAT.parse(parts[5]),      // expectedDeliveryDate
                        parts[6],                         // status
                        Double.parseDouble(parts[7]),     // amount
                        parts[8],                         // paymentMethod
                        parts[9]                          // notes
                );
            } catch (ParseException e) {
                System.err.println("Error parsing date: " + e.getMessage());
                return null;
            }
        }
        return null;
    }

    // Polymorphism methods
    public boolean processPurchase() {
        this.status = "COMPLETED";
        return true;
    }

    public boolean processBooking() {
        this.status = "CONFIRMED";
        return true;
    }

    @Override
    public String toString() {
        return "Booking{" +
                "bookingId='" + bookingId + '\'' +
                ", carId='" + carId + '\'' +
                ", buyerId='" + buyerId + '\'' +
                ", status='" + status + '\'' +
                ", amount=" + amount +
                '}';
    }
}
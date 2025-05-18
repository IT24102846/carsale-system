// PaymentMethod.java
package com.carsales.model;

import java.util.Date;
import java.text.SimpleDateFormat;

public abstract class PaymentMethod {
    private String paymentId;
    private String bookingId;
    private double amount;
    private Date paymentDate;
    private String status; // "PENDING", "COMPLETED", "FAILED", "REFUNDED"
    private String paymentType;

    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    // Default constructor
    public PaymentMethod() {}

    // Parameterized constructor
    public PaymentMethod(String paymentId, String bookingId, double amount,
                         Date paymentDate, String status, String paymentType) {
        this.paymentId = paymentId;
        this.bookingId = bookingId;
        this.amount = amount;
        this.paymentDate = paymentDate;
        this.status = status;
        this.paymentType = paymentType;
    }

    // Getters and Setters
    public String getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    // Abstract method (Abstraction)
    public abstract boolean processPayment();

    // File operations
    public String toFileString() {
        return paymentId + "," + bookingId + "," + amount + "," +
                DATE_FORMAT.format(paymentDate) + "," + status + "," + paymentType;
    }
}
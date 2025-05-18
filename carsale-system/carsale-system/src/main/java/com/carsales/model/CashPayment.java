// CashPayment.java
package com.carsales.model;

import java.util.Date;

public class CashPayment extends PaymentMethod {
    private String receiptNumber;
    private String cashierName;

    // Default constructor
    public CashPayment() {
        super();
    }

    // Parameterized constructor
    public CashPayment(String paymentId, String bookingId, double amount, Date paymentDate,
                       String status, String receiptNumber, String cashierName) {
        super(paymentId, bookingId, amount, paymentDate, status, "CASH");
        this.receiptNumber = receiptNumber;
        this.cashierName = cashierName;
    }

    // Getters and Setters
    public String getReceiptNumber() {
        return receiptNumber;
    }

    public void setReceiptNumber(String receiptNumber) {
        this.receiptNumber = receiptNumber;
    }

    public String getCashierName() {
        return cashierName;
    }

    public void setCashierName(String cashierName) {
        this.cashierName = cashierName;
    }

    // Implement abstract method
    @Override
    public boolean processPayment() {
        // Cash payment processing logic
        return true;
    }

    // File operations
    @Override
    public String toFileString() {
        return super.toFileString() + "," + receiptNumber + "," + cashierName;
    }
}
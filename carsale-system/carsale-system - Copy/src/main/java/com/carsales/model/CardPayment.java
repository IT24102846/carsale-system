package com.carsales.model;

import java.util.Date;

public class CardPayment extends PaymentMethod {
    private String cardNumber;
    private String cardholderName;
    private String expiryDate;
    private String cvv;

    // Constructors
    public CardPayment() { super(); }

    public CardPayment(String paymentId, String bookingId, double amount, Date paymentDate,
                       String status, String cardNumber, String cardholderName,
                       String expiryDate, String cvv) {
        super(paymentId, bookingId, amount, paymentDate, status, "CARD");
        this.cardNumber = cardNumber;
        this.cardholderName = cardholderName;
        this.expiryDate = expiryDate;
        this.cvv = cvv;
    }

    // Getters and Setters

    // Implement abstract method
    @Override
    public boolean processPayment() {
        // Card payment processing logic
        return true;
    }

    // File operations
    @Override
    public String toFileString() {
        // Only store last 4 digits of card number for security
        String maskedCard = "XXXX-XXXX-XXXX-" + cardNumber.substring(cardNumber.length() - 4);
        return super.toFileString() + "," + maskedCard + "," + cardholderName + "," + expiryDate;
        // Note: We don't store CVV in the file for security reasons
    }
}
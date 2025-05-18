package com.carsales.model;

import java.util.Date;

public class CarFeedback extends Feedback {
    private String carId;
    private boolean verifiedPurchase;

    // Constructors
    public CarFeedback() { super(); }

    public CarFeedback(String feedbackId, String userId, Date feedbackDate,
                       int rating, String comment, String carId, boolean verifiedPurchase) {
        super(feedbackId, userId, feedbackDate, rating, comment);
        this.carId = carId;
        this.verifiedPurchase = verifiedPurchase;
    }

    // Getters and Setters
    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

    public boolean isVerifiedPurchase() {
        return verifiedPurchase;
    }

    public void setVerifiedPurchase(boolean verifiedPurchase) {
        this.verifiedPurchase = verifiedPurchase;
    }

    // File operations
    @Override
    public String toFileString() {
        return super.toFileString() + "," + carId + "," + verifiedPurchase;
    }

    public static CarFeedback fromFileString(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 7) {
            try {
                return new CarFeedback(
                        parts[0], // feedbackId
                        parts[1], // userId
                        Feedback.DATE_FORMAT.parse(parts[2]), // feedbackDate
                        Integer.parseInt(parts[3]), // rating
                        parts[4], // comment
                        parts[5], // carId
                        Boolean.parseBoolean(parts[6]) // verifiedPurchase
                );
            } catch (Exception e) {
                return null;
            }
        }
        return null;
    }
}
package com.carsales.model;

import java.util.Date;

public class UserFeedback extends Feedback {
    private String targetUserId;
    private String transactionId;

    // Constructors
    public UserFeedback() { super(); }

    public UserFeedback(String feedbackId, String userId, Date feedbackDate,
                        int rating, String comment, String targetUserId, String transactionId) {
        super(feedbackId, userId, feedbackDate, rating, comment);
        this.targetUserId = targetUserId;
        this.transactionId = transactionId;
    }

    // Getters and Setters
    public String getTargetUserId() {
        return targetUserId;
    }

    public void setTargetUserId(String targetUserId) {
        this.targetUserId = targetUserId;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    // File operations
    @Override
    public String toFileString() {
        return super.toFileString() + "," + targetUserId + "," + transactionId;
    }

    public static UserFeedback fromFileString(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 7) {
            try {
                return new UserFeedback(
                        parts[0], // feedbackId
                        parts[1], // userId
                        DATE_FORMAT.parse(parts[2]), // feedbackDate
                        Integer.parseInt(parts[3]), // rating
                        parts[4], // comment
                        parts[5], // targetUserId
                        parts[6]  // transactionId
                );
            } catch (Exception e) {
                return null;
            }
        }
        return null;
    }
}
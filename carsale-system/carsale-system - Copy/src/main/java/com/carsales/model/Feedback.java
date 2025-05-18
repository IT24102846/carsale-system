package com.carsales.model;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.ParseException;

public class Feedback {
    private String feedbackId;
    private String userId;
    private Date feedbackDate;
    private int rating; // 1-5
    private String comment;

    // Make this accessible to child classes
    protected static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    // Constructors
    public Feedback() {}

    public Feedback(String feedbackId, String userId, Date feedbackDate,
                    int rating, String comment) {
        this.feedbackId = feedbackId;
        this.userId = userId;
        this.feedbackDate = feedbackDate;
        this.rating = rating;
        this.comment = comment;
    }

    // Getters and Setters
    public String getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(String feedbackId) {
        this.feedbackId = feedbackId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Date getFeedbackDate() {
        return feedbackDate;
    }

    public void setFeedbackDate(Date feedbackDate) {
        this.feedbackDate = feedbackDate;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    // File operations
    public String toFileString() {
        return feedbackId + "," + userId + "," + DATE_FORMAT.format(feedbackDate) +
                "," + rating + "," + comment;
    }

    public static Feedback fromFileString(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 5) {
            try {
                StringBuilder commentBuilder = new StringBuilder(parts[4]);
                for (int i = 5; i < parts.length; i++) {
                    commentBuilder.append(",").append(parts[i]);
                }

                return new Feedback(
                        parts[0],
                        parts[1],
                        DATE_FORMAT.parse(parts[2]),
                        Integer.parseInt(parts[3]),
                        commentBuilder.toString()
                );
            } catch (ParseException e) {
                System.err.println("Error parsing date: " + e.getMessage());
                return null;
            }
        }
        return null;
    }
}
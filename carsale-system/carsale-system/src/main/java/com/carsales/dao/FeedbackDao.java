package com.carsales.dao;

import com.carsales.model.Feedback;
import com.carsales.model.CarFeedback;
import com.carsales.model.UserFeedback;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDao extends FileDao<Feedback> {

    public FeedbackDao() {
        super("src/main/resources/data/feedback.txt");
    }

    @Override
    public Feedback findById(String id) {
        List<String> lines = readAllLines();
        for (String line : lines) {
            Feedback feedback = Feedback.fromFileString(line);
            if (feedback != null && feedback.getFeedbackId().equals(id)) {
                return feedback;
            }
        }
        return null;
    }

    @Override
    public List<Feedback> findAll() {
        List<String> lines = readAllLines();
        List<Feedback> feedbacks = new ArrayList<>();

        for (String line : lines) {
            Feedback feedback = Feedback.fromFileString(line);
            if (feedback != null) {
                feedbacks.add(feedback);
            }
        }
        return feedbacks;
    }

    public List<Feedback> findByUserId(String userId) {
        List<String> lines = readAllLines();
        List<Feedback> feedbacks = new ArrayList<>();

        for (String line : lines) {
            Feedback feedback = Feedback.fromFileString(line);
            if (feedback != null && feedback.getUserId().equals(userId)) {
                feedbacks.add(feedback);
            }
        }
        return feedbacks;
    }

    @Override
    public boolean save(Feedback feedback) {
        // Check if feedback already exists
        if (findById(feedback.getFeedbackId()) != null) {
            return false; // Feedback already exists
        }

        List<String> lines = readAllLines();
        lines.add(feedback.toFileString());
        writeAllLines(lines);
        return true;
    }

    @Override
    public boolean update(Feedback feedback) {
        List<String> lines = readAllLines();
        boolean updated = false;

        for (int i = 0; i < lines.size(); i++) {
            Feedback existingFeedback = Feedback.fromFileString(lines.get(i));
            if (existingFeedback != null && existingFeedback.getFeedbackId().equals(feedback.getFeedbackId())) {
                lines.set(i, feedback.toFileString());
                updated = true;
                break;
            }
        }

        if (updated) {
            writeAllLines(lines);
        }
        return updated;
    }

    @Override
    public boolean deleteById(String id) {
        List<String> lines = readAllLines();
        boolean deleted = false;

        for (int i = 0; i < lines.size(); i++) {
            Feedback existingFeedback = Feedback.fromFileString(lines.get(i));
            if (existingFeedback != null && existingFeedback.getFeedbackId().equals(id)) {
                lines.remove(i);
                deleted = true;
                break;
            }
        }

        if (deleted) {
            writeAllLines(lines);
        }
        return deleted;
    }
}
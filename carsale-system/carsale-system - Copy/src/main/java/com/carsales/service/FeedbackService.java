package com.carsales.service;

import com.carsales.dao.FeedbackDao;
import com.carsales.model.CarFeedback;
import com.carsales.model.Feedback;
import com.carsales.model.UserFeedback;
import com.carsales.util.IdGenerator;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class FeedbackService {
    private final FeedbackDao feedbackDao;

    public FeedbackService() {
        this.feedbackDao = new FeedbackDao();
    }

    public Feedback findById(String id) {
        return feedbackDao.findById(id);
    }

    public List<Feedback> findAll() {
        return feedbackDao.findAll();
    }

    public List<Feedback> findByUserId(String userId) {
        return feedbackDao.findByUserId(userId);
    }

    public List<CarFeedback> findByCarId(String carId) {
        return feedbackDao.findAll().stream()
                .filter(f -> f instanceof CarFeedback && ((CarFeedback) f).getCarId().equals(carId))
                .map(f -> (CarFeedback) f)
                .collect(Collectors.toList());
    }

    public List<UserFeedback> findByTargetUserId(String targetUserId) {
        return feedbackDao.findAll().stream()
                .filter(f -> f instanceof UserFeedback && ((UserFeedback) f).getTargetUserId().equals(targetUserId))
                .map(f -> (UserFeedback) f)
                .collect(Collectors.toList());
    }

    public boolean addCarFeedback(String userId, String carId, int rating, String comment, boolean verifiedPurchase) {
        String feedbackId = IdGenerator.generateId();
        Date feedbackDate = new Date(); // Current date

        CarFeedback feedback = new CarFeedback(
                feedbackId, userId, feedbackDate, rating, comment, carId, verifiedPurchase
        );

        return feedbackDao.save(feedback);
    }

    public boolean addUserFeedback(String userId, String targetUserId, String transactionId, int rating, String comment) {
        String feedbackId = IdGenerator.generateId();
        Date feedbackDate = new Date(); // Current date

        UserFeedback feedback = new UserFeedback(
                feedbackId, userId, feedbackDate, rating, comment, targetUserId, transactionId
        );

        return feedbackDao.save(feedback);
    }

    public boolean updateFeedback(Feedback feedback) {
        return feedbackDao.update(feedback);
    }

    public boolean deleteFeedback(String id) {
        return feedbackDao.deleteById(id);
    }
}
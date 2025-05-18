package com.carsales.service;

import com.carsales.dao.UserDao;
import com.carsales.model.*;
import com.carsales.util.IdGenerator;

import java.util.List;

public class UserService {
    private final UserDao userDao;

    public UserService() {
        this.userDao = new UserDao();
    }

    public User findById(String id) {
        return userDao.findById(id);
    }

    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    public List<User> findAll() {
        return userDao.findAll();
    }

    public boolean registerUser(String username, String password, String email, String phoneNumber,
                                String role, Object... additionalData) {
        // Check if username already exists
        if (userDao.findByUsername(username) != null) {
            return false;
        }

        String userId = IdGenerator.generateId();
        User user;

        switch (role) {
            case "BUYER":
                String address = (String) additionalData[0];
                String paymentMethod = (String) additionalData[1];
                user = new BuyerUser(userId, username, password, email, phoneNumber, address, paymentMethod);
                break;
            case "SELLER":
                String sellerAddress = (String) additionalData[0];
                String bankAccount = (String) additionalData[1];
                user = new SellerUser(userId, username, password, email, phoneNumber, sellerAddress, bankAccount);
                break;
            case "DEALER":
                String dealershipName = (String) additionalData[0];
                String dealershipAddress = (String) additionalData[1];
                String businessLicense = (String) additionalData[2];
                user = new DealerUser(userId, username, password, email, phoneNumber, dealershipName,
                        dealershipAddress, businessLicense);
                break;
            default:
                user = new User(userId, username, password, email, phoneNumber, role);
        }

        return userDao.save(user);
    }

    public boolean updateUser(User user) {
        return userDao.update(user);
    }

    public boolean deleteUser(String id) {
        return userDao.deleteById(id);
    }

    public boolean validateLogin(String username, String password) {
        User user = userDao.findByUsername(username);
        return user != null && user.getPassword().equals(password);
    }
}
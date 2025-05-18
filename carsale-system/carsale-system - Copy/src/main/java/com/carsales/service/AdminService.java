package com.carsales.service;

import com.carsales.dao.BookingDao;
import com.carsales.dao.CarDao;
import com.carsales.dao.UserDao;
import com.carsales.model.AdminUser;
import com.carsales.model.Booking;
import com.carsales.model.Car;
import com.carsales.model.User;
import com.carsales.util.IdGenerator;

import java.util.List;
import java.util.stream.Collectors;

public class AdminService {
    private final UserDao userDao;
    private final CarDao carDao;
    private final BookingDao bookingDao;

    public AdminService() {
        this.userDao = new UserDao();
        this.carDao = new CarDao();
        this.bookingDao = new BookingDao();
    }

    public boolean createAdmin(String username, String password, String email,
                               String phoneNumber, String adminLevel, String department) {
        // Check if username already exists
        if (userDao.findByUsername(username) != null) {
            return false;
        }

        String userId = IdGenerator.generateId();
        AdminUser admin = new AdminUser(userId, username, password, email, phoneNumber, adminLevel, department);

        return userDao.save(admin);
    }

    public List<User> getAllAdmins() {
        return userDao.findAll().stream()
                .filter(user -> "ADMIN".equals(user.getRole()))
                .collect(Collectors.toList());
    }

    public boolean resetUserPassword(String userId, String newPassword) {
        User user = userDao.findById(userId);
        if (user == null) {
            return false;
        }

        user.setPassword(newPassword);
        return userDao.update(user);
    }

    public List<Booking> getAllBookings() {
        return bookingDao.findAll();
    }

    public List<Car> getAllCars() {
        return carDao.findAll();
    }

    public List<User> getAllUsers() {
        return userDao.findAll();
    }

    public List<User> getUsersByRole(String role) {
        return userDao.findAll().stream()
                .filter(user -> role.equals(user.getRole()))
                .collect(Collectors.toList());
    }

    public boolean deleteUser(String userId) {
        return userDao.deleteById(userId);
    }

    public boolean deleteCar(String carId) {
        return carDao.deleteById(carId);
    }

    public boolean deleteBooking(String bookingId) {
        Booking booking = bookingDao.findById(bookingId);
        if (booking == null) {
            return false;
        }

        // Make car available again
        Car car = carDao.findById(booking.getCarId());
        if (car != null) {
            car.setAvailable(true);
            carDao.update(car);
        }

        return bookingDao.deleteById(bookingId);
    }

    public String generateSystemReport() {
        int totalUsers = userDao.findAll().size();
        int totalCars = carDao.findAll().size();
        int totalBookings = bookingDao.findAll().size();

        int availableCars = (int) carDao.findAll().stream()
                .filter(Car::isAvailable)
                .count();

        int pendingBookings = (int) bookingDao.findAll().stream()
                .filter(b -> "PENDING".equals(b.getStatus()))
                .count();

        return "System Report\n" +
                "-------------\n" +
                "Total Users: " + totalUsers + "\n" +
                "Total Cars: " + totalCars + "\n" +
                "Available Cars: " + availableCars + "\n" +
                "Total Bookings: " + totalBookings + "\n" +
                "Pending Bookings: " + pendingBookings + "\n";
    }
}
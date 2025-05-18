package com.carsales.service;

import com.carsales.dao.BookingDao;
import com.carsales.dao.CarDao;
import com.carsales.model.Booking;
import com.carsales.model.Car;
import com.carsales.util.IdGenerator;

import java.util.Date;
import java.util.List;

public class BookingService {
    private final BookingDao bookingDao;
    private final CarDao carDao;

    public BookingService() {
        this.bookingDao = new BookingDao();
        this.carDao = new CarDao();
    }

    public Booking findById(String id) {
        return bookingDao.findById(id);
    }

    public List<Booking> findAll() {
        return bookingDao.findAll();
    }

    public List<Booking> findByBuyerId(String buyerId) {
        return bookingDao.findByBuyerId(buyerId);
    }

    public List<Booking> findBySellerId(String sellerId) {
        return bookingDao.findBySellerId(sellerId);
    }

    public boolean createBooking(String carId, String buyerId, String sellerId,
                                 Date bookingDate, Date expectedDeliveryDate,
                                 String status, double amount, String paymentMethod, String notes) {
        // Check if car exists and is available
        Car car = carDao.findById(carId);
        if (car == null || !car.isAvailable()) {
            return false;
        }

        String bookingId = IdGenerator.generateId();

        Booking booking = new Booking(
                bookingId, carId, buyerId, sellerId,
                bookingDate, expectedDeliveryDate, status,
                amount, paymentMethod, notes
        );

        // Mark car as unavailable
        car.setAvailable(false);
        carDao.update(car);

        return bookingDao.save(booking);
    }

    // Original method preserved for backward compatibility
    public boolean createBooking(String carId, String buyerId, Date expectedDeliveryDate,
                                 double amount, String paymentMethod, String notes) {
        // Check if car exists and is available
        Car car = carDao.findById(carId);
        if (car == null || !car.isAvailable()) {
            return false;
        }

        String bookingId = IdGenerator.generateId();
        Date bookingDate = new Date(); // Current date

        Booking booking = new Booking(
                bookingId, carId, buyerId, car.getSellerId(),
                bookingDate, expectedDeliveryDate, "PENDING",
                amount, paymentMethod, notes
        );

        // Mark car as unavailable
        car.setAvailable(false);
        carDao.update(car);

        return bookingDao.save(booking);
    }

    public boolean updateBookingStatus(String bookingId, String status) {
        Booking booking = bookingDao.findById(bookingId);
        if (booking == null) {
            return false;
        }

        booking.setStatus(status);

        // If booking is cancelled, make the car available again
        if ("CANCELLED".equals(status)) {
            Car car = carDao.findById(booking.getCarId());
            if (car != null) {
                car.setAvailable(true);
                carDao.update(car);
            }
        }

        return bookingDao.update(booking);
    }

    public boolean deleteBooking(String id) {
        Booking booking = bookingDao.findById(id);
        if (booking == null) {
            return false;
        }

        // Make car available again if booking is deleted
        Car car = carDao.findById(booking.getCarId());
        if (car != null) {
            car.setAvailable(true);
            carDao.update(car);
        }

        return bookingDao.deleteById(id);
    }
}
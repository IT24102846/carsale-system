package com.carsales.dao;

import com.carsales.model.Booking;
import java.util.ArrayList;
import java.util.List;

public class BookingDao extends FileDao<Booking> {

    public BookingDao() {
        super("src/main/resources/data/bookings.txt");
    }

    @Override
    public Booking findById(String id) {
        List<String> lines = readAllLines();
        for (String line : lines) {
            Booking booking = Booking.fromFileString(line);
            if (booking != null && booking.getBookingId().equals(id)) {
                return booking;
            }
        }
        return null;
    }

    @Override
    public List<Booking> findAll() {
        List<String> lines = readAllLines();
        List<Booking> bookings = new ArrayList<>();

        for (String line : lines) {
            Booking booking = Booking.fromFileString(line);
            if (booking != null) {
                bookings.add(booking);
            }
        }
        return bookings;
    }

    public List<Booking> findByBuyerId(String buyerId) {
        List<String> lines = readAllLines();
        List<Booking> bookings = new ArrayList<>();

        for (String line : lines) {
            Booking booking = Booking.fromFileString(line);
            if (booking != null && booking.getBuyerId().equals(buyerId)) {
                bookings.add(booking);
            }
        }
        return bookings;
    }

    public List<Booking> findBySellerId(String sellerId) {
        List<String> lines = readAllLines();
        List<Booking> bookings = new ArrayList<>();

        for (String line : lines) {
            Booking booking = Booking.fromFileString(line);
            if (booking != null && booking.getSellerId().equals(sellerId)) {
                bookings.add(booking);
            }
        }
        return bookings;
    }

    public List<Booking> findByCarId(String carId) {
        List<String> lines = readAllLines();
        List<Booking> bookings = new ArrayList<>();

        for (String line : lines) {
            Booking booking = Booking.fromFileString(line);
            if (booking != null && booking.getCarId().equals(carId)) {
                bookings.add(booking);
            }
        }
        return bookings;
    }

    @Override
    public boolean save(Booking booking) {
        // Check if booking already exists
        if (findById(booking.getBookingId()) != null) {
            return false; // Booking already exists
        }

        List<String> lines = readAllLines();
        lines.add(booking.toFileString());
        writeAllLines(lines);
        return true;
    }

    @Override
    public boolean update(Booking booking) {
        List<String> lines = readAllLines();
        boolean updated = false;

        for (int i = 0; i < lines.size(); i++) {
            Booking existingBooking = Booking.fromFileString(lines.get(i));
            if (existingBooking != null && existingBooking.getBookingId().equals(booking.getBookingId())) {
                lines.set(i, booking.toFileString());
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
            Booking existingBooking = Booking.fromFileString(lines.get(i));
            if (existingBooking != null && existingBooking.getBookingId().equals(id)) {
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
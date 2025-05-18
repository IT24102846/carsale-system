package com.carsales.controller;

import com.carsales.model.Booking;
import com.carsales.model.Car;
import com.carsales.service.BookingService;
import com.carsales.service.CarService;
import com.carsales.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/bookings")
public class BookingController {

    private final BookingService bookingService;
    private final CarService carService;
    private final UserService userService;
    private final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    public BookingController() {
        this.bookingService = new BookingService();
        this.carService = new CarService();
        this.userService = new UserService();
    }

    @GetMapping("")
    public String displayBookings(Model model, HttpSession session) {
        // Check if user is authenticated
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        List<Booking> bookingList = bookingService.findAll();
        model.addAttribute("bookingList", bookingList);
        return "Booking/display";
    }

    @GetMapping("/create")
    public String showCreateForm(
            @RequestParam(required = false) String carId,
            @RequestParam(required = false) String userId,
            Model model,
            HttpSession session) {
        // Check if user is authenticated
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        // If carId is provided, fetch car details
        if (carId != null && !carId.isEmpty()) {
            Car car = carService.findById(carId);
            if (car != null) {
                model.addAttribute("car", car);
                model.addAttribute("carId", carId);
            }
        }

        // If userId is not provided, use the logged-in user's ID
        if (userId == null || userId.isEmpty()) {
            userId = (String) session.getAttribute("userId");
        }

        model.addAttribute("userId", userId);
        model.addAttribute("today", dateFormat.format(new Date()));

        return "Booking/create";
    }

    @PostMapping("/save")
    public String createBooking(@RequestParam String carId,
                                @RequestParam String userId,
                                @RequestParam String bookingDate,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {

        // Check if user is authenticated
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        try {
            Date parsedDate = dateFormat.parse(bookingDate);
            Date expectedDelivery = new Date(parsedDate.getTime() + (7 * 24 * 60 * 60 * 1000)); // 7 days later

            // Get car for seller info
            Car car = carService.findById(carId);
            if (car == null) {
                redirectAttributes.addFlashAttribute("error", "Car not found");
                return "redirect:/cars";
            }

            boolean created = bookingService.createBooking(
                    carId,
                    userId,
                    car.getSellerId(), // Set the seller ID from the car
                    parsedDate,
                    expectedDelivery,
                    "PENDING",
                    car.getPrice(), // Set the amount to the car price
                    "Not specified",
                    "Booking created on " + new Date()
            );

            if (created) {
                // Mark car as unavailable
                car.setAvailable(false);
                carService.updateCar(car);

                redirectAttributes.addFlashAttribute("message", "Booking created successfully");
                return "redirect:/bookings";
            } else {
                redirectAttributes.addFlashAttribute("error", "Error creating booking");
            }

        } catch (ParseException e) {
            redirectAttributes.addFlashAttribute("error", "Invalid date format");
        }

        return "redirect:/bookings";
    }

    @GetMapping("/edit")
    public String showEditForm(@RequestParam String id, Model model, HttpSession session) {
        // Check if user is authenticated
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        Booking booking = bookingService.findById(id);
        if (booking == null) {
            return "redirect:/bookings";
        }

        model.addAttribute("booking", booking);
        // Also add car details
        Car car = carService.findById(booking.getCarId());
        if (car != null) {
            model.addAttribute("car", car);
        }

        return "Booking/edit";
    }

    @PostMapping("/update")
    public String updateBooking(@RequestParam String id,
                                @RequestParam String carId,
                                @RequestParam String userId,
                                @RequestParam String bookingDate,
                                @RequestParam String status,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {

        // Check if user is authenticated
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        Booking booking = bookingService.findById(id);
        if (booking == null) {
            redirectAttributes.addFlashAttribute("error", "Booking not found");
            return "redirect:/bookings";
        }

        try {
            booking.setCarId(carId);
            booking.setBuyerId(userId);
            booking.setBookingDate(dateFormat.parse(bookingDate));
            booking.setStatus(status);

            boolean updated = bookingService.updateBookingStatus(id, status);

            if (updated) {
                // If status is CANCELLED, make car available again
                if ("CANCELLED".equals(status)) {
                    Car car = carService.findById(carId);
                    if (car != null) {
                        car.setAvailable(true);
                        carService.updateCar(car);
                    }
                }

                redirectAttributes.addFlashAttribute("message", "Booking updated successfully");
            } else {
                redirectAttributes.addFlashAttribute("error", "Error updating booking");
            }

        } catch (ParseException e) {
            redirectAttributes.addFlashAttribute("error", "Invalid date format");
        }

        return "redirect:/bookings";
    }

    @GetMapping("/delete")
    public String deleteBooking(@RequestParam String id,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {

        // Check if user is authenticated
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        Booking booking = bookingService.findById(id);
        String carId = null;
        if (booking != null) {
            carId = booking.getCarId();
        }

        boolean deleted = bookingService.deleteBooking(id);

        if (deleted) {
            // Make car available again
            if (carId != null) {
                Car car = carService.findById(carId);
                if (car != null) {
                    car.setAvailable(true);
                    carService.updateCar(car);
                }
            }

            redirectAttributes.addFlashAttribute("message", "Booking deleted successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Error deleting booking");
        }

        return "redirect:/bookings";
    }
}

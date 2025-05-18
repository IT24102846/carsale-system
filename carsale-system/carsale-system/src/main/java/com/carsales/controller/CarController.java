package com.carsales.controller;

import com.carsales.model.Car;
import com.carsales.model.DealerCar;
import com.carsales.model.UsedCar;
import com.carsales.service.CarService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
public class CarController {

    private final CarService carService;

    public CarController() {
        this.carService = new CarService();
    }

    @GetMapping("/cars")
    public String displayCars(Model model,
                              @RequestParam(required = false) String brand,
                              @RequestParam(required = false) String minPrice,
                              @RequestParam(required = false) String maxPrice,
                              @RequestParam(required = false) String sortBy) {

        List<Car> cars;

        // Apply filters
        if (brand != null && !brand.isEmpty()) {
            cars = carService.findByBrand(brand);
        } else if (minPrice != null && !minPrice.isEmpty() &&
                maxPrice != null && !maxPrice.isEmpty()) {
            try {
                double min = Double.parseDouble(minPrice);
                double max = Double.parseDouble(maxPrice);
                cars = carService.findByPriceRange(min, max);
            } catch (NumberFormatException e) {
                cars = carService.findAll();
            }
        } else {
            cars = carService.findAll();
        }

        // Filter only available cars
        cars.removeIf(car -> !car.isAvailable());

        // Sort if needed
        if ("price".equals(sortBy)) {
            Car[] sortedCars = carService.getAvailableCarsSortedByPrice();
            model.addAttribute("cars", sortedCars);
        } else {
            model.addAttribute("cars", cars);
        }

        return "Cars/display";
    }

    @GetMapping("/car")
    public String showCarDetail(@RequestParam String id, Model model) {
        Car car = carService.findById(id);
        if (car == null) {
            return "redirect:/cars";
        }
        model.addAttribute("car", car);
        return "Car/detail";
    }

    @GetMapping("/cars/create")
    public String showCreateForm(HttpSession session) {
        // Check if user is authenticated and is a seller or dealer
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        String role = (String) session.getAttribute("role");
        if (!"SELLER".equals(role) && !"DEALER".equals(role) && !"ADMIN".equals(role)) {
            return "redirect:/cars";
        }

        return "Cars/create";
    }

    @PostMapping("/cars/create")
    public String createCar(@RequestParam String make,
                            @RequestParam String model,
                            @RequestParam int year,
                            @RequestParam double price,
                            @RequestParam String transmission,
                            @RequestParam String fuelType,
                            @RequestParam String color,
                            @RequestParam double mileage,
                            @RequestParam String description,
                            @RequestParam String imageUrl,
                            @RequestParam(required = false) String carType,
                            @RequestParam(required = false) String history,
                            @RequestParam(required = false, defaultValue = "1") int previousOwners,
                            @RequestParam(required = false, defaultValue = "false") boolean hasAccidentHistory,
                            @RequestParam(required = false) String dealershipId,
                            @RequestParam(required = false, defaultValue = "false") boolean hasWarranty,
                            @RequestParam(required = false, defaultValue = "0") int warrantyMonths,
                            @RequestParam(required = false, defaultValue = "false") boolean isFinancingAvailable,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {

        // Check if user is authenticated and is a seller or dealer
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        String sellerId = (String) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");

        if (!"SELLER".equals(role) && !"DEALER".equals(role) && !"ADMIN".equals(role)) {
            return "redirect:/cars";
        }

        boolean success;
        String condition = mileage > 0 ? "USED" : "NEW";

        // Create appropriate car type
        if ("used".equals(carType)) {
            success = carService.addCar(
                    make, model, year, price, condition, color, mileage,
                    sellerId, imageUrl, description, "used",
                    history, previousOwners, hasAccidentHistory
            );
        } else if ("dealer".equals(carType) && "DEALER".equals(role)) {
            success = carService.addCar(
                    make, model, year, price, condition, color, mileage,
                    sellerId, imageUrl, description, "dealer",
                    dealershipId, hasWarranty, warrantyMonths, isFinancingAvailable
            );
        } else {
            success = carService.addCar(
                    make, model, year, price, condition, color, mileage,
                    sellerId, imageUrl, description, "standard"
            );
        }

        if (success) {
            redirectAttributes.addFlashAttribute("message", "Car created successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Error creating car");
        }

        return "redirect:/cars";
    }

    @GetMapping("/cars/edit")
    public String showEditForm(@RequestParam String id, Model model, HttpSession session) {
        // Check if user is authenticated
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        Car car = carService.findById(id);
        if (car == null) {
            return "redirect:/cars";
        }

        String userId = (String) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");

        // Check if user is the owner of the car or an admin
        if (!car.getSellerId().equals(userId) && !"ADMIN".equals(role)) {
            return "redirect:/cars";
        }

        model.addAttribute("car", car);
        return "Car/edit";
    }

    @PostMapping("/cars/update")
    public String updateCar(@RequestParam String id,
                            @RequestParam String make,
                            @RequestParam String model,
                            @RequestParam int year,
                            @RequestParam double price,
                            @RequestParam String transmission,
                            @RequestParam String fuelType,
                            @RequestParam String color,
                            @RequestParam double mileage,
                            @RequestParam String description,
                            @RequestParam(required = false) String imageUrl,
                            @RequestParam(required = false) String history,
                            @RequestParam(required = false) String previousOwnersStr,
                            @RequestParam(required = false) String hasAccidentHistoryStr,
                            @RequestParam(required = false) String hasWarrantyStr,
                            @RequestParam(required = false) String warrantyMonthsStr,
                            @RequestParam(required = false) String isFinancingAvailableStr,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {

        // Check if user is authenticated
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        Car car = carService.findById(id);
        if (car == null) {
            return "redirect:/cars";
        }

        String userId = (String) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");

        // Check if user is the owner of the car or an admin
        if (!car.getSellerId().equals(userId) && !"ADMIN".equals(role)) {
            return "redirect:/cars";
        }

        // Update car fields
        car.setBrand(make);
        car.setModel(model);
        car.setYear(year);
        car.setPrice(price);
        car.setColor(color);
        car.setMileage(mileage);
        car.setDescription(description);

        // Update image URL if provided
        if (imageUrl != null && !imageUrl.trim().isEmpty()) {
            car.setImageUrl(imageUrl);
        }

        // Update specific car type fields if needed
        if (car instanceof UsedCar) {
            // Additional fields for used car
            if (history != null && !history.trim().isEmpty()) {
                ((UsedCar) car).setHistory(history);
            }

            if (previousOwnersStr != null && !previousOwnersStr.trim().isEmpty()) {
                try {
                    ((UsedCar) car).setPreviousOwners(Integer.parseInt(previousOwnersStr));
                } catch (NumberFormatException e) {
                    // Ignore invalid input
                }
            }

            if (hasAccidentHistoryStr != null) {
                ((UsedCar) car).setHasAccidentHistory("on".equals(hasAccidentHistoryStr));
            }
        } else if (car instanceof DealerCar) {
            // Additional fields for dealer car
            if (hasWarrantyStr != null) {
                ((DealerCar) car).setHasWarranty("on".equals(hasWarrantyStr));
            }

            if (warrantyMonthsStr != null && !warrantyMonthsStr.trim().isEmpty()) {
                try {
                    ((DealerCar) car).setWarrantyMonths(Integer.parseInt(warrantyMonthsStr));
                } catch (NumberFormatException e) {
                    // Ignore invalid input
                }
            }

            if (isFinancingAvailableStr != null) {
                ((DealerCar) car).setFinancingAvailable("on".equals(isFinancingAvailableStr));
            }
        }

        boolean updated = carService.updateCar(car);

        if (updated) {
            redirectAttributes.addFlashAttribute("message", "Car updated successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Error updating car");
        }

        return "redirect:/cars";
    }

    @GetMapping("/cars/delete")
    public String deleteCar(@RequestParam String id,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {

        // Check if user is authenticated
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        Car car = carService.findById(id);
        if (car == null) {
            return "redirect:/cars";
        }

        String userId = (String) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");

        // Check if user is the owner of the car or an admin
        if (!car.getSellerId().equals(userId) && !"ADMIN".equals(role)) {
            return "redirect:/cars";
        }

        boolean deleted = carService.deleteCar(id);

        if (deleted) {
            redirectAttributes.addFlashAttribute("message", "Car deleted successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Error deleting car");
        }

        return "redirect:/cars";
    }
}
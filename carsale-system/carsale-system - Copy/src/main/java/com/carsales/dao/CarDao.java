package com.carsales.dao;

import com.carsales.model.*;
import java.util.ArrayList;
import java.util.List;

public class CarDao extends FileDao<Car> {

    public CarDao() {
        super("src/main/resources/data/cars.txt");
    }

    @Override
    public Car findById(String id) {
        List<String> lines = readAllLines();
        for (String line : lines) {
            Car car = parseCarFromLine(line);
            if (car != null && car.getCarId().equals(id)) {
                return car;
            }
        }
        return null;
    }

    @Override
    public List<Car> findAll() {
        List<String> lines = readAllLines();
        List<Car> cars = new ArrayList<>();

        System.out.println("Read " + lines.size() + " lines from cars file");

        for (String line : lines) {
            Car car = parseCarFromLine(line);
            if (car != null) {
                cars.add(car);
            }
        }

        System.out.println("Found " + cars.size() + " valid cars");
        return cars;
    }

    public List<Car> findBySellerId(String sellerId) {
        List<String> lines = readAllLines();
        List<Car> cars = new ArrayList<>();

        for (String line : lines) {
            Car car = parseCarFromLine(line);
            if (car != null && car.getSellerId().equals(sellerId)) {
                cars.add(car);
            }
        }
        return cars;
    }

    public List<Car> findByBrand(String brand) {
        List<String> lines = readAllLines();
        List<Car> cars = new ArrayList<>();

        for (String line : lines) {
            Car car = parseCarFromLine(line);
            if (car != null && car.getBrand().equalsIgnoreCase(brand)) {
                cars.add(car);
            }
        }
        return cars;
    }

    public List<Car> findByPriceRange(double minPrice, double maxPrice) {
        List<String> lines = readAllLines();
        List<Car> cars = new ArrayList<>();

        for (String line : lines) {
            Car car = parseCarFromLine(line);
            if (car != null && car.getPrice() >= minPrice && car.getPrice() <= maxPrice) {
                cars.add(car);
            }
        }
        return cars;
    }

    @Override
    public boolean save(Car car) {
        // Check if car already exists
        if (findById(car.getCarId()) != null) {
            return false; // Car already exists
        }

        List<String> lines = readAllLines();
        lines.add(car.toFileString());
        writeAllLines(lines);
        return true;
    }

    @Override
    public boolean update(Car car) {
        List<String> lines = readAllLines();
        boolean updated = false;

        for (int i = 0; i < lines.size(); i++) {
            Car existingCar = parseCarFromLine(lines.get(i));
            if (existingCar != null && existingCar.getCarId().equals(car.getCarId())) {
                lines.set(i, car.toFileString());
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
            Car existingCar = parseCarFromLine(lines.get(i));
            if (existingCar != null && existingCar.getCarId().equals(id)) {
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

    private Car parseCarFromLine(String line) {
        try {
            if (line.contains("USED") && line.split(",").length >= 15) {
                return UsedCar.fromFileString(line);
            } else if (line.contains("USED") && line.split(",").length >= 12) {
                // Handle USED cars with missing fields by adding default values
                String updatedLine = line + ",No history,1,false";
                return UsedCar.fromFileString(updatedLine);
            } else if (line.contains("DEALER") && line.split(",").length >= 16) {
                return DealerCar.fromFileString(line);
            } else if (line.split(",").length >= 12) {
                return Car.fromFileString(line);
            } else {
                System.out.println("Warning: Failed to parse car from line: " + line);
                return null;
            }
        } catch (Exception e) {
            System.err.println("Error parsing car: " + e.getMessage() + " - Line: " + line);
            return null;
        }
    }
}
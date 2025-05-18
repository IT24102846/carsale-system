package com.carsales.service;

import com.carsales.dao.CarDao;
import com.carsales.model.Car;
import com.carsales.model.DealerCar;
import com.carsales.model.UsedCar;
import com.carsales.util.IdGenerator;
import com.carsales.util.LinkedList;
import com.carsales.util.MergeSort;

import java.util.List;

public class CarService {
    private final CarDao carDao;

    public CarService() {
        this.carDao = new CarDao();
    }

    public Car findById(String id) {
        return carDao.findById(id);
    }

    public List<Car> findAll() {
        return carDao.findAll();
    }

    public List<Car> findByBrand(String brand) {
        return carDao.findByBrand(brand);
    }

    public List<Car> findByPriceRange(double minPrice, double maxPrice) {
        return carDao.findByPriceRange(minPrice, maxPrice);
    }

    public List<Car> findBySellerId(String sellerId) {
        return carDao.findBySellerId(sellerId);
    }

    public Car[] getAvailableCarsSortedByPrice() {
        List<Car> cars = carDao.findAll();
        LinkedList carList = new LinkedList();

        for (Car car : cars) {
            if (car.isAvailable()) {
                carList.add(car);
            }
        }

        Car[] carsArray = carList.toArray();
        return MergeSort.sortByPrice(carsArray);
    }

    public boolean addCar(String brand, String model, int year, double price, String condition,
                          String color, double mileage, String sellerId, String imageUrl,
                          String description, String carType, Object... additionalData) {
        String carId = IdGenerator.generateId();
        Car car;

        if ("used".equals(carType)) {
            String history = (String) additionalData[0];
            int previousOwners = (int) additionalData[1];
            boolean hasAccidentHistory = (boolean) additionalData[2];

            car = new UsedCar(carId, brand, model, year, price, condition, color, mileage,
                    sellerId, true, imageUrl, description, history,
                    previousOwners, hasAccidentHistory);
        } else if ("dealer".equals(carType)) {
            String dealershipId = (String) additionalData[0];
            boolean hasWarranty = (boolean) additionalData[1];
            int warrantyMonths = (int) additionalData[2];
            boolean isFinancingAvailable = (boolean) additionalData[3];

            car = new DealerCar(carId, brand, model, year, price, condition, color, mileage,
                    sellerId, true, imageUrl, description, dealershipId,
                    hasWarranty, warrantyMonths, isFinancingAvailable);
        } else {
            car = new Car(carId, brand, model, year, price, condition, color, mileage,
                    sellerId, true, imageUrl, description);
        }

        return carDao.save(car);
    }

    public boolean updateCar(Car car) {
        return carDao.update(car);
    }

    public boolean deleteCar(String id) {
        return carDao.deleteById(id);
    }
}
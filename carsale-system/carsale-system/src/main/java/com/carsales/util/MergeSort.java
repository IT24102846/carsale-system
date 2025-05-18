package com.carsales.util;

import com.carsales.model.Car;

public class MergeSort {

    // Sort cars by price (ascending)
    public static Car[] sortByPrice(Car[] cars) {
        if (cars == null || cars.length <= 1) {
            return cars;
        }

        mergeSort(cars, 0, cars.length - 1);
        return cars;
    }

    private static void mergeSort(Car[] cars, int left, int right) {
        if (left < right) {
            int mid = left + (right - left) / 2;

            // Sort first and second halves
            mergeSort(cars, left, mid);
            mergeSort(cars, mid + 1, right);

            // Merge the sorted halves
            merge(cars, left, mid, right);
        }
    }

    private static void merge(Car[] cars, int left, int mid, int right) {
        // Find sizes of two subarrays to be merged
        int n1 = mid - left + 1;
        int n2 = right - mid;

        // Create temp arrays
        Car[] leftArray = new Car[n1];
        Car[] rightArray = new Car[n2];

        // Copy data to temp arrays
        for (int i = 0; i < n1; ++i) {
            leftArray[i] = cars[left + i];
        }
        for (int j = 0; j < n2; ++j) {
            rightArray[j] = cars[mid + 1 + j];
        }

        // Merge the temp arrays
        int i = 0, j = 0;
        int k = left;
        while (i < n1 && j < n2) {
            if (leftArray[i].getPrice() <= rightArray[j].getPrice()) {
                cars[k] = leftArray[i];
                i++;
            } else {
                cars[k] = rightArray[j];
                j++;
            }
            k++;
        }

        // Copy remaining elements of leftArray[] if any
        while (i < n1) {
            cars[k] = leftArray[i];
            i++;
            k++;
        }

        // Copy remaining elements of rightArray[] if any
        while (j < n2) {
            cars[k] = rightArray[j];
            j++;
            k++;
        }
    }
}
package com.carsales.util;

import com.carsales.model.Car;

public class LinkedList {
    private Node head;
    private int size;

    // Node inner class
    private class Node {
        Car car;
        Node next;

        Node(Car car) {
            this.car = car;
            this.next = null;
        }
    }

    // Constructor
    public LinkedList() {
        head = null;
        size = 0;
    }

    // Add car to the linked list
    public void add(Car car) {
        Node newNode = new Node(car);

        if (head == null) {
            head = newNode;
        } else {
            Node current = head;
            while (current.next != null) {
                current = current.next;
            }
            current.next = newNode;
        }
        size++;
    }

    // Get car at index
    public Car get(int index) {
        if (index < 0 || index >= size) {
            throw new IndexOutOfBoundsException("Index: " + index + ", Size: " + size);
        }

        Node current = head;
        for (int i = 0; i < index; i++) {
            current = current.next;
        }

        return current.car;
    }

    // Remove car at index
    public void remove(int index) {
        if (index < 0 || index >= size) {
            throw new IndexOutOfBoundsException("Index: " + index + ", Size: " + size);
        }

        if (index == 0) {
            head = head.next;
        } else {
            Node current = head;
            for (int i = 0; i < index - 1; i++) {
                current = current.next;
            }
            current.next = current.next.next;
        }
        size--;
    }

    // Get size of linked list
    public int size() {
        return size;
    }

    // Convert linked list to array
    public Car[] toArray() {
        Car[] array = new Car[size];
        Node current = head;
        for (int i = 0; i < size; i++) {
            array[i] = current.car;
            current = current.next;
        }
        return array;
    }
}
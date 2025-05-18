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

package com.carsales.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home() {
        // Redirect to the cars listing page as the main entry point
        return "index"; // This should point to index.jsp in the webapp root
    }

    @GetMapping("/index")
    public String index() {
        return "index";
    }
}
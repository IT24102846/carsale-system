package com.carsales.controller;

import com.carsales.model.User;
import com.carsales.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/users")
public class UserController {

    private final UserService userService;

    public UserController() {
        this.userService = new UserService();
    }

    @GetMapping("")
    public String displayUsers(Model model, HttpSession session) {
        // Check if user is authenticated and is an admin
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role)) {
            return "redirect:/login";
        }


        List<User> userList = userService.findAll();
        model.addAttribute("userList", userList);
        return "User/display";
    }

    @GetMapping("/create")
    public String showCreateForm(HttpSession session) {
        // Check if user is authenticated and is an admin
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role)) {
            return "redirect:/login";
        }

        return "User/create";
    }

    @PostMapping("/save")
    public String createUser(@RequestParam String name,
                             @RequestParam String email,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {

        // Check if user is authenticated and is an admin
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role)) {
            return "redirect:/login";
        }

        // Generate a default password
        String defaultPassword = "password123";

        // Create a standard user with minimal information
        boolean created = userService.registerUser(
                name, defaultPassword, email, "", "USER"
        );

        if (created) {
            redirectAttributes.addFlashAttribute("message", "User created successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Error creating user");
        }

        return "redirect:/users";
    }

    @GetMapping("/edit")
    public String showEditForm(@RequestParam String id, Model model, HttpSession session) {
        // Check if user is authenticated and is an admin
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role)) {
            return "redirect:/login";
        }

        User user = userService.findById(id);
        if (user == null) {
            return "redirect:/users";
        }

        model.addAttribute("user", user);
        return "User/edit";
    }

    @PostMapping("/update")
    public String updateUser(@RequestParam String id,
                             @RequestParam String name,
                             @RequestParam String email,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {

        // Check if user is authenticated and is an admin
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role)) {
            return "redirect:/login";
        }

        User user = userService.findById(id);
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "User not found");
            return "redirect:/users";
        }

        user.setUsername(name);
        user.setEmail(email);

        boolean updated = userService.updateUser(user);

        if (updated) {
            redirectAttributes.addFlashAttribute("message", "User updated successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Error updating user");
        }

        return "redirect:/users";
    }

    @GetMapping("/delete")
    public String deleteUser(@RequestParam String id,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {

        // Check if user is authenticated and is an admin
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role)) {
            return "redirect:/login";
        }

        boolean deleted = userService.deleteUser(id);

        if (deleted) {
            redirectAttributes.addFlashAttribute("message", "User deleted successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Error deleting user");
        }

        return "redirect:/users";
    }
}
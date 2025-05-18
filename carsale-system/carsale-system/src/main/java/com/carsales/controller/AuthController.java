package com.carsales.controller;

import com.carsales.model.BuyerUser;
import com.carsales.model.DealerUser;
import com.carsales.model.SellerUser;
import com.carsales.model.User;
import com.carsales.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

@Controller
public class AuthController {

    private final UserService userService;

    public AuthController() {
        this.userService = new UserService();
    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String processLogin(@RequestParam String username,
                               @RequestParam String password,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {

        // Validate login
        User user = userService.findByUsername(username);

        if (user == null || !user.getPassword().equals(password)) {
            redirectAttributes.addFlashAttribute("error", "Invalid username or password");
            return "redirect:/login";
        }

        // Create session
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("username", user.getUsername());
        session.setAttribute("role", user.getRole());

        // Redirect based on role
        switch (user.getRole()) {
            case "ADMIN":
                return "redirect:/admin/display";
            case "BUYER":
                return "redirect:/cars";
            case "SELLER":
                return "redirect:/cars";
            case "DEALER":
                return "redirect:/cars";
            default:
                return "redirect:/cars";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login?logout=true";
    }

    @GetMapping("/register")
    public String showRegisterForm() {
        return "register";
    }

    @PostMapping("/register")
    public String processRegistration(@RequestParam String username,
                                      @RequestParam String password,
                                      @RequestParam String email,
                                      @RequestParam String phoneNumber,
                                      @RequestParam String role,
                                      @RequestParam(required = false) String address,
                                      @RequestParam(required = false) String paymentMethod,
                                      @RequestParam(required = false) String bankAccount,
                                      @RequestParam(required = false) String dealershipName,
                                      @RequestParam(required = false) String dealershipAddress,
                                      @RequestParam(required = false) String businessLicense,
                                      RedirectAttributes redirectAttributes) {

        // Check if username already exists
        if (userService.findByUsername(username) != null) {
            redirectAttributes.addFlashAttribute("error", "Username already taken");
            return "redirect:/register";
        }

        boolean registered = false;

        // Register user based on role
        switch (role) {
            case "BUYER":
                registered = userService.registerUser(
                        username, password, email, phoneNumber, role, address, paymentMethod
                );
                break;
            case "SELLER":
                registered = userService.registerUser(
                        username, password, email, phoneNumber, role, address, bankAccount
                );
                break;
            case "DEALER":
                registered = userService.registerUser(
                        username, password, email, phoneNumber, role,
                        dealershipName, dealershipAddress, businessLicense
                );
                break;
            default:
                registered = userService.registerUser(
                        username, password, email, phoneNumber, "USER"
                );
        }

        if (registered) {
            redirectAttributes.addFlashAttribute("message", "Registration successful. Please login.");
            return "redirect:/login";
        } else {
            redirectAttributes.addFlashAttribute("error", "Error registering user");
            return "redirect:/register";
        }
    }

    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }

        User user = userService.findById(userId);
        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute("user", user);

        // Add specific user type attributes
        if (user instanceof BuyerUser) {
            model.addAttribute("userType", "buyer");
            model.addAttribute("address", ((BuyerUser) user).getAddress());
            model.addAttribute("paymentMethod", ((BuyerUser) user).getPreferredPaymentMethod());
        } else if (user instanceof SellerUser) {
            model.addAttribute("userType", "seller");
            model.addAttribute("address", ((SellerUser) user).getAddress());
            model.addAttribute("bankAccount", ((SellerUser) user).getBankAccount());
        } else if (user instanceof DealerUser) {
            model.addAttribute("userType", "dealer");
            model.addAttribute("dealershipName", ((DealerUser) user).getDealershipName());
            model.addAttribute("dealershipAddress", ((DealerUser) user).getDealershipAddress());
            model.addAttribute("businessLicense", ((DealerUser) user).getBusinessLicense());
        }

        return "profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam String email,
                                @RequestParam String phoneNumber,
                                @RequestParam(required = false) String currentPassword,
                                @RequestParam(required = false) String newPassword,
                                @RequestParam(required = false) String address,
                                @RequestParam(required = false) String paymentMethod,
                                @RequestParam(required = false) String bankAccount,
                                @RequestParam(required = false) String dealershipName,
                                @RequestParam(required = false) String dealershipAddress,
                                @RequestParam(required = false) String businessLicense,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {

        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }

        User user = userService.findById(userId);
        if (user == null) {
            return "redirect:/login";
        }

        // Update common fields
        user.setEmail(email);
        user.setPhoneNumber(phoneNumber);

        // Update password if provided
        if (currentPassword != null && !currentPassword.isEmpty() &&
                newPassword != null && !newPassword.isEmpty()) {

            if (user.getPassword().equals(currentPassword)) {
                user.setPassword(newPassword);
            } else {
                redirectAttributes.addFlashAttribute("error", "Current password is incorrect");
                return "redirect:/profile";
            }
        }

        // Update user type specific fields
        if (user instanceof BuyerUser && address != null) {
            ((BuyerUser) user).setAddress(address);
            if (paymentMethod != null) {
                ((BuyerUser) user).setPreferredPaymentMethod(paymentMethod);
            }
        } else if (user instanceof SellerUser && address != null) {
            ((SellerUser) user).setAddress(address);
            if (bankAccount != null) {
                ((SellerUser) user).setBankAccount(bankAccount);
            }
        } else if (user instanceof DealerUser) {
            if (dealershipName != null) {
                ((DealerUser) user).setDealershipName(dealershipName);
            }
            if (dealershipAddress != null) {
                ((DealerUser) user).setDealershipAddress(dealershipAddress);
            }
            if (businessLicense != null) {
                ((DealerUser) user).setBusinessLicense(businessLicense);
            }
        }

        boolean updated = userService.updateUser(user);

        if (updated) {
            redirectAttributes.addFlashAttribute("message", "Profile updated successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Error updating profile");
        }

        return "redirect:/profile";
    }
}
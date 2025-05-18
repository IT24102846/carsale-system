package com.carsales.controller;

import com.carsales.model.AdminUser;
import com.carsales.model.User;
import com.carsales.service.AdminService;
import com.carsales.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.List;



@Controller
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;
    private final UserService userService;

    public AdminController() {
        this.adminService = new AdminService();
        this.userService = new UserService();
    }

    @GetMapping("/display")
    public String displayAdmins(Model model, HttpSession session) {
        // Check if user is authenticated and is an admin
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role) && !"SUPER_ADMIN".equals(role)) {
            return "redirect:/login";
        }

        List<User> admins = adminService.getAllAdmins();
        model.addAttribute("admins", admins);
        return "Admin/display";
    }

    @GetMapping("/create")
    public String showCreateForm(HttpSession session) {
        // Check if user is authenticated and is an admin
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role) && !"SUPER_ADMIN".equals(role)) {
            return "redirect:/login";
        }

        return "Admin/create";
    }

    @PostMapping("/create")
    public String createAdmin(@RequestParam String username,
                              @RequestParam String email,
                              @RequestParam String password,
                              @RequestParam String role,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {

        // Check if user is authenticated and is an admin
        String userRole = (String) session.getAttribute("role");
        if (!"ADMIN".equals(userRole) && !"SUPER_ADMIN".equals(userRole)) {
            return "redirect:/login";
        }

        boolean created = adminService.createAdmin(username, password, email,
                "", role, "Administration");

        if (created) {
            redirectAttributes.addFlashAttribute("message", "Admin created successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Error creating admin");
        }

        return "redirect:/admin/display";
    }

    @GetMapping("/edit")
    public String showEditForm(@RequestParam String id, Model model, HttpSession session) {
        // Check if user is authenticated and is an admin
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role) && !"SUPER_ADMIN".equals(role)) {
            return "redirect:/login";
        }

        User admin = userService.findById(id);
        if (admin == null) {
            return "redirect:/admin/display";
        }

        model.addAttribute("admin", admin);
        return "Admin/edit";
    }

    @PostMapping("/update")
    public String updateAdmin(@RequestParam String id,
                              @RequestParam String username,
                              @RequestParam String email,
                              @RequestParam(required = false) String password,
                              @RequestParam String role,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {

        // Check if user is authenticated and is an admin
        String userRole = (String) session.getAttribute("role");
        if (!"ADMIN".equals(userRole) && !"SUPER_ADMIN".equals(userRole)) {
            return "redirect:/login";
        }

        User admin = userService.findById(id);
        if (admin == null) {
            redirectAttributes.addFlashAttribute("error", "Admin not found");
            return "redirect:/admin/display";
        }

        admin.setUsername(username);
        admin.setEmail(email);

        if (password != null && !password.trim().isEmpty()) {
            admin.setPassword(password);
        }

        if (admin instanceof AdminUser) {
            ((AdminUser) admin).setAdminLevel(role);
        } else {
            admin.setRole(role);
        }

        boolean updated = userService.updateUser(admin);

        if (updated) {
            redirectAttributes.addFlashAttribute("message", "Admin updated successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Error updating admin");
        }

        return "redirect:/admin/display";
    }

    @PostMapping("/delete/{id}")
    public String deleteAdmin(@PathVariable String id,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {

        // Check if user is authenticated and is an admin
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role) && !"SUPER_ADMIN".equals(role)) {
            return "redirect:/login";
        }

        boolean deleted = userService.deleteUser(id);

        if (deleted) {
            redirectAttributes.addFlashAttribute("message", "Admin deleted successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Error deleting admin");
        }

        return "redirect:/admin/display";
    }
}
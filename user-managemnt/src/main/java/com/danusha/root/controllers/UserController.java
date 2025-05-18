package com.danusha.root.controllers;

import com.danusha.root.dao.UserDao;
import com.danusha.root.modal.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.UUID;

@Controller
public class UserController {

    @PostMapping("/register")
    public String register(@RequestParam String username, @RequestParam String password, @RequestParam String email, @RequestParam String role, Model model) {
        if (UserDao.getUserByEmail(email) != null) {
            model.addAttribute("error", "email already exists");
            return "redirect:/register";
        }

        String id = UUID.randomUUID().toString();
        User newUser = new User(id, username, email, password, role);
        UserDao.addUser(newUser);
        return "redirect:/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password, HttpSession session, Model model) {
        User user = UserDao.getUserByEmail(email);
        if (user != null && user.getPassword().equals(password)) {
            if ("admin".equals(user.getRole())) {
                session.setAttribute("admin",user);
                return "redirect:admin_users";
            } else {
                session.setAttribute("loggedUser", user);
                return "redirect:dashboard";
            }
        } else {
            model.addAttribute("error", "Invalid login.");
            return "redirect:/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @PostMapping("/update")
    public String updateUser(@RequestParam String id, @RequestParam String username, @RequestParam String password, @RequestParam String email, Model model, @RequestParam String role) {
        User updatedUser = new User(id, username, email, password, role);
        boolean success = UserDao.updateUser(updatedUser);

        if (success) {
            return "redirect:admin_users";
        } else {
            model.addAttribute("error", "update failed");
            return "redirect:/edit-users";

        }
    }

    @GetMapping("/edit")
    public String editUser(@RequestParam String id, Model model) {
        User user = UserDao.getUserById(id);
        if (user != null) {
            model.addAttribute("user", user);
            return "edit-user";
        } else {
            model.addAttribute("error", "user not found");
            return "edit-user";
        }

    }

    @GetMapping("/delete")
    public String deleteUser(@RequestParam String id, Model model) {
        boolean success = UserDao.deleteUser(id);
        if (success) {
            return "redirect:/admin_users";
        } else {
            model.addAttribute("error", "Failed to delete user.");
            return "admin_users"; // or redirect to an error page
        }
    }

    @GetMapping("/admin_users")
    public String showUsers(Model model) {
        List<User> users = UserDao.getAllUsers();
        model.addAttribute("userList", users);
        return "admin_users";
    }

    //page

    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @GetMapping("/signup")
    public String showRegister() {
        return "signup";
    }

    @GetMapping("/edit-user")
    public String showAccount() {
        return "edit-user";
    }

    @GetMapping("dashboard")
    public String showDashboard() {
        return "dashboard";
    }

}

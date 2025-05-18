package com.second_hand_car_sales_and_purchase.controller;

import com.second_hand_car_sales_and_purchase.model.User;
import com.second_hand_car_sales_and_purchase.dao.UserDAO;

import jakarta.jms.Session;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/user")
public class UserController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("create".equals(action)) {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            if (UserDAO.getUserByEmail(email) != null) {
                response.getWriter().println("Email already registered.");
                return;
            }

            String id = UUID.randomUUID().toString();
            User newUser = new User(id, username, email, password, role);
            UserDAO.addUser(newUser);
            response.sendRedirect("login.jsp");

        } else if ("update".equals(action)) {
            String id = request.getParameter("id");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            User updatedUser = new User(id, username, email, password, role);
            boolean success = UserDAO.updateUser(updatedUser);

            if (success) {
                response.sendRedirect("user?action=list");
            } else {
                response.getWriter().println("Update failed");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("list".equals(action)) {
            List<User> users = UserDAO.getAllUsers();
            request.setAttribute("userList", users);
            request.getRequestDispatcher("admin_users.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            String id = request.getParameter("id");
            User user = UserDAO.getUserById(id);
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("edit-user.jsp").forward(request, response);
            } else {
                response.getWriter().println("User not found");
            }

        } else if ("delete".equals(action)) {
            String id = request.getParameter("id");
            UserDAO.deleteUser(id);
            response.sendRedirect("user?action=list");
        } else if ("userDashboard".equals(action)) {
            HttpSession session = request.getSession(false);
            User user = (User) session.getAttribute("loggedUser");

            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp");
            }
        }

    }

}

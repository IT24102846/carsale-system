package com.second_hand_car_sales_and_purchase.controller;

import com.second_hand_car_sales_and_purchase.dao.UserDAO;
import com.second_hand_car_sales_and_purchase.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User

                user = UserDAO.getUserByEmail(email);

        if (user != null && user.getPassword().equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", user);
            if ("admin".equals(user.getRole())) {
                response.sendRedirect("user?action=list");
            } else {
                response.sendRedirect("user?action=userDashboard");
            }

        } else {
            response.getWriter().println("Invalid login.");
        }
    }
}

package com.carsales.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;


/**
 * Interceptor to check if user is authenticated for protected pages
 */
public class AuthInterceptor implements HandlerInterceptor {

    // URLs that don't require authentication
    private static final List<String> PUBLIC_URLS = Arrays.asList(
            "/login", "/register", "/cars", "/", "/index", "/error",
            "/static/", "/favicon.ico", "/uploads/"
    );

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        String requestURI = request.getRequestURI();

        // Allow public URLs
        for (String publicUrl : PUBLIC_URLS) {
            if (requestURI.startsWith(publicUrl)) {
                return true;
            }
        }

        // Check if user is authenticated
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }

        // Allow request if authenticated
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
        // Add common attributes to model for all views
        if (modelAndView != null) {
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("username") != null) {
                modelAndView.addObject("loggedInUsername", session.getAttribute("username"));
                modelAndView.addObject("loggedInRole", session.getAttribute("role"));
            }
        }
    }
}
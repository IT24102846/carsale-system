<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Header | AutoMarket</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    .navbar {
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      padding: 15px 0;
    }

    .navbar-brand img {
      height: 40px;
    }

    .nav-link {
      font-weight: 500;
      padding: 10px 15px !important;
      color: #333;
      position: relative;
    }

    .nav-link:hover {
      color: #0d6efd;
    }

    .nav-link.active::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 15px;
      right: 15px;
      height: 3px;
      background-color: #0d6efd;
      border-radius: 3px;
    }

    .dropdown-menu {
      border: none;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      border-radius: 8px;
      padding: 10px 0;
    }

    .dropdown-item {
      padding: 8px 20px;
    }

    .dropdown-item:hover {
      background-color: #f8f9fa;
      color: #0d6efd;
    }

    .auth-buttons .btn {
      margin-left: 10px;
    }

    /* User Avatar */
    .user-avatar {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      background-color: #e9ecef;
      display: flex;
      align-items: center;
      justify-content: center;
      overflow: hidden;
      border: 2px solid #fff;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .user-avatar img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    /* Mobile Menu */
    @media (max-width: 991px) {
      .navbar-collapse {
        background-color: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        margin-top: 10px;
      }

      .auth-buttons {
        margin-top: 15px;
      }

      .auth-buttons .btn {
        margin: 5px 0;
        display: block;
        width: 100%;
      }
    }
  </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-white">
  <div class="container">
    <a class="navbar-brand" href="/">
      <img src="/assets/logo.png" alt="AutoMarket Logo">
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link ${pageContext.request.requestURI.contains('/index') ? 'active' : ''}" href="/">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${pageContext.request.requestURI.contains('/cars') ? 'active' : ''}" href="/cars">Browse Cars</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="sellDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Sell
          </a>
          <ul class="dropdown-menu" aria-labelledby="sellDropdown">
            <li><a class="dropdown-item" href="/cars/create">Add Car Listing</a></li>
            <li><a class="dropdown-item" href="/seller/guide">Seller's Guide</a></li>
            <li><a class="dropdown-item" href="/pricing">Pricing</a></li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link ${pageContext.request.requestURI.contains('/about') ? 'active' : ''}" href="/about">About Us</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${pageContext.request.requestURI.contains('/contact') ? 'active' : ''}" href="/contact">Contact</a>
        </li>
      </ul>

      <div class="auth-buttons d-flex align-items-center">
        <c:choose>
          <c:when test="${empty sessionScope.user}">
            <a href="/login" class="btn btn-outline-primary">Login</a>
            <a href="/register" class="btn btn-primary">Register</a>
          </c:when>
          <c:otherwise>
            <div class="dropdown">
              <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                <div class="user-avatar me-2">
                  <c:choose>
                    <c:when test="${not empty sessionScope.user.profileImage}">
                      <img src="/uploads/profiles/${sessionScope.user.profileImage}" alt="${sessionScope.user.name}">
                    </c:when>
                    <c:otherwise>
                      <i class="fas fa-user"></i>
                    </c:otherwise>
                  </c:choose>
                </div>
                <span>${sessionScope.user.name}</span>
              </a>
              <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                <li><a class="dropdown-item" href="/dashboard"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a></li>
                <li><a class="dropdown-item" href="/profile"><i class="fas fa-user-circle me-2"></i>My Profile</a></li>

                <c:if test="${sessionScope.user.role == 'SELLER' || sessionScope.user.role == 'DEALER'}">
                  <li><a class="dropdown-item" href="/my-cars"><i class="fas fa-car me-2"></i>My Cars</a></li>
                </c:if>

                <c:if test="${sessionScope.user.role == 'BUYER'}">
                  <li><a class="dropdown-item" href="/my-bookings"><i class="fas fa-calendar-check me-2"></i>My Bookings</a></li>
                </c:if>

                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                  <li><hr class="dropdown-divider"></li>
                  <li><a class="dropdown-item" href="/admin/dashboard"><i class="fas fa-cog me-2"></i>Admin Panel</a></li>
                </c:if>

                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item" href="/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
              </ul>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</nav>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Register | AutoMarket</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f5f5f5;
    }
    .register-container {
      max-width: 650px;
      margin: 50px auto;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
      background-color: white;
    }
    .register-header {
      text-align: center;
      margin-bottom: 30px;
    }
    .register-header img {
      max-width: 150px;
      margin-bottom: 15px;
    }
    .btn-register {
      font-size: 1.1rem;
      padding: 8px 0;
    }
  </style>
</head>
<!-- HEADER: Add at the beginning of the <body> section in all JSP files -->
<header>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <a class="navbar-brand" href="/">AutoMarket</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav me-auto">
          <li class="nav-item">
            <a class="nav-link" href="/">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/cars">Cars</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/bookings">Bookings</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/feedback">Feedback</a>
          </li>
          <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'SUPER_ADMIN'}">
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="adminDropdown" role="button" data-bs-toggle="dropdown">
                Admin
              </a>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="/admin/display">Manage Admins</a></li>
                <li><a class="dropdown-item" href="/users">Manage Users</a></li>
                <li><a class="dropdown-item" href="/payments">Manage Payments</a></li>
              </ul>
            </li>
          </c:if>
        </ul>
        <div class="d-flex">
          <c:choose>
            <c:when test="${empty sessionScope.username}">
              <a href="/login" class="btn btn-outline-light me-2">Login</a>
              <a href="/register" class="btn btn-primary">Register</a>
            </c:when>
            <c:otherwise>
              <div class="dropdown">
                <button class="btn btn-outline-light dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown">
                    ${sessionScope.username}
                </button>
                <ul class="dropdown-menu dropdown-menu-end">
                  <li><a class="dropdown-item" href="/profile">Profile</a></li>
                  <li><hr class="dropdown-divider"></li>
                  <li><a class="dropdown-item" href="/logout">Logout</a></li>
                </ul>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>
  </nav>
</header>
<body>
<div class="container">
  <div class="register-container">
    <div class="register-header">
      <h2>Create an Account</h2>
      <p class="text-muted">Fill in your details to join AutoMarket</p>
    </div>

    <c:if test="${not empty message}">
      <div class="alert alert-success alert-dismissible fade show" role="alert">
          ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    </c:if>

    <c:if test="${not empty error}">
      <div class="alert alert-danger alert-dismissible fade show" role="alert">
          ${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    </c:if>

    <form action="/register" method="post">
      <div class="row">
        <div class="col-md-6 mb-3">
          <label for="username" class="form-label">Username</label>
          <input type="text" class="form-control" id="username" name="username" required>
        </div>
        <div class="col-md-6 mb-3">
          <label for="email" class="form-label">Email</label>
          <input type="email" class="form-control" id="email" name="email" required>
        </div>
      </div>

      <div class="row">
        <div class="col-md-6 mb-3">
          <label for="password" class="form-label">Password</label>
          <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <div class="col-md-6 mb-3">
          <label for="phoneNumber" class="form-label">Phone Number</label>
          <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required>
        </div>
      </div>

      <div class="mb-3">
        <label for="role" class="form-label">Register as</label>
        <select class="form-select" id="role" name="role" required>
          <option value="">-- Select Role --</option>
          <option value="BUYER">Buyer</option>
          <option value="SELLER">Seller</option>
          <option value="DEALER">Dealer</option>
        </select>
      </div>

      <!-- Buyer Fields (Hidden by default) -->
      <div id="buyerFields" style="display: none;">
        <div class="row">
          <div class="col-md-6 mb-3">
            <label for="address" class="form-label">Address</label>
            <input type="text" class="form-control" id="address" name="address">
          </div>
          <div class="col-md-6 mb-3">
            <label for="paymentMethod" class="form-label">Preferred Payment Method</label>
            <select class="form-select" id="paymentMethod" name="paymentMethod">
              <option value="Credit Card">Credit Card</option>
              <option value="Debit Card">Debit Card</option>
              <option value="PayPal">PayPal</option>
              <option value="Bank Transfer">Bank Transfer</option>
              <option value="Cash">Cash</option>
            </select>
          </div>
        </div>
      </div>

      <!-- Seller Fields (Hidden by default) -->
      <div id="sellerFields" style="display: none;">
        <div class="row">
          <div class="col-md-6 mb-3">
            <label for="address" class="form-label">Address</label>
            <input type="text" class="form-control" id="sellerAddress" name="address">
          </div>
          <div class="col-md-6 mb-3">
            <label for="bankAccount" class="form-label">Bank Account</label>
            <input type="text" class="form-control" id="bankAccount" name="bankAccount">
          </div>
        </div>
      </div>

      <!-- Dealer Fields (Hidden by default) -->
      <div id="dealerFields" style="display: none;">
        <div class="row">
          <div class="col-md-6 mb-3">
            <label for="dealershipName" class="form-label">Dealership Name</label>
            <input type="text" class="form-control" id="dealershipName" name="dealershipName">
          </div>
          <div class="col-md-6 mb-3">
            <label for="dealershipAddress" class="form-label">Dealership Address</label>
            <input type="text" class="form-control" id="dealershipAddress" name="dealershipAddress">
          </div>
        </div>
        <div class="mb-3">
          <label for="businessLicense" class="form-label">Business License Number</label>
          <input type="text" class="form-control" id="businessLicense" name="businessLicense">
        </div>
      </div>

      <div class="d-grid gap-2 mt-4">
        <button type="submit" class="btn btn-primary btn-register">Register</button>
      </div>
    </form>

    <div class="text-center mt-4">
      <p>Already have an account? <a href="/login">Sign In</a></p>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Show/hide role-specific fields
  document.getElementById('role').addEventListener('change', function() {
    const role = this.value;
    const buyerFields = document.getElementById('buyerFields');
    const sellerFields = document.getElementById('sellerFields');
    const dealerFields = document.getElementById('dealerFields');

    buyerFields.style.display = 'none';
    sellerFields.style.display = 'none';
    dealerFields.style.display = 'none';

    if (role === 'BUYER') {
      buyerFields.style.display = 'block';
    } else if (role === 'SELLER') {
      sellerFields.style.display = 'block';
    } else if (role === 'DEALER') {
      dealerFields.style.display = 'block';
    }
  });
</script>
</body>
</html>
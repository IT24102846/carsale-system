<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>User Profile | AutoMarket</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    .profile-container {
      max-width: 800px;
      margin: 50px auto;
      padding: 0;
    }
    .profile-header {
      background-color: #f8f9fa;
      padding: 30px;
      border-radius: 10px 10px 0 0;
      text-align: center;
      border-bottom: 1px solid #dee2e6;
    }
    .profile-avatar {
      width: 120px;
      height: 120px;
      background-color: #e9ecef;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 20px;
      font-size: 48px;
      color: #6c757d;
    }
    .profile-content {
      background-color: white;
      padding: 30px;
      border-radius: 0 0 10px 10px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
    }
    .nav-tabs {
      border-bottom: none;
      margin-bottom: 20px;
    }
    .nav-tabs .nav-link {
      border: none;
      color: #495057;
      font-weight: 500;
    }
    .nav-tabs .nav-link.active {
      background-color: transparent;
      border-bottom: 3px solid #0d6efd;
      color: #0d6efd;
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
  <div class="profile-container">
    <div class="profile-header">
      <div class="profile-avatar">
        <i class="fas fa-user"></i>
      </div>
      <h2>${user.username}</h2>
      <p class="text-muted">${user.role}</p>
    </div>

    <div class="profile-content">
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

      <ul class="nav nav-tabs" id="profileTab" role="tablist">
        <li class="nav-item" role="presentation">
          <button class="nav-link active" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile-pane"
                  type="button" role="tab" aria-controls="profile-pane" aria-selected="true">Profile</button>
        </li>
        <li class="nav-item" role="presentation">
          <button class="nav-link" id="security-tab" data-bs-toggle="tab" data-bs-target="#security-pane"
                  type="button" role="tab" aria-controls="security-pane" aria-selected="false">Security</button>
        </li>
      </ul>

      <div class="tab-content" id="profileTabContent">
        <div class="tab-pane fade show active" id="profile-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0">
          <form action="/profile/update" method="post">
            <div class="row mb-3">
              <div class="col-md-6">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
              </div>
              <div class="col-md-6">
                <label for="phoneNumber" class="form-label">Phone Number</label>
                <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}" required>
              </div>
            </div>

            <!-- Buyer specific fields -->
            <c:if test="${userType == 'buyer'}">
              <div class="row mb-3">
                <div class="col-md-6">
                  <label for="address" class="form-label">Address</label>
                  <input type="text" class="form-control" id="address" name="address" value="${address}">
                </div>
                <div class="col-md-6">
                  <label for="paymentMethod" class="form-label">Preferred Payment Method</label>
                  <select class="form-select" id="paymentMethod" name="paymentMethod">
                    <option value="Credit Card" ${paymentMethod == 'Credit Card' ? 'selected' : ''}>Credit Card</option>
                    <option value="Debit Card" ${paymentMethod == 'Debit Card' ? 'selected' : ''}>Debit Card</option>
                    <option value="PayPal" ${paymentMethod == 'PayPal' ? 'selected' : ''}>PayPal</option>
                    <option value="Bank Transfer" ${paymentMethod == 'Bank Transfer' ? 'selected' : ''}>Bank Transfer</option>
                    <option value="Cash" ${paymentMethod == 'Cash' ? 'selected' : ''}>Cash</option>
                  </select>
                </div>
              </div>
            </c:if>

            <!-- Seller specific fields -->
            <c:if test="${userType == 'seller'}">
              <div class="row mb-3">
                <div class="col-md-6">
                  <label for="address" class="form-label">Address</label>
                  <input type="text" class="form-control" id="address" name="address" value="${address}">
                </div>
                <div class="col-md-6">
                  <label for="bankAccount" class="form-label">Bank Account</label>
                  <input type="text" class="form-control" id="bankAccount" name="bankAccount" value="${bankAccount}">
                </div>
              </div>
            </c:if>

            <!-- Dealer specific fields -->
            <c:if test="${userType == 'dealer'}">
              <div class="row mb-3">
                <div class="col-md-6">
                  <label for="dealershipName" class="form-label">Dealership Name</label>
                  <input type="text" class="form-control" id="dealershipName" name="dealershipName" value="${dealershipName}">
                </div>
                <div class="col-md-6">
                  <label for="dealershipAddress" class="form-label">Dealership Address</label>
                  <input type="text" class="form-control" id="dealershipAddress" name="dealershipAddress" value="${dealershipAddress}">
                </div>
              </div>
              <div class="mb-3">
                <label for="businessLicense" class="form-label">Business License</label>
                <input type="text" class="form-control" id="businessLicense" name="businessLicense" value="${businessLicense}">
              </div>
            </c:if>

            <div class="d-grid gap-2 mt-4">
              <button type="submit" class="btn btn-primary">Update Profile</button>
            </div>
          </form>
        </div>

        <div class="tab-pane fade" id="security-pane" role="tabpanel" aria-labelledby="security-tab" tabindex="0">
          <form action="/profile/update" method="post">
            <div class="mb-3">
              <label for="currentPassword" class="form-label">Current Password</label>
              <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
            </div>
            <div class="mb-3">
              <label for="newPassword" class="form-label">New Password</label>
              <input type="password" class="form-control" id="newPassword" name="newPassword" required>
            </div>
            <div class="mb-3">
              <label for="confirmPassword" class="form-label">Confirm New Password</label>
              <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
            </div>
            <div class="d-grid gap-2 mt-4">
              <button type="submit" class="btn btn-primary">Change Password</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Check if passwords match
  document.getElementById('confirmPassword').addEventListener('input', function() {
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = this.value;

    if (newPassword !== confirmPassword) {
      this.setCustomValidity('Passwords do not match');
    } else {
      this.setCustomValidity('');
    }
  });
</script>
</body>
</html>
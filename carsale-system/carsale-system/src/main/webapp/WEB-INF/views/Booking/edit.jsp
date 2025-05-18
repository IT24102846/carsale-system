<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>Edit Booking | AutoMarket</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .booking-form {
      max-width: 650px;
      margin: 50px auto;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
      background-color: white;
    }
    .form-header {
      text-align: center;
      margin-bottom: 30px;
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
  <div class="booking-form">
    <div class="form-header">
      <h2>Edit Booking</h2>
      <p class="text-muted">Update booking details</p>
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

    <form action="/bookings/update" method="post">
      <input type="hidden" name="id" value="${booking.bookingId}">

      <div class="mb-3">
        <label for="carId" class="form-label">Car ID</label>
        <input type="text" class="form-control" id="carId" name="carId" value="${booking.carId}" required>
      </div>

      <div class="mb-3">
        <label for="userId" class="form-label">User ID</label>
        <input type="text" class="form-control" id="userId" name="userId" value="${booking.buyerId}" required>
      </div>

      <div class="mb-3">
        <label for="bookingDate" class="form-label">Booking Date</label>
        <input type="date" class="form-control" id="bookingDate" name="bookingDate"
               value="<fmt:formatDate value="${booking.bookingDate}" pattern="yyyy-MM-dd" />" required>
      </div>

      <div class="mb-3">
        <label for="status" class="form-label">Status</label>
        <select class="form-select" id="status" name="status">
          <option value="PENDING" ${booking.status == 'PENDING' ? 'selected' : ''}>Pending</option>
          <option value="CONFIRMED" ${booking.status == 'CONFIRMED' ? 'selected' : ''}>Confirmed</option>
          <option value="CANCELLED" ${booking.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
          <option value="COMPLETED" ${booking.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
        </select>
      </div>

      <div class="d-grid gap-2 mt-4">
        <button type="submit" class="btn btn-primary">Update Booking</button>
        <a href="/bookings" class="btn btn-outline-secondary">Cancel</a>
      </div>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
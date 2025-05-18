<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>Booking List | AutoMarket</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    .booking-container {
      padding: 20px;
      background-color: #f8f9fa;
      border-radius: 10px;
      box-shadow: 0 0 15px rgba(0,0,0,0.05);
      margin-top: 30px;
    }
    .table-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }
    .badge-pending {
      background-color: #ffc107;
      color: #212529;
    }
    .badge-confirmed {
      background-color: #198754;
    }
    .badge-cancelled {
      background-color: #dc3545;
    }
    .badge-completed {
      background-color: #0d6efd;
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
  <div class="booking-container">
    <div class="table-header">
      <h2>Booking Records</h2>
      <a href="/bookings/create" class="btn btn-primary">
        <i class="fas fa-plus"></i> Create Booking
      </a>
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

    <table id="bookingsTable" class="table table-striped table-hover">
      <thead class="table-dark">
      <tr>
        <th>ID</th>
        <th>Car</th>
        <th>Buyer</th>
        <th>Booking Date</th>
        <th>Expected Delivery</th>
        <th>Status</th>
        <th>Amount</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="booking" items="${bookingList}">
        <tr>
          <td>${booking.bookingId}</td>
          <td>${booking.carId}</td>
          <td>${booking.buyerId}</td>
          <td><fmt:formatDate value="${booking.bookingDate}" pattern="yyyy-MM-dd" /></td>
          <td><fmt:formatDate value="${booking.expectedDeliveryDate}" pattern="yyyy-MM-dd" /></td>
          <td>
                                <span class="badge
                                    ${booking.status == 'PENDING' ? 'badge-pending' :
                                      booking.status == 'CONFIRMED' ? 'badge-confirmed' :
                                      booking.status == 'CANCELLED' ? 'badge-cancelled' :
                                      'badge-completed'}">
                                    ${booking.status}
                                </span>
          </td>
          <td>$${booking.amount}</td>
          <td>
            <a href="/bookings/edit?id=${booking.bookingId}" class="btn btn-sm btn-warning">
              <i class="fas fa-edit"></i>
            </a>
            <a href="/bookings/delete?id=${booking.bookingId}" class="btn btn-sm btn-danger"
               onclick="return confirm('Are you sure you want to delete this booking?');">
              <i class="fas fa-trash"></i>
            </a>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<script>
  $(document).ready(function() {
    $('#bookingsTable').DataTable({
      responsive: true,
      order: [[3, 'desc']] // Sort by booking date
    });
  });
</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Create Booking</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .booking-form {
      max-width: 600px;
      margin: 30px auto;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
      background-color: white;
    }
    .car-info {
      background-color: #f8f9fa;
      padding: 15px;
      border-radius: 8px;
      margin-bottom: 20px;
    }
  </style>
</head>
<body>
<div class="container">
  <div class="booking-form">
    <h2 class="text-center mb-4">Create Booking</h2>

    <c:if test="${not empty car}">
      <div class="car-info">
        <div class="row">
          <div class="col-md-4">
            <img src="/uploads/${car.imageUrl}" class="img-fluid rounded" alt="${car.brand} ${car.model}">
          </div>
          <div class="col-md-8">
            <h5>${car.brand} ${car.model} (${car.year})</h5>
            <p class="text-muted">${car.mileage} km | ${car.condition}</p>
            <p class="fw-bold text-primary">$${car.price}</p>
          </div>
        </div>
      </div>
    </c:if>

    <form action="/bookings/save" method="post">
      <input type="hidden" name="carId" value="${carId}">

      <div class="mb-3">
        <label for="userId" class="form-label">User ID</label>
        <input type="text" class="form-control" id="userId" name="userId" value="${userId}" required>
      </div>

      <div class="mb-3">
        <label for="bookingDate" class="form-label">Booking Date</label>
        <input type="date" class="form-control" id="bookingDate" name="bookingDate" value="${today}" required>
      </div>

      <div class="d-grid gap-2">
        <button type="submit" class="btn btn-primary">Book Now</button>
        <a href="/cars" class="btn btn-outline-secondary">Cancel</a>
      </div>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
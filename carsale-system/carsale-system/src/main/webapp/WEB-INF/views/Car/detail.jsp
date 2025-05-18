<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Car Details | AutoMarket</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .car-detail {
      margin-top: 30px;
    }
    .car-images {
      position: relative;
      height: 400px;
      background-color: #f8f9fa;
      border-radius: 8px;
      overflow: hidden;
      margin-bottom: 20px;
    }
    .car-images img {
      width: 100%;
      height: 100%;
      object-fit: contain;
    }
    .car-info {
      background-color: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 0 15px rgba(0,0,0,0.05);
    }
    .price-tag {
      font-size: 28px;
      font-weight: bold;
      color: #007bff;
    }
    .car-specs {
      background-color: #f8f9fa;
      padding: 15px;
      border-radius: 8px;
      margin-bottom: 20px;
    }
    .spec-item {
      display: flex;
      justify-content: space-between;
      margin-bottom: 8px;
    }
    .seller-info {
      background-color: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 0 15px rgba(0,0,0,0.05);
      margin-top: 20px;
    }
  </style>
</head>
<body>
<div class="container car-detail">
  <div class="row">
    <div class="col-md-8">
      <div class="car-images">
        <!-- Fixed image path to use /uploads/ directly -->
        <img src="/uploads/${car.imageUrl}" alt="${car.brand} ${car.model}">
      </div>
      <div class="car-info">
        <h2>${car.brand} ${car.model} ${car.year}</h2>
        <div class="car-specs mt-4">
          <h5>Vehicle Specifications</h5>
          <div class="spec-item">
            <span>Condition:</span>
            <span>${car.condition}</span>
          </div>
          <div class="spec-item">
            <span>Mileage:</span>
            <span>${car.mileage} km</span>
          </div>
          <div class="spec-item">
            <span>Color:</span>
            <span>${car.color}</span>
          </div>
          <c:if test="${car['class'].simpleName == 'UsedCar'}">
            <div class="spec-item">
              <span>Previous Owners:</span>
              <span>${car.previousOwners}</span>
            </div>
            <div class="spec-item">
              <span>Accident History:</span>
              <span>${car.hasAccidentHistory ? 'Yes' : 'No'}</span>
            </div>
          </c:if>
          <c:if test="${car['class'].simpleName == 'DealerCar'}">
            <div class="spec-item">
              <span>Warranty:</span>
              <span>${car.hasWarranty ? car.warrantyMonths + ' months' : 'No'}</span>
            </div>
            <div class="spec-item">
              <span>Financing Available:</span>
              <span>${car.financingAvailable ? 'Yes' : 'No'}</span>
            </div>
          </c:if>
        </div>
        <div class="mt-4">
          <h5>Description</h5>
          <p>${car.description}</p>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="car-info text-center">
        <div class="price-tag mb-3">$${car.price}</div>
        <a href="/bookings/create?carId=${car.carId}&userId=${sessionScope.userId}" class="btn btn-primary btn-lg w-100 mb-3">Book Now</a>
        <button class="btn btn-outline-primary btn-lg w-100">Contact Seller</button>
      </div>

      <div class="seller-info">
        <h5>Actions</h5>
        <div class="d-grid gap-2 mt-3">
          <c:if test="${sessionScope.userId eq car.sellerId || sessionScope.role eq 'ADMIN'}">
            <a href="/cars/edit?id=${car.carId}" class="btn btn-warning">
              <i class="fas fa-edit"></i> Edit Car
            </a>
            <a href="/cars/delete?id=${car.carId}" class="btn btn-danger"
               onclick="return confirm('Are you sure you want to delete this car?');">
              <i class="fas fa-trash"></i> Delete Car
            </a>
          </c:if>
          <a href="/cars" class="btn btn-secondary mt-3">Back to Listings</a>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
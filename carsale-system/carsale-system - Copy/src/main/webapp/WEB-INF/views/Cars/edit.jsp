<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Edit Car | AutoMarket</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f8f9fa;
    }
    .car-form {
      max-width: 800px;
      margin: 30px auto;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
      background-color: white;
    }
    .form-header {
      text-align: center;
      margin-bottom: 30px;
    }
    .image-preview {
      width: 100%;
      height: 200px;
      border: 2px dashed #ddd;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 15px;
      overflow: hidden;
    }
    .image-preview img {
      max-width: 100%;
      max-height: 100%;
    }
  </style>
</head>
<body>
<div class="container">
  <div class="car-form">
    <div class="form-header">
      <h2>Edit Car Listing</h2>
      <p class="text-muted">Update the details about this vehicle</p>
    </div>
    <form action="/cars/update" method="post">
      <input type="hidden" name="id" value="${car.carId}">
      <div class="row">
        <div class="col-md-6">
          <div class="mb-3">
            <label for="make" class="form-label">Make</label>
            <input type="text" class="form-control" id="make" name="make" value="${fn:escapeXml(car.brand)}" required>
          </div>
          <div class="mb-3">
            <label for="model" class="form-label">Model</label>
            <input type="text" class="form-control" id="model" name="model" value="${fn:escapeXml(car.model)}" required>
          </div>
          <div class="mb-3">
            <label for="year" class="form-label">Year</label>
            <input type="number" class="form-control" id="year" name="year" min="1900" max="2025" value="${car.year}" required>
          </div>
          <div class="mb-3">
            <label for="price" class="form-label">Price ($)</label>
            <input type="number" class="form-control" id="price" name="price" min="0" step="0.01" value="${car.price}" required>
          </div>
        </div>
        <div class="col-md-6">
          <div class="mb-3">
            <label for="mileage" class="form-label">Mileage (km)</label>
            <input type="number" class="form-control" id="mileage" name="mileage" min="0" value="${car.mileage}" required>
          </div>
          <div class="mb-3">
            <label for="transmission" class="form-label">Transmission</label>
            <select class="form-select" id="transmission" name="transmission" required>
              <option value="Automatic" ${car.transmission == 'Automatic' ? 'selected' : ''}>Automatic</option>
              <option value="Manual" ${car.transmission == 'Manual' ? 'selected' : ''}>Manual</option>
              <option value="Semi-Automatic" ${car.transmission == 'Semi-Automatic' ? 'selected' : ''}>Semi-Automatic</option>
            </select>
          </div>
          <div class="mb-3">
            <label for="fuelType" class="form-label">Fuel Type</label>
            <select class="form-select" id="fuelType" name="fuelType" required>
              <option value="Petrol" ${car.fuelType == 'Petrol' ? 'selected' : ''}>Petrol</option>
              <option value="Diesel" ${car.fuelType == 'Diesel' ? 'selected' : ''}>Diesel</option>
              <option value="Hybrid" ${car.fuelType == 'Hybrid' ? 'selected' : ''}>Hybrid</option>
              <option value="Electric" ${car.fuelType == 'Electric' ? 'selected' : ''}>Electric</option>
            </select>
          </div>
          <div class="mb-3">
            <label for="color" class="form-label">Color</label>
            <input type="text" class="form-control" id="color" name="color" value="${fn:escapeXml(car.color)}" required>
          </div>
        </div>
      </div>
      <div class="mb-3">
        <label for="description" class="form-label">Description</label>
        <textarea class="form-control" id="description" name="description" rows="3" required>${fn:escapeXml(car.description)}</textarea>
      </div>
      <div class="mb-3">
        <label for="imageUrl" class="form-label">Image URL</label>
        <input type="url" class="form-control" id="imageUrl" name="imageUrl" value="${car.imageUrl}">
        <small class="form-text text-muted">Enter a URL to an image of the car</small>
        <div class="image-preview mt-2" id="imagePreview">
          <c:choose>
            <c:when test="${not empty car.imageUrl}">
              <img src="${car.imageUrl}" alt="Car Image">
            </c:when>
            <c:otherwise>
              <span class="text-muted">No image available</span>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

      <!-- Begin UsedCar Section -->
      <c:if test="${car['class'].simpleName == 'UsedCar'}">
        <hr>
        <h4>Used Car Details</h4>
        <div class="mb-3">
          <label for="history" class="form-label">Vehicle History</label>
          <textarea class="form-control" id="history" name="history" rows="2">${fn:escapeXml(car.history)}</textarea>
        </div>
        <div class="mb-3">
          <label for="previousOwners" class="form-label">Previous Owners</label>
          <input type="number" class="form-control" id="previousOwners" name="previousOwners" min="0" value="${car.previousOwners}">
        </div>
        <div class="mb-3 form-check">
          <input type="checkbox" class="form-check-input" id="hasAccidentHistory" name="hasAccidentHistory" ${car.hasAccidentHistory ? 'checked' : ''}>
          <label class="form-check-label" for="hasAccidentHistory">Has Accident History</label>
        </div>
      </c:if>
      <!-- End UsedCar Section -->

      <!-- Begin DealerCar Section -->
      <c:if test="${car['class'].simpleName == 'DealerCar'}">
        <hr>
        <h4>Dealer Car Details</h4>
        <div class="mb-3">
          <label for="dealershipId" class="form-label">Dealership ID</label>
          <input type="text" class="form-control" id="dealershipId" name="dealershipId" value="${car.dealershipId}">
        </div>
        <div class="mb-3 form-check">
          <input type="checkbox" class="form-check-input" id="hasWarranty" name="hasWarranty" ${car.hasWarranty ? 'checked' : ''}>
          <label class="form-check-label" for="hasWarranty">Has Warranty</label>
        </div>
        <div class="mb-3">
          <label for="warrantyMonths" class="form-label">Warranty Period (months)</label>
          <input type="number" class="form-control" id="warrantyMonths" name="warrantyMonths" min="0" value="${car.warrantyMonths}">
        </div>
        <div class="mb-3 form-check">
          <input type="checkbox" class="form-check-input" id="isFinancingAvailable" name="isFinancingAvailable" ${car.isFinancingAvailable ? 'checked' : ''}>
          <label class="form-check-label" for="isFinancingAvailable">Financing Available</label>
        </div>
      </c:if>
      <!-- End DealerCar Section -->

      <div class="d-grid gap-2">
        <button type="submit" class="btn btn-primary">Update Car</button>
        <a href="/cars" class="btn btn-outline-secondary">Cancel</a>
      </div>
    </form>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Image URL preview
  document.getElementById('imageUrl').addEventListener('input', function(event) {
    const preview = document.getElementById('imagePreview');
    preview.innerHTML = '';
    const url = this.value;

    if (!url) {
      preview.innerHTML = '<span class="text-muted">No image URL provided</span>';
      return;
    }

    const img = document.createElement('img');
    img.onerror = function() {
      preview.innerHTML = '<span class="text-danger">Invalid or inaccessible image URL</span>';
    };
    img.onload = function() {
      preview.innerHTML = '';
      preview.appendChild(img);
    };
    img.src = url;
  });
</script>
</body>
</html>

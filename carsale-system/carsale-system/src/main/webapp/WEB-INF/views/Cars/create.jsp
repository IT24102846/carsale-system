<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add New Car | AutoMarket</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    :root {
      --primary-color: #3498db;
      --secondary-color: #2c3e50;
      --success-color: #2ecc71;
      --warning-color: #f39c12;
      --danger-color: #e74c3c;
      --light-bg: #f8f9fa;
      --dark-bg: #343a40;
    }
    body {
      background-color: #f0f2f5;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .navbar-brand {
      font-weight: 700;
      color: var(--primary-color) !important;
    }

    .car-form {
      max-width: 800px;
      margin: 30px auto;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 8px 20px rgba(0,0,0,0.1);
      background-color: white;
      transition: all 0.3s ease;
    }

    .car-form:hover {
      box-shadow: 0 12px 30px rgba(0,0,0,0.15);
    }

    .form-header {
      text-align: center;
      margin-bottom: 30px;
      padding-bottom: 20px;
      border-bottom: 2px solid var(--light-bg);
    }

    .form-header h2 {
      color: var(--secondary-color);
      font-weight: 600;
    }

    .form-control, .form-select {
      border-radius: 8px;
      padding: 10px 15px;
      border: 1px solid #ced4da;
      transition: all 0.3s ease;
    }

    .form-control:focus, .form-select:focus {
      border-color: var(--primary-color);
      box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
    }

    .btn-primary {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
      border-radius: 8px;
      padding: 10px 20px;
      font-weight: 500;
      transition: all 0.3s ease;
    }

    .btn-primary:hover {
      background-color: #2980b9;
      border-color: #2980b9;
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }

    .btn-outline-secondary {
      border-radius: 8px;
      padding: 10px 20px;
      font-weight: 500;
      transition: all 0.3s ease;
    }

    .btn-outline-secondary:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }

    .section-title {
      font-size: 1.2rem;
      color: var(--secondary-color);
      font-weight: 600;
      margin-bottom: 15px;
      padding-bottom: 10px;
      border-bottom: 1px solid #eee;
    }

    .image-preview {
      width: 100%;
      height: 200px;
      border: 2px dashed #ddd;
      border-radius: 8px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 15px;
      overflow: hidden;
      transition: all 0.3s ease;
    }

    .image-preview:hover {
      border-color: var(--primary-color);
    }

    .image-preview img {
      max-width: 100%;
      max-height: 100%;
      border-radius: 6px;
    }

    .form-check-input {
      width: 1.25em;
      height: 1.25em;
      margin-top: 0.25em;
    }

    .form-check-input:checked {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
    }

    .form-check-label {
      margin-left: 0.5rem;
    }

    .car-type-selector {
      margin-bottom: 20px;
    }

    .car-type-card {
      border: 2px solid #eee;
      border-radius: 8px;
      padding: 15px;
      text-align: center;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .car-type-card.active {
      border-color: var(--primary-color);
      background-color: rgba(52, 152, 219, 0.1);
    }

    .car-type-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    .car-type-card i {
      font-size: 2rem;
      margin-bottom: 10px;
      color: var(--secondary-color);
    }

    .car-type-card.active i {
      color: var(--primary-color);
    }

    .car-type-card h5 {
      margin-bottom: 0;
      font-weight: 500;
    }

    /* Animation effects */
    .fade-in {
      animation: fadeIn 0.5s ease-in-out;
    }

    @keyframes fadeIn {
      0% { opacity: 0; transform: translateY(20px); }
      100% { opacity: 1; transform: translateY(0); }
    }
  </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm mb-4">
  <div class="container">
    <a class="navbar-brand" href="/cars">
      <i class="fas fa-car-side me-2"></i>AutoMarket
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link" href="/cars">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="/cars/create">Add Car</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/profile">My Profile</a>
        </li>
      </ul>
      <div class="d-flex">
        <a href="/logout" class="btn btn-outline-danger">
          <i class="fas fa-sign-out-alt me-1"></i> Logout
        </a>
      </div>
    </div>
  </div>
</nav>
<div class="container">
  <div class="car-form fade-in">
    <div class="form-header">
      <h2><i class="fas fa-car me-2"></i>Add New Car Listing</h2>
      <p class="text-muted">Fill in all the details about the vehicle</p>
    </div>

    <!-- Car Type Selection Cards -->
    <div class="car-type-selector row mb-4">
      <div class="col-md-4">
        <div class="car-type-card active" data-type="standard">
          <i class="fas fa-car"></i>
          <h5>Standard</h5>
          <small class="text-muted">Regular car listing</small>
        </div>
      </div>
      <div class="col-md-4">
        <div class="car-type-card" data-type="used">
          <i class="fas fa-history"></i>
          <h5>Used</h5>
          <small class="text-muted">Pre-owned vehicle</small>
        </div>
      </div>
      <div class="col-md-4">
        <div class="car-type-card" data-type="dealer">
          <i class="fas fa-building"></i>
          <h5>Dealer</h5>
          <small class="text-muted">From dealership</small>
        </div>
      </div>
    </div>

    <form action="/cars/create" method="post">
      <input type="hidden" id="carType" name="carType" value="standard">

      <div class="row">
        <div class="col-md-6">
          <div class="mb-3">
            <label for="make" class="form-label">Make</label>
            <input type="text" class="form-control" id="make" name="make" required>
          </div>
          <div class="mb-3">
            <label for="model" class="form-label">Model</label>
            <input type="text" class="form-control" id="model" name="model" required>
          </div>
          <div class="mb-3">
            <label for="year" class="form-label">Year</label>
            <input type="number" class="form-control" id="year" name="year" min="1900" max="2025" required>
          </div>
          <div class="mb-3">
            <label for="price" class="form-label">Price ($)</label>
            <div class="input-group">
              <span class="input-group-text">$</span>
              <input type="number" class="form-control" id="price" name="price" min="0" step="0.01" required>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="mb-3">
            <label for="mileage" class="form-label">Mileage (km)</label>
            <div class="input-group">
              <input type="number" class="form-control" id="mileage" name="mileage" min="0" required>
              <span class="input-group-text">km</span>
            </div>
          </div>
          <div class="mb-3">
            <label for="transmission" class="form-label">Transmission</label>
            <select class="form-select" id="transmission" name="transmission" required>
              <option value="" selected disabled>Select transmission</option>
              <option value="Automatic">Automatic</option>
              <option value="Manual">Manual</option>
              <option value="Semi-Automatic">Semi-Automatic</option>
            </select>
          </div>
          <div class="mb-3">
            <label for="fuelType" class="form-label">Fuel Type</label>
            <select class="form-select" id="fuelType" name="fuelType" required>
              <option value="" selected disabled>Select fuel type</option>
              <option value="Petrol">Petrol</option>
              <option value="Diesel">Diesel</option>
              <option value="Hybrid">Hybrid</option>
              <option value="Electric">Electric</option>
            </select>
          </div>
          <div class="mb-3">
            <label for="color" class="form-label">Color</label>
            <input type="text" class="form-control" id="color" name="color" required>
          </div>
        </div>
      </div>

      <div class="mb-3">
        <label for="description" class="form-label">Description</label>
        <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
      </div>

      <div class="mb-3">
        <label for="imageUrl" class="form-label">Image URL</label>
        <div class="input-group">
          <span class="input-group-text"><i class="fas fa-image"></i></span>
          <input type="url" class="form-control" id="imageUrl" name="imageUrl" placeholder="https://example.com/car-image.jpg" required>
        </div>
        <small class="form-text text-muted">Enter a URL to an image of the car (e.g., https://example.com/car-image.jpg)</small>
        <div class="image-preview mt-2" id="imagePreview">
          <span class="text-muted">No image URL provided</span>
        </div>
      </div>

      <!-- Used Car Specific Fields -->
      <div id="usedCarFields" style="display: none;">
        <h4 class="section-title"><i class="fas fa-history me-2"></i>Used Car Details</h4>
        <div class="mb-3">
          <label for="history" class="form-label">Vehicle History</label>
          <textarea class="form-control" id="history" name="history" rows="2"></textarea>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="mb-3">
              <label for="previousOwners" class="form-label">Previous Owners</label>
              <input type="number" class="form-control" id="previousOwners" name="previousOwners" min="0" value="1">
            </div>
          </div>
          <div class="col-md-6">
            <div class="mb-3 form-check mt-4">
              <input type="checkbox" class="form-check-input" id="hasAccidentHistory" name="hasAccidentHistory">
              <label class="form-check-label" for="hasAccidentHistory">Has Accident History</label>
            </div>
          </div>
        </div>
      </div>

      <!-- Dealer Car Specific Fields -->
      <div id="dealerCarFields" style="display: none;">
        <h4 class="section-title"><i class="fas fa-building me-2"></i>Dealer Car Details</h4>
        <div class="mb-3">
          <label for="dealershipId" class="form-label">Dealership ID</label>
          <input type="text" class="form-control" id="dealershipId" name="dealershipId">
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="mb-3 form-check">
              <input type="checkbox" class="form-check-input" id="hasWarranty" name="hasWarranty">
              <label class="form-check-label" for="hasWarranty">Has Warranty</label>
            </div>
          </div>
          <div class="col-md-6">
            <div class="mb-3">
              <label for="warrantyMonths" class="form-label">Warranty Period (months)</label>
              <input type="number" class="form-control" id="warrantyMonths" name="warrantyMonths" min="0" value="0">
            </div>
          </div>
        </div>
        <div class="mb-3 form-check">
          <input type="checkbox" class="form-check-input" id="isFinancingAvailable" name="isFinancingAvailable">
          <label class="form-check-label" for="isFinancingAvailable">Financing Available</label>
        </div>
      </div>

      <div class="d-grid gap-2 mt-4">
        <button type="submit" class="btn btn-primary">
          <i class="fas fa-plus-circle me-2"></i>Add Car
        </button>
        <a href="/cars" class="btn btn-outline-secondary">
          <i class="fas fa-arrow-left me-2"></i>Cancel
        </a>
      </div>
    </form>
  </div>
</div>

<footer class="bg-dark text-light py-3 mt-5">
  <div class="container text-center">
    <p class="mb-0">&copy; 2025 AutoMarket. All rights reserved.</p>
  </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Image preview functionality for image URL
  document.getElementById('imageUrl').addEventListener('input', function(event) {
    const preview = document.getElementById('imagePreview');
    preview.innerHTML = '';
    const url = event.target.value;

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

  // Car type selection
  const carTypeCards = document.querySelectorAll('.car-type-card');
  const carTypeInput = document.getElementById('carType');
  const usedCarFields = document.getElementById('usedCarFields');
  const dealerCarFields = document.getElementById('dealerCarFields');

  carTypeCards.forEach(card => {
    card.addEventListener('click', function() {
      // Remove active class from all cards
      carTypeCards.forEach(c => c.classList.remove('active'));

      // Add active class to clicked card
      this.classList.add('active');

      // Update hidden input value
      const type = this.getAttribute('data-type');
      carTypeInput.value = type;

      // Show/hide relevant fields
      usedCarFields.style.display = type === 'used' ? 'block' : 'none';
      dealerCarFields.style.display = type === 'dealer' ? 'block' : 'none';

      // Add animation
      if (type === 'used') {
        usedCarFields.classList.add('fade-in');
        setTimeout(() => usedCarFields.classList.remove('fade-in'), 500);
      } else if (type === 'dealer') {
        dealerCarFields.classList.add('fade-in');
        setTimeout(() => dealerCarFields.classList.remove('fade-in'), 500);
      }
    });
  });
</script>
</body>
</html>
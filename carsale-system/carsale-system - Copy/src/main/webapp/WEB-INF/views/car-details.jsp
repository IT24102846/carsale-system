<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${car.make} ${car.model} ${car.year} | AutoMarket</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    .car-detail-container {
      padding: 40px 0;
    }

    .car-main-image {
      width: 100%;
      height: 400px;
      object-fit: cover;
      border-radius: 10px;
      margin-bottom: 15px;
    }

    .car-thumbnails {
      display: flex;
      gap: 10px;
      margin-bottom: 30px;
      overflow-x: auto;
      padding-bottom: 10px;
    }

    .car-thumbnail {
      width: 100px;
      height: 70px;
      object-fit: cover;
      border-radius: 5px;
      cursor: pointer;
      transition: all 0.3s;
    }

    .car-thumbnail:hover {
      transform: scale(1.05);
    }

    .car-thumbnail.active {
      border: 3px solid #0d6efd;
    }

    .car-info-card {
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 0 15px rgba(0,0,0,0.1);
      padding: 20px;
      height: 100%;
    }

    .car-title {
      margin-bottom: 20px;
    }

    .car-price {
      font-size: 1.8rem;
      color: #0d6efd;
      margin-bottom: 20px;
    }

    .car-features {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 15px;
      margin-bottom: 20px;
    }

    .car-feature {
      display: flex;
      align-items: center;
    }

    .car-feature i {
      width: 30px;
      color: #6c757d;
    }

    .car-actions {
      margin-top: 30px;
    }

    .seller-info {
      margin-top: 20px;
      display: flex;
      align-items: center;
      padding-top: 20px;
      border-top: 1px solid #dee2e6;
    }

    .seller-avatar {
      width: 60px;
      height: 60px;
      border-radius: 50%;
      margin-right: 15px;
      overflow: hidden;
      background-color: #e9ecef;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.5rem;
      color: #6c757d;
    }

    .seller-avatar img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .car-description {
      margin-top: 30px;
    }

    .similar-cars {
      margin-top: 50px;
    }

    .car-card {
      border: none;
      box-shadow: 0 0 15px rgba(0,0,0,0.1);
      border-radius: 10px;
      overflow: hidden;
      transition: transform 0.3s;
      margin-bottom: 30px;
    }

    .car-card:hover {
      transform: translateY(-10px);
    }

    .car-card-img {
      height: 160px;
      object-fit: cover;
    }

    /* Booking Form */
    .booking-form {
      background-color: #f8f9fa;
      border-radius: 10px;
      padding: 20px;
      margin-top: 30px;
    }

    /* Reviews Section */
    .reviews-section {
      margin-top: 50px;
    }

    .review-card {
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.05);
      padding: 20px;
      margin-bottom: 20px;
    }

    .review-header {
      display: flex;
      align-items: center;
      margin-bottom: 15px;
    }

    .reviewer-avatar {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      background-color: #e9ecef;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 10px;
      font-size: 1rem;
      color: #6c757d;
    }

    .review-rating {
      color: #ffc107;
      margin-left: auto;
    }

    .review-date {
      font-size: 0.8rem;
      color: #6c757d;
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
<div class="container car-detail-container">
  <div class="row">
    <!-- Car Images Section -->
    <div class="col-md-8">
      <img src="/uploads/${car.images[0]}" alt="${car.make} ${car.model}" class="car-main-image" id="mainImage">

      <div class="car-thumbnails">
        <c:forEach items="${car.images}" var="image" varStatus="loop">
          <img src="/uploads/${image}" alt="${car.make} ${car.model}" class="car-thumbnail ${loop.index == 0 ? 'active' : ''}" onclick="changeMainImage(this.src)">
        </c:forEach>
      </div>

      <div class="car-info-card car-description">
        <h4>Description</h4>
        <p>${car.description}</p>

        <!-- Additional details based on car type -->
        <c:if test="${car['class'].simpleName == 'UsedCar'}">
          <div class="mt-4">
            <h5>Vehicle History</h5>
            <p>${car.history}</p>
            <p><strong>Previous Owners:</strong> ${car.previousOwners}</p>
            <p><strong>Accident History:</strong> ${car.hasAccidentHistory ? 'Yes' : 'No'}</p>
          </div>
        </c:if>

        <c:if test="${car['class'].simpleName == 'DealerCar'}">
          <div class="mt-4">
            <h5>Dealer Information</h5>
            <p><strong>Warranty:</strong> ${car.hasWarranty ? 'Yes, ' : 'No'}${car.hasWarranty ? car.warrantyMonths : ''} ${car.hasWarranty ? 'months' : ''}</p>
            <p><strong>Financing Available:</strong> ${car.isFinancingAvailable ? 'Yes' : 'No'}</p>
          </div>
        </c:if>
      </div>
    </div>

    <!-- Car Info and Actions Section -->
    <div class="col-md-4">
      <div class="car-info-card">
        <div class="car-title">
          <h3>${car.year} ${car.make} ${car.model}</h3>
          <p class="text-muted">${car.condition} ${car['class'].simpleName == 'UsedCar' ? '• Used' : ''}${car['class'].simpleName == 'DealerCar' ? '• Dealership' : ''}</p>
        </div>

        <div class="car-price">
          $${car.price}
        </div>

        <div class="car-features">
          <div class="car-feature">
            <i class="fas fa-calendar-alt"></i>
            <span>${car.year}</span>
          </div>
          <div class="car-feature">
            <i class="fas fa-tachometer-alt"></i>
            <span>${car.mileage} km</span>
          </div>
          <div class="car-feature">
            <i class="fas fa-cog"></i>
            <span>${car.transmission}</span>
          </div>
          <div class="car-feature">
            <i class="fas fa-gas-pump"></i>
            <span>${car.fuelType}</span>
          </div>
          <div class="car-feature">
            <i class="fas fa-palette"></i>
            <span>${car.color}</span>
          </div>
          <div class="car-feature">
            <i class="fas fa-check-circle"></i>
            <span>${car.available ? 'Available' : 'Booked'}</span>
          </div>
        </div>

        <div class="car-actions">
          <c:choose>
            <c:when test="${car.available}">
              <a href="/bookings/create?carId=${car.id}" class="btn btn-primary btn-lg w-100 mb-3">Book Now</a>
            </c:when>
            <c:otherwise>
              <button class="btn btn-secondary btn-lg w-100 mb-3" disabled>Currently Unavailable</button>
            </c:otherwise>
          </c:choose>
          <a href="/contact-seller?carId=${car.id}" class="btn btn-outline-primary w-100 mb-3">Contact Seller</a>
          <button class="btn btn-outline-danger w-100" id="saveButton">
            <i class="far fa-heart"></i> Save for Later
          </button>
        </div>

        <div class="seller-info">
          <div class="seller-avatar">
            <c:choose>
              <c:when test="${not empty seller.profileImage}">
                <img src="/uploads/profiles/${seller.profileImage}" alt="${seller.name}">
              </c:when>
              <c:otherwise>
                <i class="fas fa-user"></i>
              </c:otherwise>
            </c:choose>
          </div>
          <div>
            <h5 class="mb-0">${seller.name}</h5>
            <p class="text-muted mb-0">${seller.role == 'DEALER' ? 'Dealer' : 'Private Seller'}</p>
          </div>
        </div>
      </div>

      <!-- Car Location Map -->
      <div class="car-info-card mt-3">
        <h5>Car Location</h5>
        <div style="width: 100%; height: 200px; background-color: #e9ecef; border-radius: 5px; display: flex; align-items: center; justify-content: center;">
          <i class="fas fa-map-marker-alt fa-2x text-muted"></i>
        </div>
        <p class="text-center mt-2">City, Country</p>
      </div>
    </div>
  </div>

  <!-- Reviews Section -->
  <div class="reviews-section">
    <h4 class="mb-3">Customer Reviews</h4>

    <c:choose>
      <c:when test="${not empty reviews}">
        <c:forEach items="${reviews}" var="review">
          <div class="review-card">
            <div class="review-header">
              <div class="reviewer-avatar">
                <i class="fas fa-user"></i>
              </div>
              <div>
                <h6 class="mb-0">${review.userId}</h6>
                <p class="review-date">${review.feedbackDate}</p>
              </div>
              <div class="review-rating">
                <c:forEach begin="1" end="5" var="i">
                  <i class="fas fa-star ${i <= review.rating ? '' : 'text-muted'}"></i>
                </c:forEach>
              </div>
            </div>
            <p>${review.comment}</p>
          </div>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <div class="alert alert-info">
          No reviews yet. Be the first to review this car!
        </div>
      </c:otherwise>
    </c:choose>

    <!-- Review Form (for logged-in buyers) -->
    <c:if test="${not empty sessionScope.user && sessionScope.user.role == 'BUYER'}">
      <div class="car-info-card mt-4">
        <h5>Write a Review</h5>
        <form action="/car/review" method="post">
          <input type="hidden" name="carId" value="${car.id}">

          <div class="mb-3">
            <label class="form-label">Rating</label>
            <div class="rating-stars d-flex">
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="rating" id="rating1" value="1" required>
                <label class="form-check-label" for="rating1">1</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="rating" id="rating2" value="2">
                <label class="form-check-label" for="rating2">2</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="rating" id="rating3" value="3">
                <label class="form-check-label" for="rating3">3</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="rating" id="rating4" value="4">
                <label class="form-check-label" for="rating4">4</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="rating" id="rating5" value="5">
                <label class="form-check-label" for="rating5">5</label>
              </div>
            </div>
          </div>

          <div class="mb-3">
            <label for="comment" class="form-label">Comment</label>
            <textarea class="form-control" id="comment" name="comment" rows="3" required></textarea>
          </div>

          <button type="submit" class="btn btn-primary">Submit Review</button>
        </form>
      </div>
    </c:if>
  </div>

  <!-- Similar Cars Section -->
  <div class="similar-cars">
    <h4 class="mb-3">Similar Cars</h4>

    <div class="row">
      <c:forEach items="${similarCars}" var="similarCar">
        <div class="col-md-3 mb-4">
          <div class="card car-card">
            <img src="/uploads/${similarCar.images[0]}" class="card-img-top car-card-img" alt="${similarCar.make} ${similarCar.model}">
            <div class="card-body">
              <h6 class="card-title">${similarCar.year} ${similarCar.make} ${similarCar.model}</h6>
              <div class="d-flex justify-content-between">
                <p class="text-muted mb-0">${similarCar.mileage} km</p>
                <p class="text-primary fw-bold mb-0">$${similarCar.price}</p>
              </div>
              <a href="/car?id=${similarCar.id}" class="btn btn-sm btn-outline-primary mt-2 w-100">View Details</a>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Function to change the main image
  function changeMainImage(src) {
    document.getElementById('mainImage').src = src;

    // Update active thumbnail
    const thumbnails = document.querySelectorAll('.car-thumbnail');
    thumbnails.forEach(thumb => {
      if (thumb.src === src) {
        thumb.classList.add('active');
      } else {
        thumb.classList.remove('active');
      }
    });
  }

  // Handle save button toggle
  document.getElementById('saveButton').addEventListener('click', function() {
    const icon = this.querySelector('i');

    if (icon.classList.contains('far')) {
      icon.classList.remove('far');
      icon.classList.add('fas');
      this.classList.remove('btn-outline-danger');
      this.classList.add('btn-danger');
      this.innerHTML = '<i class="fas fa-heart"></i> Saved';
    } else {
      icon.classList.remove('fas');
      icon.classList.add('far');
      this.classList.remove('btn-danger');
      this.classList.add('btn-outline-danger');
      this.innerHTML = '<i class="far fa-heart"></i> Save for Later';
    }
  });
</script>
</body>
</html>
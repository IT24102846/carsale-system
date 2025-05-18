<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>AutoMarket - Your Trusted Car Marketplace</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    /* Hero Section */
    .hero {
      background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('https://unsplash.com/photos/xZJ28Ll-G8c/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8NDN8fHNwb3J0cyUyMGNhciUyMHdpdGglMjBkYXJrJTIwYmFja2dyb3VuZHxlbnwwfHx8fDE3NDc1NTcxMjl8MA&force=true');
      height: 70vh;
      background-position: center;
      background-repeat: no-repeat;
      background-size: cover;
      position: relative;
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      text-align: center;
    }
    .hero-content {
      max-width: 800px;
      padding: 20px;
    }
    .hero h1 {
      font-size: 4rem;
      font-weight: 700;
      margin-bottom: 20px;
    }
    .hero p {
      font-size: 1.5rem;
      margin-bottom: 30px;
    }

    /* Feature Section */
    .feature-section {
      padding: 80px 0;
    }
    .feature-card {
      text-align: center;
      padding: 30px 20px;
      border-radius: 10px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
      transition: transform 0.3s;
      height: 100%;
    }
    .feature-card:hover {
      transform: translateY(-10px);
    }
    .feature-icon {
      font-size: 3rem;
      color: #0d6efd;
      margin-bottom: 20px;
    }

    /* Car Types Section */
    .car-types {
      background-color: #f8f9fa;
      padding: 80px 0;
    }
    .car-type-card {
      position: relative;
      border-radius: 10px;
      overflow: hidden;
      margin-bottom: 30px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }
    .car-type-img {
      height: 250px;
      width: 100%;
      object-fit: cover;
    }
    .car-type-overlay {
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      background-color: rgba(0, 0, 0, 0.7);
      color: white;
      padding: 20px;
      transition: height 0.3s;
      height: 80px;
    }
    .car-type-card:hover .car-type-overlay {
      height: 150px;
    }
    .car-type-title {
      font-size: 1.5rem;
      margin-bottom: 10px;
    }
    .car-type-description {
      opacity: 0;
      transition: opacity 0.3s;
      margin-bottom: 0;
    }
    .car-type-card:hover .car-type-description {
      opacity: 1;
    }

    /* CTA Section */
    .cta-section {
      padding: 100px 0;
      background-image: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1511919884226-fd3cad34687c?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80');
      background-position: center;
      background-repeat: no-repeat;
      background-size: cover;
      color: white;
      text-align: center;
    }
    .cta-section h2 {
      font-size: 3rem;
      margin-bottom: 20px;
    }
    .cta-section p {
      font-size: 1.2rem;
      margin-bottom: 30px;
      max-width: 700px;
      margin-left: auto;
      margin-right: auto;
    }

    /* Footer */
    footer {
      padding: 50px 0;
      background-color: #343a40;
      color: white;
    }
    .footer-links {
      list-style: none;
      padding-left: 0;
    }
    .footer-links li {
      margin-bottom: 10px;
    }
    .footer-links a {
      color: rgba(255, 255, 255, 0.7);
      text-decoration: none;
      transition: color 0.3s;
    }
    .footer-links a:hover {
      color: white;
    }
    .social-icons {
      font-size: 1.5rem;
    }
    .social-icons a {
      color: rgba(255, 255, 255, 0.7);
      margin-right: 15px;
      transition: color 0.3s;
    }
    .social-icons a:hover {
      color: white;
    }
  </style>
</head>
<!-- HEADER: Add at the beginning of the <body> section in all JSP files -->
<header>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <a class="navbar-brand" href="/">Auto market</a>
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
<!-- Navbar -->


<!-- Hero Section -->
<section class="hero">
  <div class="hero-content">
    <h1>Find Your Perfect Car</h1>
    <p>AutoMarket connects buyers and sellers for a seamless car shopping experience.</p>
    <a href="/cars" class="btn btn-primary btn-lg">Browse Cars</a>
    <a href="/register" class="btn btn-outline-light btn-lg ms-2">Sell Your Car</a>
  </div>
</section>

<!-- Feature Section -->
<section class="feature-section">
  <div class="container">
    <div class="text-center mb-5">
      <h2>Why Choose AutoMarket?</h2>
      <p class="lead">We make car buying and selling simple, secure, and stress-free.</p>
    </div>
    <div class="row">
      <div class="col-md-4 mb-4">
        <div class="feature-card">
          <div class="feature-icon">
            <i class="fas fa-car"></i>
          </div>
          <h3>Wide Selection</h3>
          <p>Browse thousands of cars from private sellers and dealerships all in one place.</p>
        </div>
      </div>
      <div class="col-md-4 mb-4">
        <div class="feature-card">
          <div class="feature-icon">
            <i class="fas fa-shield-alt"></i>
          </div>
          <h3>Secure Transactions</h3>
          <p>Our secure platform ensures safe and reliable transactions for both buyers and sellers.</p>
        </div>
      </div>
      <div class="col-md-4 mb-4">
        <div class="feature-card">
          <div class="feature-icon">
            <i class="fas fa-star"></i>
          </div>
          <h3>Verified Reviews</h3>
          <p>Read honest reviews from real buyers to help you make informed decisions.</p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Car Types Section -->
<section class="car-types">
  <div class="container">
    <div class="text-center mb-5">
      <h2>Explore Car Types</h2>
      <p class="lead">Find the perfect vehicle to fit your lifestyle and needs.</p>
    </div>
    <div class="row">
      <div class="col-md-4">
        <div class="car-type-card">
          <img src="https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" class="car-type-img" alt="SUV">
          <div class="car-type-overlay">
            <h3 class="car-type-title">SUVs</h3>
            <p class="car-type-description">Perfect for families and adventures, SUVs offer space, safety, and versatility.</p>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="car-type-card">
          <img src="https://images.unsplash.com/photo-1552519507-da3b142c6e3d?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" class="car-type-img" alt="Sedan">
          <div class="car-type-overlay">
            <h3 class="car-type-title">Sedans</h3>
            <p class="car-type-description">Reliable, efficient, and comfortable for everyday driving and commuting.</p>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="car-type-card">
          <img src="https://images.unsplash.com/photo-1614200179396-2bdb77ebf81b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" class="car-type-img" alt="Luxury">
          <div class="car-type-overlay">
            <h3 class="car-type-title">Luxury</h3>
            <p class="car-type-description">Experience ultimate comfort, performance, and prestige with luxury vehicles.</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- CTA Section -->
<section class="cta-section">
  <div class="container">
    <h2>Ready to Buy or Sell?</h2>
    <p>Whether you're looking for your dream car or want to sell your current vehicle, AutoMarket makes it easy.</p>
    <a href="/register" class="btn btn-primary btn-lg">Get Started Today</a>
  </div>
</section>

<!-- Footer -->
<footer>
  <div class="container">
    <div class="row">
      <div class="col-md-4 mb-4">
        <h5>AutoMarket</h5>
        <p>The trusted marketplace for buying and selling cars. We connect car enthusiasts and make transactions simple and secure.</p>
        <div class="social-icons">
          <a href="#"><i class="fab fa-facebook"></i></a>
          <a href="#"><i class="fab fa-twitter"></i></a>
          <a href="#"><i class="fab fa-instagram"></i></a>
          <a href="#"><i class="fab fa-linkedin"></i></a>
        </div>
      </div>
      <div class="col-md-2 mb-4">
        <h5>Quick Links</h5>
        <ul class="footer-links">
          <li><a href="/">Home</a></li>
          <li><a href="/cars">Cars</a></li>
          <li><a href="/register">Sell Car</a></li>
          <li><a href="/feedback">Feedback</a></li>
        </ul>
      </div>
      <div class="col-md-2 mb-4">
        <h5>About</h5>
        <ul class="footer-links">
          <li><a href="#">About Us</a></li>
          <li><a href="#">How It Works</a></li>
          <li><a href="#">FAQs</a></li>
          <li><a href="#">Contact Us</a></li>
        </ul>
      </div>
      <div class="col-md-4">
        <h5>Newsletter</h5>
        <p>Stay updated with our latest deals and news.</p>
        <form class="mb-3">
          <div class="input-group">
            <input type="email" class="form-control" placeholder="Your Email">
            <button class="btn btn-primary" type="submit">Subscribe</button>
          </div>
        </form>
      </div>
    </div>
    <hr class="mt-4 mb-4" style="background-color: rgba(255, 255, 255, 0.2);">
    <div class="row">
      <div class="col-md-6 text-center text-md-start">
        <p class="mb-0">&copy; 2025 AutoMarket. All rights reserved.</p>
      </div>
      <div class="col-md-6 text-center text-md-end">
        <p class="mb-0">
          <a href="#" class="text-white me-3">Privacy Policy</a>
          <a href="#" class="text-white">Terms of Service</a>
        </p>
      </div>
    </div>
  </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
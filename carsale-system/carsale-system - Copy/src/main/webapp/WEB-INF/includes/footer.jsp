<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Footer | AutoMarket</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    footer {
      background-color: #343a40;
      color: white;
      padding: 50px 0 20px;
    }

    .footer-links h5 {
      margin-bottom: 20px;
      border-bottom: 2px solid #0d6efd;
      padding-bottom: 10px;
      display: inline-block;
    }

    .footer-links ul {
      list-style: none;
      padding-left: 0;
    }

    .footer-links ul li {
      margin-bottom: 10px;
    }

    .footer-links ul li a {
      color: #adb5bd;
      text-decoration: none;
      transition: color 0.3s;
    }

    .footer-links ul li a:hover {
      color: white;
    }

    .social-links {
      display: flex;
      gap: 15px;
      margin-top: 20px;
    }

    .social-links a {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      background-color: #495057;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      text-decoration: none;
      transition: background-color 0.3s;
    }

    .social-links a:hover {
      background-color: #0d6efd;
    }

    .copyright {
      border-top: 1px solid #495057;
      padding-top: 20px;
      margin-top: 30px;
      text-align: center;
      color: #adb5bd;
    }

    .subscribe-form {
      position: relative;
    }

    .subscribe-form input {
      border-radius: 30px;
      padding-right: 50px;
      background-color: #495057;
      border: none;
      color: white;
    }

    .subscribe-form input::placeholder {
      color: #adb5bd;
    }

    .subscribe-form button {
      position: absolute;
      right: 5px;
      top: 5px;
      border-radius: 50%;
      width: 30px;
      height: 30px;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 0;
    }
  </style>
</head>
<body>
<footer>
  <div class="container">
    <div class="row">
      <div class="col-md-4 mb-4">
        <h4>AutoMarket</h4>
        <p>Your trusted platform for buying and selling cars. We make the process easy, secure, and transparent.</p>
        <div class="social-links">
          <a href="#"><i class="fab fa-facebook-f"></i></a>
          <a href="#"><i class="fab fa-twitter"></i></a>
          <a href="#"><i class="fab fa-instagram"></i></a>
          <a href="#"><i class="fab fa-linkedin-in"></i></a>
        </div>
      </div>
      <div class="col-md-2 mb-4 footer-links">
        <h5>Quick Links</h5>
        <ul>
          <li><a href="/">Home</a></li>
          <li><a href="/cars">Browse Cars</a></li>
          <li><a href="/sell">Sell Your Car</a></li>
          <li><a href="/about">About Us</a></li>
          <li><a href="/contact">Contact Us</a></li>
        </ul>
      </div>
      <div class="col-md-2 mb-4 footer-links">
        <h5>Resources</h5>
        <ul>
          <li><a href="/blog">Blog</a></li>
          <li><a href="/how-it-works">How It Works</a></li>
          <li><a href="/faq">FAQ</a></li>
          <li><a href="/testimonials">Testimonials</a></li>
        </ul>
      </div>
      <div class="col-md-4 mb-4 footer-links">
        <h5>Newsletter</h5>
        <p>Subscribe to our newsletter for the latest updates and offers.</p>
        <form class="subscribe-form">
          <div class="input-group mb-3">
            <input type="email" class="form-control" placeholder="Your email address" aria-label="Email address" required>
            <button class="btn btn-primary" type="submit"><i class="fas fa-arrow-right"></i></button>
          </div>
        </form>
        <h5 class="mt-4">Contact Info</h5>
        <ul>
          <li><i class="fas fa-map-marker-alt me-2"></i> 123 Main St, City, Country</li>
          <li><i class="fas fa-phone me-2"></i> +1 (123) 456-7890</li>
          <li><i class="fas fa-envelope me-2"></i> info@automarket.com</li>
          <li><i class="fas fa-clock me-2"></i> Mon-Fri: 9AM - 5PM</li>
        </ul>
      </div>
    </div>
    <div class="copyright">
      <p>&copy; 2025 AutoMarket. All rights reserved.</p>
    </div>
  </div>
</footer>
</body>
</html>ca
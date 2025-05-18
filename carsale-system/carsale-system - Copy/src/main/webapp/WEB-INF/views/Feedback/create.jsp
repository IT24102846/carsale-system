<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Create Feedback | AutoMarket</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    .feedback-form {
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
    .rating {
      display: flex;
      flex-direction: row-reverse;
      justify-content: center;
      margin-bottom: 20px;
    }
    .rating > input {
      display: none;
    }
    .rating > label {
      position: relative;
      width: 1.1em;
      font-size: 2.5rem;
      color: #ccc;
      cursor: pointer;
    }
    .rating > label::before {
      content: "\2605";
      position: absolute;
      opacity: 0;
    }
    .rating > label:hover:before,
    .rating > label:hover ~ label:before {
      opacity: 1 !important;
    }
    .rating > input:checked ~ label:before {
      opacity: 1;
    }
    .rating:hover > input:checked ~ label:before {
      opacity: 0.4;
    }
    .rating > label {
      color: #ddd;
    }
    .rating > input:checked ~ label {
      color: #ffc107;
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
  <div class="feedback-form">
    <div class="form-header">
      <h2>Create Feedback</h2>
      <p class="text-muted">Share your experience</p>
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

    <form action="/feedback/create" method="post">
      <div class="mb-3">
        <label for="username" class="form-label">Username</label>
        <input type="text" class="form-control" id="username" name="username"
               value="${sessionScope.username}" required>
      </div>

      <div class="mb-3 text-center">
        <label class="form-label d-block">Rating</label>
        <div class="rating">
          <input type="radio" id="star5" name="rating" value="5" /><label for="star5" title="5 stars"></label>
          <input type="radio" id="star4" name="rating" value="4" /><label for="star4" title="4 stars"></label>
          <input type="radio" id="star3" name="rating" value="3" checked /><label for="star3" title="3 stars"></label>
          <input type="radio" id="star2" name="rating" value="2" /><label for="star2" title="2 stars"></label>
          <input type="radio" id="star1" name="rating" value="1" /><label for="star1" title="1 star"></label>
        </div>
      </div>

      <div class="mb-3">
        <label for="comment" class="form-label">Comment</label>
        <textarea class="form-control" id="comment" name="comment" rows="4" required></textarea>
      </div>

      <div class="d-grid gap-2 mt-4">
        <button type="submit" class="btn btn-primary">Submit Feedback</button>
        <a href="/feedback" class="btn btn-outline-secondary">Cancel</a>
      </div>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
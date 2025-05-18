<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Error | AutoMarket</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    body {
      background-color: #f8f9fa;
      min-height: 100vh;
      display: flex;
      align-items: center;
    }
    .error-container {
      text-align: center;
      padding: 40px;
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
      max-width: 600px;
      margin: 0 auto;
    }
    .error-icon {
      font-size: 5rem;
      color: #dc3545;
      margin-bottom: 20px;
    }
    .error-code {
      font-size: 3rem;
      font-weight: 700;
      margin-bottom: 10px;
    }
    .error-message {
      font-size: 1.5rem;
      margin-bottom: 30px;
    }
    .error-detail {
      margin-bottom: 30px;
      color: #6c757d;
    }
    .btn-home {
      font-size: 1.1rem;
      padding: 10px 30px;
    }
  </style>
</head>
<body>
<div class="container">
  <div class="error-container">
    <div class="error-icon">
      <i class="fas fa-exclamation-triangle"></i>
    </div>
    <div class="error-code">${statusCode}</div>
    <div class="error-message">${errorMessage}</div>
    <div class="error-detail">
      <p>We're sorry, something went wrong while processing your request.</p>
      <p>Timestamp: ${timestamp}</p>
    </div>
    <a href="/" class="btn btn-primary btn-home">Back to Home</a>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
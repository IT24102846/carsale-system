<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Car Listings | AutoMarket</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .car-container {
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.05);
            margin-bottom: 20px;
        }
        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .car-card {
            transition: transform 0.3s;
            margin-bottom: 20px;
            border: none;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            height: 100%;
        }
        .car-card:hover {
            transform: translateY(-5px);
        }
        .car-img {
            height: 180px;
            object-fit: cover;
        }
        .filters {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .card-body {
            padding: 1.25rem;
        }
        .card-footer {
            padding: 0.75rem 1.25rem;
            background-color: rgba(0,0,0,.03);
            border-top: 1px solid rgba(0,0,0,.125);
        }
        .badge {
            font-size: 0.8rem;
            padding: 0.35em 0.65em;
        }
        .price-tag {
            font-weight: bold;
            color: #3498db;
            font-size: 1.25rem;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <div class="car-container">
        <div class="table-header">
            <h2>Car Listings</h2>
            <c:if test="${sessionScope.role == 'SELLER' || sessionScope.role == 'DEALER' || sessionScope.role == 'ADMIN'}">
                <a href="/cars/create" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add New Car
                </a>
            </c:if>
        </div>

        <!-- Filters -->
        <div class="filters">
            <form method="get" action="/cars" class="row g-3">
                <div class="col-md-3">
                    <label for="brand" class="form-label">Brand</label>
                    <input type="text" class="form-control" id="brand" name="brand" value="${param.brand}">
                </div>
                <div class="col-md-3">
                    <label for="minPrice" class="form-label">Min Price</label>
                    <input type="number" class="form-control" id="minPrice" name="minPrice" value="${param.minPrice}">
                </div>
                <div class="col-md-3">
                    <label for="maxPrice" class="form-label">Max Price</label>
                    <input type="number" class="form-control" id="maxPrice" name="maxPrice" value="${param.maxPrice}">
                </div>
                <div class="col-md-2">
                    <label for="sortBy" class="form-label">Sort By</label>
                    <select class="form-select" id="sortBy" name="sortBy">
                        <option value="">Default</option>
                        <option value="price" ${param.sortBy == 'price' ? 'selected' : ''}>Price</option>
                    </select>
                </div>
                <div class="col-md-1 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">Filter</button>
                </div>
            </form>
        </div>

        <!-- Car Listings -->
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <c:forEach items="${cars}" var="car">
                <div class="col">
                    <div class="card car-card h-100">
                        <c:choose>
                            <c:when test="${not empty car.imageUrl}">
                                <img src="${car.imageUrl}" class="card-img-top car-img" alt="${car.brand} ${car.model}" onerror="this.src='https://via.placeholder.com/400x200?text=No+Image';this.onerror='';">
                            </c:when>
                            <c:otherwise>
                                <img src="https://via.placeholder.com/400x200?text=No+Image" class="card-img-top car-img" alt="No Image Available">
                            </c:otherwise>
                        </c:choose>
                        <div class="card-body">
                            <h5 class="card-title">${car.brand} ${car.model} (${car.year})</h5>
                            <p class="card-text text-muted">${car.mileage} km | ${car.condition}</p>
                            <p class="card-text">${car.description}</p>
                        </div>
                        <div class="card-footer">
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="price-tag">$${car.price}</span>
                                <div class="action-btns">
                                    <c:if test="${sessionScope.userId == car.sellerId || sessionScope.role == 'ADMIN'}">
                                        <a href="/cars/edit?id=${car.carId}" class="btn btn-sm btn-warning">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <a href="/cars/delete?id=${car.carId}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this car?');">
                                            <i class="fas fa-trash"></i> Delete
                                        </a>
                                    </c:if>
                                    <a href="/car?id=${car.carId}" class="btn btn-sm btn-info">
                                        <i class="fas fa-eye"></i> View
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- If no cars are available -->
        <c:if test="${empty cars}">
            <div class="alert alert-info text-center mt-4">
                No cars available that match your criteria.
                <c:if test="${sessionScope.role == 'SELLER' || sessionScope.role == 'DEALER' || sessionScope.role == 'ADMIN'}">
                    <a href="/cars/create">Add a new car</a> to get started!
                </c:if>
            </div>
        </c:if>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Handle image loading errors
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.car-img').forEach(img => {
            img.onerror = function() {
                this.src = 'https://via.placeholder.com/400x200?text=No+Image';
                this.onerror = '';
            };
        });
    });
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Dashboard | AutoMarket</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    body {
      background-color: #f8f9fa;
    }
    .dashboard-container {
      padding: 30px 0;
    }
    .dashboard-header {
      margin-bottom: 30px;
    }
    .dashboard-card {
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 0 15px rgba(0,0,0,0.05);
      padding: 20px;
      height: 100%;
      transition: transform 0.3s;
    }
    .dashboard-card:hover {
      transform: translateY(-5px);
    }
    .stat-card {
      padding: 20px;
      border-radius: 10px;
      margin-bottom: 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .stat-card i {
      font-size: 2.5rem;
      margin-right: 15px;
    }
    .stat-card-purple {
      background-color: #7952b3;
      color: white;
    }
    .stat-card-blue {
      background-color: #0d6efd;
      color: white;
    }
    .stat-card-green {
      background-color: #198754;
      color: white;
    }
    .stat-card-orange {
      background-color: #fd7e14;
      color: white;
    }
    .stat-number {
      font-size: 1.8rem;
      font-weight: bold;
      margin: 0;
    }
    .stat-label {
      text-transform: uppercase;
      font-size: 0.8rem;
      margin: 0;
    }
    .recent-activity {
      margin-top: 30px;
    }
    .activity-item {
      display: flex;
      align-items: center;
      padding: 15px 0;
      border-bottom: 1px solid #eee;
    }
    .activity-icon {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      background-color: #e9ecef;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 15px;
    }
    .activity-content {
      flex-grow: 1;
    }
    .activity-time {
      color: #6c757d;
      font-size: 0.8rem;
    }
    .quick-actions {
      margin-top: 30px;
    }
    .action-btn {
      display: flex;
      flex-direction: column;
      align-items: center;
      padding: 15px;
      border-radius: 10px;
      background-color: #f8f9fa;
      margin-bottom: 10px;
      text-decoration: none;
      color: #212529;
      transition: all 0.3s;
    }
    .action-btn:hover {
      background-color: #e9ecef;
      transform: translateY(-3px);
    }
    .action-btn i {
      font-size: 2rem;
      margin-bottom: 10px;
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
<div class="container dashboard-container">
  <div class="dashboard-header">
    <h2>Welcome back, ${user.name}!</h2>
    <p class="text-muted">Here's what's happening with your account today.</p>
  </div>

  <div class="row">
    <!-- Statistics Cards - Content depends on user role -->
    <c:choose>
      <c:when test="${user.role == 'ADMIN'}">
        <div class="col-md-3 col-sm-6 mb-4">
          <div class="stat-card stat-card-purple">
            <div>
              <p class="stat-number">${totalUsers}</p>
              <p class="stat-label">Total Users</p>
            </div>
            <i class="fas fa-users"></i>
          </div>
        </div>
        <div class="col-md-3 col-sm-6 mb-4">
          <div class="stat-card stat-card-blue">
            <div>
              <p class="stat-number">${totalCars}</p>
              <p class="stat-label">Total Cars</p>
            </div>
            <i class="fas fa-car"></i>
          </div>
        </div>
        <div class="col-md-3 col-sm-6 mb-4">
          <div class="stat-card stat-card-green">
            <div>
              <p class="stat-number">${totalBookings}</p>
              <p class="stat-label">Total Bookings</p>
            </div>
            <i class="fas fa-calendar-check"></i>
          </div>
        </div>
        <div class="col-md-3 col-sm-6 mb-4">
          <div class="stat-card stat-card-orange">
            <div>
              <p class="stat-number">${totalRevenue}</p>
              <p class="stat-label">Total Revenue</p>
            </div>
            <i class="fas fa-dollar-sign"></i>
          </div>
        </div>
      </c:when>
      <c:when test="${user.role == 'SELLER' || user.role == 'DEALER'}">
        <div class="col-md-3 col-sm-6 mb-4">
          <div class="stat-card stat-card-purple">
            <div>
              <p class="stat-number">${totalCars}</p>
              <p class="stat-label">Total Cars</p>
            </div>
            <i class="fas fa-car"></i>
          </div>
        </div>
        <div class="col-md-3 col-sm-6 mb-4">
          <div class="stat-card stat-card-blue">
            <div>
              <p class="stat-number">${availableCars}</p>
              <p class="stat-label">Available Cars</p>
            </div>
            <i class="fas fa-check-circle"></i>
          </div>
        </div>
        <div class="col-md-3 col-sm-6 mb-4">
          <div class="stat-card stat-card-green">
            <div>
              <p class="stat-number">${totalBookings}</p>
              <p class="stat-label">Total Bookings</p>
            </div>
            <i class="fas fa-calendar-check"></i>
          </div>
        </div>
        <div class="col-md-3 col-sm-6 mb-4">
          <div class="stat-card stat-card-orange">
            <div>
              <p class="stat-number">${totalRevenue}</p>
              <p class="stat-label">Total Revenue</p>
            </div>
            <i class="fas fa-dollar-sign"></i>
          </div>
        </div>
      </c:when>
      <c:when test="${user.role == 'BUYER'}">
        <div class="col-md-4 col-sm-6 mb-4">
          <div class="stat-card stat-card-purple">
            <div>
              <p class="stat-number">${totalBookings}</p>
              <p class="stat-label">My Bookings</p>
            </div>
            <i class="fas fa-calendar-check"></i>
          </div>
        </div>
        <div class="col-md-4 col-sm-6 mb-4">
          <div class="stat-card stat-card-green">
            <div>
              <p class="stat-number">${completedBookings}</p>
              <p class="stat-label">Completed</p>
            </div>
            <i class="fas fa-check-circle"></i>
          </div>
        </div>
        <div class="col-md-4 col-sm-6 mb-4">
          <div class="stat-card stat-card-orange">
            <div>
              <p class="stat-number">${totalSpent}</p>
              <p class="stat-label">Total Spent</p>
            </div>
            <i class="fas fa-dollar-sign"></i>
          </div>
        </div>
      </c:when>
    </c:choose>
  </div>

  <div class="row">
    <!-- Quick Actions Section -->
    <div class="col-md-4">
      <div class="dashboard-card">
        <h4>Quick Actions</h4>
        <div class="quick-actions">
          <c:choose>
            <c:when test="${user.role == 'ADMIN'}">
              <a href="/admin/users" class="action-btn">
                <i class="fas fa-users"></i>
                <span>Manage Users</span>
              </a>
              <a href="/admin/cars" class="action-btn">
                <i class="fas fa-car"></i>
                <span>Manage Cars</span>
              </a>
              <a href="/admin/bookings" class="action-btn">
                <i class="fas fa-calendar-check"></i>
                <span>Manage Bookings</span>
              </a>
              <a href="/admin/reports" class="action-btn">
                <i class="fas fa-chart-bar"></i>
                <span>View Reports</span>
              </a>
            </c:when>
            <c:when test="${user.role == 'SELLER' || user.role == 'DEALER'}">
              <a href="/cars/create" class="action-btn">
                <i class="fas fa-plus-circle"></i>
                <span>Add New Car</span>
              </a>
              <a href="/my-cars" class="action-btn">
                <i class="fas fa-car"></i>
                <span>My Cars</span>
              </a>
              <a href="/my-bookings" class="action-btn">
                <i class="fas fa-calendar-check"></i>
                <span>Booking Requests</span>
              </a>
              <a href="/profile" class="action-btn">
                <i class="fas fa-user-edit"></i>
                <span>Edit Profile</span>
              </a>
            </c:when>
            <c:when test="${user.role == 'BUYER'}">
              <a href="/cars" class="action-btn">
                <i class="fas fa-search"></i>
                <span>Browse Cars</span>
              </a>
              <a href="/my-bookings" class="action-btn">
                <i class="fas fa-calendar-check"></i>
                <span>My Bookings</span>
              </a>
              <a href="/payments" class="action-btn">
                <i class="fas fa-credit-card"></i>
                <span>Payment History</span>
              </a>
              <a href="/profile" class="action-btn">
                <i class="fas fa-user-edit"></i>
                <span>Edit Profile</span>
              </a>
            </c:when>
          </c:choose>
        </div>
      </div>
    </div>

    <!-- Recent Activities Section -->
    <div class="col-md-8">
      <div class="dashboard-card">
        <h4>Recent Activity</h4>
        <div class="recent-activity">
          <c:choose>
            <c:when test="${not empty activities}">
              <c:forEach items="${activities}" var="activity">
                <div class="activity-item">
                  <div class="activity-icon">
                    <i class="${activity.icon}"></i>
                  </div>
                  <div class="activity-content">
                    <p>${activity.description}</p>
                    <p class="activity-time">${activity.time}</p>
                  </div>
                </div>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <div class="text-center py-4">
                <i class="fas fa-history fa-3x text-muted mb-3"></i>
                <p>No recent activities to show.</p>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>
  </div>

  <!-- Additional Sections Based on Role -->
  <c:if test="${user.role == 'ADMIN'}">
    <div class="row mt-4">
      <div class="col-12">
        <div class="dashboard-card">
          <h4>System Status</h4>
          <div class="table-responsive">
            <table class="table table-bordered">
              <thead>
              <tr>
                <th>Component</th>
                <th>Status</th>
                <th>Last Updated</th>
              </tr>
              </thead>
              <tbody>
              <tr>
                <td>User Database</td>
                <td><span class="badge bg-success">Operational</span></td>
                <td>Today, 09:15 AM</td>
              </tr>
              <tr>
                <td>Payment Gateway</td>
                <td><span class="badge bg-success">Operational</span></td>
                <td>Today, 09:15 AM</td>
              </tr>
              <tr>
                <td>Email Service</td>
                <td><span class="badge bg-success">Operational</span></td>
                <td>Today, 09:15 AM</td>
              </tr>
              <tr>
                <td>File Storage</td>
                <td><span class="badge bg-success">Operational</span></td>
                <td>Today, 09:15 AM</td>
              </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </c:if>

  <c:if test="${user.role == 'SELLER' || user.role == 'DEALER'}">
    <div class="row mt-4">
      <div class="col-12">
        <div class="dashboard-card">
          <h4>Recent Bookings</h4>
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
              <tr>
                <th>Car</th>
                <th>Buyer</th>
                <th>Date</th>
                <th>Status</th>
                <th>Amount</th>
                <th>Actions</th>
              </tr>
              </thead>
              <tbody>
              <c:forEach items="${recentBookings}" var="booking" end="4">
                <tr>
                  <td>${booking.car.make} ${booking.car.model}</td>
                  <td>${booking.buyer.name}</td>
                  <td>${booking.bookingDate}</td>
                  <td>
                                                <span class="badge
                                                    ${booking.status == 'COMPLETED' ? 'bg-success' :
                                                    booking.status == 'PENDING' ? 'bg-warning' :
                                                    booking.status == 'CANCELLED' ? 'bg-danger' : 'bg-primary'}">
                                                    ${booking.status}
                                                </span>
                  </td>
                  <td>$${booking.amount}</td>
                  <td>
                    <a href="/bookings/view?id=${booking.id}" class="btn btn-sm btn-info">
                      <i class="fas fa-eye"></i>
                    </a>
                  </td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
            <div class="text-end">
              <a href="/my-bookings" class="btn btn-sm btn-outline-primary">View All</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </c:if>

  <c:if test="${user.role == 'BUYER'}">
    <div class="row mt-4">
      <div class="col-12">
        <div class="dashboard-card">
          <h4>Featured Cars</h4>
          <div class="row">
            <c:forEach items="${featuredCars}" var="car" end="3">
              <div class="col-md-3 col-sm-6 mb-3">
                <div class="card h-100">
                  <img src="/uploads/${car.images[0]}" class="card-img-top" alt="${car.make} ${car.model}" style="height: 150px; object-fit: cover;">
                  <div class="card-body">
                    <h5 class="card-title">${car.make} ${car.model}</h5>
                    <p class="card-text">${car.year} | ${car.mileage} km</p>
                    <p class="text-primary fw-bold">$${car.price}</p>
                    <a href="/car?id=${car.id}" class="btn btn-sm btn-outline-primary">View Details</a>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
          <div class="text-end mt-3">
            <a href="/cars" class="btn btn-outline-primary">Browse All Cars</a>
          </div>
        </div>
      </div>
    </div>
  </c:if>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
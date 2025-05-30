<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Management | AutoMarket</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
    <style>
        .admin-container {
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.05);
        }
        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .action-btns .btn {
            margin-right: 5px;
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
<div class="container mt-4">
    <div class="admin-container">
        <div class="table-header">
            <h2>Admin Accounts</h2>
            <a href="/admin/create" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add New Admin
            </a>
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

        <table id="adminsTable" class="table table-striped table-hover">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Role</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${admins}" var="admin">
                <tr>
                    <td>${admin.userId}</td>
                    <td>${admin.username}</td>
                    <td>${admin.email}</td>
                    <td>
                                <span class="badge ${admin.role == 'SUPER_ADMIN' ? 'bg-danger' : 'bg-primary'}">
                                        ${admin.role}
                                </span>
                    </td>
                    <td class="action-btns">
                        <a href="/admin/edit?id=${admin.userId}" class="btn btn-sm btn-warning">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                        <form action="/admin/delete/${admin.userId}" method="post" style="display: inline;">
                            <button type="submit" class="btn btn-sm btn-danger delete-btn"
                                    onclick="return confirm('Are you sure you want to delete this admin?');">
                                <i class="fas fa-trash"></i> Delete
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script>
    $(document).ready(function() {
        // Initialize DataTable
        $('#adminsTable').DataTable({
            responsive: true,
            order: [[0, 'desc']]
        });
    });
</script>
</body>
</html>
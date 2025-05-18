<%@ page import="com.danusha.root.modal.User" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  response.setHeader("Cache-Control","no-cache, no-store, must-validate");
  if(session.getAttribute("admin") == null){
    response.sendRedirect("login");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>All Users - Admin</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(to right, #6366f1, #a855f7, #ec4899);
      min-height: 100vh;
      font-family: 'Segoe UI', sans-serif;
      display: flex;
      justify-content: center;
      align-items: start;
      padding-top: 50px;
    }

    .card {
      background: #ffffffcc;
      backdrop-filter: blur(12px);
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
    }

    h2, h5 {
      background: linear-gradient(45deg, #000000, #000000);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      font-weight: 700;
    }

    .btn-primary {
      background: linear-gradient(45deg, #6366f1, #a855f7);
      border: none;
    }

    .btn-danger {
      background: linear-gradient(45deg, #ef4444, #f97316);
      border: none;
    }

    .btn-outline-primary {
      border-color: #6366f1;
      color: #6366f1;
    }

    .btn-outline-primary:hover {
      background-color: #6366f1;
      color: white;
    }

    .table thead th {
      text-align: center;
    }
  </style>
</head>
<body>
<div class="container">
  <%
    String error = (String) request.getAttribute("error");
    if (error != null) {
  %>
  <div class="alert alert-danger alert-dismissible fade show" role="alert">
    <%= error %>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <%
    }
  %>

  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2>User List (Admin View)</h2>
    <a href="login" class="btn btn-outline-primary">Back to Login</a>
  </div>

  <div class="card shadow p-4">
    <div class="card-header border-0 bg-transparent">
      <h5 class="mb-0">Registered Users</h5>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle mb-0">
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
          <%
            List<User> users = (List<User>) request.getAttribute("userList");
            if (users != null && !users.isEmpty()) {
              for (User user : users) {
          %>
          <tr>
            <td class="text-center"><%= user.getId() %></td>
            <td><%= user.getUsername() %></td>
            <td><%= user.getEmail() %></td>
            <td class="text-center"><%= user.getRole() %></td>
            <td class="text-center">
              <a href="edit?id=<%= user.getId() %>" class="btn btn-sm btn-primary me-1">Edit</a>
              <a href="delete?id=<%= user.getId() %>" class="btn btn-sm btn-danger"
                 onclick="return confirm('Are you sure you want to delete this user?')">Delete</a>
            </td>
          </tr>
          <%
            }
          } else {
          %>
          <tr>
            <td colspan="5" class="text-center text-muted">No users found.</td>
          </tr>
          <%
            }
          %>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
</body>
</html>

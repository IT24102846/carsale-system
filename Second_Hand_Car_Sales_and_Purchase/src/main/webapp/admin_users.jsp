<%@ page import="java.util.*, com.second_hand_car_sales_and_purchase.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>All Users - Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="css/styles.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="fw-bold">User List (Admin View)</h2>
    <a href="login.jsp" class="btn btn-outline-primary">Back to Login</a>
  </div>

  <div class="card shadow rounded-4">
    <div class="card-header py-3">
      <h5 class="mb-0">Registered Users</h5>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle mb-0">
          <thead class="table-dark text-center">
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
            <td><%= user.getId() %></td>
            <td><%= user.getUsername() %></td>
            <td><%= user.getEmail() %></td>
            <td><%= user.getRole() %></td>
            <td class="text-center">
              <a href="user?action=edit&id=<%= user.getId() %>" class="btn btn-sm btn-primary me-1">Edit</a>
              <a href="user?action=delete&id=<%= user.getId() %>" class="btn btn-sm btn-danger"
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

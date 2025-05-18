<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 5/1/2025
  Time: 11:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.second_hand_car_sales_and_purchase.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User) request.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card shadow p-4">
        <h2>Edit User</h2>
        <form action="user" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= user.getId() %>">

            <div class="mb-3">
                <label>Username</label>
                <input type="text" name="username" class="form-control" value="<%= user.getUsername() %>" required>
            </div>
            <div class="mb-3">
                <label>Email</label>
                <input type="email" name="email" class="form-control" value="<%= user.getEmail() %>" required>
            </div>
            <div class="mb-3">
                <label>Password</label>
                <input type="password" name="password" class="form-control" value="<%= user.getPassword() %>" required>
            </div>
            <div class="mb-3">
                <label>Role</label>
                <select name="role" class="form-control">
                    <option value="user" <%= user.getRole().equals("user") ? "selected" : "" %>>User</option>
                    <option value="admin" <%= user.getRole().equals("admin") ? "selected" : "" %>>Admin</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Update</button>
        </form>
</div>
</body>
</html>


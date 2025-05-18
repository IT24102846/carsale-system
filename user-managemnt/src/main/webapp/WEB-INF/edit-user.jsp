<%@ page import="com.danusha.root.modal.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("Cache-Control","no-cache, no-store, must-validate");
    if(session.getAttribute("admin") == null){
        response.sendRedirect("login");
        return;
    }
    User user = (User) request.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to right, #f8f9fa, #a855f7, #ec4899);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .card {
            background: #ffffffcc;
            backdrop-filter: blur(10px);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        h2 {
            background: linear-gradient(45deg, #6366f1, #a855f7);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 700;
        }

        label {
            font-weight: 600;
        }

        .btn-primary {
            background: linear-gradient(45deg, #6366f1, #a855f7);
            border: none;
        }

        .btn-primary:hover {
            background: linear-gradient(45deg, #4f46e5, #9333ea);
        }

        .form-text {
            font-size: 0.875em;
            color: #6b7280;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card shadow p-5">
        <h2 class="text-center mb-4">Edit User</h2>
        <form action="update" method="post">
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
                <input type="password" name="password" class="form-control" placeholder="Enter new password">
                <small class="form-text">Leave blank to keep the current password.</small>
            </div>

            <div class="mb-3">
                <label>Role</label>
                <select name="role" class="form-control">
                    <option value="user" <%= user.getRole().equals("user") ? "selected" : "" %>>User</option>
                    <option value="admin" <%= user.getRole().equals("admin") ? "selected" : "" %>>Admin</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary w-100 mt-3">Update</button>
        </form>
    </div>
</div>
</body>
</html>

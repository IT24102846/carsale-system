<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Signup</title>
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

        .auth-card {
            background: #ffffffcc;
            backdrop-filter: blur(10px);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
        }

        .btn-primary {
            background: linear-gradient(45deg, #6366f1, #a855f7);
            border: none;
        }

        .btn-primary:hover {
            background: linear-gradient(45deg, #4f46e5, #9333ea);
        }
    </style>
</head>
<body>
<div class="container d-flex justify-content-center align-items-center">
    <div class="card auth-card shadow p-5">
        <h2 class="mb-4 text-center">Create Account</h2>
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger" role="alert">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>
        <form action="register" method="post">
            <div class="mb-3">
                <label class="form-label">Username</label>
                <input type="text" name="username" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>

            <input type="hidden" name="role" value="user">

            <div class="d-grid">
                <button type="submit" class="btn btn-primary btn-lg">Register</button>
            </div>

            <div class="mt-3 text-center">
                Already have an account?
                <a href="login" class="text-decoration-none fw-medium text-primary">
                    Login here
                </a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
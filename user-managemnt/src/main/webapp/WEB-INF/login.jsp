<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            background: linear-gradient(to right, #f8f9fa, #a855f7, #ec4899);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
        }

        .auth-card {
            width: 100%;
            max-width: 400px;
            border-radius: 1rem;
            border: none;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            background: #ffffffcc;
            backdrop-filter: blur(10px);
        }

        .form-control {
            padding: 0.75rem 1.25rem;
            border-radius: 0.5rem;
        }

        .input-icon {
            position: absolute;
            z-index: 2;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #333;
        }
    </style>
</head>
<body>
<div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
    <div class="card auth-card">
        <div class="card-body p-5">
            <div class="text-center mb-5">
                <div class="avatar-lg mx-auto mb-4">
                    <i class="bi bi-person-circle display-4 text-primary"></i>
                </div>
                <h2 class="h3 mb-0">Welcome Back</h2>
                <p class="text-muted">Please sign in to continue</p>
            </div>

            <form action="login" method="post">
                <div class="mb-4 position-relative">
                    <label class="form-label fw-medium">Email Address</label>
                    <i class="bi bi-envelope-at input-icon"></i>
                    <input type="email" name="email" class="form-control ps-5"
                           placeholder="name@example.com" required>
                </div>

                <div class="mb-4 position-relative">
                    <label class="form-label fw-medium">Password</label>
                    <i class="bi bi-lock input-icon"></i>
                    <input type="password" name="password" class="form-control ps-5"
                           placeholder="Enter your password" required>
                </div>

                <div class="d-grid mb-4">
                    <button type="submit" class="btn btn-primary btn-lg rounded-pill fw-medium">
                        <i class="bi bi-box-arrow-in-right me-2"></i>Sign In
                    </button>
                </div>

                <div class="text-center text-muted">
                    Don't have an account?
                    <a href="signup" class="text-decoration-none fw-medium text-primary">
                        Create Account
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
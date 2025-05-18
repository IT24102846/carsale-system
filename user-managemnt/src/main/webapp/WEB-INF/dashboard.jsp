<%@ page import="com.danusha.root.modal.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Dashboard</title>
    <style>
        :root {
            --primary: #6366f1;
            --secondary: #a855f7;
            --accent: #ec4899;
            --background: #f8fafc;
        }

        body {
            background: linear-gradient(to right, #f8f9fa, #a855f7, #ec4899);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
        }

        /* Animated background elements */
        .decorative-circle {
            position: absolute;
            border-radius: 50%;
            filter: blur(60px);
            opacity: 0.4;
            animation: float 20s infinite;
        }

        .circle-1 { background: var(--primary); width: 300px; height: 300px; top: -50px; left: -50px; }
        .circle-2 { background: var(--secondary); width: 400px; height: 400px; bottom: -100px; right: -100px; animation-delay: 5s; }
        .circle-3 { background: var(--accent); width: 200px; height: 200px; top: 40%; left: 30%; animation-delay: 10s; }

        .dashboard-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            text-align: center;
            position: relative;
            z-index: 1;
            max-width: 500px;
            width: 90%;
            margin: 50px auto;
            transform: translateY(0);
            animation:
                    containerEntrance 1s cubic-bezier(0.34, 1.56, 0.64, 1),
                    containerFloat 6s ease-in-out infinite;
        }

        h1 {
            color: #1e293b;
            margin-bottom: 30px;
            font-size: 2.5rem;
            background: linear-gradient(45deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: textEntrance 0.8s ease-out;
        }

        .user-info {
            margin: 20px 0;
            font-size: 1.1rem;
            color: #475569;
            padding: 15px;
            background: rgba(241, 245, 249, 0.4);
            border-radius: 10px;
            transform: translateX(0);
            opacity: 1;
            animation: infoSlide 0.6s ease-out;
        }

        .user-info:nth-child(2) { animation-delay: 0.2s; }
        .user-info:nth-child(3) { animation-delay: 0.4s; }

        .btn-group {
            margin-top: 30px;
            display: flex;
            gap: 15px;
            justify-content: center;
        }

        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-primary {
            background: linear-gradient(45deg, var(--primary), var(--secondary));
            color: white;
        }

        .btn-logout {
            background: linear-gradient(45deg, var(--accent), #f43f5e);
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .btn::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: rgba(255, 255, 255, 0.1);
            transform: rotate(45deg) translate(-20%, 100%);
            transition: all 0.5s ease;
        }

        .btn:hover::after {
            transform: rotate(45deg) translate(20%, -50%);
        }

        /* Animations */
        @keyframes containerEntrance {
            from {
                opacity: 0;
                transform: translateY(100px) scale(0.9);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        @keyframes containerFloat {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        @keyframes textEntrance {
            from {
                letter-spacing: -0.5em;
                opacity: 0;
            }
            to {
                letter-spacing: normal;
                opacity: 1;
            }
        }

        @keyframes infoSlide {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes float {
            0%, 100% { transform: translate(0, 0); }
            25% { transform: translate(10px, 10px); }
            50% { transform: translate(-10px, 20px); }
            75% { transform: translate(-20px, -10px); }
        }

        @media (max-width: 480px) {
            .dashboard-container {
                padding: 25px;
            }
            h1 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
<%-- Background decorative elements --%>
<div class="decorative-circle circle-1"></div>
<div class="decorative-circle circle-2"></div>
<div class="decorative-circle circle-3"></div>

<div class="dashboard-container">
    <%
        response.setHeader("Cache-Control","no-cache, no-store, must-validate");
        if(session.getAttribute("loggedUser") == null){
            response.sendRedirect("login");
            return;
        }
        User user = (User) session.getAttribute("loggedUser");
    %>
    <h1>Welcome Back, <%=user.getUsername()%>!</h1>
    <div class="user-info">✨ Name: <%=user.getUsername()%></div>
    <div class="user-info">📧 Email: <%=user.getEmail()%></div>
    <div class="btn-group">
        <a href="login" class="btn btn-primary">Dashboard</a>
        <a href="logout" class="btn btn-logout">Log Out</a>
    </div>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // If already logged in, go to dashboard
    String admin = (String) session.getAttribute("admin");
    if (admin != null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login - Student Feedback System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #1a73e8, #0d47a1);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            background: white;
            border-radius: 15px;
            padding: 40px;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        .login-title {
            color: #1a73e8;
            font-weight: 700;
            text-align: center;
            margin-bottom: 5px;
        }
        .login-subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
            font-size: 14px;
        }
        .btn-login {
            background: #1a73e8;
            border: none;
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border-radius: 8px;
            color: white;
        }
        .btn-login:hover {
            background: #0d47a1;
            color: white;
        }
        .form-control:focus {
            border-color: #1a73e8;
            box-shadow: 0 0 0 0.2rem rgba(26,115,232,0.25);
        }
        .error-msg {
            background: #fdecea;
            color: #c62828;
            padding: 10px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="login-card">

        <h3 class="login-title">🎓 Feedback System</h3>
        <p class="login-subtitle">Student Feedback Management — Admin Panel</p>

        <!-- Show error if login failed -->
        <% String error = (String) request.getAttribute("error");
           if (error != null) { %>
            <div class="error-msg">⚠️ <%= error %></div>
        <% } %>

        <form action="adminLogin" method="post">
            <div class="mb-3">
                <label class="form-label fw-semibold">Username</label>
                <input type="text" name="username" class="form-control"
                       placeholder="Enter username" required autofocus>
            </div>
            <div class="mb-4">
                <label class="form-label fw-semibold">Password</label>
                <input type="password" name="password" class="form-control"
                       placeholder="Enter password" required>
            </div>
            <button type="submit" class="btn btn-login">Login →</button>
        </form>

        <p class="text-center mt-3" style="font-size:13px; color:#999;">
            Default: admin / admin123
        </p>

    </div>
</body>
</html>
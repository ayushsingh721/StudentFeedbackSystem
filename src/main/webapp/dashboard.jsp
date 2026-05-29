<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.DBConnection" %>
<%
    // Session check — if not logged in, redirect to login
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get counts for dashboard stats
    int totalStudents = 0;
    int totalSubjects = 0;
    int totalFeedbacks = 0;

    try {
        Connection con = DBConnection.getConnection();

        ResultSet rs1 = con.createStatement().executeQuery("SELECT COUNT(*) FROM students");
        if (rs1.next()) totalStudents = rs1.getInt(1);

        ResultSet rs2 = con.createStatement().executeQuery("SELECT COUNT(*) FROM subjects");
        if (rs2.next()) totalSubjects = rs2.getInt(1);

        ResultSet rs3 = con.createStatement().executeQuery("SELECT COUNT(*) FROM feedback");
        if (rs3.next()) totalFeedbacks = rs3.getInt(1);

        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Student Feedback System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background: #f0f4f8;
            font-family: 'Segoe UI', sans-serif;
        }
        .navbar {
            background: #1a73e8;
            padding: 15px 30px;
        }
        .navbar-brand {
            color: white !important;
            font-weight: 700;
            font-size: 20px;
        }
        .nav-link {
            color: rgba(255,255,255,0.85) !important;
            font-weight: 500;
            margin: 0 5px;
        }
        .nav-link:hover {
            color: white !important;
        }
        .btn-logout {
            background: white;
            color: #1a73e8;
            border: none;
            padding: 6px 18px;
            border-radius: 20px;
            font-weight: 600;
        }
        .btn-logout:hover {
            background: #e8f0fe;
        }
        .welcome-box {
            background: linear-gradient(135deg, #1a73e8, #0d47a1);
            color: white;
            border-radius: 15px;
            padding: 30px;
            margin: 30px 0 20px 0;
        }
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            transition: transform 0.2s;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
        .stat-number {
            font-size: 42px;
            font-weight: 700;
        }
        .stat-label {
            color: #666;
            font-size: 15px;
            margin-top: 5px;
        }
        .action-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            text-decoration: none;
            color: #333;
            display: block;
            transition: transform 0.2s;
        }
        .action-card:hover {
            transform: translateY(-5px);
            color: #1a73e8;
        }
        .action-icon {
            font-size: 40px;
            margin-bottom: 10px;
        }
        .action-title {
            font-weight: 600;
            font-size: 16px;
        }
        .action-desc {
            font-size: 13px;
            color: #888;
            margin-top: 5px;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg">
        <span class="navbar-brand">🎓 Student Feedback System</span>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item"><a class="nav-link" href="dashboard.jsp">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="students.jsp">Students</a></li>
                <li class="nav-item"><a class="nav-link" href="subjects.jsp">Subjects</a></li>
                <li class="nav-item"><a class="nav-link" href="feedback.jsp">Feedback</a></li>
                <li class="nav-item"><a class="nav-link" href="viewFeedback.jsp">Reports</a></li>
                <li class="nav-item ms-3">
                    <a href="adminLogout" class="btn btn-logout">Logout</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container">

        <!-- Welcome Box -->
        <div class="welcome-box">
            <h4>👋 Welcome, <%= admin %>!</h4>
            <p class="mb-0" style="opacity:0.85;">Manage students, subjects and view feedback reports from here.</p>
        </div>

        <!-- Stats Row -->
        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="stat-card">
                    <div class="stat-number" style="color:#1a73e8;"><%= totalStudents %></div>
                    <div class="stat-label">👨‍🎓 Total Students</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card">
                    <div class="stat-number" style="color:#34a853;"><%= totalSubjects %></div>
                    <div class="stat-label">📚 Total Subjects</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card">
                    <div class="stat-number" style="color:#ea4335;"><%= totalFeedbacks %></div>
                    <div class="stat-label">💬 Total Feedbacks</div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <h5 class="mb-3 fw-bold">Quick Actions</h5>
        <div class="row g-4 mb-5">
            <div class="col-md-3">
                <a href="students.jsp" class="action-card">
                    <div class="action-icon">👨‍🎓</div>
                    <div class="action-title">Manage Students</div>
                    <div class="action-desc">Add & view students</div>
                </a>
            </div>
            <div class="col-md-3">
                <a href="subjects.jsp" class="action-card">
                    <div class="action-icon">📚</div>
                    <div class="action-title">Manage Subjects</div>
                    <div class="action-desc">Add & view subjects</div>
                </a>
            </div>
            <div class="col-md-3">
                <a href="feedback.jsp" class="action-card">
                    <div class="action-icon">💬</div>
                    <div class="action-title">Submit Feedback</div>
                    <div class="action-desc">Give feedback on subjects</div>
                </a>
            </div>
            <div class="col-md-3">
                <a href="viewFeedback.jsp" class="action-card">
                    <div class="action-icon">📊</div>
                    <div class="action-title">View Reports</div>
                    <div class="action-desc">See all feedback reports</div>
                </a>
            </div>
        </div>

    </div>

</body>
</html>
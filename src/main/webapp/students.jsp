<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.DBConnection" %>
<%
    // Session check
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Students - Student Feedback System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { background: #f0f4f8; font-family: 'Segoe UI', sans-serif; }
        .navbar { background: #1a73e8; padding: 15px 30px; }
        .navbar-brand { color: white !important; font-weight: 700; font-size: 20px; }
        .nav-link { color: rgba(255,255,255,0.85) !important; font-weight: 500; margin: 0 5px; }
        .nav-link:hover { color: white !important; }
        .btn-logout { background: white; color: #1a73e8; border: none; padding: 6px 18px; border-radius: 20px; font-weight: 600; }
        .page-card { background: white; border-radius: 12px; padding: 30px; margin: 30px 0; box-shadow: 0 2px 10px rgba(0,0,0,0.08); }
        .page-title { font-weight: 700; color: #1a73e8; margin-bottom: 20px; }
        .table thead { background: #1a73e8; color: white; }
        .table tbody tr:hover { background: #e8f0fe; }
        .btn-add { background: #1a73e8; color: white; border: none; padding: 8px 20px; border-radius: 8px; font-weight: 600; }
        .btn-add:hover { background: #0d47a1; color: white; }
        .btn-delete { background: #ea4335; color: white; border: none; padding: 4px 12px; border-radius: 6px; font-size: 13px; }
        .btn-delete:hover { background: #c62828; color: white; }
        .success-msg { background: #e6f4ea; color: #2e7d32; padding: 10px 15px; border-radius: 8px; margin-bottom: 20px; font-size: 14px; }
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
        <div class="page-card">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="page-title mb-0">👨‍🎓 Manage Students</h4>
                <a href="addStudent.jsp" class="btn btn-add">+ Add Student</a>
            </div>

            <!-- Success message -->
            <% String msg = (String) session.getAttribute("msg");
               if (msg != null) { %>
                <div class="success-msg">✅ <%= msg %></div>
            <% session.removeAttribute("msg"); } %>

            <!-- Students Table -->
            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Branch</th>
                        <th>Year</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    try {
                        Connection con = DBConnection.getConnection();
                        ResultSet rs = con.createStatement().executeQuery("SELECT * FROM students ORDER BY id DESC");
                        int sr = 1;
                        while (rs.next()) {
                %>
                    <tr>
                        <td><%= sr++ %></td>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getString("email") %></td>
                        <td><%= rs.getString("branch") %></td>
                        <td>Year <%= rs.getInt("year") %></td>
                        <td>
                            <a href="student?action=delete&id=<%= rs.getInt("id") %>"
                               class="btn btn-delete"
                               onclick="return confirm('Delete this student?')">Delete</a>
                        </td>
                    </tr>
                <%
                        }
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
                </tbody>
            </table>

        </div>
    </div>

</body>
</html>
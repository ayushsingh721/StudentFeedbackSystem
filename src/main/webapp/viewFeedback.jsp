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
    <title>View Feedback - Student Feedback System</title>
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
        .btn-delete { background: #ea4335; color: white; border: none; padding: 4px 12px; border-radius: 6px; font-size: 13px; }
        .btn-delete:hover { background: #c62828; color: white; }
        .success-msg { background: #e6f4ea; color: #2e7d32; padding: 10px 15px; border-radius: 8px; margin-bottom: 20px; font-size: 14px; }
        .badge-rating {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }
        .rating-5 { background: #e6f4ea; color: #2e7d32; }
        .rating-4 { background: #e8f5e9; color: #388e3c; }
        .rating-3 { background: #fff8e1; color: #f57f17; }
        .rating-2 { background: #fff3e0; color: #e65100; }
        .rating-1 { background: #fdecea; color: #c62828; }
        .no-data { text-align: center; color: #999; padding: 30px; font-size: 15px; }
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
                <li class="nav-item"><a class="nav-link active" href="viewFeedback.jsp">Reports</a></li>
                <li class="nav-item ms-3">
                    <a href="adminLogout" class="btn btn-logout">Logout</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <div class="page-card">

            <h4 class="page-title">📊 Feedback Reports</h4>

            <!-- Success message -->
            <% String msg = (String) session.getAttribute("msg");
               if (msg != null) { %>
                <div class="success-msg">✅ <%= msg %></div>
            <% session.removeAttribute("msg"); } %>

            <!-- Feedback Table -->
            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Student Name</th>
                        <th>Branch</th>
                        <th>Subject</th>
                        <th>Teacher</th>
                        <th>Rating</th>
                        <th>Comments</th>
                        <th>Submitted At</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    try {
                        Connection con = DBConnection.getConnection();

                        String sql = "SELECT f.id, s.name, s.branch, sub.subject_name, " +
                                     "sub.teacher_name, f.rating, f.comments, f.submitted_at " +
                                     "FROM feedback f " +
                                     "JOIN students s ON f.student_id = s.id " +
                                     "JOIN subjects sub ON f.subject_id = sub.id " +
                                     "ORDER BY f.submitted_at DESC";

                        ResultSet rs = con.createStatement().executeQuery(sql);

                        int sr = 1;
                        boolean hasData = false;

                        while (rs.next()) {
                            hasData = true;
                            int rating = rs.getInt("rating");
                            String ratingClass = "rating-" + rating;
                            String stars = "";
                            for (int i = 0; i < rating; i++) stars += "⭐";
                %>
                    <tr>
                        <td><%= sr++ %></td>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getString("branch") %></td>
                        <td><%= rs.getString("subject_name") %></td>
                        <td><%= rs.getString("teacher_name") %></td>
                        <td>
                            <span class="badge-rating <%= ratingClass %>">
                                <%= stars %> (<%= rating %>/5)
                            </span>
                        </td>
                        <td><%= rs.getString("comments") != null ? rs.getString("comments") : "-" %></td>
                        <td><%= rs.getTimestamp("submitted_at") %></td>
                        <td>
                            <a href="feedback?action=delete&id=<%= rs.getInt("id") %>"
                               class="btn btn-delete"
                               onclick="return confirm('Delete this feedback?')">Delete</a>
                        </td>
                    </tr>
                <%
                        }

                        if (!hasData) {
                %>
                    <tr>
                        <td colspan="9" class="no-data">
                            📭 No feedback submitted yet. <a href="feedback.jsp">Submit feedback</a>
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
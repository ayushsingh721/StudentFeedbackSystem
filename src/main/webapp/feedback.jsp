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
    <title>Submit Feedback - Student Feedback System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { background: #f0f4f8; font-family: 'Segoe UI', sans-serif; }
        .navbar { background: #1a73e8; padding: 15px 30px; }
        .navbar-brand { color: white !important; font-weight: 700; font-size: 20px; }
        .nav-link { color: rgba(255,255,255,0.85) !important; font-weight: 500; margin: 0 5px; }
        .nav-link:hover { color: white !important; }
        .btn-logout { background: white; color: #1a73e8; border: none; padding: 6px 18px; border-radius: 20px; font-weight: 600; }
        .page-card { background: white; border-radius: 12px; padding: 35px; margin: 40px auto; box-shadow: 0 2px 10px rgba(0,0,0,0.08); max-width: 600px; }
        .page-title { font-weight: 700; color: #1a73e8; margin-bottom: 25px; }
        .btn-submit { background: #1a73e8; color: white; border: none; padding: 10px 30px; border-radius: 8px; font-weight: 600; width: 100%; font-size: 16px; }
        .btn-submit:hover { background: #0d47a1; color: white; }
        .btn-back { background: #f0f4f8; color: #333; border: none; padding: 10px 20px; border-radius: 8px; font-weight: 600; }
        .btn-back:hover { background: #e0e0e0; }
        .form-control:focus { border-color: #1a73e8; box-shadow: 0 0 0 0.2rem rgba(26,115,232,0.25); }
        .form-select:focus { border-color: #1a73e8; box-shadow: 0 0 0 0.2rem rgba(26,115,232,0.25); }
        .success-msg { background: #e6f4ea; color: #2e7d32; padding: 10px 15px; border-radius: 8px; margin-bottom: 20px; font-size: 14px; }
        .rating-group { display: flex; gap: 10px; flex-wrap: wrap; }
        .rating-label {
            flex: 1;
            min-width: 60px;
            text-align: center;
            padding: 10px 5px;
            border: 2px solid #ddd;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.2s;
        }
        .rating-label:hover { border-color: #1a73e8; color: #1a73e8; }
        input[type="radio"]:checked + .rating-label {
            background: #1a73e8;
            color: white;
            border-color: #1a73e8;
        }
        input[type="radio"].rating-radio { display: none; }
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
                <li class="nav-item"><a class="nav-link active" href="feedback.jsp">Feedback</a></li>
                <li class="nav-item"><a class="nav-link" href="viewFeedback.jsp">Reports</a></li>
                <li class="nav-item ms-3">
                    <a href="adminLogout" class="btn btn-logout">Logout</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <div class="page-card">

            <h4 class="page-title">💬 Submit Student Feedback</h4>

            <!-- Success message -->
            <% String msg = (String) session.getAttribute("msg");
               if (msg != null) { %>
                <div class="success-msg">✅ <%= msg %></div>
            <% session.removeAttribute("msg"); } %>

            <form action="feedback" method="post">
                <input type="hidden" name="action" value="add">

                <!-- Student Dropdown -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">Select Student</label>
                    <select name="student_id" class="form-select" required>
                        <option value="">-- Select Student --</option>
                        <%
                            try {
                                Connection con1 = DBConnection.getConnection();
                                ResultSet rs1 = con1.createStatement().executeQuery("SELECT * FROM students ORDER BY name");
                                while (rs1.next()) {
                        %>
                        <option value="<%= rs1.getInt("id") %>">
                            <%= rs1.getString("name") %> — <%= rs1.getString("branch") %> Year <%= rs1.getInt("year") %>
                        </option>
                        <%
                                }
                                con1.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </select>
                </div>

                <!-- Subject Dropdown -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">Select Subject</label>
                    <select name="subject_id" class="form-select" required>
                        <option value="">-- Select Subject --</option>
                        <%
                            try {
                                Connection con2 = DBConnection.getConnection();
                                ResultSet rs2 = con2.createStatement().executeQuery("SELECT * FROM subjects ORDER BY subject_name");
                                while (rs2.next()) {
                        %>
                        <option value="<%= rs2.getInt("id") %>">
                            <%= rs2.getString("subject_name") %> — <%= rs2.getString("teacher_name") %>
                        </option>
                        <%
                                }
                                con2.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </select>
                </div>

                <!-- Rating -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">Rating</label>
                    <div class="rating-group">
                        <input type="radio" class="rating-radio" name="rating" id="r1" value="1" required>
                        <label for="r1" class="rating-label">1 ⭐</label>

                        <input type="radio" class="rating-radio" name="rating" id="r2" value="2">
                        <label for="r2" class="rating-label">2 ⭐</label>

                        <input type="radio" class="rating-radio" name="rating" id="r3" value="3">
                        <label for="r3" class="rating-label">3 ⭐</label>

                        <input type="radio" class="rating-radio" name="rating" id="r4" value="4">
                        <label for="r4" class="rating-label">4 ⭐</label>

                        <input type="radio" class="rating-radio" name="rating" id="r5" value="5">
                        <label for="r5" class="rating-label">5 ⭐</label>
                    </div>
                </div>

                <!-- Comments -->
                <div class="mb-4">
                    <label class="form-label fw-semibold">Comments</label>
                    <textarea name="comments" class="form-control" rows="4"
                              placeholder="Write feedback comments here..."></textarea>
                </div>

                <div class="d-flex gap-2">
                    <a href="dashboard.jsp" class="btn btn-back">← Back</a>
                    <button type="submit" class="btn btn-submit">Submit Feedback</button>
                </div>

            </form>

        </div>
    </div>

</body>
</html>
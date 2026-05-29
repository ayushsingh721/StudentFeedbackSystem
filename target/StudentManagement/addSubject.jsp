<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Add Subject - Student Feedback System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { background: #f0f4f8; font-family: 'Segoe UI', sans-serif; }
        .navbar { background: #1a73e8; padding: 15px 30px; }
        .navbar-brand { color: white !important; font-weight: 700; font-size: 20px; }
        .nav-link { color: rgba(255,255,255,0.85) !important; font-weight: 500; margin: 0 5px; }
        .nav-link:hover { color: white !important; }
        .btn-logout { background: white; color: #1a73e8; border: none; padding: 6px 18px; border-radius: 20px; font-weight: 600; }
        .page-card { background: white; border-radius: 12px; padding: 35px; margin: 40px auto; box-shadow: 0 2px 10px rgba(0,0,0,0.08); max-width: 550px; }
        .page-title { font-weight: 700; color: #1a73e8; margin-bottom: 25px; }
        .btn-submit { background: #34a853; color: white; border: none; padding: 10px 30px; border-radius: 8px; font-weight: 600; width: 100%; font-size: 16px; }
        .btn-submit:hover { background: #2e7d32; color: white; }
        .btn-back { background: #f0f4f8; color: #333; border: none; padding: 10px 20px; border-radius: 8px; font-weight: 600; }
        .btn-back:hover { background: #e0e0e0; }
        .form-control:focus { border-color: #1a73e8; box-shadow: 0 0 0 0.2rem rgba(26,115,232,0.25); }
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

            <h4 class="page-title">➕ Add New Subject</h4>

            <form action="subject" method="post">
                <input type="hidden" name="action" value="add">

                <div class="mb-3">
                    <label class="form-label fw-semibold">Subject Name</label>
                    <input type="text" name="subject_name" class="form-control"
                           placeholder="e.g. Data Structures" required>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Teacher Name</label>
                    <input type="text" name="teacher_name" class="form-control"
                           placeholder="e.g. Prof. Sharma" required>
                </div>

                <div class="d-flex gap-2">
                    <a href="subjects.jsp" class="btn btn-back">← Back</a>
                    <button type="submit" class="btn btn-submit">Add Subject</button>
                </div>

            </form>

        </div>
    </div>

</body>
</html>
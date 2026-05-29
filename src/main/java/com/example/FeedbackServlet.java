package com.example;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
public class FeedbackServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            try {
                // Get form data
                int studentId = Integer.parseInt(request.getParameter("student_id"));
                int subjectId = Integer.parseInt(request.getParameter("subject_id"));
                int rating    = Integer.parseInt(request.getParameter("rating"));
                String comments = request.getParameter("comments");

                Connection con = DBConnection.getConnection();

                String sql = "INSERT INTO feedback (student_id, subject_id, rating, comments) VALUES (?, ?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, studentId);
                ps.setInt(2, subjectId);
                ps.setInt(3, rating);
                ps.setString(4, comments);
                ps.executeUpdate();

                ps.close();
                con.close();

                // Success message
                session.setAttribute("msg", "Feedback submitted successfully!");
                response.sendRedirect("feedback.jsp");

            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("msg", "Error submitting feedback. Please try again.");
                response.sendRedirect("feedback.jsp");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));

            try {
                Connection con = DBConnection.getConnection();

                String sql = "DELETE FROM feedback WHERE id = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, id);
                ps.executeUpdate();

                ps.close();
                con.close();

                session.setAttribute("msg", "Feedback deleted successfully!");
                response.sendRedirect("viewFeedback.jsp");

            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("msg", "Error deleting feedback. Please try again.");
                response.sendRedirect("viewFeedback.jsp");
            }
        }
    }
}
package com.example;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class SubjectServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String subjectName = request.getParameter("subject_name");
            String teacherName = request.getParameter("teacher_name");

            try {
                Connection con = DBConnection.getConnection();

                String sql = "INSERT INTO subjects (subject_name, teacher_name) VALUES (?, ?)";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, subjectName);
                ps.setString(2, teacherName);
                ps.executeUpdate();

                ps.close();
                con.close();

                session.setAttribute("msg", "Subject added successfully!");
                response.sendRedirect("subjects.jsp");

            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("msg", "Error adding subject. Please try again.");
                response.sendRedirect("addSubject.jsp");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

                String deleteFeedback = "DELETE FROM feedback WHERE subject_id = ?";
                PreparedStatement ps1 = con.prepareStatement(deleteFeedback);
                ps1.setInt(1, id);
                ps1.executeUpdate();
                ps1.close();

                String deleteSubject = "DELETE FROM subjects WHERE id = ?";
                PreparedStatement ps2 = con.prepareStatement(deleteSubject);
                ps2.setInt(1, id);
                ps2.executeUpdate();
                ps2.close();

                con.close();

                session.setAttribute("msg", "Subject deleted successfully!");
                response.sendRedirect("subjects.jsp");

            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("msg", "Error deleting subject. Please try again.");
                response.sendRedirect("subjects.jsp");
            }
        }
    }
}
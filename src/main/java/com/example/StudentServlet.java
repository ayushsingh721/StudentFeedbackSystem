package com.example;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class StudentServlet extends HttpServlet {

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
            // Get form data
            String name   = request.getParameter("name");
            String email  = request.getParameter("email");
            String branch = request.getParameter("branch");
            int year      = Integer.parseInt(request.getParameter("year"));

            try {
                Connection con = DBConnection.getConnection();

                String sql = "INSERT INTO students (name, email, branch, year) VALUES (?, ?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, branch);
                ps.setInt(4, year);
                ps.executeUpdate();

                ps.close();
                con.close();

                // Success message
                session.setAttribute("msg", "Student added successfully!");
                response.sendRedirect("students.jsp");

            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("msg", "Error adding student. Please try again.");
                response.sendRedirect("addStudent.jsp");
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

                // First delete related feedback records
                String deleteFeedback = "DELETE FROM feedback WHERE student_id = ?";
                PreparedStatement ps1 = con.prepareStatement(deleteFeedback);
                ps1.setInt(1, id);
                ps1.executeUpdate();
                ps1.close();

                // Then delete student
                String deleteStudent = "DELETE FROM students WHERE id = ?";
                PreparedStatement ps2 = con.prepareStatement(deleteStudent);
                ps2.setInt(1, id);
                ps2.executeUpdate();
                ps2.close();

                con.close();

                session.setAttribute("msg", "Student deleted successfully!");
                response.sendRedirect("students.jsp");

            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("msg", "Error deleting student. Please try again.");
                response.sendRedirect("students.jsp");
            }
        }
    }
}
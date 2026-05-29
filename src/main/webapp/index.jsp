<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // If admin already logged in, redirect to dashboard
    String admin = (String) session.getAttribute("admin");
    if (admin != null) {
        response.sendRedirect("dashboard.jsp");
        return;
    } else {
        response.sendRedirect("login.jsp");
        return;
    }
%>
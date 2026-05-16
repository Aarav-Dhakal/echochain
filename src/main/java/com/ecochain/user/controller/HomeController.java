package com.ecochain.user.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({"/about", "/contact"})
public class HomeController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/about".equals(path)) {
            request.getRequestDispatcher("/pages/about.jsp").forward(request, response);
        } else if ("/contact".equals(path)) {
            request.getRequestDispatcher("/pages/contact.jsp").forward(request, response);
        }
    }
}
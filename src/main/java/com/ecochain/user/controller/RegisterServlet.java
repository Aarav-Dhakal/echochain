package com.ecochain.user.controller;

import com.ecochain.user.model.User;
import com.ecochain.user.model.dao.UserDao;
import com.ecochain.utils.PasswordManager;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet(name = "registerPage", value = "/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("pages/register.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (fullName.isEmpty() || email.isEmpty() || password.isEmpty() || role.isEmpty()) {
            request.setAttribute("error", "Please fill all the required fields.");
            request.getRequestDispatcher("pages/register.jsp").forward(request, response);
            return;
        }

        String hashedPassword = PasswordManager.hashPassword(password);

        try {
            if (UserDao.emailExists(email)) {
                request.setAttribute("error", "Email already registered. Please login.");
                request.getRequestDispatcher("pages/register.jsp").forward(request, response);
                return;
            }

            boolean userInserted = UserDao.insertUser(fullName, email, hashedPassword, role);
            if (userInserted) {
                request.setAttribute("success", "Registration successful! Wait for admin approval.");
                request.getRequestDispatcher("pages/login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Something went wrong! Please try again.");
                request.getRequestDispatcher("pages/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("pages/register.jsp").forward(request, response);
        }
    }
}
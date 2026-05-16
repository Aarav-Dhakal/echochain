package com.ecochain.user.controller;

import com.ecochain.user.model.User;
import com.ecochain.user.model.dao.UserDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.ecochain.utils.SchemaSetup;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        try {
            UserDao.installAdmin();
            SchemaSetup.init();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("pages/login.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            User userObj = UserDao.loginUser(email, password);
            if (userObj != null) {
                if (userObj.getStatus().equals("pending")) {
                    request.setAttribute("error", "Your account is pending admin approval.");
                    request.getRequestDispatcher("pages/login.jsp").forward(request, response);
                    return;
                }
                if (userObj.getStatus().equals("suspended")) {
                    request.setAttribute("error", "Your account has been suspended.");
                    request.getRequestDispatcher("pages/login.jsp").forward(request, response);
                    return;
                }
                HttpSession session = request.getSession();
                session.setAttribute("user", userObj);
                if (userObj.getRole().equals("admin")) {
                    response.sendRedirect("/admin/dashboard");
                } else if (userObj.getRole().equals("donor")) {
                    response.sendRedirect("/donor/dashboard");
                } else {
                    response.sendRedirect("/organization/dashboard");
                }
            } else {
                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("pages/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("pages/login.jsp").forward(request, response);
        }
    }
}
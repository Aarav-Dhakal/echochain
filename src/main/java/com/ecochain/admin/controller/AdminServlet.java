package com.ecochain.admin.controller;

import com.ecochain.admin.model.Admin;
import com.ecochain.admin.model.dao.AdminDao;
import com.ecochain.user.model.User;
import com.ecochain.user.model.dao.UserDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(value = "/admin/*")
public class AdminServlet extends HttpServlet {
    // Install admin on startup
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals("admin")) {
            resp.sendRedirect("/login");
            return;
        }

        String path = req.getPathInfo();

        try {
            if ("/dashboard".equals(path)) {
                int totalUsers = AdminDao.getTotalUsers();
                int pendingUsers = AdminDao.getPendingUsers();
                int totalListings = AdminDao.getTotalListings();
                int totalPickups = AdminDao.getTotalPickups();
                double totalFoodRescued = AdminDao.getTotalFoodRescued();
                double totalCO2Saved = AdminDao.getTotalCO2Saved();
                int totalMealsServed = AdminDao.getTotalMealsServed();

                req.setAttribute("totalUsers", totalUsers);
                req.setAttribute("pendingUsers", pendingUsers);
                req.setAttribute("totalListings", totalListings);
                req.setAttribute("totalPickups", totalPickups);
                req.setAttribute("totalFoodRescued", totalFoodRescued);
                req.setAttribute("totalCO2Saved", totalCO2Saved);
                req.setAttribute("totalMealsServed", totalMealsServed);

                req.getRequestDispatcher("/pages/admin/dashboard.jsp").forward(req, resp);

            } else if ("/users".equals(path)) {
                List<Admin> users = AdminDao.fetchAllUsers();
                req.setAttribute("users", users);
                req.getRequestDispatcher("/pages/admin/user-management.jsp").forward(req, resp);

            } else if ("/categories".equals(path)) {
                List<String> categories = AdminDao.fetchAllCategories();
                req.setAttribute("categories", categories);
                req.getRequestDispatcher("/pages/admin/category-management.jsp").forward(req, resp);
            } else if ("/listings".equals(path)) {
                List<com.ecochain.listing.model.Listing> listings = com.ecochain.listing.model.dao.ListingDao.fetchAllListings();
                req.setAttribute("listings", listings);
                req.getRequestDispatcher("/pages/admin/listing-moderation.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/pages/admin/dashboard.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals("admin")) {
            resp.sendRedirect("/login");
            return;
        }

        String action = req.getParameter("action");

        try {
            if ("approve".equals(action)) {
                int userId = Integer.parseInt(req.getParameter("userId"));
                AdminDao.approveUser(userId);
                resp.sendRedirect("/admin/users");

            } else if ("suspend".equals(action)) {
                int userId = Integer.parseInt(req.getParameter("userId"));
                AdminDao.suspendUser(userId);
                resp.sendRedirect("/admin/users");

            } else if ("delete".equals(action)) {
                int userId = Integer.parseInt(req.getParameter("userId"));
                AdminDao.deleteUser(userId);
                resp.sendRedirect("/admin/users");

            } else if ("addCategory".equals(action)) {
                String name = req.getParameter("name");
                AdminDao.insertCategory(name);
                resp.sendRedirect("/admin/categories");

            } else if ("deleteCategory".equals(action)) {
                int categoryId = Integer.parseInt(req.getParameter("categoryId"));
                AdminDao.deleteCategory(categoryId);
                resp.sendRedirect("/admin/categories");

            } else if ("deleteListing".equals(action)) {
                int listingId = Integer.parseInt(req.getParameter("listingId"));
                com.ecochain.listing.model.dao.ListingDao.deleteListing(listingId);
                resp.sendRedirect("/admin/listings");
            }

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/pages/admin/dashboard.jsp").forward(req, resp);
        }
    }
}

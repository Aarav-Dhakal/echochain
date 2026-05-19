package com.ecochain.donor.controller;

import com.ecochain.donor.model.Donor;
import com.ecochain.donor.model.dao.DonorDao;
import com.ecochain.user.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.ecochain.pickup.model.PickupRequestDTO;
import com.ecochain.pickup.model.dao.PickupDao;

import java.io.IOException;
import java.util.List;

@WebServlet("/donor/*")
public class DonorServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals("donor")) {
            resp.sendRedirect("/login");
            return;
        }

        String path = req.getPathInfo();

        try {
            Donor donor = DonorDao.fetchDonorByUserId(user.getId());

            if (donor == null && !"/complete-profile".equals(path)) {
                resp.sendRedirect("/donor/complete-profile");
                return;
            }

            if ("/dashboard".equals(path)) {
                int totalListings = DonorDao.getTotalListings(donor.getId());
                int totalPickups = DonorDao.getTotalPickups(donor.getId());
                req.setAttribute("donor", donor);
                req.setAttribute("totalListings", totalListings);
                req.setAttribute("totalPickups", totalPickups);
                req.getRequestDispatcher("/pages/donor/dashboard.jsp").forward(req, resp);

            } else if ("/pickup-requests".equals(path)) {
                List<PickupRequestDTO> requests = PickupDao.fetchPickupsByDonorId(donor.getId());
                req.setAttribute("requests", requests);
                req.getRequestDispatcher("/pages/donor/pickup-requests.jsp").forward(req, resp);

            } else if ("/history".equals(path)) {
                List<PickupRequestDTO> requests = PickupDao.fetchPickupsByDonorId(donor.getId());
                req.setAttribute("requests", requests);
                req.getRequestDispatcher("/pages/donor/donation-history.jsp").forward(req, resp);

            } else if ("/complete-profile".equals(path)) {
                req.getRequestDispatcher("/pages/donor/complete-profile.jsp").forward(req, resp);
            } else if ("/profile".equals(path)) {
                req.setAttribute("donor", donor);
                req.getRequestDispatcher("/pages/donor/profile.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/pages/donor/dashboard.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals("donor")) {
            resp.sendRedirect("/login");
            return;
        }

        String action = req.getParameter("action");

        try {
            if ("completeProfile".equals(action)) {
                String businessName = req.getParameter("businessName");
                String address = req.getParameter("address");
                String licenseNumber = req.getParameter("licenseNumber");
                String phone = req.getParameter("phone");

                Donor donor = new Donor();
                donor.setUserId(user.getId());
                donor.setBusinessName(businessName);
                donor.setAddress(address);
                donor.setLicenseNumber(licenseNumber);
                donor.setPhone(phone);

                boolean result = DonorDao.insertDonor(donor);
                if (result) {
                    resp.sendRedirect("/donor/dashboard");
                } else {
                    req.setAttribute("error", "Failed to save profile.");
                    req.getRequestDispatcher("/pages/donor/complete-profile.jsp").forward(req, resp);
                }
            } else if ("approvePickup".equals(action)) {
                int pickupId = Integer.parseInt(req.getParameter("pickupId"));
                PickupDao.updatePickupStatus(pickupId, "approved");
                resp.sendRedirect("/donor/pickup-requests");

            } else if ("rejectPickup".equals(action)) {
                int pickupId = Integer.parseInt(req.getParameter("pickupId"));
                PickupDao.updatePickupStatus(pickupId, "rejected");
                resp.sendRedirect("/donor/pickup-requests");

            } else if ("completePickup".equals(action)) {
                int pickupId = Integer.parseInt(req.getParameter("pickupId"));
                double quantity = Double.parseDouble(req.getParameter("quantity"));
                PickupDao.completePickup(pickupId, quantity);
                resp.sendRedirect("/donor/pickup-requests");
            } else if ("updateProfile".equals(action)) {
                String fullName = req.getParameter("fullName");
                String email = req.getParameter("email");
                String businessName = req.getParameter("businessName");
                String address = req.getParameter("address");
                String licenseNumber = req.getParameter("licenseNumber");
                String phone = req.getParameter("phone");

                com.ecochain.user.model.dao.UserDao.updateUser(user.getId(), fullName, email);
                user.setFullName(fullName);
                user.setEmail(email);
                session.setAttribute("user", user);

                Donor donor = DonorDao.fetchDonorByUserId(user.getId());
                donor.setBusinessName(businessName);
                donor.setAddress(address);
                donor.setLicenseNumber(licenseNumber);
                donor.setPhone(phone);

                DonorDao.updateDonor(donor);
                req.setAttribute("success", "Profile updated successfully!");
                req.setAttribute("donor", donor);
                req.getRequestDispatcher("/pages/donor/profile.jsp").forward(req, resp);

            } else if ("changePassword".equals(action)) {
                String currentPassword = req.getParameter("currentPassword");
                String newPassword = req.getParameter("newPassword");
                String confirmPassword = req.getParameter("confirmPassword");

                if (!newPassword.equals(confirmPassword)) {
                    req.setAttribute("error", "New passwords do not match.");
                } else if (!com.ecochain.utils.PasswordManager.checkPassword(currentPassword, user.getPassword())) {
                    req.setAttribute("error", "Incorrect current password.");
                } else {
                    com.ecochain.user.model.dao.UserDao.updatePassword(user.getId(), newPassword);
                    user.setPassword(com.ecochain.utils.PasswordManager.hashPassword(newPassword));
                    req.setAttribute("success", "Password changed successfully!");
                }
                req.setAttribute("donor", DonorDao.fetchDonorByUserId(user.getId()));
                req.getRequestDispatcher("/pages/donor/profile.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/pages/donor/complete-profile.jsp").forward(req, resp);
        }
    }
}

package com.ecochain.organization.controller;

import com.ecochain.listing.model.Listing;
import com.ecochain.listing.model.dao.ListingDao;
import com.ecochain.organization.model.Organization;
import com.ecochain.organization.model.dao.OrganizationDao;
import com.ecochain.user.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.ecochain.pickup.model.OrgPickupRequestDTO;
import com.ecochain.pickup.model.dao.PickupDao;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/organization/*")
public class OrganizationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals("organization")) {
            resp.sendRedirect("/login");
            return;
        }

        String path = req.getPathInfo();

        try {
            Organization org = OrganizationDao.fetchOrganizationByUserId(user.getId());

            if (org == null && !"/complete-profile".equals(path)) {
                resp.sendRedirect("/organization/complete-profile");
                return;
            }

            if ("/dashboard".equals(path)) {
                int totalRequests = OrganizationDao.getTotalRequests(org.getId());
                int completedPickups = OrganizationDao.getCompletedPickups(org.getId());
                req.setAttribute("org", org);
                req.setAttribute("totalRequests", totalRequests);
                req.setAttribute("completedPickups", completedPickups);
                req.getRequestDispatcher("/pages/organization/dashboard.jsp").forward(req, resp);

            } else if ("/browse".equals(path)) {
                String query = req.getParameter("query");
                List<Listing> listings;
                if (query != null && !query.isEmpty()) {
                    listings = ListingDao.searchListings(query);
                } else {
                    listings = ListingDao.fetchAllAvailableListings();
                }
                req.setAttribute("listings", listings);
                req.getRequestDispatcher("/pages/organization/browse-listings.jsp").forward(req, resp);

            } else if ("/my-requests".equals(path)) {
                List<OrgPickupRequestDTO> requests = PickupDao.fetchPickupsByOrgId(org.getId());
                req.setAttribute("requests", requests);
                req.getRequestDispatcher("/pages/organization/my-requests.jsp").forward(req, resp);

            } else if ("/complete-profile".equals(path)) {
                req.getRequestDispatcher("/pages/organization/complete-profile.jsp").forward(req, resp);
            } else if ("/profile".equals(path)) {
                req.setAttribute("org", org);
                req.getRequestDispatcher("/pages/organization/profile.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            getServletContext().log("Exception in OrganizationServlet.doGet", e);
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/pages/organization/dashboard.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals("organization")) {
            resp.sendRedirect("/login");
            return;
        }

        String action = req.getParameter("action");

        try {
            if ("completeProfile".equals(action)) {
                String orgName = req.getParameter("orgName");
                String address = req.getParameter("address");
                String phone = req.getParameter("phone");
                String areaOfService = req.getParameter("areaOfService");
                String regCertificate = req.getParameter("regCertificate");

                Organization org = new Organization();
                org.setUserId(user.getId());
                org.setOrgName(orgName);
                org.setAddress(address);
                org.setPhone(phone);
                org.setAreaOfService(areaOfService);
                org.setRegCertificate(regCertificate);

                boolean result = OrganizationDao.insertOrganization(org);
                if (result) {
                    resp.sendRedirect("/organization/dashboard");
                } else {
                    req.setAttribute("error", "Failed to save profile.");
                    req.getRequestDispatcher("/pages/organization/complete-profile.jsp").forward(req, resp);
                }
            } else if ("rateDonor".equals(action)) {
                int pickupId = Integer.parseInt(req.getParameter("pickupId"));
                int rating = Integer.parseInt(req.getParameter("rating"));
                String comment = req.getParameter("comment");

                // Fetch donor info from pickup
                com.ecochain.pickup.model.OrgPickupRequestDTO pickup = null;
                List<com.ecochain.pickup.model.OrgPickupRequestDTO> requests = com.ecochain.pickup.model.dao.PickupDao.fetchPickupsByOrgId(OrganizationDao.fetchOrganizationByUserId(user.getId()).getId());
                for(com.ecochain.pickup.model.OrgPickupRequestDTO r : requests) {
                    if(r.getPickupId() == pickupId) {
                        pickup = r;
                        break;
                    }
                }

                if (pickup != null) {
                    com.ecochain.rating.model.dao.RatingDao.insertRating(pickupId, rating, comment);
                    resp.sendRedirect("/organization/my-requests");
                }
            } else if ("updateProfile".equals(action)) {
                String fullName = req.getParameter("fullName");
                String email = req.getParameter("email");
                String orgName = req.getParameter("orgName");
                String address = req.getParameter("address");
                String phone = req.getParameter("phone");
                String areaOfService = req.getParameter("areaOfService");
                String regCertificate = req.getParameter("regCertificate");

                com.ecochain.user.model.dao.UserDao.updateUser(user.getId(), fullName, email);
                user.setFullName(fullName);
                user.setEmail(email);
                session.setAttribute("user", user);

                Organization org = OrganizationDao.fetchOrganizationByUserId(user.getId());
                org.setOrgName(orgName);
                org.setAddress(address);
                org.setPhone(phone);
                org.setAreaOfService(areaOfService);
                org.setRegCertificate(regCertificate);

                OrganizationDao.updateOrganization(org);
                req.setAttribute("success", "Profile updated successfully!");
                req.setAttribute("org", org);
                req.getRequestDispatcher("/pages/organization/profile.jsp").forward(req, resp);

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
                req.setAttribute("org", OrganizationDao.fetchOrganizationByUserId(user.getId()));
                req.getRequestDispatcher("/pages/organization/profile.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            getServletContext().log("Exception in OrganizationServlet.doPost", e);
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/pages/organization/complete-profile.jsp").forward(req, resp);
        }
    }
}
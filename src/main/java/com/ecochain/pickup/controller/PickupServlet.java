package com.ecochain.pickup.controller;

import com.ecochain.organization.model.Organization;
import com.ecochain.organization.model.dao.OrganizationDao;
import com.ecochain.pickup.model.Pickup;
import com.ecochain.pickup.model.dao.PickupDao;
import com.ecochain.user.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/pickup/*")
public class PickupServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Redirect to dashboard or browse if accessed via GET
        resp.sendRedirect("/organization/browse");
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

        String path = req.getPathInfo();
        String action = req.getParameter("action");

        try {
            Organization org = OrganizationDao.fetchOrganizationByUserId(user.getId());

            if ("/request".equals(path) || "requestPickup".equals(action)) {
                int listingId = Integer.parseInt(req.getParameter("listingId"));

                Pickup pickup = new Pickup();
                pickup.setListingId(listingId);
                pickup.setOrgId(org.getId());
                pickup.setQuantity(0);
                pickup.setPickupTime(new Timestamp(System.currentTimeMillis()));
                pickup.setStatus("pending");
                pickup.setNotes("");

                boolean result = PickupDao.insertPickup(pickup);
                if (result) {
                    resp.sendRedirect("/organization/browse");
                } else {
                    req.setAttribute("error", "Failed to request pickup.");
                    resp.sendRedirect("/organization/browse");
                }
            }

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            resp.sendRedirect("/organization/browse");
        }
    }
}
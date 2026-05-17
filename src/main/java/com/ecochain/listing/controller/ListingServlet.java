package com.ecochain.listing.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import com.ecochain.donor.model.Donor;
import com.ecochain.donor.model.dao.DonorDao;
import com.ecochain.listing.model.Listing;
import com.ecochain.listing.model.dao.ListingDao;
import com.ecochain.user.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/listing/*")
public class ListingServlet extends HttpServlet {
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

            if ("/add".equals(path)) {
                List<String> categories = ListingDao.fetchAllCategories();
                req.setAttribute("categories", categories);
                req.getRequestDispatcher("/pages/donor/add-listing.jsp").forward(req, resp);

            } else if ("/my-listings".equals(path)) {
                List<Listing> listings = ListingDao.fetchListingsByDonorId(donor.getId());
                req.setAttribute("listings", listings);
                req.getRequestDispatcher("/pages/donor/my-listings.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/pages/donor/add-listing.jsp").forward(req, resp);
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
            Donor donor = DonorDao.fetchDonorByUserId(user.getId());

            if ("addListing".equals(action)) {
                int categoryId = Integer.parseInt(req.getParameter("categoryId"));
                String foodName = req.getParameter("foodName");
                double quantity = Double.parseDouble(req.getParameter("quantity"));
                String unit = req.getParameter("unit");
                Date expiryDate = Date.valueOf(req.getParameter("expiryDate"));
                String storageNotes = req.getParameter("storageNotes");
                String allergens = req.getParameter("allergens");

                Listing listing = new Listing();
                listing.setDonorId(donor.getId());
                listing.setCategoryId(categoryId);
                listing.setFoodName(foodName);
                listing.setQuantity(quantity);
                listing.setUnit(unit);
                listing.setExpiryDate(expiryDate);
                listing.setStorageNotes(storageNotes);
                listing.setAllergens(allergens);

                boolean result = ListingDao.insertListing(listing);
                if (result) {
                    resp.sendRedirect("/listing/my-listings");
                } else {
                    req.setAttribute("error", "Failed to add listing.");
                    req.getRequestDispatcher("/pages/donor/add-listing.jsp").forward(req, resp);
                }

            } else if ("deleteListing".equals(action)) {
                int listingId = Integer.parseInt(req.getParameter("listingId"));
                ListingDao.deleteListing(listingId);
                resp.sendRedirect("/listing/my-listings");
            }

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/pages/donor/add-listing.jsp").forward(req, resp);
        }
    }
}
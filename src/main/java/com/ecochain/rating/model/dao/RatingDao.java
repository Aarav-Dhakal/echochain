package com.ecochain.rating.model.dao;

import com.ecochain.utils.DbConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RatingDao {
    public static boolean insertRating(int pickupId, int rating, String comment) throws SQLException {
        // First get donor_id and org_id from pickup
        String getIds = "SELECT listing_id, org_id FROM pickups WHERE id = ?";
        int listingId = 0, orgId = 0, donorId = 0;

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(getIds)) {
            st.setInt(1, pickupId);
            java.sql.ResultSet rs = st.executeQuery();
            if (rs.next()) {
                listingId = rs.getInt("listing_id");
                orgId = rs.getInt("org_id");
            }
        }

        if (listingId > 0) {
            String getDonorId = "SELECT donor_id FROM listings WHERE id = ?";
            try (Connection conn = DbConnection.getConnection();
                 PreparedStatement st = conn.prepareStatement(getDonorId)) {
                st.setInt(1, listingId);
                java.sql.ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    donorId = rs.getInt("donor_id");
                }
            }
        }

        String query = "INSERT INTO ratings (pickup_id, donor_id, org_id, rating, comment) VALUES (?,?,?,?,?)";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, pickupId);
            st.setInt(2, donorId);
            st.setInt(3, orgId);
            st.setInt(4, rating);
            st.setString(5, comment);
            return st.executeUpdate() > 0;
        }
    }
}
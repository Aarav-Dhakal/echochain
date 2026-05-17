package com.ecochain.pickup.model.dao;

import com.ecochain.pickup.model.Pickup;
import com.ecochain.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PickupDao {
    public static boolean insertPickup(Pickup pickup) throws SQLException {
        String query = "INSERT INTO pickups (listing_id, org_id, quantity, pickup_time, status, notes) VALUES (?,?,?,?,?,?)";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, pickup.getListingId());
            st.setInt(2, pickup.getOrgId());
            st.setDouble(3, pickup.getQuantity());
            st.setTimestamp(4, pickup.getPickupTime());
            st.setString(5, pickup.getStatus());
            st.setString(6, pickup.getNotes());
            int rowsInserted = st.executeUpdate();

            if (rowsInserted > 0) {
                String updateListing = "UPDATE listings SET status = 'requested' WHERE id = ?";
                try (PreparedStatement ps = conn.prepareStatement(updateListing)) {
                    ps.setInt(1, pickup.getListingId());
                    ps.executeUpdate();
                }
                return true;
            }
        }
        return false;
    }
    public static java.util.List<com.ecochain.pickup.model.PickupRequestDTO> fetchPickupsByDonorId(int donorId) throws SQLException {
        java.util.List<com.ecochain.pickup.model.PickupRequestDTO> requests = new java.util.ArrayList<>();
        String query = "SELECT p.id, l.food_name, o.org_name, p.quantity, p.status, p.pickup_time, p.notes " +
                "FROM pickups p " +
                "JOIN listings l ON p.listing_id = l.id " +
                "JOIN organizations o ON p.org_id = o.id " +
                "WHERE l.donor_id = ? " +
                "ORDER BY p.pickup_time DESC";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, donorId);
            java.sql.ResultSet rs = st.executeQuery();
            while (rs.next()) {
                com.ecochain.pickup.model.PickupRequestDTO dto = new com.ecochain.pickup.model.PickupRequestDTO();
                dto.setPickupId(rs.getInt("id"));
                dto.setFoodName(rs.getString("food_name"));
                dto.setOrgName(rs.getString("org_name"));
                dto.setQuantity(rs.getDouble("quantity"));
                dto.setStatus(rs.getString("status"));
                dto.setPickupTime(rs.getTimestamp("pickup_time"));
                dto.setNotes(rs.getString("notes"));
                requests.add(dto);
            }
        }
        return requests;
    }
    public static java.util.List<com.ecochain.pickup.model.OrgPickupRequestDTO> fetchPickupsByOrgId(int orgId) throws SQLException {
        java.util.List<com.ecochain.pickup.model.OrgPickupRequestDTO> requests = new java.util.ArrayList<>();
        String query = "SELECT p.id, l.food_name, d.business_name, d.address, d.phone, p.status, p.pickup_time " +
                "FROM pickups p " +
                "JOIN listings l ON p.listing_id = l.id " +
                "JOIN donors d ON l.donor_id = d.id " +
                "WHERE p.org_id = ? " +
                "ORDER BY p.pickup_time DESC";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, orgId);
            java.sql.ResultSet rs = st.executeQuery();
            while (rs.next()) {
                com.ecochain.pickup.model.OrgPickupRequestDTO dto = new com.ecochain.pickup.model.OrgPickupRequestDTO();
                dto.setPickupId(rs.getInt("id"));
                dto.setFoodName(rs.getString("food_name"));
                dto.setDonorName(rs.getString("business_name"));
                dto.setDonorAddress(rs.getString("address"));
                dto.setDonorPhone(rs.getString("phone"));
                dto.setStatus(rs.getString("status"));
                dto.setPickupTime(rs.getTimestamp("pickup_time"));
                requests.add(dto);
            }
        }
        return requests;
    }

    public static boolean updatePickupStatus(int pickupId, String status) throws SQLException {
        String query = "UPDATE pickups SET status = ? WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setString(1, status);
            st.setInt(2, pickupId);
            return st.executeUpdate() > 0;
        }
    }

    public static boolean completePickup(int pickupId, double quantity) throws SQLException {
        String getInfoQuery = "SELECT listing_id, org_id FROM pickups WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(getInfoQuery)) {
            st.setInt(1, pickupId);
            java.sql.ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int listingId = rs.getInt("listing_id");
                int orgId = rs.getInt("org_id");

                conn.setAutoCommit(false);
                try {
                    // Update pickup
                    String updatePickup = "UPDATE pickups SET status = 'completed', quantity = ? WHERE id = ?";
                    try (PreparedStatement ps1 = conn.prepareStatement(updatePickup)) {
                        ps1.setDouble(1, quantity);
                        ps1.setInt(2, pickupId);
                        ps1.executeUpdate();
                    }

                    // Update listing
                    String updateListing = "UPDATE listings SET status = 'picked_up' WHERE id = ?";
                    try (PreparedStatement ps2 = conn.prepareStatement(updateListing)) {
                        ps2.setInt(1, listingId);
                        ps2.executeUpdate();
                    }

                    // Update organization total intake
                    String updateOrg = "UPDATE organizations SET total_food_received = total_food_received + ? WHERE id = ?";
                    try (PreparedStatement ps3 = conn.prepareStatement(updateOrg)) {
                        ps3.setDouble(1, quantity);
                        ps3.setInt(2, orgId);
                        ps3.executeUpdate();
                    }

                    conn.commit();
                    return true;
                } catch (SQLException e) {
                    conn.rollback();
                    throw e;
                } finally {
                    conn.setAutoCommit(true);
                }
            }
        }
        return false;
    }
}
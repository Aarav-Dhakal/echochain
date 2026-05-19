package com.ecochain.donor.model.dao;

import com.ecochain.donor.model.Donor;
import com.ecochain.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DonorDao {
    public static boolean insertDonor(Donor donor) throws SQLException {
        String query = "INSERT INTO donors (user_id, business_name, address, license_number, phone) VALUES (?,?,?,?,?)";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, donor.getUserId());
            st.setString(2, donor.getBusinessName());
            st.setString(3, donor.getAddress());
            st.setString(4, donor.getLicenseNumber());
            st.setString(5, donor.getPhone());
            int rowsInserted = st.executeUpdate();
            return rowsInserted > 0;
        }
    }

    public static Donor fetchDonorByUserId(int userId) throws SQLException {
        String query = "SELECT * FROM donors WHERE user_id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String businessName = rs.getString("business_name");
                String address = rs.getString("address");
                String licenseNumber = rs.getString("license_number");
                String phone = rs.getString("phone");
                double reputationScore = getReputationScore(id);
                return new Donor(id, userId, businessName, address, licenseNumber, phone, reputationScore);
            }
        }
        return null;
    }

    public static double getReputationScore(int donorId) throws SQLException {
        String query = "SELECT AVG(rating) FROM ratings WHERE donor_id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, donorId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                double score = rs.getDouble(1);
                return score > 0 ? score : 5.0; // Default to 5.0 if no ratings yet
            }
        }
        return 5.0;
    }

    public static int getTotalListings(int donorId) throws SQLException {
        String query = "SELECT COUNT(*) FROM listings WHERE donor_id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, donorId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public static int getTotalPickups(int donorId) throws SQLException {
        String query = "SELECT COUNT(*) FROM pickups p JOIN listings l ON p.listing_id = l.id WHERE l.donor_id = ? AND p.status = 'completed'";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, donorId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public static boolean updateDonor(Donor donor) throws SQLException {
        String query = "UPDATE donors SET business_name = ?, address = ?, license_number = ?, phone = ? WHERE user_id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setString(1, donor.getBusinessName());
            st.setString(2, donor.getAddress());
            st.setString(3, donor.getLicenseNumber());
            st.setString(4, donor.getPhone());
            st.setInt(5, donor.getUserId());
            return st.executeUpdate() > 0;
        }
    }
}

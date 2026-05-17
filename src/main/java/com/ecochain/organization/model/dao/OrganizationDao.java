package com.ecochain.organization.model.dao;

import com.ecochain.organization.model.Organization;
import com.ecochain.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class OrganizationDao {
    public static boolean insertOrganization(Organization org) throws SQLException {
        String query = "INSERT INTO organizations (user_id, org_name, address, phone, area_of_service, reg_certificate) VALUES (?,?,?,?,?,?)";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, org.getUserId());
            st.setString(2, org.getOrgName());
            st.setString(3, org.getAddress());
            st.setString(4, org.getPhone());
            st.setString(5, org.getAreaOfService());
            st.setString(6, org.getRegCertificate());
            int rowsInserted = st.executeUpdate();
            return rowsInserted > 0;
        }
    }

    public static Organization fetchOrganizationByUserId(int userId) throws SQLException {
        String query = "SELECT * FROM organizations WHERE user_id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String orgName = rs.getString("org_name");
                String address = rs.getString("address");
                String phone = rs.getString("phone");
                String areaOfService = rs.getString("area_of_service");
                String regCertificate = rs.getString("reg_certificate");
                double totalFoodReceived = rs.getDouble("total_food_received");
                return new Organization(id, userId, orgName, address, phone, areaOfService, regCertificate, totalFoodReceived);
            }
        }
        return null;
    }

    public static int getTotalRequests(int orgId) throws SQLException {
        String query = "SELECT COUNT(*) FROM pickups WHERE org_id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, orgId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public static int getCompletedPickups(int orgId) throws SQLException {
        String query = "SELECT COUNT(*) FROM pickups WHERE org_id = ? AND status = 'completed'";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, orgId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public static boolean updateOrganization(Organization org) throws SQLException {
        String query = "UPDATE organizations SET org_name = ?, address = ?, phone = ?, area_of_service = ?, reg_certificate = ? WHERE user_id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setString(1, org.getOrgName());
            st.setString(2, org.getAddress());
            st.setString(3, org.getPhone());
            st.setString(4, org.getAreaOfService());
            st.setString(5, org.getRegCertificate());
            st.setInt(6, org.getUserId());
            return st.executeUpdate() > 0;
        }
    }
}
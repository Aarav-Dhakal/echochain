package com.ecochain.admin.model.dao;

import com.ecochain.admin.model.Admin;
import com.ecochain.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminDao {
    // Get all users except admin
    public static List<Admin> fetchAllUsers() throws SQLException {
        String query = "SELECT * FROM users WHERE role != 'admin'";
        List<Admin> users = new ArrayList<>();
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String fullName = rs.getString("full_name");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String role = rs.getString("role");
                String status = rs.getString("status");
                Admin user = new Admin(id, fullName, email, password, role, status);
                users.add(user);
            }
        }
        return users;
    }

    public static boolean approveUser(int userId) throws SQLException {
        String query = "UPDATE users SET status = 'active' WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, userId);
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public static boolean suspendUser(int userId) throws SQLException {
        String query = "UPDATE users SET status = 'suspended' WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, userId);
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public static boolean deleteUser(int userId) throws SQLException {
        String query = "DELETE FROM users WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, userId);
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public static int getTotalUsers() throws SQLException {
        String query = "SELECT COUNT(*) FROM users WHERE role != 'admin'";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public static int getPendingUsers() throws SQLException {
        String query = "SELECT COUNT(*) FROM users WHERE status = 'pending'";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public static int getTotalListings() throws SQLException {
        String query = "SELECT COUNT(*) FROM listings";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public static int getTotalPickups() throws SQLException {
        String query = "SELECT COUNT(*) FROM pickups WHERE status = 'completed'";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public static List<String> fetchAllCategories() throws SQLException {
        String query = "SELECT * FROM categories";
        List<String> categories = new ArrayList<>();
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                categories.add(id + ":" + name);
            }
        }
        return categories;
    }

    public static boolean insertCategory(String name) throws SQLException {
        String query = "INSERT INTO categories (name) VALUES (?)";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setString(1, name);
            int rowsInserted = st.executeUpdate();
            return rowsInserted > 0;
        }
    }

    public static boolean deleteCategory(int categoryId) throws SQLException {
        String query = "DELETE FROM categories WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, categoryId);
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public static double getTotalFoodRescued() throws SQLException {
        String query = "SELECT SUM(quantity) FROM pickups WHERE status = 'completed'";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        }
        return 0;
    }

    public static double getTotalCO2Saved() throws SQLException {
        return getTotalFoodRescued() * 2.5;
    }

    public static int getTotalMealsServed() throws SQLException {
        return (int) (getTotalFoodRescued() * 2.5);
    }
}

package com.ecochain.user.model.dao;

import com.ecochain.user.model.User;
import com.ecochain.utils.DbConnection;
import com.ecochain.utils.PasswordManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {

    public static boolean insertUser(String fullName, String email, String password, String role) throws SQLException {
        String query = "INSERT INTO users (full_name, email, password, role, status) VALUES (?,?,?,?,'pending')";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setString(1, fullName);
            st.setString(2, email);
            st.setString(3, password);
            st.setString(4, role);
            int rowsInserted = st.executeUpdate();
            return rowsInserted > 0;
        }
    }

    public static boolean emailExists(String email) throws SQLException {
        String query = "SELECT id FROM users WHERE email = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            return rs.next();
        }
    }

    public static User loginUser(String email, String password) throws SQLException {
        String query = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                String storedPassword = rs.getString("password");
                String role = rs.getString("role");

                boolean passwordMatch;
                if (role.equals("admin")) {
                    passwordMatch = password.equals(storedPassword);
                } else {
                    passwordMatch = PasswordManager.checkPassword(password, storedPassword);
                }

                if (passwordMatch) {
                    int id = rs.getInt("id");
                    String fullName = rs.getString("full_name");
                    String status = rs.getString("status");
                    return new User(id, fullName, email, storedPassword, role, status);
                }
            }
            return null;
        }
    }

    public static boolean installAdmin() throws SQLException {
        String checkQuery = "SELECT id FROM users WHERE role = 'admin' LIMIT 1";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(checkQuery)) {
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return false;
            }
        }

        String insertQuery = "INSERT INTO users (full_name, email, password, role, status) VALUES (?, ?, ?, 'admin', 'active')";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(insertQuery)) {
            st.setString(1, "Admin");
            st.setString(2, "admin@ecochain.com");
            st.setString(3, "admin123");
            return st.executeUpdate() > 0;
        }
    }

    public static boolean updateUser(int userId, String fullName, String email) throws SQLException {
        String query = "UPDATE users SET full_name = ?, email = ? WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setString(1, fullName);
            st.setString(2, email);
            st.setInt(3, userId);
            return st.executeUpdate() > 0;
        }
    }

    public static boolean updatePassword(int userId, String newPassword) throws SQLException {
        String query = "UPDATE users SET password = ? WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setString(1, PasswordManager.hashPassword(newPassword));
            st.setInt(2, userId);
            return st.executeUpdate() > 0;
        }
    }
}
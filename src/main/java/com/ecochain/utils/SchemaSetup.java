package com.ecochain.utils;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.SQLException;

public class SchemaSetup {
    public static void init() {
        try (Connection conn = DbConnection.getConnection();
             Statement st = conn.createStatement()) {

            // Create ratings table
            st.execute("CREATE TABLE IF NOT EXISTS ratings (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "pickup_id INT NOT NULL," +
                    "donor_id INT NOT NULL," +
                    "org_id INT NOT NULL," +
                    "rating INT CHECK (rating >= 1 AND rating <= 5)," +
                    "comment TEXT," +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                    ")");

            // Create notifications table
            st.execute("CREATE TABLE IF NOT EXISTS notifications (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "user_id INT NOT NULL," +
                    "message TEXT NOT NULL," +
                    "type VARCHAR(50)," +
                    "is_read BOOLEAN DEFAULT FALSE," +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                    ")");

            System.out.println("Database schema initialized successfully.");
        } catch (SQLException e) {
            System.err.println("Error initializing database schema: " + e.getMessage());
        }
    }
}

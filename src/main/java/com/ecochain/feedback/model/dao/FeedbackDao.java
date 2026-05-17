package com.ecochain.feedback.model.dao;

import com.ecochain.feedback.model.Feedback;
import com.ecochain.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class FeedbackDao {
    public static boolean insertFeedback(Feedback feedback) throws SQLException {
        String query = "INSERT INTO feedback (pickup_id, org_id, donor_id, rating, comment) VALUES (?,?,?,?,?)";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, feedback.getPickupId());
            st.setInt(2, feedback.getOrgId());
            st.setInt(3, feedback.getDonorId());
            st.setInt(4, feedback.getRating());
            st.setString(5, feedback.getComment());
            int rowsInserted = st.executeUpdate();
            return rowsInserted > 0;
        }
    }
}
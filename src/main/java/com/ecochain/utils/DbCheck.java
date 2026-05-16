package com.ecochain.utils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;

public class DbCheck {
    public static void main(String[] args) {
        try (Connection conn = DbConnection.getConnection();
             Statement st = conn.createStatement()) {

            String[] tables = {"listings", "pickups"};
            for (String table : tables) {
                System.out.println("Checking table: " + table);
                String query = "SELECT COLUMN_NAME, COLUMN_TYPE, CHARACTER_MAXIMUM_LENGTH " +
                        "FROM INFORMATION_SCHEMA.COLUMNS " +
                        "WHERE TABLE_SCHEMA = 'ecochain' AND TABLE_NAME = '" + table + "' AND COLUMN_NAME = 'status'";
                ResultSet rs = st.executeQuery(query);
                if (rs.next()) {
                    System.out.println("Column: " + rs.getString("COLUMN_NAME"));
                    System.out.println("Type: " + rs.getString("COLUMN_TYPE"));
                    System.out.println("Max Length: " + rs.getString("CHARACTER_MAXIMUM_LENGTH"));
                }
                System.out.println();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

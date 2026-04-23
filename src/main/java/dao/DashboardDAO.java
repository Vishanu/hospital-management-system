package dao;

import util.DBConnection;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class DashboardDAO {

    public int getCount(String tableName) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM " + tableName;
        try (Connection con = DBConnection.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // ✅ ADD THIS METHOD - Get all counts at once
    public int[] getAllCounts() {
        int[] counts = new int[3];
        try (Connection con = DBConnection.getConnection();
             Statement stmt = con.createStatement()) {

            ResultSet rs1 = stmt.executeQuery("SELECT COUNT(*) FROM doctors");
            if (rs1.next()) counts[0] = rs1.getInt(1);

            ResultSet rs2 = stmt.executeQuery("SELECT COUNT(*) FROM patients");
            if (rs2.next()) counts[1] = rs2.getInt(1);

            ResultSet rs3 = stmt.executeQuery("SELECT COUNT(*) FROM appointments");
            if (rs3.next()) counts[2] = rs3.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return counts;
    }
}
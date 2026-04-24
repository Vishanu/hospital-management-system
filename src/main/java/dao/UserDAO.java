package dao;

import java.sql.*;
import util.DBConnection;

public class UserDAO {

    public ResultSet loginUser(String email, String password) {
        String query = "SELECT * FROM users WHERE email = ? AND password = ?";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            return pst.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public String login(String email, String password) {
        String query = "SELECT role FROM users WHERE email = ? AND password = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(query)) {

            pst.setString(1, email);
            pst.setString(2, password);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                return rs.getString("role");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean register(String name, String email, String password, String role) {
        boolean status = false;

        try (Connection con = DBConnection.getConnection()) {

            String query = "INSERT INTO users(name,email,password,role) VALUES(?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, role.toLowerCase()); // 🔥 important

            int i = ps.executeUpdate();

            if (i > 0) status = true;

        } catch (Exception e) {
            e.printStackTrace(); // 🔥 console में error देखो
        }

        return status;
    }

    public int getUserId(String email) {
        int id = 0;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT id FROM users WHERE email=?"
            );
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                id = rs.getInt("id");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return id;
    }

    public boolean deleteUser(int id){
        boolean status = false;
        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM users WHERE id=?"
            );
            ps.setInt(1, id);

            if(ps.executeUpdate() > 0){
                status = true;
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return status;
    }
}
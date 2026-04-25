package dao;

import model.Doctor;
import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DoctorDAO {

    public boolean addDoctor(Doctor doctor) {
        boolean status = false;

        try (Connection con = DBConnection.getConnection()) {

            String sql = "INSERT INTO doctors(name, specialization, phone, user_id) VALUES(?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, doctor.getName());
            ps.setString(2, doctor.getSpecialization());
            ps.setString(3, doctor.getPhone());
            ps.setInt(4, doctor.getUserId());   // 🔥 FIX

            int i = ps.executeUpdate();

            if (i > 0) status = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public List<Doctor> getAllDoctors() {
        List<Doctor> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT * FROM doctors ORDER BY id DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Doctor d = new Doctor();
                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setSpecialization(rs.getString("specialization"));
                d.setPhone(rs.getString("phone"));
                d.setUserId(rs.getInt("user_id"));
                list.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getUserIdByDoctorId(int id) {
        int userId = 0;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT user_id FROM doctors WHERE id=?"
            );
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                userId = rs.getInt("user_id");
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return userId;
    }

    public int getDoctorCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM doctors";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean deleteDoctor(int id) {
        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM doctors WHERE id=?"
            );
            ps.setInt(1, id);

            int i = ps.executeUpdate();
            if(i > 0) status = true;

        } catch(Exception e){
            e.printStackTrace();
        }
        return status;
    }

    public int getDoctorIdByUserId(int userId) {
        int id = 0;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT id FROM doctors WHERE user_id=?"
            );
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                id = rs.getInt("id");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return id;
    }
}
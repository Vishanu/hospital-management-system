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
            String sql = "INSERT INTO doctors(name, specialization, phone) VALUES(?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, doctor.getName());
            ps.setString(2, doctor.getSpecialization());
            ps.setString(3, doctor.getPhone());
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
                list.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteDoctorById(int id) {
        boolean status = false;
        try (Connection con = DBConnection.getConnection()) {
            String sql = "DELETE FROM doctors WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            if(ps.executeUpdate() > 0) status = true;
        } catch(Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public boolean deleteDoctor(String name) {
        boolean status = false;
        try (Connection con = DBConnection.getConnection()) {
            String sql = "DELETE FROM doctors WHERE name = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            if(ps.executeUpdate() > 0) status = true;
        } catch(Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public Doctor getDoctorById(int id) {
        Doctor d = null;
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT * FROM doctors WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                d = new Doctor();
                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setSpecialization(rs.getString("specialization"));
                d.setPhone(rs.getString("phone"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return d;
    }

    // ✅ ADD THIS METHOD - Get doctor count
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
}
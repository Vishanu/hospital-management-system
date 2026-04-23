package dao;

import model.Patient;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PatientDAO {

    public boolean addPatient(Patient patient) {
        boolean status = false;
        String sql = "INSERT INTO patients(name, age, gender, phone, disease) VALUES(?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, patient.getName());
            ps.setInt(2, patient.getAge());
            ps.setString(3, patient.getGender());
            ps.setString(4, patient.getPhone());
            ps.setString(5, patient.getDisease());
            if (ps.executeUpdate() > 0) status = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // ✅ ADD THIS METHOD - Get all patients
    public List<Patient> getAllPatients() {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM patients ORDER BY id DESC";
        try (Connection con = DBConnection.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Patient p = new Patient();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setAge(rs.getInt("age"));
                p.setGender(rs.getString("gender"));
                p.setPhone(rs.getString("phone"));
                p.setDisease(rs.getString("disease"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Patient getPatientById(int id) {
        Patient p = null;
        String sql = "SELECT * FROM patients WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                p = new Patient();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setAge(rs.getInt("age"));
                p.setGender(rs.getString("gender"));
                p.setPhone(rs.getString("phone"));
                p.setDisease(rs.getString("disease"));
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return p;
    }

    public List<Patient> searchPatientByName(String name) {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM patients WHERE name LIKE ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Patient p = new Patient();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setAge(rs.getInt("age"));
                p.setGender(rs.getString("gender"));
                p.setPhone(rs.getString("phone"));
                p.setDisease(rs.getString("disease"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ ADD THIS METHOD - Delete patient by ID
    public boolean deletePatientById(int id) {
        boolean status = false;
        String sql = "DELETE FROM patients WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            if (ps.executeUpdate() > 0) status = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // ✅ ADD THIS METHOD - Get patient count
    public int getPatientCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM patients";
        try (Connection con = DBConnection.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}
package dao;

import model.Appointment;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    public boolean bookAppointment(int pId, int dId, String date) {
        boolean status = false;
        String sql = "INSERT INTO appointments(patient_id, doctor_id, appointment_date, status) VALUES(?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, pId);
            ps.setInt(2, dId);
            ps.setString(3, date);
            ps.setString(4, "Pending");
            if (ps.executeUpdate() > 0) status = true;
        } catch (Exception e) { e.printStackTrace(); }
        return status;
    }

    // ✅ ADD THIS METHOD - Get all appointments with patient and doctor names
    public List<Appointment> getAllAppointments() {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT a.id, a.patient_id, a.doctor_id, a.appointment_date, a.status, " +
                "p.name as patient_name, d.name as doctor_name " +
                "FROM appointments a " +
                "JOIN patients p ON a.patient_id = p.id " +
                "JOIN doctors d ON a.doctor_id = d.id " +
                "ORDER BY a.appointment_date DESC";
        try (Connection con = DBConnection.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Appointment a = new Appointment();
                a.setId(rs.getInt("id"));
                a.setPatientId(rs.getInt("patient_id"));
                a.setDoctorId(rs.getInt("doctor_id"));
                a.setPatientName(rs.getString("patient_name"));
                a.setDoctorName(rs.getString("doctor_name"));
                a.setAppointmentDate(rs.getString("appointment_date"));
                a.setStatus(rs.getString("status"));
                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Appointment> getAppointmentsByPatientId(int patientId) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT a.id, a.patient_id, a.doctor_id, a.appointment_date, a.status, " +
                "d.name as doctor_name " +
                "FROM appointments a " +
                "JOIN doctors d ON a.doctor_id = d.id " +
                "WHERE a.patient_id = ? " +
                "ORDER BY a.appointment_date DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, patientId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment a = new Appointment();
                a.setId(rs.getInt("id"));
                a.setPatientId(rs.getInt("patient_id"));
                a.setDoctorId(rs.getInt("doctor_id"));
                a.setDoctorName(rs.getString("doctor_name"));
                a.setAppointmentDate(rs.getString("appointment_date"));
                a.setStatus(rs.getString("status"));
                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateAppointmentStatus(int id, String newStatus) {
        boolean status = false;
        String sql = "UPDATE appointments SET status = ? WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, id);
            if (ps.executeUpdate() > 0) status = true;
        } catch (Exception e) { e.printStackTrace(); }
        return status;
    }

    public boolean deleteAppointment(int id) {
        boolean status = false;
        String sql = "DELETE FROM appointments WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            if (ps.executeUpdate() > 0) status = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public List<Appointment> getAppointmentsByDoctorId(int doctorId) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT a.id, p.name as pname, a.appointment_date, a.status " +
                "FROM appointments a " +
                "JOIN patients p ON a.patient_id = p.id " +
                "WHERE a.doctor_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, doctorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment a = new Appointment();
                a.setId(rs.getInt("id"));
                a.setPatientName(rs.getString("pname"));
                a.setAppointmentDate(rs.getString("appointment_date"));
                a.setStatus(rs.getString("status"));
                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ ADD THIS METHOD - Get appointment count
    public int getAppointmentCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM appointments";
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
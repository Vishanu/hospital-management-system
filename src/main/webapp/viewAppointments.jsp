<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, dao.AppointmentDAO, dao.PatientDAO, dao.DoctorDAO, model.Appointment" %>
<%@ page session="true" %>

<%
String role = (String) session.getAttribute("role");

if(role == null){
    response.sendRedirect("login.jsp");
    return;
}

AppointmentDAO dao = new AppointmentDAO();
List<Appointment> list = null;

Integer userId = (Integer) session.getAttribute("userId");

if(("patient".equals(role) || "doctor".equals(role)) && userId == null){
    response.sendRedirect("login.jsp");
    return;
}

// ✅ FIXED ROLE LOGIC
if("admin".equals(role)){

    list = dao.getAllAppointments();

} else if("patient".equals(role)){

    PatientDAO pdao = new PatientDAO();
    int patientId = pdao.getPatientIdByUserId(userId);

    list = dao.getAppointmentsByPatientId(patientId);

} else if("doctor".equals(role)){

    DoctorDAO ddao = new DoctorDAO();
    int doctorId = ddao.getDoctorIdByUserId(userId);

    list = dao.getAppointmentsByDoctorId(doctorId);
}

// Back page
String backPage = "login.jsp";
if("admin".equals(role)){
    backPage = "adminDashboard.jsp";
} else if("doctor".equals(role)){
    backPage = "doctorDashboard.jsp";
} else if("patient".equals(role)){
    backPage = "patientDashboard.jsp";
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Management System | Appointments</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #e0f2fe 0%, #bbf0d3 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }

        /* Centered Container */
        .appointments-wrapper {
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Card Style */
        .card {
            background: white;
            border-radius: 28px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.2s ease;
        }

        .card:hover {
            transform: translateY(-3px);
        }

        /* Header Section */
        .card-header {
            background: linear-gradient(135deg, #1e3a5f 0%, #2c5a7a 100%);
            padding: 35px 40px 30px;
            text-align: center;
        }

        .appointment-icon {
            font-size: 56px;
            margin-bottom: 12px;
        }

        .card-header h1 {
            color: white;
            font-size: 28px;
            font-weight: 600;
            letter-spacing: -0.3px;
            margin-bottom: 8px;
        }

        .card-header p {
            color: rgba(255, 255, 255, 0.85);
            font-size: 14px;
        }

        /* Role Badge */
        .role-badge {
            background: rgba(255, 255, 255, 0.2);
            display: inline-block;
            padding: 6px 18px;
            border-radius: 40px;
            font-size: 13px;
            margin-top: 15px;
            font-weight: 500;
            backdrop-filter: blur(5px);
        }

        /* Content Body */
        .card-body {
            padding: 35px 40px;
        }

        /* Table Container for Responsive Scroll */
        .table-container {
            overflow-x: auto;
            margin-bottom: 30px;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
        }

        /* Modern Table Design */
        .appointments-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
            min-width: 600px;
        }

        .appointments-table thead {
            background: linear-gradient(105deg, #1e3a5f 0%, #2c5a7a 100%);
        }

        .appointments-table th {
            padding: 16px 20px;
            text-align: left;
            color: white;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .appointments-table td {
            padding: 14px 20px;
            border-bottom: 1px solid #e2e8f0;
            color: #2c3e50;
        }

        .appointments-table tbody tr {
            transition: all 0.2s ease;
        }

        .appointments-table tbody tr:hover {
            background: #f8fafc;
            transform: scale(1.01);
        }

        .appointments-table tbody tr:last-child td {
            border-bottom: none;
        }

        /* Status Badges */
        .status-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 40px;
            font-size: 12px;
            font-weight: 600;
            text-align: center;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-approved {
            background: #d4edda;
            color: #155724;
        }

        .status-rejected {
            background: #fee2e2;
            color: #c0392b;
        }

        .status-completed {
            background: #d1ecf1;
            color: #0c5460;
        }

        .status-default {
            background: #e2e8f0;
            color: #4a5568;
        }

        /* Doctor Action Form */
        .action-form {
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }

        .action-select {
            padding: 8px 12px;
            border: 1.5px solid #e2e8f0;
            border-radius: 10px;
            font-size: 13px;
            font-family: inherit;
            background: #f8fafc;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .action-select:focus {
            border-color: #2ecc71;
            outline: none;
        }

        .btn-update {
            background: linear-gradient(105deg, #3498db 0%, #2980b9 100%);
            color: white;
            border: none;
            padding: 8px 18px;
            border-radius: 40px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-update:hover {
            background: linear-gradient(105deg, #2980b9 0%, #216795 100%);
            transform: scale(1.02);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: #f8fafc;
            border-radius: 16px;
            margin-bottom: 30px;
        }

        .empty-icon {
            font-size: 64px;
            margin-bottom: 15px;
        }

        .empty-title {
            font-size: 20px;
            font-weight: 600;
            color: #1e3a5f;
            margin-bottom: 8px;
        }

        .empty-text {
            color: #5a6e7c;
            font-size: 14px;
        }

        /* Back Button */
        .back-button {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: #e2e8f0;
            color: #1e3a5f;
            text-decoration: none;
            padding: 12px 28px;
            border-radius: 40px;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.2s ease;
        }

        .back-button:hover {
            background: #cbd5e1;
            transform: translateX(-3px);
        }

        /* Footer */
        .footer {
            text-align: center;
            padding-top: 25px;
            margin-top: 20px;
            border-top: 1px solid #e2e8f0;
            font-size: 12px;
            color: #5a6e7c;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .card-body {
                padding: 25px;
            }

            .card-header {
                padding: 25px 20px;
            }

            .card-header h1 {
                font-size: 22px;
            }

            .appointments-table th,
            .appointments-table td {
                padding: 12px 15px;
            }

            .action-form {
                flex-direction: column;
                align-items: stretch;
            }
        }
    </style>
</head>

<body>

<div class="appointments-wrapper">
    <div class="card">

        <!-- Header Section -->
        <div class="card-header">
            <div class="appointment-icon">📅</div>
            <h1>Hospital Management System</h1>
            <p>Appointment Management Portal</p>
            <div class="role-badge">
                <% if("admin".equals(role)){ %>
                    👑 Administrator Access
                <% } else if("doctor".equals(role)){ %>
                    👨‍⚕️ Doctor Access
                <% } else if("patient".equals(role)){ %>
                    👤 Patient Access
                <% } %>
            </div>
        </div>

        <!-- Content Body -->
        <div class="card-body">

            <div class="table-container">
                <table class="appointments-table">
                    <thead>
                        <tr>
                            <% if("admin".equals(role)){ %>
                                <th>ID</th>
                                <th>Patient</th>
                                <th>Doctor</th>
                                <th>Date</th>
                                <th>Status</th>
                            <% } else if("patient".equals(role)){ %>
                                <th>ID</th>
                                <th>Doctor</th>
                                <th>Date</th>
                                <th>Status</th>
                            <% } else if("doctor".equals(role)){ %>
                                <th>ID</th>
                                <th>Patient</th>
                                <th>Date</th>
                                <th>Status</th>
                                <th>Action</th>
                            <% } %>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        if(list != null && !list.isEmpty()){
                            for(Appointment a : list){
                        %>
                        <tr>
                            <% if("admin".equals(role)){ %>
                                <td><%= a.getId() %></td>
                                <td><%= a.getPatientName() %></td>
                                <td><%= a.getDoctorName() %></td>
                                <td><%= a.getAppointmentDate() %></td>
                                <td>
                                    <span class="status-badge
                                        <%= "Pending".equalsIgnoreCase(a.getStatus()) ? "status-pending" :
                                           "Approved".equalsIgnoreCase(a.getStatus()) ? "status-approved" :
                                           "Rejected".equalsIgnoreCase(a.getStatus()) ? "status-rejected" :
                                           "Completed".equalsIgnoreCase(a.getStatus()) ? "status-completed" : "status-default" %>">
                                        <%= a.getStatus() %>
                                    </span>
                                </td>
                            <% } else if("patient".equals(role)){ %>
                                <td><%= a.getId() %></td>
                                <td><%= a.getDoctorName() %></td>
                                <td><%= a.getAppointmentDate() %></td>
                                <td>
                                    <span class="status-badge
                                        <%= "Pending".equalsIgnoreCase(a.getStatus()) ? "status-pending" :
                                           "Approved".equalsIgnoreCase(a.getStatus()) ? "status-approved" :
                                           "Rejected".equalsIgnoreCase(a.getStatus()) ? "status-rejected" :
                                           "Completed".equalsIgnoreCase(a.getStatus()) ? "status-completed" : "status-default" %>">
                                        <%= a.getStatus() %>
                                    </span>
                                </td>
                            <% } else if("doctor".equals(role)){ %>
                                <td><%= a.getId() %></td>
                                <td><%= a.getPatientName() %></td>
                                <td><%= a.getAppointmentDate() %></td>
                                <td>
                                    <span class="status-badge
                                        <%= "Pending".equalsIgnoreCase(a.getStatus()) ? "status-pending" :
                                           "Approved".equalsIgnoreCase(a.getStatus()) ? "status-approved" :
                                           "Rejected".equalsIgnoreCase(a.getStatus()) ? "status-rejected" :
                                           "Completed".equalsIgnoreCase(a.getStatus()) ? "status-completed" : "status-default" %>">
                                        <%= a.getStatus() %>
                                    </span>
                                </td>
                                <td>
                                    <form action="updateStatus" method="post" class="action-form">
                                        <input type="hidden" name="id" value="<%= a.getId() %>">
                                        <select name="status" class="action-select">
                                            <option value="Approved">Approve</option>
                                            <option value="Rejected">Reject</option>
                                        </select>
                                        <button type="submit" class="btn-update">Update</button>
                                    </form>
                                </td>
                            <% } %>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 40px;">
                                <div class="empty-state" style="background: transparent; padding: 0;">
                                    <div class="empty-icon">📭</div>
                                    <div class="empty-title">No Appointments Found</div>
                                    <div class="empty-text">There are no appointments to display at this time.</div>
                                </div>
                            </td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div>

            <!-- Back Button with Dynamic Link -->
            <div style="text-align: center;">
                <a href="<%= backPage %>" class="back-button">
                    ← Back to Dashboard
                </a>
            </div>

            <!-- Footer -->
            <div class="footer">
                <p>© 2024 Hospital Management System | Secure Appointment Portal</p>
            </div>

        </div>
    </div>
</div>

</body>
</html>
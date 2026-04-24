<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, dao.DoctorDAO, model.Doctor" %>
<%@ page session="true" %>

<%
String role = (String) session.getAttribute("role");

if(role == null || !role.equals("admin")){
    response.sendRedirect("login.jsp");
    return;
}

// Fetch doctors
DoctorDAO dao = new DoctorDAO();
List<Doctor> list = dao.getAllDoctors();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Management System | View Doctors</title>

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
        .doctors-wrapper {
            max-width: 1200px;
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

        .doctor-icon {
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

        /* Stats Card */
        .stats-card {
            background: linear-gradient(105deg, #e8f5e9 0%, #e0f2fe 100%);
            border-radius: 20px;
            padding: 20px 25px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            border: 1px solid rgba(46, 204, 113, 0.2);
        }

        .stats-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .stats-number {
            font-size: 42px;
            font-weight: 700;
            color: #1e3a5f;
        }

        .stats-label {
            font-size: 16px;
            color: #2c3e50;
            font-weight: 500;
        }

        .add-doctor-btn {
            background: linear-gradient(105deg, #2ecc71 0%, #27ae60 100%);
            color: white;
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 40px;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .add-doctor-btn:hover {
            background: linear-gradient(105deg, #27ae60 0%, #219a52 100%);
            transform: scale(1.02);
            box-shadow: 0 4px 12px rgba(46, 204, 113, 0.3);
        }

        /* Table Container */
        .table-container {
            overflow-x: auto;
            margin-bottom: 30px;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
        }

        /* Modern Table Design */
        .doctors-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
            min-width: 600px;
        }

        .doctors-table thead {
            background: linear-gradient(105deg, #1e3a5f 0%, #2c5a7a 100%);
        }

        .doctors-table th {
            padding: 16px 20px;
            text-align: left;
            color: white;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .doctors-table td {
            padding: 14px 20px;
            border-bottom: 1px solid #e2e8f0;
            color: #2c3e50;
        }

        .doctors-table tbody tr {
            transition: all 0.2s ease;
        }

        .doctors-table tbody tr:hover {
            background: #f8fafc;
        }

        .doctors-table tbody tr:last-child td {
            border-bottom: none;
        }

        /* Delete Button */
        .btn-delete {
            background: #fee2e2;
            color: #e74c3c;
            border: none;
            padding: 8px 18px;
            border-radius: 40px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            border: 1px solid #fecaca;
        }

        .btn-delete:hover {
            background: #fecaca;
            transform: scale(1.02);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: #f8fafc;
            border-radius: 16px;
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

        /* Action Buttons Container */
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 10px;
            flex-wrap: wrap;
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

            .stats-card {
                flex-direction: column;
                text-align: center;
            }

            .stats-info {
                flex-direction: column;
            }

            .doctors-table th,
            .doctors-table td {
                padding: 12px 15px;
            }
        }
    </style>
</head>

<body>

<div class="doctors-wrapper">
    <div class="card">

        <!-- Header Section -->
        <div class="card-header">
            <div class="doctor-icon">👨‍⚕️</div>
            <h1>Hospital Management System</h1>
            <p>Medical Staff Directory</p>
            <div class="role-badge">👑 Administrator Access</div>
        </div>

        <!-- Content Body -->
        <div class="card-body">

            <!-- Stats and Add Button Section -->
            <div class="stats-card">
                <div class="stats-info">
                    <div class="stats-number"><%= list != null ? list.size() : 0 %></div>
                    <div class="stats-label">Total Doctors Registered</div>
                </div>
                <a href="addDoctor.jsp" class="add-doctor-btn">
                    ➕ Add New Doctor
                </a>
            </div>

            <!-- Doctors Table -->
            <div class="table-container">
                <table class="doctors-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Full Name</th>
                            <th>Specialization</th>
                            <th>Phone Number</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        if(list != null && !list.isEmpty()){
                        for(Doctor d : list){
                        %>
                        <tr>
                            <td><%= d.getId() %></td>
                            <td><%= d.getName() %></td>
                            <td><%= d.getSpecialization() %></td>
                            <td><%= d.getPhone() %></td>
                            <td>
                                <form action="deleteDoctor" method="post"
                                      onsubmit="return confirm('⚠️ Are you sure you want to delete this doctor?\n\nDoctor: <%= d.getName() %>\nSpecialization: <%= d.getSpecialization() %>\n\nThis action cannot be undone!');">
                                    <input type="hidden" name="id" value="<%= d.getId() %>">
                                    <button type="submit" class="btn-delete">🗑️ Delete</button>
                                </form>
                             </td>
                        </tr>
                        <%
                        }
                        } else {
                        %>
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 0;">
                                <div class="empty-state" style="background: transparent; padding: 40px;">
                                    <div class="empty-icon">👨‍⚕️</div>
                                    <div class="empty-title">No Doctors Found</div>
                                    <div class="empty-text">There are no doctors registered in the system yet.</div>
                                </div>
                            </td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div>

            <!-- Action Buttons -->
            <div class="action-buttons">
                <a href="adminDashboard.jsp" class="back-button">
                    ← Back to Dashboard
                </a>
            </div>

            <!-- Footer -->
            <div class="footer">
                <p>© 2024 Hospital Management System | Secure Admin Portal</p>
            </div>

        </div>
    </div>
</div>

</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, dao.PatientDAO, model.Patient" %>
<%@ page session="true" %>

<%
String role = (String) session.getAttribute("role");

if(role == null || !role.equals("admin")){
    response.sendRedirect("login.jsp");
    return;
}

// Fetch patients
PatientDAO dao = new PatientDAO();
List<Patient> list = dao.getAllPatients();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Management System | View Patients</title>

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
        .patients-wrapper {
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

        .patient-icon {
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

        /* Table Container */
        .table-container {
            overflow-x: auto;
            margin-bottom: 30px;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
        }

        /* Modern Table Design */
        .patients-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
            min-width: 800px;
        }

        .patients-table thead {
            background: linear-gradient(105deg, #1e3a5f 0%, #2c5a7a 100%);
        }

        .patients-table th {
            padding: 16px 20px;
            text-align: left;
            color: white;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .patients-table td {
            padding: 14px 20px;
            border-bottom: 1px solid #e2e8f0;
            color: #2c3e50;
        }

        .patients-table tbody tr {
            transition: all 0.2s ease;
        }

        .patients-table tbody tr:hover {
            background: #f8fafc;
        }

        .patients-table tbody tr:last-child td {
            border-bottom: none;
        }

        /* Gender Badges */
        .gender-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 40px;
            font-size: 12px;
            font-weight: 600;
        }

        .gender-male {
            background: #d4edda;
            color: #155724;
        }

        .gender-female {
            background: #fee2e2;
            color: #c0392b;
        }

        .gender-other {
            background: #e2e8f0;
            color: #4a5568;
        }

        /* Disease Badge */
        .disease-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 40px;
            font-size: 12px;
            font-weight: 500;
            background: #fff3cd;
            color: #856404;
            max-width: 150px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
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
            margin-top: 10px;
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

            .patients-table th,
            .patients-table td {
                padding: 12px 15px;
            }
        }
    </style>
</head>

<body>

<div class="patients-wrapper">
    <div class="card">

        <!-- Header Section -->
        <div class="card-header">
            <div class="patient-icon">🏥</div>
            <h1>Hospital Management System</h1>
            <p>Patient Records Management</p>
            <div class="role-badge">👑 Administrator Access</div>
        </div>

        <!-- Content Body -->
        <div class="card-body">

            <!-- Stats Section -->
            <div class="stats-card">
                <div class="stats-info">
                    <div class="stats-number"><%= list != null ? list.size() : 0 %></div>
                    <div class="stats-label">Total Patients Registered</div>
                </div>
            </div>

            <!-- Patients Table -->
            <div class="table-container">
                <table class="patients-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Full Name</th>
                            <th>Age</th>
                            <th>Gender</th>
                            <th>Phone Number</th>
                            <th>Disease</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        if(list != null && !list.isEmpty()){
                        for(Patient p : list){
                        %>
                        <tr>
                            <td><%= p.getId() %></td>
                            <td><%= p.getName() %></td>
                            <td><%= p.getAge() %></td>
                            <td>
                                <span class="gender-badge
                                    <%= "Male".equalsIgnoreCase(p.getGender()) ? "gender-male" :
                                       "Female".equalsIgnoreCase(p.getGender()) ? "gender-female" : "gender-other" %>">
                                    <%= p.getGender() %>
                                </span>
                            </td>
                            <td><%= p.getPhone() %></td>
                            <td>
                                <span class="disease-badge" title="<%= p.getDisease() %>">
                                    <%= p.getDisease().length() > 20 ? p.getDisease().substring(0, 20) + "..." : p.getDisease() %>
                                </span>
                            </td>
                            <td>
                                <form action="deletePatient" method="post"
                                      onsubmit="return confirm('⚠️ Are you sure you want to delete this patient?\n\nPatient: <%= p.getName() %>\nDisease: <%= p.getDisease() %>\n\nThis action cannot be undone!');">
                                    <input type="hidden" name="id" value="<%= p.getId() %>">
                                    <button type="submit" class="btn-delete">🗑️ Delete</button>
                                </form>
                            </td>
                        </tr>
                        <%
                        }
                        } else {
                        %>
                        <tr>
                            <td colspan="7" style="text-align: center; padding: 0;">
                                <div class="empty-state" style="background: transparent; padding: 40px;">
                                    <div class="empty-icon">🏥</div>
                                    <div class="empty-title">No Patients Found</div>
                                    <div class="empty-text">There are no patients registered in the system yet.</div>
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
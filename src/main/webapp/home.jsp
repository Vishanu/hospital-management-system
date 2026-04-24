<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page session="true" %>

<%
String role = (String) session.getAttribute("role");
String username = (String) session.getAttribute("user");

// 🔥 FIXED role
if(role == null || !role.equals("admin")){
    response.sendRedirect("login.jsp");
    return;
}

DashboardDAO dDao = new DashboardDAO();

int doctorCount = dDao.getCount("doctors");
int patientCount = dDao.getCount("patients");
int appointmentCount = dDao.getCount("appointments");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Management System | Admin Dashboard</title>

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
        .dashboard-wrapper {
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

        .hospital-icon {
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

        /* Welcome Section */
        .welcome-section {
            background: linear-gradient(105deg, #e8f5e9 0%, #e0f2fe 100%);
            padding: 25px 40px;
            border-bottom: 1px solid rgba(46, 204, 113, 0.2);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .welcome-text {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .welcome-icon {
            font-size: 40px;
        }

        .welcome-text h2 {
            color: #1e3a5f;
            font-size: 24px;
            font-weight: 600;
        }

        .welcome-text p {
            color: #2c3e50;
            font-size: 14px;
            margin-top: 5px;
        }

        .date-badge {
            background: white;
            padding: 10px 20px;
            border-radius: 40px;
            font-size: 14px;
            font-weight: 600;
            color: #1e3a5f;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            padding: 35px 40px;
            background: #f8fafc;
        }

        .stat-card {
            background: white;
            border-radius: 20px;
            padding: 25px;
            text-align: center;
            transition: all 0.2s ease;
            border: 1px solid #e2e8f0;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);
            border-color: #2ecc71;
        }

        .stat-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }

        .stat-number {
            font-size: 42px;
            font-weight: 700;
            color: #1e3a5f;
            margin-bottom: 8px;
        }

        .stat-label {
            font-size: 14px;
            color: #5a6e7c;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 600;
        }

        /* Content Sections */
        .content-section {
            padding: 0 40px 20px 40px;
        }

        .section-title {
            font-size: 20px;
            font-weight: 600;
            color: #1e3a5f;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e2e8f0;
        }

        .section-icon {
            font-size: 24px;
        }

        /* Grid Layout for Management and Actions */
        .grid-2cols {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 35px;
        }

        .grid-3cols {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 35px;
        }

        .action-card {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            padding: 20px;
            text-decoration: none;
            transition: all 0.2s ease;
            display: block;
        }

        .action-card:hover {
            background: white;
            border-color: #2ecc71;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }

        .action-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 10px;
        }

        .action-icon {
            font-size: 32px;
        }

        .action-title {
            font-size: 18px;
            font-weight: 600;
            color: #1e3a5f;
        }

        .action-desc {
            font-size: 13px;
            color: #5a6e7c;
            line-height: 1.4;
        }

        /* Logout Section */
        .logout-section {
            padding: 20px 40px 35px 40px;
            text-align: center;
            border-top: 1px solid #e2e8f0;
            margin-top: 10px;
        }

        .btn-logout {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: #fee2e2;
            color: #e74c3c;
            text-decoration: none;
            padding: 12px 32px;
            border-radius: 40px;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.2s ease;
            border: 1px solid #fecaca;
        }

        .btn-logout:hover {
            background: #fecaca;
            transform: scale(1.02);
            box-shadow: 0 4px 12px rgba(231, 76, 60, 0.2);
        }

        /* Footer */
        .footer {
            text-align: center;
            padding: 20px 40px;
            border-top: 1px solid #e2e8f0;
            font-size: 12px;
            color: #5a6e7c;
            background: white;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .stats-grid {
                padding: 25px;
                gap: 18px;
            }

            .content-section {
                padding: 0 25px 20px 25px;
            }

            .welcome-section {
                padding: 20px 25px;
                flex-direction: column;
                text-align: center;
            }

            .welcome-text {
                flex-direction: column;
            }

            .card-header {
                padding: 25px 20px;
            }

            .card-header h1 {
                font-size: 22px;
            }

            .logout-section {
                padding: 20px 25px 30px 25px;
            }

            .footer {
                padding: 20px 25px;
            }
        }

        @media (max-width: 480px) {
            .stat-number {
                font-size: 32px;
            }

            .stat-icon {
                font-size: 36px;
            }

            .grid-2cols, .grid-3cols {
                grid-template-columns: 1fr;
            }
        }

        /* Animation */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card {
            animation: fadeIn 0.4s ease-out;
        }
    </style>
</head>

<body>

<div class="dashboard-wrapper">
    <div class="card">

        <!-- Header Section -->
        <div class="card-header">
            <div class="hospital-icon">🏥</div>
            <h1>Hospital Management System</h1>
            <p>Centralized Healthcare Administration Platform</p>
            <div class="role-badge">👑 Administrator Access</div>
        </div>

        <!-- Welcome Section with Dynamic Data -->
        <div class="welcome-section">
            <div class="welcome-text">
                <div class="welcome-icon">👋</div>
                <div>
                    <h2>Welcome, <%= username != null ? username : "Admin" %></h2>
                    <p>You have full access to manage hospital operations</p>
                </div>
            </div>
            <div class="date-badge">
                📅 <%= new java.text.SimpleDateFormat("dd-MM-yyyy").format(new java.util.Date()) %>
            </div>
        </div>

        <!-- Statistics Section - Dynamic Counts -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">👨‍⚕️</div>
                <div class="stat-number"><%= doctorCount %></div>
                <div class="stat-label">Total Doctors</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">🏥</div>
                <div class="stat-number"><%= patientCount %></div>
                <div class="stat-label">Total Patients</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">📅</div>
                <div class="stat-number"><%= appointmentCount %></div>
                <div class="stat-label">Total Appointments</div>
            </div>
        </div>

        <!-- Management Section -->
        <div class="content-section">
            <div class="section-title">
                <span class="section-icon">⚙️</span>
                <span>Management Tools</span>
            </div>

            <div class="grid-2cols">
                <a href="viewDoctors.jsp" class="action-card">
                    <div class="action-header">
                        <div class="action-icon">👨‍⚕️</div>
                        <div class="action-title">Manage Doctors</div>
                    </div>
                    <div class="action-desc">View, update, and manage all doctor records in the system</div>
                </a>

                <a href="viewPatients.jsp" class="action-card">
                    <div class="action-header">
                        <div class="action-icon">🏥</div>
                        <div class="action-title">Manage Patients</div>
                    </div>
                    <div class="action-desc">Access complete patient directory and medical records</div>
                </a>

                <a href="viewAppointments.jsp" class="action-card">
                    <div class="action-header">
                        <div class="action-icon">📅</div>
                        <div class="action-title">Manage Appointments</div>
                    </div>
                    <div class="action-desc">Schedule and track all patient appointments</div>
                </a>
            </div>
        </div>

        <!-- Quick Actions Section -->
        <div class="content-section">
            <div class="section-title">
                <span class="section-icon">⚡</span>
                <span>Quick Actions</span>
            </div>

            <div class="grid-3cols">
                <a href="addDoctor.jsp" class="action-card">
                    <div class="action-header">
                        <div class="action-icon">➕</div>
                        <div class="action-title">Add Doctor</div>
                    </div>
                    <div class="action-desc">Register new medical staff to the hospital</div>
                </a>

                <a href="addPatient.jsp" class="action-card">
                    <div class="action-header">
                        <div class="action-icon">🏨</div>
                        <div class="action-title">Admit Patient</div>
                    </div>
                    <div class="action-desc">Admit a new patient to the hospital</div>
                </a>

                <a href="bookAppointment.jsp" class="action-card">
                    <div class="action-header">
                        <div class="action-icon">📝</div>
                        <div class="action-title">Book Appointment</div>
                    </div>
                    <div class="action-desc">Schedule appointments for patients</div>
                </a>
            </div>
        </div>

        <!-- Logout Section -->
        <div class="logout-section">
            <a href="logout.jsp" class="btn-logout">
                🚪 Logout from System
            </a>
        </div>

        <!-- Footer -->
        <div class="footer">
            <p>© 2024 Hospital Management System | Secure Admin Portal</p>
        </div>

    </div>
</div>

</body>
</html>
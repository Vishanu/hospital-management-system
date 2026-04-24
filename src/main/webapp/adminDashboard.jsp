<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>

<%
String role = (String) session.getAttribute("role");

if(role == null || !role.equals("admin")){
    response.sendRedirect("login.jsp");
    return;
}
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
            max-width: 800px;
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
            padding: 35px 35px 30px;
            text-align: center;
            position: relative;
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
            padding: 20px 35px;
            border-bottom: 1px solid rgba(46, 204, 113, 0.2);
        }

        .welcome-text {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .welcome-icon {
            font-size: 32px;
        }

        .welcome-text h2 {
            color: #1e3a5f;
            font-size: 22px;
            font-weight: 600;
        }

        .welcome-text p {
            color: #2c3e50;
            font-size: 15px;
            margin-top: 5px;
        }

        /* Stats Section */
        .stats-section {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1px;
            background: #e2e8f0;
            margin: 0;
        }

        .stat-card {
            background: white;
            padding: 20px 15px;
            text-align: center;
            transition: all 0.2s ease;
        }

        .stat-card:hover {
            background: #f8fafc;
            transform: translateY(-2px);
        }

        .stat-icon {
            font-size: 28px;
            margin-bottom: 8px;
        }

        .stat-number {
            font-size: 28px;
            font-weight: 700;
            color: #1e3a5f;
        }

        .stat-label {
            font-size: 12px;
            color: #5a6e7c;
            margin-top: 5px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Menu Grid */
        .menu-section {
            padding: 35px;
        }

        .section-title {
            font-size: 18px;
            font-weight: 600;
            color: #1e3a5f;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .section-title:before {
            content: "⚙️";
            font-size: 20px;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 18px;
            margin-bottom: 30px;
        }

        .menu-card {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 20px;
            padding: 22px 20px;
            text-decoration: none;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .menu-card:hover {
            background: white;
            border-color: #2ecc71;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }

        .menu-icon {
            font-size: 36px;
        }

        .menu-content {
            flex: 1;
        }

        .menu-title {
            font-size: 16px;
            font-weight: 600;
            color: #1e3a5f;
            margin-bottom: 4px;
        }

        .menu-desc {
            font-size: 12px;
            color: #5a6e7c;
        }

        /* Logout Section */
        .logout-section {
            padding: 0 35px 35px 35px;
            text-align: center;
        }

        .btn-logout {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: #fee2e2;
            color: #e74c3c;
            text-decoration: none;
            padding: 12px 30px;
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
            padding: 20px 35px;
            border-top: 1px solid #e2e8f0;
            font-size: 12px;
            color: #5a6e7c;
        }

        /* Responsive */
        @media (max-width: 650px) {
            .stats-section {
                grid-template-columns: repeat(2, 1fr);
                gap: 1px;
            }

            .menu-grid {
                grid-template-columns: 1fr;
            }

            .card-header h1 {
                font-size: 24px;
            }

            .welcome-text {
                flex-direction: column;
                text-align: center;
            }

            .menu-section {
                padding: 25px;
            }

            .logout-section {
                padding: 0 25px 25px 25px;
            }
        }

        @media (max-width: 480px) {
            .stats-section {
                grid-template-columns: 1fr;
            }

            .card-header {
                padding: 25px 20px;
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

        <!-- Welcome Section -->
        <div class="welcome-section">
            <div class="welcome-text">
                <div class="welcome-icon">👋</div>
                <div>
                    <h2>Welcome, Admin</h2>
                    <p>You have full access to manage hospital operations</p>
                </div>
            </div>
        </div>

        <!-- Statistics Overview (Visual enhancement only) -->
        <div class="stats-section">
            <div class="stat-card">
                <div class="stat-icon">👨‍⚕️</div>
                <div class="stat-number">+</div>
                <div class="stat-label">Doctors</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">🏥</div>
                <div class="stat-number">+</div>
                <div class="stat-label">Patients</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">📅</div>
                <div class="stat-number">+</div>
                <div class="stat-label">Appointments</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">✅</div>
                <div class="stat-number">Active</div>
                <div class="stat-label">Session</div>
            </div>
        </div>

        <!-- Menu Section -->
        <div class="menu-section">
            <div class="section-title">Management Tools</div>

            <div class="menu-grid">
                <!-- Add Doctor -->
                <a href="addDoctor.jsp" class="menu-card">
                    <div class="menu-icon">👨‍⚕️</div>
                    <div class="menu-content">
                        <div class="menu-title">Add Doctor</div>
                        <div class="menu-desc">Register new medical staff</div>
                    </div>
                    <div class="menu-arrow">→</div>
                </a>

                <!-- View Doctors -->
                <a href="viewDoctors.jsp" class="menu-card">
                    <div class="menu-icon">📋</div>
                    <div class="menu-content">
                        <div class="menu-title">View Doctors</div>
                        <div class="menu-desc">Manage doctor records</div>
                    </div>
                    <div class="menu-arrow">→</div>
                </a>

                <!-- View Patients -->
                <a href="viewPatients.jsp" class="menu-card">
                    <div class="menu-icon">🏥</div>
                    <div class="menu-content">
                        <div class="menu-title">View Patients</div>
                        <div class="menu-desc">Access patient directory</div>
                    </div>
                    <div class="menu-arrow">→</div>
                </a>

                <!-- View Appointments -->
                <a href="viewAppointments.jsp" class="menu-card">
                    <div class="menu-icon">📅</div>
                    <div class="menu-content">
                        <div class="menu-title">View Appointments</div>
                        <div class="menu-desc">Schedule management</div>
                    </div>
                    <div class="menu-arrow">→</div>
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
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>

<%
String role = (String) session.getAttribute("role");

if(role == null || !role.equals("doctor")){
    response.sendRedirect("login.jsp");
    return; // 🔥 MUST ADD
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Management System | Doctor Dashboard</title>

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
            max-width: 700px;
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

        /* Welcome Section */
        .welcome-section {
            background: linear-gradient(105deg, #e8f5e9 0%, #e0f2fe 100%);
            padding: 25px 35px;
            border-bottom: 1px solid rgba(46, 204, 113, 0.2);
        }

        .welcome-text {
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
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

        /* Quick Stats Section */
        .stats-section {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1px;
            background: #e2e8f0;
            margin: 0;
        }

        .stat-card {
            background: white;
            padding: 25px 15px;
            text-align: center;
            transition: all 0.2s ease;
        }

        .stat-card:hover {
            background: #f8fafc;
            transform: translateY(-2px);
        }

        .stat-icon {
            font-size: 32px;
            margin-bottom: 10px;
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

        /* Menu Section */
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
            content: "⚕️";
            font-size: 20px;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 18px;
            margin-bottom: 30px;
        }

        .menu-card {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 20px;
            padding: 22px 25px;
            text-decoration: none;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .menu-card:hover {
            background: white;
            border-color: #2ecc71;
            transform: translateX(5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }

        .menu-icon {
            font-size: 42px;
        }

        .menu-content {
            flex: 1;
        }

        .menu-title {
            font-size: 18px;
            font-weight: 600;
            color: #1e3a5f;
            margin-bottom: 5px;
        }

        .menu-desc {
            font-size: 13px;
            color: #5a6e7c;
        }

        .menu-arrow {
            font-size: 20px;
            color: #2ecc71;
            transition: transform 0.2s ease;
        }

        .menu-card:hover .menu-arrow {
            transform: translateX(5px);
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

        /* Info Note */
        .info-note {
            background: #e8f4fd;
            padding: 12px 15px;
            border-radius: 12px;
            font-size: 12px;
            color: #1e3a5f;
            text-align: center;
            margin: 0 35px 20px 35px;
        }

        /* Responsive */
        @media (max-width: 550px) {
            .stats-section {
                grid-template-columns: 1fr;
                gap: 1px;
            }

            .card-header h1 {
                font-size: 22px;
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

            .info-note {
                margin: 0 25px 15px 25px;
            }

            .menu-card {
                padding: 18px 20px;
            }

            .menu-icon {
                font-size: 32px;
            }

            .menu-title {
                font-size: 16px;
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
            <div class="doctor-icon">👨‍⚕️</div>
            <h1>Hospital Management System</h1>
            <p>Doctor Portal - Patient Care Management</p>
            <div class="role-badge">⚕️ Medical Professional Access</div>
        </div>

        <!-- Welcome Section -->
        <div class="welcome-section">
            <div class="welcome-text">
                <div class="welcome-icon">👋</div>
                <div>
                    <h2>Welcome, Doctor</h2>
                    <p>Manage your appointments and provide quality care to patients</p>
                </div>
            </div>
        </div>

        <!-- Quick Stats Overview (Visual enhancement only) -->
        <div class="stats-section">
            <div class="stat-card">
                <div class="stat-icon">📅</div>
                <div class="stat-number">+</div>
                <div class="stat-label">Today's Appointments</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">📋</div>
                <div class="stat-number">+</div>
                <div class="stat-label">Total Appointments</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">✅</div>
                <div class="stat-number">Active</div>
                <div class="stat-label">Session</div>
            </div>
        </div>

        <!-- Menu Section -->
        <div class="menu-section">
            <div class="section-title">Quick Actions</div>

            <div class="menu-grid">
                <!-- View Appointments -->
                <a href="viewAppointments.jsp" class="menu-card">
                    <div class="menu-icon">📋</div>
                    <div class="menu-content">
                        <div class="menu-title">View Appointments</div>
                        <div class="menu-desc">Check your scheduled appointments and patient list</div>
                    </div>
                    <div class="menu-arrow">→</div>
                </a>
            </div>
        </div>

        <!-- Info Note -->
        <div class="info-note">
            💡 You can view all your upcoming and past appointments here. Click on any appointment to see patient details.
        </div>

        <!-- Logout Section -->
        <div class="logout-section">
            <a href="logout.jsp" class="btn-logout">
                🚪 Logout from System
            </a>
        </div>

        <!-- Footer -->
        <div class="footer">
            <p>© 2024 Hospital Management System | Secure Doctor Portal</p>
        </div>

    </div>
</div>

</body>
</html>
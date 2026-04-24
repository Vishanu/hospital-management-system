<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>

<%
String role = (String) session.getAttribute("role");

if(role == null || !role.equals("patient")){
    response.sendRedirect("login.jsp");
    return;
}

String msg = request.getParameter("msg");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Management System | Patient Dashboard</title>

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

        /* Success Message */
        .success-message {
            background: #d4edda;
            border-left: 4px solid #28a745;
            padding: 14px 20px;
            border-radius: 14px;
            margin: 0 35px 25px 35px;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideDown 0.4s ease-out;
        }

        .success-message span {
            color: #155724;
            font-size: 14px;
            font-weight: 500;
        }

        .success-icon {
            font-size: 20px;
        }

        /* Quick Stats Section */
        .stats-section {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1px;
            background: #e2e8f0;
            margin: 0 35px 25px 35px;
            border-radius: 16px;
            overflow: hidden;
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
            font-size: 24px;
            font-weight: 700;
            color: #1e3a5f;
        }

        .stat-label {
            font-size: 11px;
            color: #5a6e7c;
            margin-top: 5px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Menu Section */
        .menu-section {
            padding: 0 35px 25px 35px;
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
            content: "🏥";
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

        /* Animations */
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

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card {
            animation: fadeIn 0.4s ease-out;
        }

        /* Responsive */
        @media (max-width: 550px) {
            .stats-section {
                margin: 0 25px 20px 25px;
                flex-direction: column;
            }

            .card-header h1 {
                font-size: 22px;
            }

            .welcome-text {
                flex-direction: column;
                text-align: center;
            }

            .menu-section {
                padding: 0 25px 25px 25px;
            }

            .logout-section {
                padding: 0 25px 30px 25px;
            }

            .success-message {
                margin: 0 25px 20px 25px;
            }

            .info-note {
                margin: 0 25px 20px 25px;
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

            .stat-number {
                font-size: 20px;
            }
        }
    </style>
</head>

<body>

<div class="dashboard-wrapper">
    <div class="card">

        <!-- Header Section -->
        <div class="card-header">
            <div class="patient-icon">👤</div>
            <h1>Hospital Management System</h1>
            <p>Patient Portal - Your Healthcare Companion</p>
            <div class="role-badge">👤 Patient Access</div>
        </div>

        <!-- Welcome Section -->
        <div class="welcome-section">
            <div class="welcome-text">
                <div class="welcome-icon">👋</div>
                <div>
                    <h2>Welcome, Patient</h2>
                    <p>Manage your appointments and healthcare needs</p>
                </div>
            </div>
        </div>

        <!-- ✅ SUCCESS MESSAGE (only once) - JSP LOGIC PRESERVED -->
        <% if("booked".equals(msg)){ %>
        <div class="success-message">
            <div class="success-icon">✅</div>
            <span>Appointment Booked Successfully!</span>
        </div>
        <% } %>

        <!-- Quick Stats Overview (Visual enhancement only) -->
        <div class="stats-section">
            <div class="stat-card">
                <div class="stat-icon">📅</div>
                <div class="stat-number">+</div>
                <div class="stat-label">Upcoming</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">📋</div>
                <div class="stat-number">+</div>
                <div class="stat-label">Completed</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">✅</div>
                <div class="stat-number">Active</div>
                <div class="stat-label">Session</div>
            </div>
        </div>

        <!-- Menu Section -->
        <div class="menu-section">
            <div class="section-title">Healthcare Services</div>

            <div class="menu-grid">
                <!-- Book Appointment -->
                <a href="bookAppointment.jsp" class="menu-card">
                    <div class="menu-icon">📅</div>
                    <div class="menu-content">
                        <div class="menu-title">Book Appointment</div>
                        <div class="menu-desc">Schedule a consultation with our expert doctors</div>
                    </div>
                    <div class="menu-arrow">→</div>
                </a>

                <!-- View My Appointments -->
                <a href="viewAppointments.jsp" class="menu-card">
                    <div class="menu-icon">📋</div>
                    <div class="menu-content">
                        <div class="menu-title">View My Appointments</div>
                        <div class="menu-desc">Check your upcoming and past appointments</div>
                    </div>
                    <div class="menu-arrow">→</div>
                </a>
            </div>
        </div>

        <!-- Info Note -->
        <div class="info-note">
            💡 Need medical assistance? Book an appointment with our specialist doctors. You can view all your appointment history here.
        </div>

        <!-- Logout Section -->
        <div class="logout-section">
            <a href="logout.jsp" class="btn-logout">
                🚪 Logout from System
            </a>
        </div>

        <!-- Footer -->
        <div class="footer">
            <p>© 2024 Hospital Management System | Secure Patient Portal</p>
        </div>

    </div>
</div>

</body>
</html>
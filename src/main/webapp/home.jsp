<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>

<%
String role = (String) session.getAttribute("role");
String username = (String) session.getAttribute("user");

if(role == null || !role.equals("ADMIN")){
    response.sendRedirect("login.jsp");
    return;
}

DashboardDAO dDao = new DashboardDAO();

int doctorCount = dDao.getCount("doctors");
int patientCount = dDao.getCount("patients");
int appointmentCount = dDao.getCount("appointments");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Healix Hospital</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 30px 20px;
        }

        .container {
            max-width: 1300px;
            margin: 0 auto;
        }

        /* Header */
        .header {
            background: white;
            border-radius: 24px;
            padding: 30px 35px;
            margin-bottom: 30px;
            box-shadow: 0 20px 35px -10px rgba(0,0,0,0.15);
            transition: transform 0.3s ease;
        }

        .header:hover {
            transform: translateY(-3px);
        }

        .header h1 {
            color: #1e293b;
            font-size: 32px;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .header h1 i {
            color: #667eea;
            margin-right: 12px;
        }

        .header p {
            color: #64748b;
            margin-top: 10px;
            font-size: 14px;
            font-weight: 500;
        }

        .header p i {
            color: #667eea;
            margin-right: 6px;
        }

        /* Stats Cards */
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: white;
            border-radius: 24px;
            padding: 28px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 10px 25px -5px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .stat-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 20px 35px -10px rgba(0,0,0,0.2);
        }

        .stat-info h3 {
            font-size: 42px;
            font-weight: 800;
            color: #1e293b;
            letter-spacing: -1px;
        }

        .stat-info p {
            color: #64748b;
            margin-top: 8px;
            font-weight: 500;
            font-size: 14px;
        }

        .stat-info p i {
            margin-right: 6px;
            color: #667eea;
        }

        .stat-icon {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
        }

        .stat-icon i {
            font-size: 32px;
            color: white;
        }

        /* Section Title */
        .section-title {
            color: white;
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .section-title i {
            font-size: 28px;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1));
        }

        /* Management Cards */
        .management-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 28px;
            margin-bottom: 40px;
        }

        .card {
            background: white;
            border-radius: 24px;
            padding: 32px 28px;
            text-align: center;
            transition: all 0.3s ease;
            box-shadow: 0 10px 25px -5px rgba(0,0,0,0.1);
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px -12px rgba(0,0,0,0.2);
        }

        .card-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 25px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
            transition: all 0.3s ease;
        }

        .card:hover .card-icon {
            transform: scale(1.05);
        }

        .card-icon i {
            font-size: 38px;
            color: white;
        }

        .card h3 {
            font-size: 22px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 12px;
        }

        .card p {
            color: #64748b;
            font-size: 14px;
            line-height: 1.5;
            margin-bottom: 25px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 12px 28px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            text-decoration: none;
            border-radius: 40px;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        .btn:hover {
            transform: translateX(5px);
            box-shadow: 0 6px 18px rgba(102, 126, 234, 0.4);
        }

        /* Summary Cards */
        .summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .summary-card {
            background: linear-gradient(135deg, rgba(255,255,255,0.95), rgba(255,255,255,0.98));
            backdrop-filter: blur(10px);
            border-radius: 24px;
            padding: 28px;
            text-align: center;
            color: #1e293b;
            box-shadow: 0 10px 25px -5px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            border: 1px solid rgba(255,255,255,0.3);
        }

        .summary-card:hover {
            transform: translateY(-5px);
            background: white;
        }

        .summary-card h3 {
            font-size: 38px;
            font-weight: 800;
            margin-bottom: 8px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .summary-card p {
            font-size: 14px;
            font-weight: 500;
            color: #64748b;
        }

        .summary-card p i {
            margin-right: 6px;
            color: #667eea;
        }

        /* Nav Links */
        .nav-links {
            text-align: center;
            margin-top: 40px;
            padding-top: 25px;
            border-top: 2px solid rgba(255,255,255,0.2);
            display: flex;
            justify-content: center;
            gap: 25px;
            flex-wrap: wrap;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 40px;
            font-weight: 500;
            font-size: 14px;
            transition: all 0.3s ease;
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(5px);
        }

        .nav-links a:hover {
            background: rgba(255,255,255,0.25);
            transform: translateY(-2px);
        }

        /* Responsive */
        @media (max-width: 768px) {
            body {
                padding: 20px 15px;
            }

            .stats {
                grid-template-columns: 1fr;
            }

            .management-grid {
                grid-template-columns: 1fr;
            }

            .summary {
                grid-template-columns: 1fr;
            }

            .header h1 {
                font-size: 24px;
            }

            .stat-info h3 {
                font-size: 32px;
            }

            .nav-links {
                gap: 12px;
            }

            .nav-links a {
                padding: 8px 16px;
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1><i class="fas fa-user-shield"></i> Welcome, <%= username != null ? username : "Admin" %>!</h1>
            <p><i class="fas fa-calendar-alt"></i> <%= new java.text.SimpleDateFormat("EEEE, MMMM d, yyyy").format(new java.util.Date()) %></p>
        </div>

        <!-- Stats Cards -->
        <div class="stats">
            <div class="stat-card">
                <div class="stat-info">
                    <h3><%= doctorCount %></h3>
                    <p><i class="fas fa-user-md"></i> Total Doctors</p>
                </div>
                <div class="stat-icon"><i class="fas fa-stethoscope"></i></div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <h3><%= patientCount %></h3>
                    <p><i class="fas fa-users"></i> Total Patients</p>
                </div>
                <div class="stat-icon"><i class="fas fa-procedures"></i></div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <h3><%= appointmentCount %></h3>
                    <p><i class="fas fa-calendar-check"></i> Appointments</p>
                </div>
                <div class="stat-icon"><i class="fas fa-calendar-alt"></i></div>
            </div>
        </div>

        <!-- Quick Navigation -->
        <div class="section-title"><i class="fas fa-bolt"></i> Quick Navigation</div>

        <div class="management-grid">
            <div class="card">
                <div class="card-icon"><i class="fas fa-user-md"></i></div>
                <h3>Doctor Management</h3>
                <p>Add new doctors, view all doctors, and manage medical staff efficiently</p>
                <a href="viewDoctors.jsp" class="btn">Manage Doctors <i class="fas fa-arrow-right"></i></a>
            </div>
            <div class="card">
                <div class="card-icon"><i class="fas fa-procedures"></i></div>
                <h3>Patient Management</h3>
                <p>Admit new patients, view all patients, and manage health records</p>
                <a href="viewPatients.jsp" class="btn">Manage Patients <i class="fas fa-arrow-right"></i></a>
            </div>
            <div class="card">
                <div class="card-icon"><i class="fas fa-calendar-alt"></i></div>
                <h3>Appointment Management</h3>
                <p>Book appointments, view schedules, and manage all appointments</p>
                <a href="viewAppointments.jsp" class="btn">Manage Appointments <i class="fas fa-arrow-right"></i></a>
            </div>
        </div>

        <!-- Summary -->
        <div class="summary">
            <div class="summary-card">
                <h3><%= doctorCount + patientCount %></h3>
                <p><i class="fas fa-users"></i> Total People Registered</p>
            </div>
            <div class="summary-card">
                <h3><%= (doctorCount > 0 && patientCount > 0) ? Math.round((double)appointmentCount / (doctorCount + patientCount) * 100) : 0 %>%</h3>
                <p><i class="fas fa-chart-line"></i> Hospital Engagement Rate</p>
            </div>
        </div>

        <!-- Navigation Links -->
        <div class="nav-links">
            <a href="addDoctor.jsp"><i class="fas fa-plus-circle"></i> Add Doctor</a>
            <a href="addPatient.jsp"><i class="fas fa-procedures"></i> Admit Patient</a>
            <a href="bookAppointment.jsp"><i class="fas fa-calendar-plus"></i> Book Appointment</a>
            <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>
</body>
</html>
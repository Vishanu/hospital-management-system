<%@ page session="true" %>

<%
String role = (String) session.getAttribute("role");

if(role == null || !role.equals("admin")){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard | Hospital Management</title>

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
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 20px;
        margin: 0;
        position: relative;
    }

    /* Optional: Abstract background pattern */
    body::before {
        content: '';
        position: absolute;
        width: 100%;
        height: 100%;
        background-image: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200"><path fill="rgba(255,255,255,0.05)" d="M0 0h200v200H0z"/><path fill="rgba(255,255,255,0.05)" d="M100 0L0 100h200zM0 100l100 100 100-100z"/></svg>');
        background-size: 30px;
        pointer-events: none;
    }

    .container {
        background: white;
        border-radius: 32px;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        padding: 50px 40px;
        width: 100%;
        max-width: 550px;
        text-align: center;
        transition: transform 0.3s ease;
        position: relative;
        z-index: 1;
        border: none;
        display: block;
    }

    .container:hover {
        transform: translateY(-8px);
    }

    h2 {
        color: #1e293b;
        font-size: 36px;
        font-weight: 800;
        margin-bottom: 15px;
        letter-spacing: -0.5px;
    }

    .welcome-text {
        color: #64748b;
        font-size: 16px;
        margin-bottom: 40px;
        padding-bottom: 20px;
        border-bottom: 2px solid #e2e8f0;
    }

    .dashboard-grid {
        display: flex;
        flex-direction: column;
        gap: 15px;
        margin-bottom: 30px;
    }

    .dashboard-link {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 18px 24px;
        background: #f8fafc;
        border: 2px solid #e2e8f0;
        border-radius: 16px;
        text-decoration: none;
        color: #1e293b;
        font-weight: 600;
        font-size: 16px;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    .dashboard-link::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(102, 126, 234, 0.1), transparent);
        transition: left 0.5s ease;
    }

    .dashboard-link:hover::before {
        left: 100%;
    }

    .dashboard-link:hover {
        background: white;
        border-color: #667eea;
        transform: translateX(8px);
        box-shadow: 0 4px 12px rgba(102, 126, 234, 0.2);
    }

    .link-icon {
        font-size: 24px;
        width: 40px;
        text-align: center;
    }

    .link-text {
        flex: 1;
        text-align: left;
        margin-left: 15px;
    }

    .link-arrow {
        font-size: 18px;
        color: #94a3b8;
        transition: all 0.3s ease;
    }

    .dashboard-link:hover .link-arrow {
        color: #667eea;
        transform: translateX(5px);
    }

    /* Different colors for each link icon */
    .dashboard-link:nth-child(1) .link-icon { color: #10b981; }
    .dashboard-link:nth-child(2) .link-icon { color: #3b82f6; }
    .dashboard-link:nth-child(3) .link-icon { color: #8b5cf6; }
    .dashboard-link:nth-child(4) .link-icon { color: #f59e0b; }
    .dashboard-link:nth-child(5) .link-icon { color: #ef4444; }

    .logout-section {
        margin-top: 20px;
        padding-top: 20px;
        border-top: 2px solid #e2e8f0;
    }

    .logout-link {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        padding: 12px 28px;
        background: #fee2e2;
        color: #dc2626;
        text-decoration: none;
        border-radius: 40px;
        font-weight: 600;
        font-size: 14px;
        transition: all 0.3s ease;
    }

    .logout-link:hover {
        background: #dc2626;
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(220, 38, 38, 0.3);
    }

    /* Stats Cards */
    .stats {
        display: flex;
        justify-content: center;
        gap: 15px;
        margin-top: 30px;
        flex-wrap: wrap;
    }

    .stat-card {
        background: #f1f5f9;
        padding: 12px 18px;
        border-radius: 40px;
        font-size: 12px;
        font-weight: 500;
        color: #475569;
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }

    /* Responsive */
    @media (max-width: 500px) {
        .container {
            padding: 30px 20px;
        }

        h2 {
            font-size: 28px;
        }

        .dashboard-link {
            padding: 14px 18px;
        }

        .link-text {
            font-size: 14px;
        }

        .stats {
            gap: 10px;
        }

        .stat-card {
            font-size: 10px;
            padding: 8px 12px;
        }
    }
</style>

</head>

<body>

<div class="container">

<h2>🏥 Admin Dashboard</h2>
<div class="welcome-text">
    <i class="fas fa-user-shield"></i> Welcome back, Admin
</div>

<div class="dashboard-grid">
    <a href="addDoctor.jsp" class="dashboard-link">
        <span class="link-icon"><i class="fas fa-plus-circle"></i></span>
        <span class="link-text">Add Doctor</span>
        <span class="link-arrow"><i class="fas fa-chevron-right"></i></span>
    </a>

    <a href="viewDoctors.jsp" class="dashboard-link">
        <span class="link-icon"><i class="fas fa-user-md"></i></span>
        <span class="link-text">View Doctors</span>
        <span class="link-arrow"><i class="fas fa-chevron-right"></i></span>
    </a>

    <a href="viewPatients.jsp" class="dashboard-link">
        <span class="link-icon"><i class="fas fa-procedures"></i></span>
        <span class="link-text">View Patients</span>
        <span class="link-arrow"><i class="fas fa-chevron-right"></i></span>
    </a>

    <a href="viewAppointments.jsp" class="dashboard-link">
        <span class="link-icon"><i class="fas fa-calendar-check"></i></span>
        <span class="link-text">View Appointments</span>
        <span class="link-arrow"><i class="fas fa-chevron-right"></i></span>
    </a>
</div>

<div class="logout-section">
    <a href="logout.jsp" class="logout-link">
        <i class="fas fa-sign-out-alt"></i> Logout
    </a>
</div>

<!-- Optional Stats Indicator (just for looks) -->
<div class="stats">
    <span class="stat-card"><i class="fas fa-chart-line"></i> System Active</span>
    <span class="stat-card"><i class="fas fa-lock"></i> Secure Session</span>
</div>

</div>

</body>
</html>
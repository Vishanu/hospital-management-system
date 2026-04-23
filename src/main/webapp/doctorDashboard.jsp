<%@ page session="true" %>
<%
String role = (String) session.getAttribute("role");
if(role == null || !role.equals("doctor")){
    response.sendRedirect("login.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Doctor Dashboard | Hospital Management</title>

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

    /* Background pattern */
    body::before {
        content: '';
        position: absolute;
        width: 100%;
        height: 100%;
        background-image: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200"><path fill="rgba(255,255,255,0.05)" d="M100 0L0 100h200zM0 100l100 100 100-100z"/><circle fill="rgba(255,255,255,0.03)" cx="100" cy="100" r="80"/></svg>');
        background-size: 40px;
        pointer-events: none;
    }

    .container {
        background: white;
        border-radius: 32px;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.3);
        padding: 50px 40px;
        width: 100%;
        max-width: 600px;
        text-align: center;
        transition: all 0.3s ease;
        position: relative;
        z-index: 1;
    }

    .container:hover {
        transform: translateY(-8px);
    }

    /* Doctor Avatar */
    .doctor-avatar {
        width: 100px;
        height: 100px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 20px;
        box-shadow: 0 10px 25px -5px rgba(102, 126, 234, 0.4);
    }

    .doctor-avatar i {
        font-size: 50px;
        color: white;
    }

    h2 {
        color: #1e293b;
        font-size: 32px;
        font-weight: 800;
        margin-bottom: 10px;
        letter-spacing: -0.5px;
    }

    .welcome-badge {
        background: #dbeafe;
        color: #1e40af;
        font-size: 14px;
        font-weight: 600;
        padding: 6px 16px;
        border-radius: 40px;
        display: inline-block;
        margin-bottom: 30px;
    }

    .dashboard-grid {
        display: flex;
        flex-direction: column;
        gap: 18px;
        margin: 35px 0;
    }

    .dashboard-card {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 22px 28px;
        background: #f8fafc;
        border: 2px solid #e2e8f0;
        border-radius: 20px;
        text-decoration: none;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    .dashboard-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(102, 126, 234, 0.1), transparent);
        transition: left 0.5s ease;
    }

    .dashboard-card:hover::before {
        left: 100%;
    }

    .dashboard-card:hover {
        background: white;
        border-color: #667eea;
        transform: translateX(10px);
        box-shadow: 0 8px 20px rgba(102, 126, 234, 0.15);
    }

    .card-icon {
        width: 55px;
        height: 55px;
        background: linear-gradient(135deg, #667eea15 0%, #764ba215 100%);
        border-radius: 18px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .card-icon i {
        font-size: 28px;
        color: #667eea;
    }

    .card-content {
        flex: 1;
        text-align: left;
        margin-left: 20px;
    }

    .card-title {
        font-size: 20px;
        font-weight: 700;
        color: #1e293b;
        margin-bottom: 5px;
    }

    .card-subtitle {
        font-size: 13px;
        color: #64748b;
    }

    .card-arrow {
        color: #94a3b8;
        font-size: 20px;
        transition: all 0.3s ease;
    }

    .dashboard-card:hover .card-arrow {
        color: #667eea;
        transform: translateX(5px);
    }

    /* Stats Section */
    .stats-section {
        display: flex;
        justify-content: center;
        gap: 20px;
        margin: 25px 0;
        flex-wrap: wrap;
    }

    .stat-item {
        background: #f1f5f9;
        padding: 12px 20px;
        border-radius: 50px;
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 13px;
        font-weight: 500;
        color: #475569;
    }

    .stat-item i {
        color: #667eea;
        font-size: 14px;
    }

    /* Logout Button */
    .logout-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        background: #fee2e2;
        color: #dc2626;
        padding: 14px 32px;
        border-radius: 50px;
        text-decoration: none;
        font-weight: 600;
        font-size: 15px;
        transition: all 0.3s ease;
        margin-top: 20px;
        border: none;
        cursor: pointer;
    }

    .logout-btn:hover {
        background: #dc2626;
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(220, 38, 38, 0.3);
    }

    /* Quote Section */
    .quote {
        margin-top: 30px;
        padding-top: 20px;
        border-top: 2px solid #e2e8f0;
        font-size: 12px;
        color: #94a3b8;
    }

    .quote i {
        color: #f59e0b;
        margin: 0 4px;
    }

    /* Responsive */
    @media (max-width: 500px) {
        .container {
            padding: 35px 20px;
        }

        h2 {
            font-size: 26px;
        }

        .dashboard-card {
            padding: 16px 20px;
        }

        .card-title {
            font-size: 16px;
        }

        .card-icon {
            width: 45px;
            height: 45px;
        }

        .card-icon i {
            font-size: 22px;
        }

        .stats-section {
            gap: 12px;
        }

        .stat-item {
            padding: 8px 14px;
            font-size: 11px;
        }
    }
</style>

</head>
<body>

<div class="container">

    <div class="doctor-avatar">
        <i class="fas fa-user-md"></i>
    </div>

    <h2>Doctor Dashboard</h2>
    <div class="welcome-badge">
        <i class="fas fa-stethoscope"></i> Welcome Doctor
    </div>

    <div class="dashboard-grid">
        <a href="viewAppointments.jsp" class="dashboard-card">
            <div class="card-icon">
                <i class="fas fa-calendar-check"></i>
            </div>
            <div class="card-content">
                <div class="card-title">View Appointments</div>
                <div class="card-subtitle">Check your scheduled appointments</div>
            </div>
            <div class="card-arrow">
                <i class="fas fa-chevron-right"></i>
            </div>
        </a>
    </div>

    <div class="stats-section">
        <div class="stat-item">
            <i class="fas fa-clock"></i> Today's Schedule
        </div>
        <div class="stat-item">
            <i class="fas fa-chart-line"></i> Active Session
        </div>
        <div class="stat-item">
            <i class="fas fa-shield-alt"></i> Secure Access
        </div>
    </div>

    <a href="logout.jsp" class="logout-btn">
        <i class="fas fa-sign-out-alt"></i> Logout
    </a>

    <div class="quote">
        <i class="fas fa-heartbeat"></i> "Healing hands, caring hearts" <i class="fas fa-heartbeat"></i>
    </div>

</div>

</body>
</html>
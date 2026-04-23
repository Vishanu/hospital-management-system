<%@ page session="true" %>

<%
String role = (String) session.getAttribute("role");

if(role == null || !role.equals("patient")){
    response.sendRedirect("login.jsp");
    return;
}

// 🔥 SUCCESS MESSAGE
String msg = request.getParameter("msg");
%>

<!DOCTYPE html>
<html>
<head>
<title>Patient Dashboard | Hospital Management</title>

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

    /* Decorative background elements */
    body::before {
        content: '';
        position: absolute;
        width: 400px;
        height: 400px;
        background: rgba(255,255,255,0.05);
        border-radius: 50%;
        top: -200px;
        right: -200px;
    }

    body::after {
        content: '';
        position: absolute;
        width: 300px;
        height: 300px;
        background: rgba(255,255,255,0.05);
        border-radius: 50%;
        bottom: -150px;
        left: -150px;
    }

    .container {
        background: white;
        border-radius: 32px;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.3);
        padding: 50px 45px;
        width: 100%;
        max-width: 500px;
        text-align: center;
        transition: transform 0.3s ease;
        position: relative;
        z-index: 1;
        border: none;
        display: block;
    }

    .container:hover {
        transform: translateY(-5px);
    }

    /* Patient Avatar */
    .patient-avatar {
        width: 90px;
        height: 90px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 20px;
        box-shadow: 0 10px 25px -5px rgba(102, 126, 234, 0.4);
    }

    .patient-avatar i {
        font-size: 45px;
        color: white;
    }

    h2 {
        color: #1e293b;
        font-size: 32px;
        font-weight: 800;
        margin-bottom: 10px;
        letter-spacing: -0.5px;
    }

    .welcome-text {
        color: #64748b;
        font-size: 14px;
        margin-bottom: 30px;
        padding-bottom: 20px;
        border-bottom: 2px solid #e2e8f0;
    }

    /* 🔥 message style */
    .success {
        background: #d1fae5;
        color: #065f46;
        padding: 14px 20px;
        border-radius: 14px;
        margin-bottom: 25px;
        font-weight: 600;
        font-size: 14px;
        text-align: center;
        border-left: 4px solid #059669;
        animation: slideDown 0.4s ease;
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

    .success i {
        margin-right: 8px;
        color: #059669;
    }

    /* Dashboard Links Grid */
    .dashboard-links {
        display: flex;
        flex-direction: column;
        gap: 16px;
        margin: 25px 0;
    }

    .dashboard-link {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 18px 24px;
        background: #f8fafc;
        border: 2px solid #e2e8f0;
        border-radius: 18px;
        text-decoration: none;
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
        box-shadow: 0 8px 20px rgba(102, 126, 234, 0.15);
    }

    .link-icon {
        width: 45px;
        height: 45px;
        background: linear-gradient(135deg, #667eea15 0%, #764ba215 100%);
        border-radius: 14px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .link-icon i {
        font-size: 22px;
        color: #667eea;
    }

    .link-content {
        flex: 1;
        text-align: left;
        margin-left: 18px;
    }

    .link-title {
        font-size: 17px;
        font-weight: 700;
        color: #1e293b;
        margin-bottom: 4px;
    }

    .link-desc {
        font-size: 12px;
        color: #64748b;
    }

    .link-arrow {
        color: #94a3b8;
        font-size: 18px;
        transition: all 0.3s ease;
    }

    .dashboard-link:hover .link-arrow {
        color: #667eea;
        transform: translateX(5px);
    }

    /* Logout Button */
    .logout-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        background: #fee2e2;
        color: #dc2626;
        padding: 12px 28px;
        border-radius: 40px;
        text-decoration: none;
        font-weight: 600;
        font-size: 14px;
        transition: all 0.3s ease;
        margin-top: 20px;
        width: 100%;
    }

    .logout-btn:hover {
        background: #dc2626;
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(220, 38, 38, 0.3);
    }

    /* Health Tip Section */
    .health-tip {
        margin-top: 25px;
        padding: 15px;
        background: #fef3c7;
        border-radius: 14px;
        font-size: 12px;
        color: #92400e;
        text-align: center;
        border-left: 4px solid #f59e0b;
    }

    .health-tip i {
        margin-right: 6px;
        color: #f59e0b;
    }

    /* Responsive */
    @media (max-width: 500px) {
        .container {
            padding: 35px 25px;
        }

        h2 {
            font-size: 26px;
        }

        .dashboard-link {
            padding: 14px 18px;
        }

        .link-title {
            font-size: 15px;
        }

        .link-desc {
            font-size: 11px;
        }

        .link-icon {
            width: 38px;
            height: 38px;
        }

        .link-icon i {
            font-size: 18px;
        }
    }
</style>

<script>
// 🔥 auto hide message with fade animation
setTimeout(() => {
    let msgBox = document.getElementById("msgBox");
    if(msgBox) {
        msgBox.style.transition = "opacity 0.5s ease";
        msgBox.style.opacity = "0";
        setTimeout(() => {
            if(msgBox) msgBox.style.display = "none";
        }, 500);
    }
}, 2500);
</script>

</head>

<body>

<div class="container">

<div class="patient-avatar">
    <i class="fas fa-user-injured"></i>
</div>

<h2>Patient Dashboard</h2>
<div class="welcome-text">
    <i class="fas fa-heartbeat"></i> Welcome back! We care about your health
</div>

<!-- 🔥 SUCCESS MESSAGE -->
<% if("booked".equals(msg)){ %>
    <p id="msgBox" class="success"><i class="fas fa-check-circle"></i> ✔ Appointment Booked Successfully!</p>
<% } %>

<div class="dashboard-links">
    <a href="bookAppointment.jsp" class="dashboard-link">
        <div class="link-icon">
            <i class="fas fa-calendar-plus"></i>
        </div>
        <div class="link-content">
            <div class="link-title">Book Appointment</div>
            <div class="link-desc">Schedule a visit with a doctor</div>
        </div>
        <div class="link-arrow"><i class="fas fa-chevron-right"></i></div>
    </a>

    <a href="viewAppointments.jsp" class="dashboard-link">
        <div class="link-icon">
            <i class="fas fa-calendar-check"></i>
        </div>
        <div class="link-content">
            <div class="link-title">View My Appointments</div>
            <div class="link-desc">Check your upcoming visits</div>
        </div>
        <div class="link-arrow"><i class="fas fa-chevron-right"></i></div>
    </a>
</div>

<a href="logout.jsp" class="logout-btn">
    <i class="fas fa-sign-out-alt"></i> Logout
</a>

<div class="health-tip">
    <i class="fas fa-heart"></i>
    <strong>Health Tip:</strong> Stay hydrated! Drink at least 8 glasses of water daily.
</div>

</div>

</body>
</html>
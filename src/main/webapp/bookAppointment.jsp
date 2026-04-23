<%@ page import="java.util.*, dao.DoctorDAO, model.Doctor" %>

<%
String role = (String) session.getAttribute("role");

if(role == null || !role.equals("patient")){
    response.sendRedirect("login.jsp");
    return;
}

// 🔥 Fetch all doctors
DoctorDAO dao = new DoctorDAO();
List<Doctor> doctors = dao.getAllDoctors();
%>

<!DOCTYPE html>
<html>
<head>
<title>Book Appointment | Hospital Management</title>

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet">

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
    }

    .container {
        background: white;
        border-radius: 28px;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.3);
        padding: 45px 40px;
        width: 100%;
        max-width: 550px;
        transition: transform 0.3s ease;
        border: none;
        display: block;
    }

    .container:hover {
        transform: translateY(-5px);
    }

    h2 {
        color: #1e293b;
        font-size: 32px;
        font-weight: 700;
        margin-bottom: 15px;
        text-align: center;
        position: relative;
        padding-bottom: 15px;
    }

    h2 i {
        color: #667eea;
        margin-right: 12px;
    }

    h2:after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 70px;
        height: 4px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 2px;
    }

    .subtitle {
        text-align: center;
        color: #64748b;
        font-size: 14px;
        margin-bottom: 30px;
    }

    select, input {
        width: 100%;
        padding: 14px 16px;
        margin: 10px 0;
        border: 2px solid #e2e8f0;
        border-radius: 14px;
        font-size: 15px;
        font-family: 'Inter', sans-serif;
        transition: all 0.3s ease;
        background: #f8fafc;
        cursor: pointer;
    }

    select {
        appearance: none;
        background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="%2364748b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>');
        background-repeat: no-repeat;
        background-position: right 16px center;
    }

    input[type="date"] {
        cursor: pointer;
    }

    input[type="date"]::-webkit-calendar-picker-indicator {
        cursor: pointer;
        filter: invert(0.5);
    }

    select:focus, input:focus {
        outline: none;
        border-color: #667eea;
        background: white;
        box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
    }

    button {
        width: 100%;
        padding: 14px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        border-radius: 14px;
        font-size: 16px;
        font-weight: 600;
        font-family: 'Inter', sans-serif;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-top: 20px;
        box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
    }

    button:hover {
        background: linear-gradient(135deg, #5a67d8 0%, #6b46a0 100%);
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
    }

    button:active {
        transform: translateY(0);
    }

    button i {
        margin-right: 8px;
    }

    .error {
        color: #dc2626;
        background: #fee2e2;
        padding: 14px;
        border-radius: 12px;
        margin: 15px 0;
        text-align: center;
        font-weight: 500;
        font-size: 14px;
        border-left: 4px solid #dc2626;
        animation: shake 0.3s ease;
    }

    @keyframes shake {
        0%, 100% { transform: translateX(0); }
        25% { transform: translateX(-5px); }
        75% { transform: translateX(5px); }
    }

    .back-link {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        margin-top: 25px;
        color: #667eea;
        text-decoration: none;
        font-weight: 500;
        font-size: 14px;
        transition: all 0.3s ease;
        padding: 10px 20px;
        border-radius: 40px;
        background: #f1f5f9;
    }

    .back-link:hover {
        background: #e2e8f0;
        color: #5a67d8;
        transform: translateX(-5px);
    }

    /* Doctor count badge */
    .doctor-count {
        display: inline-block;
        background: #dbeafe;
        color: #1e40af;
        font-size: 12px;
        font-weight: 600;
        padding: 4px 12px;
        border-radius: 40px;
        margin-left: 10px;
    }

    .info-note {
        background: #fef3c7;
        border-left: 4px solid #f59e0b;
        padding: 12px;
        margin-top: 20px;
        border-radius: 10px;
        font-size: 12px;
        color: #92400e;
        text-align: left;
    }

    .info-note i {
        margin-right: 8px;
        color: #f59e0b;
    }

    /* Responsive */
    @media (max-width: 600px) {
        .container {
            padding: 30px 20px;
        }

        h2 {
            font-size: 26px;
        }

        select, input, button {
            padding: 12px 14px;
        }
    }
</style>

<script>
function validateForm() {
    let doctor = document.forms["form"]["doctorId"].value;
    let date = document.forms["form"]["date"].value;

    if (doctor === "") {
        alert("⚠️ Please select a doctor");
        return false;
    }

    if (date === "") {
        alert("📅 Please select a date");
        return false;
    }

    // Optional: Check if date is not in past
    let selectedDate = new Date(date);
    let today = new Date();
    today.setHours(0, 0, 0, 0);

    if (selectedDate < today) {
        alert("📅 Please select today or a future date");
        return false;
    }

    return true;
}
</script>

</head>

<body>

<div class="container">

<h2><i class="fas fa-calendar-plus"></i> Book Appointment</h2>
<div class="subtitle">
    <i class="fas fa-stethoscope"></i> Select your preferred doctor and date
    <span class="doctor-count"><i class="fas fa-user-md"></i> <%= doctors.size() %> Doctors Available</span>
</div>

<form name="form" action="bookAppointment" method="post" onsubmit="return validateForm()">

    <!-- 🔥 Doctor Dropdown -->
    <select name="doctorId" required>
        <option value="" disabled selected>-- 👨‍⚕️ Select Doctor --</option>

        <%
        for(Doctor d : doctors){
        %>
        <option value="<%= d.getId() %>">
            🩺 <%= d.getName() %> - <%= d.getSpecialization() %>
        </option>
        <%
        }
        %>

    </select>

    <!-- Date -->
    <input type="date" name="date" required placeholder="Select Date">

    <button type="submit"><i class="fas fa-check-circle"></i> Book Appointment</button>

</form>

<br>

<% if(request.getParameter("error") != null){ %>
<p class="error"><i class="fas fa-exclamation-triangle"></i> Something went wrong! Please try again.</p>
<% } %>

<div class="info-note">
    <i class="fas fa-info-circle"></i>
    <strong>Note:</strong> Appointment request will be confirmed by the admin. Please check your dashboard for status updates.
</div>

<br>
<a href="patientDashboard.jsp" class="back-link"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>

</div>

</body>
</html>
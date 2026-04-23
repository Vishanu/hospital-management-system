<%@ page import="java.util.*, dao.AppointmentDAO, model.Appointment" %>

<%
String role = (String) session.getAttribute("role");

if(role == null){
    response.sendRedirect("login.jsp");
    return;
}

AppointmentDAO dao = new AppointmentDAO();
List<Appointment> list = null;

// 🔥 Role based data
if("admin".equals(role)){
    list = dao.getAllAppointments();

} else if("patient".equals(role)){
    Integer patientId = (Integer) session.getAttribute("userId");
    list = dao.getAppointmentsByPatientId(patientId);

}else if("doctor".equals(role)){

     Integer doctorId = (Integer) session.getAttribute("userId");

     out.println("DEBUG doctorId = " + doctorId); // TEMP

     if(doctorId == null || doctorId == 0){
         response.sendRedirect("login.jsp");
         return;
     }

     list = dao.getAppointmentsByDoctorId(doctorId);
 }

// 🔥 Dynamic back page
String backPage = "login.jsp";

if("admin".equals(role)){
    backPage = "adminDashboard.jsp";
} else if("doctor".equals(role)){
    backPage = "doctorDashboard.jsp";
} else if("patient".equals(role)){
    backPage = "patientDashboard.jsp";
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Appointments | Hospital Management</title>

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
        padding: 40px 20px;
    }

    .container {
        max-width: 1300px;
        margin: 0 auto;
        background: white;
        border-radius: 28px;
        padding: 35px;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
    }

    h2 {
        color: #1e293b;
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
        gap: 12px;
    }

    h2 i {
        color: #667eea;
        font-size: 32px;
    }

    .subtitle {
        color: #64748b;
        font-size: 14px;
        margin-bottom: 30px;
        padding-bottom: 20px;
        border-bottom: 2px solid #e2e8f0;
    }

    /* Table Styles */
    .table-wrapper {
        overflow-x: auto;
        border-radius: 20px;
        margin-bottom: 30px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 14px;
    }

    th {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 16px 15px;
        font-weight: 600;
        text-align: center;
        font-size: 14px;
    }

    th i {
        margin-right: 8px;
        font-size: 14px;
    }

    td {
        padding: 14px 15px;
        text-align: center;
        border-bottom: 1px solid #e2e8f0;
        color: #334155;
    }

    tr {
        transition: all 0.3s ease;
    }

    tr:hover {
        background: #f8fafc;
        transform: scale(1.01);
    }

    /* Status Badges */
    .status-badge {
        display: inline-block;
        padding: 6px 14px;
        border-radius: 40px;
        font-size: 12px;
        font-weight: 600;
    }

    .status-pending {
        background: #fef3c7;
        color: #92400e;
    }

    .status-approved {
        background: #d1fae5;
        color: #065f46;
    }

    .status-rejected {
        background: #fee2e2;
        color: #991b1b;
    }

    .status-completed {
        background: #dbeafe;
        color: #1e40af;
    }

    /* Doctor Action Form */
    .action-form {
        display: flex;
        gap: 8px;
        justify-content: center;
        align-items: center;
        flex-wrap: wrap;
    }

    .action-select {
        padding: 8px 12px;
        border: 2px solid #e2e8f0;
        border-radius: 10px;
        font-size: 13px;
        font-family: 'Inter', sans-serif;
        background: white;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .action-select:focus {
        outline: none;
        border-color: #667eea;
    }

    .action-btn {
        padding: 8px 18px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        border-radius: 10px;
        font-size: 12px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .action-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 10px rgba(102, 126, 234, 0.4);
    }

    /* Empty State */
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        color: #94a3b8;
    }

    .empty-state i {
        font-size: 64px;
        margin-bottom: 20px;
        opacity: 0.5;
    }

    .empty-state p {
        font-size: 16px;
    }

    /* Back Button */
    .back-btn {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        background: #f1f5f9;
        color: #475569;
        padding: 12px 28px;
        border-radius: 40px;
        text-decoration: none;
        font-weight: 600;
        font-size: 14px;
        transition: all 0.3s ease;
        margin-top: 10px;
    }

    .back-btn:hover {
        background: #e2e8f0;
        color: #1e293b;
        transform: translateX(-5px);
    }

    /* Debug Info (kept original) */
    .debug-info {
        background: #f1f5f9;
        padding: 8px 15px;
        border-radius: 10px;
        font-size: 12px;
        color: #64748b;
        margin-bottom: 20px;
        font-family: monospace;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .container {
            padding: 20px;
        }

        h2 {
            font-size: 24px;
        }

        th, td {
            padding: 10px 8px;
            font-size: 12px;
        }

        .action-form {
            flex-direction: column;
        }

        .action-select, .action-btn {
            width: 100%;
        }
    }
</style>

</head>

<body>

<div class="container">

<h2>
    <i class="fas fa-calendar-alt"></i>
    Appointments
</h2>
<div class="subtitle">
    <i class="fas fa-list"></i>
    View and manage all appointments
    <% if("doctor".equals(role)){ %>
        • <i class="fas fa-check-circle"></i> You can update appointment status
    <% } %>
</div>

<div class="table-wrapper">
<table>
    <thead>
        <tr>

<% if("admin".equals(role)){ %>
    <th><i class="fas fa-hashtag"></i> ID</th>
    <th><i class="fas fa-user"></i> Patient</th>
    <th><i class="fas fa-user-md"></i> Doctor</th>
    <th><i class="fas fa-calendar-day"></i> Date</th>
    <th><i class="fas fa-flag-checkered"></i> Status</th>

<% } else if("patient".equals(role)){ %>
    <th><i class="fas fa-hashtag"></i> ID</th>
    <th><i class="fas fa-user-md"></i> Doctor</th>
    <th><i class="fas fa-calendar-day"></i> Date</th>
    <th><i class="fas fa-flag-checkered"></i> Status</th>

<% } else if("doctor".equals(role)){ %>
    <th><i class="fas fa-hashtag"></i> ID</th>
    <th><i class="fas fa-user"></i> Patient</th>
    <th><i class="fas fa-calendar-day"></i> Date</th>
    <th><i class="fas fa-flag-checkered"></i> Status</th>
    <th><i class="fas fa-edit"></i> Action</th>
<% } %>

        </tr>
    </thead>
    <tbody>

<%
if(list != null && !list.isEmpty()){
for(Appointment a : list){
%>

<tr>

<% if("admin".equals(role)){ %>
    <td><strong>#<%= a.getId() %></strong></td>
    <td><i class="fas fa-user-circle"></i> <%= a.getPatientName() %></td>
    <td><i class="fas fa-stethoscope"></i> <%= a.getDoctorName() %></td>
    <td><i class="far fa-calendar-alt"></i> <%= a.getAppointmentDate() %></td>
    <td>
        <%
        String status = a.getStatus();
        String badgeClass = "status-pending";
        if("Approved".equalsIgnoreCase(status)) badgeClass = "status-approved";
        else if("Rejected".equalsIgnoreCase(status)) badgeClass = "status-rejected";
        else if("Completed".equalsIgnoreCase(status)) badgeClass = "status-completed";
        %>
        <span class="status-badge <%= badgeClass %>">
            <i class="fas <%= status.equalsIgnoreCase("Approved") ? "fa-check" : status.equalsIgnoreCase("Rejected") ? "fa-times" : "fa-clock" %>"></i>
            <%= status %>
        </span>
    </td>

<% } else if("patient".equals(role)){ %>
    <td><strong>#<%= a.getId() %></strong></td>
    <td><i class="fas fa-stethoscope"></i> <%= a.getDoctorName() %></td>
    <td><i class="far fa-calendar-alt"></i> <%= a.getAppointmentDate() %></td>
    <td>
        <%
        String status = a.getStatus();
        String badgeClass = "status-pending";
        if("Approved".equalsIgnoreCase(status)) badgeClass = "status-approved";
        else if("Rejected".equalsIgnoreCase(status)) badgeClass = "status-rejected";
        else if("Completed".equalsIgnoreCase(status)) badgeClass = "status-completed";
        %>
        <span class="status-badge <%= badgeClass %>">
            <i class="fas <%= status.equalsIgnoreCase("Approved") ? "fa-check" : status.equalsIgnoreCase("Rejected") ? "fa-times" : "fa-clock" %>"></i>
            <%= status %>
        </span>
    </td>

<% } else if("doctor".equals(role)){ %>
    <td><strong>#<%= a.getId() %></strong></td>
    <td><i class="fas fa-user-circle"></i> <%= a.getPatientName() %></td>
    <td><i class="far fa-calendar-alt"></i> <%= a.getAppointmentDate() %></td>
    <td>
        <%
        String status = a.getStatus();
        String badgeClass = "status-pending";
        if("Approved".equalsIgnoreCase(status)) badgeClass = "status-approved";
        else if("Rejected".equalsIgnoreCase(status)) badgeClass = "status-rejected";
        else if("Completed".equalsIgnoreCase(status)) badgeClass = "status-completed";
        %>
        <span class="status-badge <%= badgeClass %>">
            <i class="fas <%= status.equalsIgnoreCase("Approved") ? "fa-check" : status.equalsIgnoreCase("Rejected") ? "fa-times" : "fa-clock" %>"></i>
            <%= status %>
        </span>
    </td>

    <td>
        <form action="updateStatus" method="post" class="action-form">
            <input type="hidden" name="id" value="<%= a.getId() %>">
            <select name="status" class="action-select">
                <option value="Approved">✅ Approve</option>
                <option value="Rejected">❌ Reject</option>
            </select>
            <button type="submit" class="action-btn"><i class="fas fa-save"></i> Update</button>
        </form>
    </td>

<% } %>

</tr>

<%
}
} else {
%>

<tr>
    <td colspan="<%= "admin".equals(role) ? 5 : "patient".equals(role) ? 4 : 5 %>">
        <div class="empty-state">
            <i class="fas fa-calendar-times"></i>
            <p>No appointments found</p>
            <p style="font-size: 12px; margin-top: 8px;">
                <% if("patient".equals(role)){ %>
                    <a href="bookAppointment.jsp" style="color: #667eea;">Book your first appointment →</a>
                <% } else { %>
                    Check back later for updates
                <% } %>
            </p>
        </div>
    </td>
</tr>

<%
}
%>

    </tbody>
</table>
</div>

<!-- 🔥 FIXED BACK BUTTON -->
<a href="<%= backPage %>" class="back-btn">
    <i class="fas fa-arrow-left"></i> Back to Dashboard
</a>

</div>

</body>
</html>
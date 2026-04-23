<%@ page import="java.util.*, dao.DoctorDAO, model.Doctor" %>

<%
String role = (String) session.getAttribute("role");

if(role == null || !role.equals("admin")){
    response.sendRedirect("login.jsp");
    return;
}

// 🔥 Fetch all doctors
DoctorDAO dao = new DoctorDAO();
List<Doctor> list = dao.getAllDoctors();
%>

<!DOCTYPE html>
<html>
<head>
<title>View Doctors | Hospital Management</title>

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
        max-width: 1200px;
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
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
    }

    .doctor-count {
        background: #dbeafe;
        color: #1e40af;
        padding: 6px 15px;
        border-radius: 40px;
        font-size: 13px;
        font-weight: 600;
    }

    .doctor-count i {
        margin-right: 6px;
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

    /* Doctor Name with icon */
    .doctor-name {
        font-weight: 600;
        color: #1e293b;
    }

    .doctor-name i {
        color: #667eea;
        margin-right: 8px;
    }

    .specialization {
        display: inline-block;
        padding: 4px 12px;
        background: #e0e7ff;
        border-radius: 40px;
        font-size: 12px;
        font-weight: 500;
        color: #4338ca;
    }

    .specialization i {
        margin-right: 4px;
        font-size: 11px;
    }

    .phone-number {
        font-family: monospace;
        font-size: 13px;
        letter-spacing: 0.5px;
    }

    /* Delete Button */
    .delete-form {
        display: inline-block;
    }

    .delete-btn {
        background: #fee2e2;
        color: #dc2626;
        border: none;
        padding: 8px 20px;
        border-radius: 40px;
        cursor: pointer;
        font-size: 13px;
        font-weight: 600;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }

    .delete-btn:hover {
        background: #dc2626;
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(220, 38, 38, 0.3);
    }

    .delete-btn i {
        font-size: 12px;
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

    .empty-state a {
        color: #667eea;
        text-decoration: none;
        font-weight: 600;
    }

    .empty-state a:hover {
        text-decoration: underline;
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
    }

    .back-btn:hover {
        background: #e2e8f0;
        color: #1e293b;
        transform: translateX(-5px);
    }

    /* Add Doctor Button */
    .add-doctor-link {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
        padding: 10px 24px;
        border-radius: 40px;
        text-decoration: none;
        font-weight: 600;
        font-size: 13px;
        transition: all 0.3s ease;
        box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
    }

    .add-doctor-link:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
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

        .delete-btn {
            padding: 6px 14px;
            font-size: 11px;
        }

        .subtitle {
            flex-direction: column;
            align-items: flex-start;
        }
    }
</style>

</head>

<body>

<div class="container">

<h2>
    <i class="fas fa-user-md"></i>
    Doctors List
</h2>
<div class="subtitle">
    <span><i class="fas fa-list"></i> Manage all registered doctors</span>
    <span class="doctor-count">
        <i class="fas fa-stethoscope"></i> Total Doctors: <%= list != null ? list.size() : 0 %>
    </span>
</div>

<div class="table-wrapper">
<table>
    <thead>
        <tr>
            <th><i class="fas fa-hashtag"></i> ID</th>
            <th><i class="fas fa-user-md"></i> Name</th>
            <th><i class="fas fa-brain"></i> Specialization</th>
            <th><i class="fas fa-phone-alt"></i> Phone</th>
            <th><i class="fas fa-trash-alt"></i> Action</th>
        </tr>
    </thead>
    <tbody>

<%
if(list != null && !list.isEmpty()){
for(Doctor d : list){
%>

        <tr>
            <td><strong>#<%= d.getId() %></strong></td>
            <td class="doctor-name">
                <i class="fas fa-user-circle"></i> <%= d.getName() %>
            </td>
            <td>
                <span class="specialization">
                    <i class="fas fa-stethoscope"></i> <%= d.getSpecialization() %>
                </span>
            </td>
            <td class="phone-number">
                <i class="fas fa-phone"></i> <%= d.getPhone() %>
            </td>
            <td>
                <form action="deleteDoctor" method="post" class="delete-form" onsubmit="return confirm('⚠️ Are you sure you want to delete Dr. <%= d.getName() %>? This action cannot be undone.');">
                    <input type="hidden" name="id" value="<%= d.getId() %>">
                    <button type="submit" class="delete-btn">
                        <i class="fas fa-trash-alt"></i> Delete
                    </button>
                </form>
            </td>
        </tr>

<%
}
} else {
%>

        <tr>
            <td colspan="5">
                <div class="empty-state">
                    <i class="fas fa-user-md"></i>
                    <p>No doctors found</p>
                    <p style="font-size: 12px; margin-top: 8px;">
                        <a href="addDoctor.jsp">➕ Add your first doctor</a>
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

<div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px;">
    <a href="adminDashboard.jsp" class="back-btn">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>

    <a href="addDoctor.jsp" class="add-doctor-link">
        <i class="fas fa-plus-circle"></i> Add New Doctor
    </a>
</div>

</div>

</body>
</html>
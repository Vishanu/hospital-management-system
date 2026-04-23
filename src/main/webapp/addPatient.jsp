<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*, model.*" %>

<%
String role = (String) session.getAttribute("role");
String username = (String) session.getAttribute("user");

if(role == null || !role.equals("ADMIN")){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admit Patient - Healix Hospital</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet">
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
            margin: 0;
            padding: 20px;
            min-height: 100vh;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            background: white;
            padding: 40px;
            border-radius: 24px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            transition: transform 0.3s ease;
        }

        .container:hover {
            transform: translateY(-5px);
        }

        h2 {
            text-align: center;
            color: #1e293b;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 30px;
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
            width: 80px;
            height: 4px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 2px;
        }

        .form-group {
            margin-bottom: 22px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #334155;
            font-size: 14px;
        }

        label i {
            margin-right: 8px;
            color: #667eea;
        }

        input[type="text"],
        input[type="number"],
        input[type="tel"],
        select {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 14px;
            font-family: 'Inter', sans-serif;
            transition: all 0.3s ease;
            background: #f8fafc;
        }

        input:focus, select:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }

        .radio-group {
            display: flex;
            gap: 20px;
            margin-top: 8px;
            padding: 8px 0;
        }

        .radio-group label {
            font-weight: 400;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            cursor: pointer;
            color: #475569;
        }

        .radio-group input[type="radio"] {
            width: auto;
            cursor: pointer;
            accent-color: #667eea;
        }

        button {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 14px 20px;
            border-radius: 12px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            font-weight: 600;
            font-family: 'Inter', sans-serif;
            margin-top: 15px;
            transition: all 0.3s ease;
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

        .message {
            margin-top: 20px;
            padding: 14px;
            border-radius: 12px;
            text-align: center;
            font-weight: 500;
            font-size: 14px;
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .success {
            background: #d1fae5;
            color: #065f46;
            border-left: 4px solid #059669;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
            border-left: 4px solid #dc2626;
        }

        .nav-links {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 2px solid #e2e8f0;
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .nav-links a {
            color: #64748b;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 8px;
            transition: all 0.3s ease;
            font-size: 14px;
            font-weight: 500;
        }

        .nav-links a:hover {
            background: #f1f5f9;
            color: #667eea;
            transform: translateY(-2px);
        }

        .nav-links a i {
            margin-right: 6px;
        }

        /* Responsive */
        @media (max-width: 640px) {
            .container {
                padding: 25px 20px;
                margin: 20px;
            }

            h2 {
                font-size: 24px;
            }

            .radio-group {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2><i class="fas fa-procedures"></i> Admit New Patient</h2>

        <form method="post" action="addPatient.jsp">
            <div class="form-group">
                <label><i class="fas fa-user"></i> Full Name:</label>
                <input type="text" name="name" placeholder="Enter patient name" required>
            </div>

            <div class="form-group">
                <label><i class="fas fa-calendar-alt"></i> Age:</label>
                <input type="number" name="age" placeholder="Enter age" min="0" max="150" required>
            </div>

            <div class="form-group">
                <label><i class="fas fa-venus-mars"></i> Gender:</label>
                <div class="radio-group">
                    <label><input type="radio" name="gender" value="Male" checked> <i class="fas fa-mars"></i> Male</label>
                    <label><input type="radio" name="gender" value="Female"> <i class="fas fa-venus"></i> Female</label>
                    <label><input type="radio" name="gender" value="Other"> <i class="fas fa-genderless"></i> Other</label>
                </div>
            </div>

            <div class="form-group">
                <label><i class="fas fa-phone-alt"></i> Phone Number:</label>
                <input type="tel" name="phone" placeholder="Enter contact number" required>
            </div>

            <div class="form-group">
                <label><i class="fas fa-stethoscope"></i> Disease / Reason:</label>
                <input type="text" name="disease" placeholder="e.g., Fever, Surgery" required>
            </div>

            <button type="submit" name="submit"><i class="fas fa-plus-circle"></i> Admit Patient</button>
        </form>

        <%
            if("POST".equalsIgnoreCase(request.getMethod())){
                try {
                    String name = request.getParameter("name");
                    int age = Integer.parseInt(request.getParameter("age"));
                    String gender = request.getParameter("gender");
                    String phone = request.getParameter("phone");
                    String disease = request.getParameter("disease");

                    if(name != null && !name.trim().isEmpty()){
                        Patient p = new Patient(name, age, gender, phone, disease);
                        PatientDAO dao = new PatientDAO();

                        if(dao.addPatient(p)){
                            out.println("<div class='message success'><i class='fas fa-check-circle'></i> ✅ Patient Admitted Successfully!</div>");
                        } else {
                            out.println("<div class='message error'><i class='fas fa-exclamation-triangle'></i> ❌ Failed to admit patient. Please try again.</div>");
                        }
                    } else {
                        out.println("<div class='message error'><i class='fas fa-exclamation-triangle'></i> ❌ Please fill all fields!</div>");
                    }
                } catch(NumberFormatException e) {
                    out.println("<div class='message error'><i class='fas fa-exclamation-triangle'></i> ❌ Invalid age! Please enter a valid number.</div>");
                } catch(Exception e) {
                    out.println("<div class='message error'><i class='fas fa-exclamation-triangle'></i> ❌ Error: " + e.getMessage() + "</div>");
                }
            }
        %>

        <div class="nav-links">
            <a href="viewPatients.jsp"><i class="fas fa-list"></i> View All Patients</a>
            <a href="home.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
            <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*, model.*" %>
<%@ page session="true" %>

<%
String role = (String) session.getAttribute("role");

if(role == null || !role.equals("admin")){  // 🔥 FIXED
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Management System | Admit Patient</title>

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
        .add-patient-wrapper {
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
            padding: 30px 35px;
            text-align: center;
        }

        .hospital-icon {
            font-size: 48px;
            margin-bottom: 10px;
        }

        .card-header h1 {
            color: white;
            font-size: 26px;
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
            padding: 5px 15px;
            border-radius: 40px;
            font-size: 12px;
            margin-top: 12px;
            font-weight: 500;
        }

        /* Form Body */
        .card-body {
            padding: 35px;
        }

        .form-title {
            font-size: 24px;
            font-weight: 600;
            color: #1e3a5f;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-subtitle {
            color: #5a6e7c;
            font-size: 14px;
            margin-bottom: 28px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e2e8f0;
        }

        /* Form Layout */
        .form-group {
            margin-bottom: 22px;
        }

        .input-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .input-group label {
            font-weight: 600;
            color: #2c3e50;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .input-group label i {
            margin-right: 6px;
        }

        .required:after {
            content: " *";
            color: #e74c3c;
        }

        .input-group input[type="text"],
        .input-group input[type="number"] {
            padding: 12px 16px;
            border: 1.5px solid #e2e8f0;
            border-radius: 12px;
            font-size: 14px;
            font-family: inherit;
            transition: all 0.2s ease;
            background: #f8fafc;
            outline: none;
        }

        .input-group input:focus {
            border-color: #2ecc71;
            box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.1);
            background: white;
        }

        /* Radio Group Styling */
        .radio-group {
            display: flex;
            gap: 25px;
            align-items: center;
            padding: 8px 0;
        }

        .radio-option {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }

        .radio-option input[type="radio"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: #2ecc71;
        }

        .radio-option label {
            font-weight: 500;
            color: #2c3e50;
            cursor: pointer;
            text-transform: none;
            letter-spacing: normal;
        }

        /* Two Column Layout */
        .two-columns {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 22px;
        }

        /* Button */
        .btn-admit {
            width: 100%;
            background: linear-gradient(105deg, #2ecc71 0%, #27ae60 100%);
            color: white;
            border: none;
            padding: 14px 24px;
            border-radius: 40px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            margin-top: 10px;
            font-family: inherit;
            letter-spacing: 0.5px;
        }

        .btn-admit:hover {
            background: linear-gradient(105deg, #27ae60 0%, #219a52 100%);
            transform: scale(1.02);
            box-shadow: 0 8px 18px rgba(46, 204, 113, 0.3);
        }

        .btn-admit:active {
            transform: scale(0.98);
        }

        /* Message Styles */
        .success-message {
            background: #d4edda;
            border-left: 4px solid #28a745;
            padding: 14px 18px;
            border-radius: 14px;
            margin: 20px 0 15px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .success-message span {
            color: #155724;
            font-size: 14px;
            font-weight: 500;
        }

        .error-message {
            background: #fee2e2;
            border-left: 4px solid #e74c3c;
            padding: 14px 18px;
            border-radius: 14px;
            margin: 20px 0 15px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .error-message span {
            color: #c0392b;
            font-size: 14px;
            font-weight: 500;
        }

        .warning-message {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 14px 18px;
            border-radius: 14px;
            margin: 20px 0 15px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .warning-message span {
            color: #856404;
            font-size: 14px;
            font-weight: 500;
        }

        /* Action Links */
        .action-links {
            background: #f8fafc;
            border-radius: 16px;
            padding: 15px 20px;
            margin-top: 25px;
            display: flex;
            justify-content: center;
            gap: 25px;
            flex-wrap: wrap;
        }

        .action-links a {
            color: #3498db;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 12px;
            border-radius: 40px;
        }

        .action-links a:hover {
            background: #e8f4fd;
            color: #2980b9;
        }

        /* Divider */
        .divider {
            border-top: 1px solid #e2e8f0;
            margin: 20px 0 5px;
        }

        /* Responsive */
        @media (max-width: 550px) {
            .card-body {
                padding: 25px;
            }

            .two-columns {
                grid-template-columns: 1fr;
                gap: 22px;
                margin-bottom: 0;
            }

            .form-group {
                margin-bottom: 18px;
            }

            .card-header h1 {
                font-size: 22px;
            }

            .radio-group {
                flex-wrap: wrap;
                gap: 15px;
            }

            .action-links {
                flex-direction: column;
                align-items: center;
                gap: 10px;
            }
        }
    </style>
</head>

<body>

<div class="add-patient-wrapper">
    <div class="card">

        <!-- Header Section -->
        <div class="card-header">
            <div class="hospital-icon">🏥</div>
            <h1>Hospital Management System</h1>
            <p>Admin Portal - Patient Admission</p>
            <div class="role-badge">🔐 Admin Access Only</div>
        </div>

        <!-- Form Body -->
        <div class="card-body">
            <div class="form-title">
                🏥 Admit New Patient
            </div>
            <div class="form-subtitle">
                Enter patient details to complete admission process
            </div>

            <!-- Add Patient Form - All backend logic preserved -->
            <form method="post">

                <!-- Full Name -->
                <div class="form-group">
                    <div class="input-group">
                        <label><i>👤</i> <span class="required">Full Name</span></label>
                        <input type="text" name="name" placeholder="Enter patient's full name" required>
                    </div>
                </div>

                <!-- Two Column Layout for Age & Gender -->
                <div class="two-columns">
                    <div class="input-group">
                        <label><i>📅</i> <span class="required">Age</span></label>
                        <input type="number" name="age" min="0" max="150" placeholder="Enter age (0-150)" required>
                    </div>

                    <div class="input-group">
                        <label><i>⚧</i> <span class="required">Gender</span></label>
                        <div class="radio-group">
                            <label class="radio-option">
                                <input type="radio" name="gender" value="Male" checked> Male
                            </label>
                            <label class="radio-option">
                                <input type="radio" name="gender" value="Female"> Female
                            </label>
                            <label class="radio-option">
                                <input type="radio" name="gender" value="Other"> Other
                            </label>
                        </div>
                    </div>
                </div>

                <!-- Phone Number -->
                <div class="form-group">
                    <div class="input-group">
                        <label><i>📱</i> <span class="required">Phone Number</span></label>
                        <input type="text" name="phone" placeholder="10-digit mobile number" required>
                    </div>
                </div>

                <!-- Disease -->
                <div class="form-group">
                    <div class="input-group">
                        <label><i>🩺</i> <span class="required">Disease / Medical Condition</span></label>
                        <input type="text" name="disease" placeholder="e.g., Fever, Diabetes, Hypertension" required>
                    </div>
                </div>

                <button type="submit" class="btn-admit">✓ Admit Patient</button>

            </form>

            <!-- Form Processing Results - ALL JSP LOGIC PRESERVED -->
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
            %>
            <div class="success-message">
                <span>✅</span>
                <span>Patient Admitted Successfully!</span>
            </div>
            <%
                        } else {
            %>
            <div class="error-message">
                <span>❌</span>
                <span>Failed to admit patient!</span>
            </div>
            <%
                        }
                    } else {
            %>
            <div class="warning-message">
                <span>⚠️</span>
                <span>Please fill all fields!</span>
            </div>
            <%
                    }

                } catch(Exception e){
            %>
            <div class="error-message">
                <span>⚠️</span>
                <span>Error: <%= e.getMessage() %></span>
            </div>
            <%
                }
            }
            %>

            <!-- Action Links -->
            <div class="action-links">
                <a href="viewPatients.jsp">📋 View All Patients</a>
                <a href="adminDashboard.jsp">📊 Dashboard</a>
                <a href="logout.jsp">🚪 Logout</a>
            </div>

        </div>
    </div>
</div>

</body>
</html>
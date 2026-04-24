<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>

<%
String role = (String) session.getAttribute("role");

if(role == null || !role.equals("admin")){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Management System | Add Doctor</title>

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
        .add-doctor-wrapper {
            max-width: 650px;
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

        .input-group input {
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

        /* Two Column Layout for Specialization & Phone */
        .two-columns {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 22px;
        }

        /* Button */
        .btn-add {
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

        .btn-add:hover {
            background: linear-gradient(105deg, #27ae60 0%, #219a52 100%);
            transform: scale(1.02);
            box-shadow: 0 8px 18px rgba(46, 204, 113, 0.3);
        }

        .btn-add:active {
            transform: scale(0.98);
        }

        /* Success Message */
        .success-message {
            background: #d4edda;
            border-left: 4px solid #28a745;
            padding: 14px 18px;
            border-radius: 14px;
            margin: 20px 0 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .success-message span {
            color: #155724;
            font-size: 14px;
            font-weight: 500;
        }

        /* Error Message */
        .error-message {
            background: #fee2e2;
            border-left: 4px solid #e74c3c;
            padding: 14px 18px;
            border-radius: 14px;
            margin: 20px 0 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .error-message span {
            color: #c0392b;
            font-size: 14px;
            font-weight: 500;
        }

        /* Footer Link */
        .footer-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #e2e8f0;
        }

        .footer-link a {
            color: #3498db;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: color 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .footer-link a:hover {
            color: #2980b9;
            text-decoration: underline;
        }

        /* Info Note */
        .info-note {
            background: #e8f4fd;
            padding: 10px 15px;
            border-radius: 12px;
            font-size: 12px;
            color: #1e3a5f;
            text-align: center;
            margin-bottom: 20px;
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
        }
    </style>

    <script>
        function validateForm() {
            let name = document.forms["form"]["name"].value.trim();
            let spec = document.forms["form"]["specialization"].value.trim();
            let phone = document.forms["form"]["phone"].value.trim();
            let email = document.forms["form"]["email"].value.trim();
            let password = document.forms["form"]["password"].value.trim();

            if (name === "" || spec === "" || phone === "" || email === "" || password === "") {
                alert("All fields are required!");
                return false;
            }

            if (!/^[0-9]{10}$/.test(phone)) {
                alert("Phone must be exactly 10 digits!");
                return false;
            }

            if (password.length < 6) {
                alert("Password must be at least 6 characters!");
                return false;
            }

            return true;
        }
    </script>
</head>

<body>

<div class="add-doctor-wrapper">
    <div class="card">

        <!-- Header Section -->
        <div class="card-header">
            <div class="hospital-icon">👨‍⚕️</div>
            <h1>Hospital Management System</h1>
            <p>Admin Portal - Doctor Management</p>
            <div class="role-badge">🔐 Admin Access Only</div>
        </div>

        <!-- Form Body -->
        <div class="card-body">
            <div class="form-title">
                ➕ Add New Doctor
            </div>
            <div class="form-subtitle">
                Enter doctor credentials and professional details
            </div>

            <!-- Info Note -->
            <div class="info-note">
                ℹ️ Doctor will receive these credentials. Password must be at least 6 characters.
            </div>

            <!-- Add Doctor Form - All backend logic preserved -->
            <form name="form" action="addDoctor" method="post" onsubmit="return validateForm()">

                <!-- Full Name -->
                <div class="form-group">
                    <div class="input-group">
                        <label><i>👤</i> <span class="required">Full Name</span></label>
                        <input type="text" name="name" placeholder="Dr. John Doe" required>
                    </div>
                </div>

                <!-- Two Column Layout -->
                <div class="two-columns">
                    <div class="input-group">
                        <label><i>🩺</i> <span class="required">Specialization</span></label>
                        <input type="text" name="specialization" placeholder="Cardiology, Neurology, etc." required>
                    </div>

                    <div class="input-group">
                        <label><i>📱</i> <span class="required">Phone Number</span></label>
                        <input type="text" name="phone" placeholder="10-digit mobile number" required>
                    </div>
                </div>

                <!-- Email -->
                <div class="form-group">
                    <div class="input-group">
                        <label><i>📧</i> <span class="required">Email Address</span></label>
                        <input type="email" name="email" placeholder="doctor@hospital.com" required>
                    </div>
                </div>

                <!-- Password -->
                <div class="form-group">
                    <div class="input-group">
                        <label><i>🔒</i> <span class="required">Password</span></label>
                        <input type="password" name="password" placeholder="Minimum 6 characters" required>
                    </div>
                </div>

                <button type="submit" class="btn-add">✓ Add New Doctor</button>

            </form>

            <!-- Success Message - JSP logic preserved -->
            <% if(request.getParameter("msg") != null){ %>
            <div class="success-message">
                <span>✅</span>
                <span>Doctor Added Successfully!</span>
            </div>
            <% } %>

            <!-- Error Message - JSP logic preserved -->
            <% if(request.getParameter("error") != null){ %>
            <div class="error-message">
                <span>⚠️</span>
                <span>Error while adding doctor! Please try again.</span>
            </div>
            <% } %>

            <!-- Footer Link -->
            <div class="footer-link">
                <a href="adminDashboard.jsp">← Back to Admin Dashboard</a>
            </div>

        </div>
    </div>
</div>

</body>
</html>
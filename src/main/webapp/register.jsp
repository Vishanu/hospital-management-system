<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Management System | Patient Registration</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #d4f1f9 0%, #a8e6cf 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }

        /* Centered Container */
        .register-wrapper {
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

        /* Form Grid Layout */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px 25px;
        }

        .full-width {
            grid-column: span 2;
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

        .input-group input,
        .input-group select {
            padding: 12px 14px;
            border: 1.5px solid #e2e8f0;
            border-radius: 12px;
            font-size: 14px;
            font-family: inherit;
            transition: all 0.2s ease;
            background: #f8fafc;
            outline: none;
        }

        .input-group input:focus,
        .input-group select:focus {
            border-color: #2ecc71;
            box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.1);
            background: white;
        }

        /* Required Field Indicator */
        .required:after {
            content: " *";
            color: #e74c3c;
        }

        /* Button */
        .btn-register {
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
            margin-top: 15px;
            font-family: inherit;
            letter-spacing: 0.5px;
        }

        .btn-register:hover {
            background: linear-gradient(105deg, #27ae60 0%, #219a52 100%);
            transform: scale(1.02);
            box-shadow: 0 8px 18px rgba(46, 204, 113, 0.3);
        }

        .btn-register:active {
            transform: scale(0.98);
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
            color: #2ecc71;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: color 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .footer-link a:hover {
            color: #27ae60;
            text-decoration: underline;
        }

        /* Responsive */
        @media (max-width: 600px) {
            .card-body {
                padding: 25px;
            }

            .form-grid {
                grid-template-columns: 1fr;
                gap: 18px;
            }

            .full-width {
                grid-column: span 1;
            }

            .card-header h1 {
                font-size: 22px;
            }
        }

        /* Info badge for role */
        .role-info {
            background: #e8f5e9;
            padding: 10px 15px;
            border-radius: 12px;
            font-size: 12px;
            color: #2e7d32;
            text-align: center;
            margin-bottom: 15px;
        }
    </style>

    <script>
        function validateForm() {
            let name = document.forms["form"]["name"].value.trim();
            let email = document.forms["form"]["email"].value.trim();
            let password = document.forms["form"]["password"].value.trim();
            let age = document.forms["form"]["age"].value.trim();
            let phone = document.forms["form"]["phone"].value.trim();

            if (name === "" || email === "" || password === "" || age === "" || phone === "") {
                alert("All fields are required!");
                return false;
            }

            let emailPattern = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/;
            if (!emailPattern.test(email)) {
                alert("Enter valid email!");
                return false;
            }

            if (password.length < 6) {
                alert("Password must be at least 6 characters!");
                return false;
            }

            if (!/^[0-9]{10}$/.test(phone)) {
                alert("Phone must be 10 digits!");
                return false;
            }

            return true;
        }
    </script>
</head>

<body>

<div class="register-wrapper">
    <div class="card">

        <!-- Header Section -->
        <div class="card-header">
            <div class="hospital-icon">🏥</div>
            <h1>Hospital Management System</h1>
            <p>Secure Patient Registration Portal</p>
        </div>

        <!-- Form Body -->
        <div class="card-body">
            <div class="form-title">
                📝 Create Patient Account
            </div>
            <div class="form-subtitle">
                Please fill in all required information to register as a patient
            </div>

            <!-- Role Information Badge -->
            <div class="role-info">
                ⚕️ Registering as: <strong>Patient</strong> (Access to appointments, prescriptions & medical records)
            </div>

            <!-- Registration Form - All backend logic preserved -->
            <form name="form" action="register" method="post" onsubmit="return validateForm()">

                <div class="form-grid">
                    <!-- Name -->
                    <div class="input-group full-width">
                        <label><i>👤</i> <span class="required">Full Name</span></label>
                        <input type="text" name="name" placeholder="Enter your full name" required>
                    </div>

                    <!-- Email -->
                    <div class="input-group full-width">
                        <label><i>📧</i> <span class="required">Email Address</span></label>
                        <input type="email" name="email" placeholder="you@example.com" required>
                    </div>

                    <!-- Password -->
                    <div class="input-group full-width">
                        <label><i>🔒</i> <span class="required">Password</span></label>
                        <input type="password" name="password" placeholder="Minimum 6 characters" required>
                    </div>

                    <!-- Age -->
                    <div class="input-group">
                        <label><i>📅</i> <span class="required">Age</span></label>
                        <input type="number" name="age" placeholder="e.g., 30" required>
                    </div>
                    <!-- Gender -->
                    <div class="input-group">
                        <label><i>⚧</i> Gender</label>
                        <select name="gender">
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                        </select>
                    </div>

                    <!-- Phone -->
                    <div class="input-group full-width">
                        <label><i>📱</i> <span class="required">Phone Number</span></label>
                        <input type="text" name="phone" placeholder="10-digit mobile number" required>
                    </div>

                    <!-- Disease -->
                    <div class="input-group full-width">
                        <label><i>🩺</i> Disease / Medical Condition</label>
                        <input type="text" name="disease" placeholder="e.g., Fever, Diabetes, Hypertension" required>
                    </div>
                </div>

                <!-- 🔥 hidden role - PRESERVED -->
                <input type="hidden" name="role" value="patient">

                <button type="submit" class="btn-register">✓ Register Patient Account</button>

            </form>

            <!-- Error Message Section - JSP logic preserved -->
            <%
            if(request.getParameter("error") != null){
            %>
            <div class="error-message">
                <span>⚠️</span>
                <span>Registration failed! Please check your details and try again.</span>
            </div>
            <%
            }
            %>

            <!-- Footer Link -->
            <div class="footer-link">
                <a href="login.jsp">← Back to Login</a>
            </div>

        </div>
    </div>
</div>

</body>
</html>
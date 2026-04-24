<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Management System | Login</title>

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
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        /* Centered Card Container */
        .login-container {
            width: 100%;
            max-width: 450px;
        }

        .card {
            background: white;
            border-radius: 24px;
            box-shadow: 0 20px 35px -10px rgba(0, 0, 0, 0.15);
            padding: 40px 35px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 30px 45px -12px rgba(0, 0, 0, 0.2);
        }

        /* Header */
        .hospital-brand {
            text-align: center;
            margin-bottom: 30px;
        }

        .hospital-icon {
            font-size: 48px;
            margin-bottom: 10px;
        }

        .hospital-brand h1 {
            font-size: 24px;
            color: #1e3a5f;
            font-weight: 600;
            letter-spacing: -0.3px;
        }

        .hospital-brand p {
            color: #5a6e7c;
            font-size: 14px;
            margin-top: 5px;
        }

        .login-title {
            text-align: center;
            font-size: 28px;
            font-weight: 600;
            color: #1e3a5f;
            margin-bottom: 28px;
            border-bottom: 3px solid #2ecc71;
            display: inline-block;
            width: auto;
            padding-bottom: 8px;
        }

        .title-wrapper {
            text-align: center;
            margin-bottom: 25px;
        }

        /* Form Styling */
        .login-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .input-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .input-group label {
            font-weight: 500;
            color: #2c3e50;
            font-size: 14px;
            letter-spacing: 0.3px;
        }

        .input-group input {
            padding: 12px 16px;
            border: 1.5px solid #e2e8f0;
            border-radius: 12px;
            font-size: 15px;
            transition: all 0.2s ease;
            font-family: inherit;
            outline: none;
            background: #f8fafc;
        }

        .input-group input:focus {
            border-color: #2ecc71;
            box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.1);
            background: white;
        }

        /* Modern Button */
        .btn-login {
            background: linear-gradient(105deg, #1e3a5f 0%, #2c5a7a 100%);
            color: white;
            border: none;
            padding: 14px 20px;
            border-radius: 40px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            margin-top: 10px;
            font-family: inherit;
            letter-spacing: 0.5px;
        }

        .btn-login:hover {
            background: linear-gradient(105deg, #16324d 0%, #1f4662 100%);
            transform: scale(1.02);
            box-shadow: 0 8px 18px rgba(0, 0, 0, 0.1);
        }

        .btn-login:active {
            transform: scale(0.98);
        }

        /* Error Message */
        .error-message {
            background: #fee2e2;
            border-left: 4px solid #e74c3c;
            padding: 12px 16px;
            border-radius: 12px;
            margin: 20px 0 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .error-message span {
            color: #c0392b;
            font-size: 14px;
            font-weight: 500;
        }

        .error-icon {
            font-size: 18px;
        }

        /* Register Link */
        .register-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #e2e8f0;
        }

        .register-link a {
            color: #2ecc71;
            text-decoration: none;
            font-weight: 600;
            font-size: 15px;
            transition: color 0.2s ease;
        }

        .register-link a:hover {
            color: #27ae60;
            text-decoration: underline;
        }

        .register-link p {
            color: #5a6e7c;
            font-size: 14px;
        }

        /* Responsive */
        @media (max-width: 500px) {
            .card {
                padding: 30px 20px;
            }

            .login-title {
                font-size: 24px;
            }
        }
    </style>

    <script>
        function validateForm() {
            let email = document.forms["loginForm"]["email"].value.trim();
            let password = document.forms["loginForm"]["password"].value.trim();

            if (email === "" || password === "") {
                alert("All fields are required!");
                return false;
            }

            // simple email regex
            let emailPattern = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/;
            if (!emailPattern.test(email)) {
                alert("Enter valid email!");
                return false;
            }

            return true;
        }
    </script>
</head>

<body>

<div class="login-container">
    <div class="card">

        <!-- Hospital Branding -->
        <div class="hospital-brand">
            <div class="hospital-icon">🏥</div>
            <h1>Hospital Management System</h1>
            <p>Secure Access Portal</p>
        </div>

        <div class="title-wrapper">
            <div class="login-title">Welcome Back</div>
        </div>

        <!-- Login Form - All backend logic preserved -->
        <form name="loginForm" class="login-form" action="login" method="post" onsubmit="return validateForm()">

            <div class="input-group">
                <label for="email">📧 Email Address</label>
                <input type="email" name="email" id="email" placeholder="doctor@hospital.com" required>
            </div>

            <div class="input-group">
                <label for="password">🔒 Password</label>
                <input type="password" name="password" id="password" placeholder="Enter your password" required>
            </div>

            <button type="submit" class="btn-login">Login to Dashboard →</button>

        </form>

        <!-- Error message section - JSP logic preserved -->
        <%
        if(request.getParameter("error") != null){
        %>
        <div class="error-message">
            <div class="error-icon">⚠️</div>
            <span>Invalid Email or Password. Please try again.</span>
        </div>
        <%
        }
        %>

        <!-- Registration Link -->
        <div class="register-link">
            <p>Don't have an account?</p>
            <a href="register.jsp">Create New Account →</a>
        </div>

    </div>
</div>

</body>
</html>
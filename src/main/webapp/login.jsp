<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Login | Hospital Management System</title>

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

    /* Decorative background circles */
    body::before {
        content: '';
        position: absolute;
        width: 300px;
        height: 300px;
        background: rgba(255,255,255,0.1);
        border-radius: 50%;
        top: -150px;
        right: -150px;
    }

    body::after {
        content: '';
        position: absolute;
        width: 250px;
        height: 250px;
        background: rgba(255,255,255,0.08);
        border-radius: 50%;
        bottom: -100px;
        left: -100px;
    }

    .login-container {
        background: white;
        border-radius: 32px;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        padding: 50px 45px;
        width: 100%;
        max-width: 450px;
        text-align: center;
        transition: transform 0.3s ease;
        position: relative;
        z-index: 1;
    }

    .login-container:hover {
        transform: translateY(-5px);
    }

    /* Hospital Logo/Brand */
    .brand {
        margin-bottom: 30px;
    }

    .brand-icon {
        width: 70px;
        height: 70px;
        background: linear-gradient(135deg, #667eea, #764ba2);
        border-radius: 25px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 15px;
        box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
    }

    .brand-icon i {
        font-size: 36px;
        color: white;
    }

    .brand h2 {
        color: #1e293b;
        font-size: 28px;
        font-weight: 800;
        letter-spacing: -0.5px;
    }

    .brand p {
        color: #64748b;
        font-size: 13px;
        margin-top: 5px;
    }

    /* Input Groups */
    .input-group {
        margin-bottom: 20px;
        text-align: left;
    }

    .input-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        font-size: 13px;
        color: #334155;
    }

    .input-group label i {
        margin-right: 8px;
        color: #667eea;
    }

    .input-wrapper {
        position: relative;
    }

    .input-wrapper i {
        position: absolute;
        left: 15px;
        top: 50%;
        transform: translateY(-50%);
        color: #94a3b8;
        font-size: 16px;
    }

    input {
        width: 100%;
        padding: 14px 16px 14px 45px;
        border: 2px solid #e2e8f0;
        border-radius: 14px;
        font-size: 14px;
        font-family: 'Inter', sans-serif;
        transition: all 0.3s ease;
        background: #f8fafc;
    }

    input:focus {
        outline: none;
        border-color: #667eea;
        background: white;
        box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
    }

    input::placeholder {
        color: #cbd5e1;
        font-weight: 400;
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
        margin-top: 10px;
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
        padding: 12px;
        border-radius: 12px;
        margin: 15px 0;
        text-align: center;
        font-weight: 500;
        font-size: 13px;
        border-left: 4px solid #dc2626;
        animation: shake 0.3s ease;
    }

    @keyframes shake {
        0%, 100% { transform: translateX(0); }
        25% { transform: translateX(-5px); }
        75% { transform: translateX(5px); }
    }

    .register-link {
        margin-top: 25px;
        padding-top: 20px;
        border-top: 2px solid #e2e8f0;
    }

    .register-link a {
        color: #667eea;
        text-decoration: none;
        font-weight: 600;
        font-size: 14px;
        transition: all 0.3s ease;
    }

    .register-link a:hover {
        color: #5a67d8;
        text-decoration: underline;
    }

    .register-link a i {
        margin-right: 6px;
    }

    /* Footer */
    .footer-note {
        margin-top: 20px;
        font-size: 11px;
        color: #94a3b8;
    }

    /* Responsive */
    @media (max-width: 480px) {
        .login-container {
            padding: 35px 25px;
        }

        .brand h2 {
            font-size: 24px;
        }

        input {
            padding: 12px 16px 12px 40px;
        }
    }
</style>

<script>
function validateForm() {
    let email = document.forms["loginForm"]["email"].value;
    let password = document.forms["loginForm"]["password"].value;

    if (email === "" || password === "") {
        alert("⚠️ All fields are required!");
        return false;
    }

    if (!email.includes("@")) {
        alert("📧 Please enter a valid email address!");
        return false;
    }

    return true;
}
</script>

</head>

<body>

<div class="login-container">

    <div class="brand">
        <div class="brand-icon">
            <i class="fas fa-hospital-user"></i>
        </div>
        <h2>Welcome Back</h2>
        <p>Login to access your dashboard</p>
    </div>

    <form name="loginForm" action="login" method="post" onsubmit="return validateForm()">

        <div class="input-group">
            <label><i class="fas fa-envelope"></i> Email Address</label>
            <div class="input-wrapper">
                <i class="fas fa-envelope"></i>
                <input type="email" name="email" placeholder="doctor@hospital.com" required>
            </div>
        </div>

        <div class="input-group">
            <label><i class="fas fa-lock"></i> Password</label>
            <div class="input-wrapper">
                <i class="fas fa-lock"></i>
                <input type="password" name="password" placeholder="Enter your password" required>
            </div>
        </div>

        <button type="submit"><i class="fas fa-sign-in-alt"></i> Login</button>
    </form>

    <% if(request.getParameter("error") != null){ %>
    <p class="error"><i class="fas fa-exclamation-triangle"></i> Invalid Email or Password</p>
    <% } %>

    <div class="register-link">
        <a href="register.jsp"><i class="fas fa-user-plus"></i> Create New Account</a>
    </div>

    <div class="footer-note">
        <i class="fas fa-shield-alt"></i> Secure Login • Hospital Management System
    </div>
</div>

</body>
</html>
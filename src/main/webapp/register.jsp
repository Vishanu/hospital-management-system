<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Register | Hospital Management System</title>

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

    /* Decorative circles */
    body::before {
        content: '';
        position: absolute;
        width: 350px;
        height: 350px;
        background: rgba(255,255,255,0.08);
        border-radius: 50%;
        top: -150px;
        right: -150px;
    }

    body::after {
        content: '';
        position: absolute;
        width: 280px;
        height: 280px;
        background: rgba(255,255,255,0.08);
        border-radius: 50%;
        bottom: -120px;
        left: -120px;
    }

    .register-container {
        background: white;
        border-radius: 32px;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        padding: 45px 45px;
        width: 100%;
        max-width: 500px;
        transition: transform 0.3s ease;
        position: relative;
        z-index: 1;
    }

    .register-container:hover {
        transform: translateY(-5px);
    }

    /* Logo/Brand */
    .brand {
        text-align: center;
        margin-bottom: 30px;
    }

    .brand-icon {
        width: 70px;
        height: 70px;
        background: linear-gradient(135deg, #667eea, #764ba2);
        border-radius: 22px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 15px;
        box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
    }

    .brand-icon i {
        font-size: 34px;
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

    /* Form Groups */
    .form-group {
        margin-bottom: 22px;
    }

    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        font-size: 13px;
        color: #334155;
    }

    .form-group label i {
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

    input, select {
        width: 100%;
        padding: 14px 16px 14px 45px;
        border: 2px solid #e2e8f0;
        border-radius: 14px;
        font-size: 14px;
        font-family: 'Inter', sans-serif;
        transition: all 0.3s ease;
        background: #f8fafc;
    }

    select {
        padding: 14px 16px;
        appearance: none;
        background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="%2364748b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>');
        background-repeat: no-repeat;
        background-position: right 16px center;
        cursor: pointer;
    }

    input:focus, select:focus {
        outline: none;
        border-color: #667eea;
        background: white;
        box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
    }

    input::placeholder {
        color: #cbd5e1;
        font-weight: 400;
    }

    /* Role specific styling */
    .role-hint {
        font-size: 11px;
        color: #94a3b8;
        margin-top: 6px;
        display: block;
    }

    .role-hint i {
        font-size: 10px;
        margin-right: 4px;
    }

    /* Button */
    .btn-register {
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

    .btn-register:hover {
        background: linear-gradient(135deg, #5a67d8 0%, #6b46a0 100%);
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
    }

    .btn-register:active {
        transform: translateY(0);
    }

    .btn-register i {
        margin-right: 8px;
    }

    /* Footer Links */
    .footer-links {
        margin-top: 25px;
        padding-top: 20px;
        border-top: 2px solid #e2e8f0;
        text-align: center;
        display: flex;
        justify-content: center;
        gap: 20px;
        flex-wrap: wrap;
    }

    .footer-links a {
        color: #667eea;
        text-decoration: none;
        font-weight: 600;
        font-size: 13px;
        transition: all 0.3s ease;
    }

    .footer-links a:hover {
        color: #5a67d8;
        text-decoration: underline;
    }

    .footer-links a i {
        margin-right: 6px;
    }

    /* Password strength indicator (decorative) */
    .password-hint {
        font-size: 11px;
        color: #94a3b8;
        margin-top: 6px;
    }

    /* Responsive */
    @media (max-width: 550px) {
        .register-container {
            padding: 35px 25px;
        }

        .brand h2 {
            font-size: 24px;
        }

        input, select {
            padding: 12px 16px 12px 40px;
        }

        .footer-links {
            gap: 12px;
        }

        .footer-links a {
            font-size: 12px;
        }
    }
</style>

</head>
<body>

<div class="register-container">

    <div class="brand">
        <div class="brand-icon">
            <i class="fas fa-user-plus"></i>
        </div>
        <h2>Create Account</h2>
        <p>Join our hospital management system</p>
    </div>

    <form action="register" method="post">

        <div class="form-group">
            <label><i class="fas fa-user"></i> Full Name</label>
            <div class="input-wrapper">
                <i class="fas fa-user"></i>
                <input type="text" name="name" placeholder="Enter your full name" required>
            </div>
        </div>

        <div class="form-group">
            <label><i class="fas fa-envelope"></i> Email Address</label>
            <div class="input-wrapper">
                <i class="fas fa-envelope"></i>
                <input type="email" name="email" placeholder="your@email.com" required>
            </div>
        </div>

        <div class="form-group">
            <label><i class="fas fa-lock"></i> Password</label>
            <div class="input-wrapper">
                <i class="fas fa-lock"></i>
                <input type="password" name="password" placeholder="Create a strong password" required>
            </div>
            <div class="password-hint">
                <i class="fas fa-info-circle"></i> Password should be at least 6 characters
            </div>
        </div>

        <div class="form-group">
            <label><i class="fas fa-user-tag"></i> Register As</label>
            <select name="role">
                <option value="patient">🩺 Patient</option>
                <option value="doctor">👨‍⚕️ Doctor</option>
            </select>
            <div class="role-hint">
                <i class="fas fa-question-circle"></i>
                Patients can book appointments, Doctors can manage schedules
            </div>
        </div>

        <button type="submit" class="btn-register">
            <i class="fas fa-arrow-right"></i> Register
        </button>
    </form>

    <div class="footer-links">
        <a href="login.jsp"><i class="fas fa-arrow-left"></i> Back to Login</a>
    </div>

</div>

</body>
</html>
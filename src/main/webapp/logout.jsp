<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
session.invalidate();
response.sendRedirect("login.jsp");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logging Out | Hospital Management</title>

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
            position: relative;
            overflow: hidden;
        }

        /* Animated background circles */
        body::before {
            content: '';
            position: absolute;
            width: 400px;
            height: 400px;
            background: rgba(255,255,255,0.08);
            border-radius: 50%;
            top: -200px;
            right: -200px;
            animation: float 20s ease-in-out infinite;
        }

        body::after {
            content: '';
            position: absolute;
            width: 300px;
            height: 300px;
            background: rgba(255,255,255,0.08);
            border-radius: 50%;
            bottom: -150px;
            left: -150px;
            animation: float 15s ease-in-out infinite reverse;
        }

        @keyframes float {
            0%, 100% { transform: translate(0, 0); }
            50% { transform: translate(30px, 20px); }
        }

        .logout-card {
            background: white;
            border-radius: 32px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.3);
            padding: 55px 45px;
            width: 100%;
            max-width: 450px;
            text-align: center;
            position: relative;
            z-index: 1;
            animation: fadeInUp 0.6s ease;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Icon Animation */
        .logout-icon {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #667eea15 0%, #764ba215 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
            animation: pulse 1.5s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
                box-shadow: 0 0 0 0 rgba(102, 126, 234, 0.4);
            }
            50% {
                transform: scale(1.05);
                box-shadow: 0 0 0 15px rgba(102, 126, 234, 0);
            }
        }

        .logout-icon i {
            font-size: 50px;
            color: #667eea;
            animation: spin 0.8s ease;
        }

        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        h2 {
            color: #1e293b;
            font-size: 28px;
            font-weight: 800;
            margin-bottom: 12px;
            letter-spacing: -0.5px;
        }

        .message {
            color: #64748b;
            font-size: 15px;
            margin-bottom: 25px;
            line-height: 1.5;
        }

        /* Progress Bar */
        .progress-container {
            margin: 30px 0 20px;
        }

        .progress-bar {
            width: 100%;
            height: 4px;
            background: #e2e8f0;
            border-radius: 4px;
            overflow: hidden;
        }

        .progress-fill {
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, #667eea, #764ba2);
            border-radius: 4px;
            animation: loading 1.5s ease-in-out;
        }

        @keyframes loading {
            from { width: 0%; }
            to { width: 100%; }
        }

        /* Loading Dots */
        .loading-dots {
            display: flex;
            justify-content: center;
            gap: 8px;
            margin-top: 20px;
        }

        .loading-dots span {
            width: 8px;
            height: 8px;
            background: #cbd5e1;
            border-radius: 50%;
            animation: bounce 1.4s ease-in-out infinite;
        }

        .loading-dots span:nth-child(1) { animation-delay: 0s; }
        .loading-dots span:nth-child(2) { animation-delay: 0.2s; }
        .loading-dots span:nth-child(3) { animation-delay: 0.4s; }

        @keyframes bounce {
            0%, 60%, 100% { transform: translateY(0); }
            30% { transform: translateY(-8px); background: #667eea; }
        }

        /* Security Note */
        .security-note {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 2px solid #e2e8f0;
            font-size: 11px;
            color: #94a3b8;
        }

        .security-note i {
            margin-right: 6px;
            color: #10b981;
        }

        /* Redirect Hint */
        .redirect-hint {
            font-size: 12px;
            color: #94a3b8;
            margin-top: 15px;
        }

        /* Responsive */
        @media (max-width: 500px) {
            .logout-card {
                padding: 40px 25px;
            }

            h2 {
                font-size: 24px;
            }

            .logout-icon {
                width: 80px;
                height: 80px;
            }

            .logout-icon i {
                font-size: 40px;
            }
        }
    </style>

    <script>
        // Redirect is already handled by Java response.sendRedirect()
        // This is just for visual feedback
        setTimeout(function() {
            // If somehow redirect takes too long, show message
            console.log("Redirecting to login page...");
        }, 500);
    </script>
</head>
<body>

<div class="logout-card">

    <div class="logout-icon">
        <i class="fas fa-sign-out-alt"></i>
    </div>

    <h2>Goodbye!</h2>

    <div class="message">
        <i class="fas fa-spinner fa-pulse"></i>
        You have been successfully logged out.
    </div>

    <div class="progress-container">
        <div class="progress-bar">
            <div class="progress-fill"></div>
        </div>
    </div>

    <div class="loading-dots">
        <span></span>
        <span></span>
        <span></span>
    </div>

    <div class="redirect-hint">
        <i class="fas fa-arrow-right"></i> Redirecting to login page...
    </div>

    <div class="security-note">
        <i class="fas fa-shield-alt"></i>
        For security reasons, please close your browser window if you're on a shared computer.
    </div>

</div>

</body>
</html>
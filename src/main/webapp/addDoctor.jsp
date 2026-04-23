<%@ page session="true" %>

<%
String role = (String) session.getAttribute("role");

if(role == null || !role.equals("admin")){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Add Doctor | Hospital Management</title>

<!-- Google Fonts for better typography -->
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
        margin: 0;
    }

    .container {
        background: white;
        border-radius: 24px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        padding: 40px;
        width: 100%;
        max-width: 500px;
        transition: transform 0.3s ease;
        border: none;
        display: block;
    }

    .container:hover {
        transform: translateY(-5px);
    }

    h2 {
        color: #1e293b;
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 30px;
        text-align: center;
        position: relative;
        padding-bottom: 15px;
    }

    h2:after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 60px;
        height: 4px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 2px;
    }

    input {
        width: 100%;
        padding: 14px 16px;
        margin: 12px 0;
        border: 2px solid #e2e8f0;
        border-radius: 12px;
        font-size: 15px;
        font-family: 'Inter', sans-serif;
        transition: all 0.3s ease;
        background: #f8fafc;
        box-sizing: border-box;
    }

    input:focus {
        outline: none;
        border-color: #667eea;
        background: white;
        box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
    }

    input::placeholder {
        color: #94a3b8;
        font-weight: 400;
    }

    button {
        width: 100%;
        padding: 14px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        border-radius: 12px;
        font-size: 16px;
        font-weight: 600;
        font-family: 'Inter', sans-serif;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-top: 20px;
        box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
    }

    button:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
        background: linear-gradient(135deg, #5a67d8 0%, #6b46a0 100%);
    }

    button:active {
        transform: translateY(0);
    }

    .success {
        color: #059669;
        background: #d1fae5;
        padding: 12px;
        border-radius: 10px;
        margin: 15px 0;
        text-align: center;
        font-weight: 500;
        font-size: 14px;
        border-left: 4px solid #059669;
    }

    .error {
        color: #dc2626;
        background: #fee2e2;
        padding: 12px;
        border-radius: 10px;
        margin: 15px 0;
        text-align: center;
        font-weight: 500;
        font-size: 14px;
        border-left: 4px solid #dc2626;
    }

    a {
        display: inline-block;
        margin-top: 25px;
        color: #667eea;
        text-decoration: none;
        font-weight: 500;
        transition: all 0.3s ease;
        font-size: 14px;
    }

    a:hover {
        color: #764ba2;
        transform: translateX(-5px);
    }

    a i {
        margin-right: 6px;
    }

    /* Input with icons effect */
    .input-wrapper {
        position: relative;
    }

    /* Responsive */
    @media (max-width: 600px) {
        .container {
            padding: 30px 20px;
        }

        h2 {
            font-size: 24px;
        }

        input {
            padding: 12px 14px;
        }
    }
</style>

<script>
function validateForm() {
    let name = document.forms["form"]["name"].value;
    let spec = document.forms["form"]["specialization"].value;
    let phone = document.forms["form"]["phone"].value;

    if (name === "" || spec === "" || phone === "") {
        alert("All fields are required!");
        return false;
    }

    if (phone.length != 10) {
        alert("Phone must be 10 digits");
        return false;
    }

    return true;
}
</script>

</head>

<body>

<div class="container">

<h2><i class="fas fa-user-md" style="margin-right: 10px;"></i> Add New Doctor</h2>

<form name="form" action="addDoctor" method="post" onsubmit="return validateForm()">

    <input type="text" name="name" placeholder="👨‍⚕️ Doctor Name" required>

    <input type="text" name="specialization" placeholder="💊 Specialization" required>

    <input type="text" name="phone" placeholder="📞 Phone Number" required>

    <button type="submit"><i class="fas fa-plus-circle"></i> Add Doctor</button>

</form>

<br>

<% if(request.getParameter("msg") != null){ %>
<p class="success"><i class="fas fa-check-circle"></i> Doctor Added Successfully!</p>
<% } %>

<% if(request.getParameter("error") != null){ %>
<p class="error"><i class="fas fa-exclamation-triangle"></i> Something went wrong!</p>
<% } %>

<br>
<a href="adminDashboard.jsp"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>

</div>

</body>
</html>
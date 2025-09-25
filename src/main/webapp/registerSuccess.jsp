<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Successful</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #f9f9f9, #e0eafc);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .success-card {
            background: #fff;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
            text-align: center;
            max-width: 400px;
        }
        .success-card h2 {
            color: #28a745;
            margin-bottom: 15px;
        }
        .success-card p {
            font-size: 16px;
            color: #333;
            margin-bottom: 20px;
        }
        .success-card a {
            display: inline-block;
            padding: 10px 20px;
            background: #007bff;
            color: #fff;
            border-radius: 8px;
            text-decoration: none;
            transition: 0.2s;
        }
        .success-card a:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
<div class="success-card">
    <h2>✅ Registration Successful!</h2>
    <p>Welcome <b><%= request.getAttribute("userName") %></b>, your account has been created.</p>
    <p>You can now log in to continue.</p>
    <a href="login.jsp">Login Now</a>
</div>
</body>
</html>

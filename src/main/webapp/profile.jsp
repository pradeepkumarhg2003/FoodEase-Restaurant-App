<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.food.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .profile-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-width: 500px;
            width: 100%;
            animation: slideUp 0.6s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .profile-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 30px;
            text-align: center;
            position: relative;
        }

        .profile-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="white" opacity="0.1"/><circle cx="75" cy="75" r="1" fill="white" opacity="0.1"/><circle cx="50" cy="10" r="0.5" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            opacity: 0.3;
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 40px;
            font-weight: bold;
            border: 4px solid rgba(255, 255, 255, 0.3);
            position: relative;
            z-index: 1;
        }

        .profile-title {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 10px;
            position: relative;
            z-index: 1;
        }

        .profile-subtitle {
            font-size: 16px;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        .profile-content {
            padding: 40px 30px;
        }

        .profile-field {
            display: flex;
            align-items: center;
            padding: 20px 0;
            border-bottom: 1px solid #f0f0f0;
            transition: all 0.3s ease;
        }

        .profile-field:last-child {
            border-bottom: none;
        }

        .profile-field:hover {
            background: #f8f9ff;
            margin: 0 -30px;
            padding-left: 30px;
            padding-right: 30px;
            border-radius: 10px;
        }

        .field-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 20px;
            color: white;
            font-size: 20px;
        }

        .field-content {
            flex: 1;
        }

        .field-label {
            font-size: 14px;
            color: #666;
            font-weight: 500;
            margin-bottom: 5px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .field-value {
            font-size: 18px;
            color: #333;
            font-weight: 600;
        }

        .profile-actions {
            padding: 30px;
            background: #f8f9ff;
            text-align: center;
        }

        .btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            margin: 0 10px;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-secondary {
            background: #6c757d;
        }

        .btn-secondary:hover {
            box-shadow: 0 10px 20px rgba(108, 117, 125, 0.3);
        }

        @media (max-width: 600px) {
            .profile-container {
                margin: 10px;
                border-radius: 15px;
            }
            
            .profile-header {
                padding: 30px 20px;
            }
            
            .profile-content {
                padding: 30px 20px;
            }
            
            .profile-actions {
                padding: 20px;
            }
            
            .btn {
                display: block;
                margin: 10px auto;
                width: 200px;
            }
        }
    </style>
</head>
<body>
<%
    User loggedUser = (User) session.getAttribute("user");
    if (loggedUser != null) {
%>
    <div class="profile-container">
        <div class="profile-header">
            <div class="profile-avatar">
                <%=loggedUser.getName().charAt(0) %>
            </div>
            <h1 class="profile-title">Your Profile</h1>
            <p class="profile-subtitle">Welcome back, <%= loggedUser.getName() %></p>
        </div>
        
        <div class="profile-content">
            <div class="profile-field">
                <div class="field-icon">👤</div>
                <div class="field-content">
                    <div class="field-label">Full Name</div>
                    <div class="field-value"><%= loggedUser.getName() %></div>
                </div>
            </div>
            
            <div class="profile-field">
                <div class="field-icon">📧</div>
                <div class="field-content">
                    <div class="field-label">Email Address</div>
                    <div class="field-value"><%= loggedUser.getEmail() %></div>
                </div>
            </div>
            
            <div class="profile-field">
                <div class="field-icon">📱</div>
                <div class="field-content">
                    <div class="field-label">Phone Number</div>
                    <div class="field-value"><%= loggedUser.getPhonenumber() %></div>
                </div>
            </div>
            
            <div class="profile-field">
                <div class="field-icon">🔑</div>
                <div class="field-content">
                    <div class="field-label">User Role</div>
                    <div class="field-value"><%= loggedUser.getRole() %></div>
                </div>
            </div>
        </div>
        
        <div class="profile-actions">
            <a href="home" class="btn">Go to Menu</a>
            <a href="cart.jsp" class="btn btn-secondary">View Cart</a>
        </div>
    </div>
<%
    } else {
        response.sendRedirect("login.jsp");
    }
%>
</body>
</html>

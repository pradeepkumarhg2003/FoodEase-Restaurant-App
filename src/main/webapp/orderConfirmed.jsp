<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed</title>
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
            overflow-x: hidden;
        }

        .confirmation-container {
            background: white;
            border-radius: 25px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
            overflow: hidden;
            max-width: 600px;
            width: 100%;
            animation: slideUp 0.8s ease-out;
            position: relative;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px) scale(0.9);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .success-header {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            color: white;
            padding: 50px 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .success-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .success-icon {
            width: 120px;
            height: 120px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
            font-size: 60px;
            border: 5px solid rgba(255, 255, 255, 0.3);
            position: relative;
            z-index: 1;
            animation: bounce 2s ease-in-out infinite;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-10px); }
            60% { transform: translateY(-5px); }
        }

        .success-title {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 15px;
            position: relative;
            z-index: 1;
        }

        .success-subtitle {
            font-size: 18px;
            opacity: 0.95;
            position: relative;
            z-index: 1;
        }

        .confirmation-content {
            padding: 40px;
        }

        .order-details {
            background: #f8f9ff;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            border-left: 5px solid #4CAF50;
        }

        .order-number {
            font-size: 24px;
            font-weight: 700;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #e9ecef;
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            font-size: 16px;
            color: #666;
            font-weight: 500;
        }

        .detail-value {
            font-size: 16px;
            color: #333;
            font-weight: 600;
        }

        .estimated-delivery {
            background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%);
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }

        .delivery-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .delivery-time {
            font-size: 18px;
            font-weight: 500;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            padding: 15px 30px;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            min-width: 150px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(76, 175, 80, 0.3);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-secondary:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(102, 126, 234, 0.3);
        }

        .btn-outline {
            background: transparent;
            color: #4CAF50;
            border: 2px solid #4CAF50;
        }

        .btn-outline:hover {
            background: #4CAF50;
            color: white;
            transform: translateY(-3px);
        }

        .celebration-particles {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            overflow: hidden;
        }

        .particle {
            position: absolute;
            width: 8px;
            height: 8px;
            background: #FFD700;
            border-radius: 50%;
            animation: fall 3s linear infinite;
        }

        @keyframes fall {
            0% {
                transform: translateY(-100px) rotate(0deg);
                opacity: 1;
            }
            100% {
                transform: translateY(100vh) rotate(360deg);
                opacity: 0;
            }
        }

        .thank-you-message {
            text-align: center;
            padding: 20px 0;
            color: #666;
            font-style: italic;
        }

        @media (max-width: 768px) {
            .confirmation-container {
                margin: 10px;
                border-radius: 20px;
            }
            
            .success-header {
                padding: 40px 30px;
            }
            
            .confirmation-content {
                padding: 30px 25px;
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .btn {
                width: 100%;
                max-width: 250px;
            }
            
            .success-title {
                font-size: 28px;
            }
            
            .success-icon {
                width: 100px;
                height: 100px;
                font-size: 50px;
            }
        }

        /* Generate random particles */
        .particle:nth-child(1) { left: 10%; animation-delay: 0s; }
        .particle:nth-child(2) { left: 20%; animation-delay: 0.5s; }
        .particle:nth-child(3) { left: 30%; animation-delay: 1s; }
        .particle:nth-child(4) { left: 40%; animation-delay: 1.5s; }
        .particle:nth-child(5) { left: 50%; animation-delay: 2s; }
        .particle:nth-child(6) { left: 60%; animation-delay: 2.5s; }
        .particle:nth-child(7) { left: 70%; animation-delay: 3s; }
        .particle:nth-child(8) { left: 80%; animation-delay: 3.5s; }
        .particle:nth-child(9) { left: 90%; animation-delay: 4s; }
    </style>
</head>
<body>
    <div class="celebration-particles">
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
    </div>

    <div class="confirmation-container">
        <div class="success-header">
            <div class="success-icon">✅</div>
            <h1 class="success-title">Order Confirmed!</h1>
            <p class="success-subtitle">Your payment was successful and order has been placed</p>
        </div>
        
        <div class="confirmation-content">
            <div class="order-details">
                <div class="order-number">Order #12345</div>
                
                <div class="detail-row">
                    <span class="detail-label">Order Status:</span>
                    <span class="detail-value" style="color: #4CAF50; font-weight: 700;">✓ Confirmed</span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Payment Status:</span>
                    <span class="detail-value" style="color: #4CAF50; font-weight: 700;">✓ Paid</span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Order Date:</span>
                    <span class="detail-value">Dec 15, 2024</span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Order Time:</span>
                    <span class="detail-value">2:30 PM</span>
                </div>
            </div>
            
            <div class="estimated-delivery">
                <div class="delivery-title">🚚 Estimated Delivery</div>
                <div class="delivery-time">30-45 minutes</div>
            </div>
            
            <div class="action-buttons">
                <a href="home" class="btn btn-primary">Order More Food</a>
                <a href="profile.jsp" class="btn btn-secondary">View Profile</a>
                <a href="index.html" class="btn btn-outline">Back to Home</a>
            </div>
            
            <div class="thank-you-message">
                Thank you for choosing our restaurant! We're preparing your delicious meal with care. 🍕
            </div>
        </div>
    </div>
</body>
</html>

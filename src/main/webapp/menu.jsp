<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.List,com.food.model.Menu,com.food.model.Restaurant" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu - FoodApp</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
            position: relative;
            overflow-x: hidden;
        }

        /* Header */
        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 20px 0;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            color: black;
            text-decoration: none;
         }

        .logo i {
            font-size: 2rem;
        }

        .logo h1 {
            font-size: 1.8rem;
            font-weight: 700;
        }

        .search-bar {
            flex: 1;
            max-width: 500px;
            margin: 0 20px;
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 12px 45px 12px 15px;
            border: 2px solid #e1e5e9;
            border-radius: 25px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.8);
        }

        .search-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .search-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            font-size: 1.1rem;
        }

        .user-menu {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-menu a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .user-menu a:hover {
            color: #764ba2;
        }

        /* Main Content */
        .main-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .page-title {
            text-align: center;
            color: white;
            margin-bottom: 40px;
        }

        .page-title h2 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .page-title p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        /* Restaurant Info */
        .restaurant-info {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .restaurant-image {
            width: 120px;
            height: 120px;
            border-radius: 15px;
            overflow: hidden;
            flex-shrink: 0;
        }

        .restaurant-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .restaurant-details h3 {
            font-size: 1.8rem;
            color: #333;
            margin-bottom: 10px;
        }

        .restaurant-details p {
            color: #666;
            margin-bottom: 15px;
        }

        .restaurant-stats {
            display: flex;
            gap: 20px;
        }

        .stat {
            display: flex;
            align-items: center;
            gap: 5px;
            color: #667eea;
            font-weight: 600;
        }

        /* Filters */
        .filters {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            align-items: center;
        }

        .filter-btn {
            padding: 8px 16px;
            border: 2px solid #e1e5e9;
            border-radius: 20px;
            background: white;
            color: #666;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.9rem;
        }

        .filter-btn:hover,
        .filter-btn.active {
            border-color: #667eea;
            background: #667eea;
            color: white;
        }

        /* Menu Grid */
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        /* Menu Item Card */
        .menu-item {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .menu-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .item-image {
            position: relative;
            height: 200px;
            overflow: hidden;
        }

        .item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .menu-item:hover .item-image img {
            transform: scale(1.05);
        }

        .availability-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .available {
            background: rgba(76, 175, 80, 0.9);
            color: white;
        }

        .unavailable {
            background: rgba(244, 67, 54, 0.9);
            color: white;
        }

        .rating-badge {
            position: absolute;
            top: 15px;
            left: 15px;
            background: rgba(255, 255, 255, 0.95);
            color: #333;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.9rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .rating-badge i {
            color: #ffd700;
        }

        .item-content {
            padding: 20px;
        }

        .item-name {
            font-size: 1.3rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 8px;
        }

        .item-description {
            color: #666;
            font-size: 0.9rem;
            line-height: 1.5;
            margin-bottom: 15px;
        }

        .item-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .item-price {
            font-size: 1.4rem;
            font-weight: 700;
            color: #667eea;
        }

        .item-actions {
            display: flex;
            gap: 10px;
        }

        .action-btn {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 10px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-secondary {
            background: rgba(102, 126, 234, 0.1);
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn-secondary:hover {
            background: #667eea;
            color: white;
        }

        .btn-disabled {
            background: #e0e0e0;
            color: #999;
            cursor: not-allowed;
        }

        /* Load More Button */
        .load-more {
            text-align: center;
            margin-top: 40px;
        }

        .load-more-btn {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 25px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .load-more-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 15px;
            }

            .search-bar {
                margin: 0;
                max-width: 100%;
            }

            .menu-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .page-title h2 {
                font-size: 2rem;
            }

            .filters {
                justify-content: center;
            }

            .restaurant-info {
                flex-direction: column;
                text-align: center;
            }

            .restaurant-stats {
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            .main-content {
                padding: 20px 15px;
            }

            .menu-item {
                margin: 0 10px;
            }

            .item-actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-content">
          <a href="index.html" class="logo">
             <i class="fas fa-utensils"></i>
               <h1>FoodEase</h1>
          </a>

        </div>
    </header>

    <!-- Main Content -->
    <main class="main-content">
        <div class="page-title">
            <h2>Restaurant Menu</h2>
            <p>Explore our delicious menu items</p>
        </div>
		
			<%
			 Restaurant r = (Restaurant) request.getAttribute("restaurant");
    			if (r != null ) {
			%>

    <!-- Restaurant Info -->
    <div class="restaurant-info">
        <div class="restaurant-image">
            <img src="<%= r.getImagePath() %>" alt="Restaurant">
        </div>
        <div class="restaurant-details">
            <h3><%= r.getName() %></h3>
            <p>Authentic <%= r.getCuisineType() %> cuisine with the finest ingredients and traditional recipes</p>
            <p class="restaurant-address">
📍 <%= r.getAddress() %>
        </p>
            <div class="restaurant-stats">
                <div class="stat">
                    <i class="fas fa-star"></i>
                    <span><%= r.getRating() %></span>
                </div>
                <div class="stat">
                    <i class="fas fa-clock"></i>
                    <span><%= r.getDeliveryTime() %> mins</span>
                </div>
            </div>
        </div>
    </div>

<%    
    } 
    else {
%>
    <p style="color:white; text-align:center;">No restaurants found.</p>
<%
    }
%>

<!-- Menu Grid -->
<div class="menu-grid">
<%
    List<Menu> menuList = (List<Menu>) request.getAttribute("menus");
     session.setAttribute("menus", menuList);

    if (menuList != null && !menuList.isEmpty()) {
        for (Menu m : menuList) {
%>
    <div class="menu-item">
        <div class="item-image">
            <img src="<%= m.getImagePath() %>" alt="<%= m.getItemName() %>">
            <div class="availability-badge <%= m.isAvailable() ? "available" : "unavailable" %>">
                <%= m.isAvailable() ? "Available" : "Unavailable" %>
            </div>
            <div class="rating-badge">
                <i class="fas fa-star"></i>
                <%= m.getRatings() %>
            </div>
        </div>
        <div class="item-content">
            <h3 class="item-name"><%= m.getItemName() %></h3>
            <p class="item-description"><%= m.getDescription() %></p>
            <div class="item-details">
                <div class="item-price">Price: Rs.<%= m.getPrice() %></div>
            </div>

            <form action="cart" method="post">
                <input type="hidden" name="restId" value="<%= m.getRestaurantId() %>">
                <input type="hidden" name="itemId" value="<%= m.getMenuId() %>">
                <input type="hidden" name="quantity" value="1">
                <input type="hidden" name="action" value="add">
                <div class="item-actions">
                    <button class="action-btn btn-primary" <%= m.isAvailable() ? "" : "disabled" %>>
                        <i class="fas fa-shopping-cart"></i>
                        Add to Cart
                    </button>
                </div>
            </form>
        </div>
    </div>

<%
        }
    } else {
%>
    <p style="color:white; text-align:center;">No menu items available.</p>
<%
    }
%>
</div>

    </main>
</body>
</html>

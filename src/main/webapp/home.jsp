<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.food.model.Restaurant,com.food.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Restaurants - FoodApp</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <link href="css/home.css" rel="stylesheet">
  
</head>
<body>
  <!-- Header -->
  <header class="header">
    <div class="header-content">
      <a href="index.html" class="logo">
        <i class="fas fa-utensils"></i>
        <h1>FoodEase</h1>
      </a>
      
      <div class="search-bar">
        <input type="text" class="search-input" placeholder="Search restaurants, cuisines...">
        <i class="fas fa-search search-icon"></i>
      </div>
      
      
      <%
       User loggedUser = (User) session.getAttribute("user");
      
         if (loggedUser == null) { 
          // Not logged in
       %>
      <div class="user-menu">
        <a href="login.jsp"><i class="fas fa-user"></i> Login</a>
        <a href="register.jsp"><i class="fas fa-user-plus"></i> Register</a>
      </div>
  <%
      } else { 
          // Logged in
  %>
    <div class="user-info">
        Welcome, <b><%= loggedUser.getName() %></b> |
        <a href="profile.jsp">Profile</a> |
        <a href="index.html">Logout</a>
    </div>
<%
    }
%>
    </div>
  </header>

  <!-- Main Content -->
  <main class="main-content">
    <div class="page-title">
      <h2>Discover Amazing Restaurants</h2>
      <p>Find the best food from your favorite restaurants</p>
    </div>


    <!-- Restaurant Grid -->
    <div class="restaurant-grid">
      <!-- Restaurant Card 1 --> 
      <%
        List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
     	if (restaurants != null && !restaurants.isEmpty()) {
    	  for(Restaurant r : restaurants){      
      %>
      
      <div class="restaurant-card">
      <a href="menu?restaurantId=<%=r.getRestaurantId()%>" style="text-decoration: none">
        <div class="card-image">
          <img src="<%=r.getImagePath()%>" alt="<%= r.getName() %>">
          <div class="rating-badge">
            <i class="fas fa-star"></i>
            <%= r.getRating() %>
          </div>
        </div>
        <div class="card-content">
          <h3 class="restaurant-name"> <%= r.getName() %></h3>
          <div class="cuisine-type">
            <i class="fas fa-utensils"></i>
            <%= r.getCuisineType() %>
          </div>
          <div class="card-details">
            <div class="delivery-info">
              <i class="fas fa-clock"></i>
              <%= r.getDeliveryTime() %> Mins
            </div>
            <div class="price-range"></div>
          </div>
          <div class="card-actions">
            <button class="action-btn btn-primary">
              <i class="fas fa-shopping-cart"></i>
              Order Now
            </button>
           
          </div>
        </div>
        </a>
      </div>
      
    <%
    	}
     } else {
    %>
       <p>No restaurants available.</p>
    <%
        }
    %>
    </div>
  </main>
</body>
</html>
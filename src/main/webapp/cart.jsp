<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.food.model.Menu,com.food.model.Cart,com.food.model.CartItem,java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Your Cart</title>
  <link rel="stylesheet" href="style.css" />
  <style>
    :root {
      --bg: #0f172a;
      --panel: #111827;
      --muted: #94a3b8;
      --text: #f8fafc;
      --primary: #22c55e;
      --primary-600: #16a34a;
      --border: #1f2937;
      --danger: #ef4444;
      --shadow: 0 10px 25px rgba(0,0,0,.35);
      --radius: 16px;
    }

    body {
      margin: 0;
      background: radial-gradient(1400px 900px at 10% 0%, #0b1223 0%, var(--bg) 55%),
                  radial-gradient(1400px 900px at 100% 10%, #0b1a2f 0%, var(--bg) 60%);
      color: var(--text);
      font-family: "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
      display: flex;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
      padding: 20px;
    }

    .page { width: 100%; max-width: 1100px; }
    .header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 22px; }
    .title { font-size: 32px; font-weight: 800; letter-spacing: 0.4px; }

    .cart-shell { display: grid; grid-template-columns: 1.5fr .7fr; gap: 20px; }
    .panel {
      background: linear-gradient(180deg, rgba(255,255,255,.05), rgba(255,255,255,.02));
      border: 1px solid var(--border);
      border-radius: var(--radius);
      box-shadow: var(--shadow);
      overflow: hidden;
    }

    .items { padding: 20px; }
    .summary { padding: 22px; position: sticky; top: 16px; }

    .item {
      display: grid;
      grid-template-columns: 80px 1fr auto;
      gap: 16px;
      padding: 16px;
      border-radius: 14px;
      background: rgba(255,255,255,.02);
      margin-bottom: 12px;
      transition: transform .2s ease;
    }
    .item:hover { transform: translateY(-2px); background: rgba(255,255,255,.05); }

    .thumb img { width: 80px; height: 80px; border-radius: 12px; border: 1px solid var(--border); }

    .meta { display: flex; flex-direction: column; justify-content: center; }
    .name { font-weight: 600; font-size: 16px; margin-bottom: 6px; }
    .controls { display: flex; gap: 10px; align-items: center; margin-top: 8px; }
    .qty-display {
      font-weight: 700;
      font-size: 15px;
      padding: 6px 14px;
      background: #0b1223;
      border: 1px solid var(--border);
      border-radius: 10px;
    }
    .price { font-weight: 700; font-size: 18px; margin-top: auto; }

    .btn {
      padding: 8px 14px;
      border-radius: 12px;
      border: 1px solid var(--border);
      color: var(--text);
      background: #0b1223;
      cursor: pointer;
      text-decoration: none;
      transition: all .2s ease;
      font-size: 14px;
    }
    .btn:hover { background: #1e293b; }
    .btn.primary { background: linear-gradient(180deg, var(--primary), var(--primary-600)); border-color: transparent; color: #051b0e; font-weight: 800; }
    .btn.danger { border-color: rgba(239,68,68,.35); color: #fecaca; }
    .btn.small { padding: 4px 10px; font-size: 13px; }

    .line { display: flex; align-items: center; justify-content: space-between; padding: 10px 0; }
    .line.muted { color: var(--muted); font-size: 15px; }
    .line.total { padding-top: 12px; margin-top: 12px; border-top: 1px dashed var(--border); font-weight: 800; font-size: 20px; }

    .footer-actions { display: flex; gap: 12px; justify-content: flex-end; padding-top: 14px; }
    .empty { padding: 28px; text-align: center; font-size: 18px; color: var(--muted); }

    @media (max-width: 900px) {
      .cart-shell { grid-template-columns: 1fr; }
      .summary { position: static; }
    }
  </style>
</head>
<body>
  <main class="page">
    <div class="header">
      <div class="title">🛒 Your Cart</div>
      <form action="home">
        <button type="submit" class="btn">Visit Restaurants</button>
      </form>
    </div>

    <div class="cart-shell">
      <section class="panel items">
        <%
          Cart cart = (Cart) session.getAttribute("cart");
          Integer restaurantId = (Integer) session.getAttribute("restaurantId");

          if (cart != null && !cart.getItems().isEmpty()) {
              for (CartItem item : cart.getItems().values()) {
        %>
        <div class="item">
          <div class="thumb">
            <img src="<%= item.getImagePath() %>" alt="Food Image">
          </div>
          <div class="meta">
            <div class="name"><%= item.getName() %></div>
            <div class="controls">
              <!-- Decrease quantity -->
              <form action="cart" method="post" style="display:inline;">
                <input type="hidden" name="restId" value="<%= restaurantId %>">
                <input type="hidden" name="itemId" value="<%= item.getItemId()%>">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="quantity" value="<%= item.getQuantity() - 1 %>">
                <button class="btn small" <% if(item.getQuantity() == 1) { %> disabled <% } %>>-</button>
              </form>

              <span class="qty-display"><%= item.getQuantity() %></span>

              <!-- Increase quantity -->
              <form action="cart" method="post" style="display:inline;">
                <input type="hidden" name="restId" value="<%= restaurantId %>">
                <input type="hidden" name="itemId" value="<%= item.getItemId()%>">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="quantity" value="<%= item.getQuantity() + 1 %>">
                <button class="btn small">+</button>
              </form>

              <!-- Remove item -->
              <form action="cart" method="post" style="display:inline;">
                <input type="hidden" name="restId" value="<%= restaurantId %>">
                <input type="hidden" name="itemId" value="<%= item.getItemId()%>">
                <input type="hidden" name="action" value="delete">
                <button class="btn danger small">Remove</button>
              </form>
            </div>
          </div>
          <div class="price">₹ <%= item.getPrice() %></div>
        </div>
        <%
              } // end cart items loop
          } else {
        %>
        <div class="empty">Your cart is empty 🛍️</div>
        <%
          }
        %>
      </section>

      <!-- Summary Section -->
      <aside class="panel summary">
        <div class="line muted"><span>Subtotal</span><span>₹<%= (cart != null ? cart.getTotalPrice() : 0) %></span></div>
        <div class="line muted"><span>Delivery</span><span>₹50</span></div>
        <div class="line muted"><span>Tax</span><span>₹10</span></div>
        <div class="line total">
          <span>Total</span>
          <span>₹<%= (cart != null ? cart.getTotalPrice()+ 50 + 10 : 0) %> </span>
        </div>
        <div class="footer-actions">
          <a class="btn" href="menu?restaurantId=<%= session.getAttribute("restaurantId") %>">➕ Add more items</a>
          <% if (cart != null) { %>
          <form action="checkout.jsp" method="post">
            <button type="submit" class="btn">Proceed to Checkout</button>
          </form>
          <% } %>
        </div>
      </aside>
    </div>
  </main>
</body>
</html>

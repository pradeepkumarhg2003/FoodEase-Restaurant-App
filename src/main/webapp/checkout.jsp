<%@ page contentType="text/html; charset=UTF-8" language="java" %> 
<%@ page import="com.food.model.Cart,com.food.model.CartItem,java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Checkout</title>
  <link rel="stylesheet" href="style.css" />
  <style>
    :root {
      --bg: #0f172a;
      --panel: #111827;
      --muted: #94a3b8;
      --text: #e5e7eb;
      --primary: #22c55e;
      --primary-600: #16a34a;
      --border: #1f2937;
      --shadow: 0 10px 25px rgba(0,0,0,.35);
      --radius: 14px;
    }

    html, body { height: 100%; }
    body {
      margin: 0;
      background: radial-gradient(1200px 700px at 10% 0%, #0b1223 0%, var(--bg) 55%),
                  radial-gradient(1200px 700px at 100% 10%, #0b1a2f 0%, var(--bg) 60%);
      color: var(--text);
      font-family: ui-sans-serif, -apple-system, Segoe UI, Roboto, Helvetica, Arial, Noto Sans, "Apple Color Emoji", "Segoe UI Emoji";
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .page { width: 100%; max-width: 1100px; padding: 24px; }

    .header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 18px; }
    .title { font-size: 28px; font-weight: 700; letter-spacing: 0.3px; }

    .grid { display: grid; grid-template-columns: 1.2fr .8fr; gap: 18px; }
    @media (max-width: 900px) { .grid { grid-template-columns: 1fr; } }

    .panel { background: linear-gradient(180deg, rgba(255,255,255,.04), rgba(255,255,255,.02)); border: 1px solid var(--border); border-radius: var(--radius); box-shadow: var(--shadow); overflow: hidden; }
    .panel-body { padding: 16px 8px; }
    .section-title { font-weight: 700; margin-bottom: 10px; }
    .section-sub { color: var(--muted); font-size: 14px; margin-bottom: 12px; }

    .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
    .form-grid.full { grid-template-columns: 1fr; }
    .field { display: flex; flex-direction: column; gap: 6px; }
    label { font-size: 13px; color: var(--muted); }
    input, select, textarea {
      padding: 10px 12px;
      border-radius: 10px;
      border: 1px solid var(--border);
      background: #0b1223;
      color: var(--text);
      outline: none;
    }
    textarea { min-height: 88px; resize: vertical; }

    .btn { display: inline-flex; align-items: center; justify-content: center; gap: 8px; padding: 10px 14px; border-radius: 12px; border: 1px solid var(--border); color: var(--text); background: #0b1223; cursor: pointer; text-decoration: none; transition: transform .05s ease, background .2s ease, border-color .2s ease; }
    .btn:hover { background: #0f172a; }
    .btn:active { transform: translateY(1px); }
    .btn.primary { background: linear-gradient(180deg, var(--primary), var(--primary-600)); border-color: rgba(0,0,0,.15); color: #051b0e; font-weight: 800; }
    .btn.ghost { background: #0b1223; }

    .actions { display: flex; gap: 10px; justify-content: flex-end; padding-top: 12px; }

    .summary-line { display: flex; align-items: center; justify-content: space-between; padding: 8px 0; }
    .summary-line.muted { color: var(--muted); font-size: 15px; display: flex }
    .summary-line.total { padding-top: 10px; margin-top: 10px; border-top: 1px dashed var(--border); font-weight: 800; font-size: 18px; }

    /* FIX: Limit item list height and add scroll */
    .items {
      display: grid;
      gap: 10px;
      padding-top: 6px;
      max-height: 220px;   /* limit height */
      overflow-y: auto;    /* add scroll if too many */
    }
    .items::-webkit-scrollbar {
      width: 6px;
    }
    .items::-webkit-scrollbar-thumb {
      background: #22c55e;
      border-radius: 4px;
    }

    .item { display: flex; align-items: center; justify-content: space-between; gap: 8px; padding: 8px 0; border-bottom: 1px dashed rgba(255,255,255,.06); }
    .item:last-child { border-bottom: none; }
    .item-name { font-weight: 600; }
    .item-meta { color: var(--muted); font-size: 13px; }
  </style>
</head>
<body>
  <main class="page">
    <div class="header">
      <div class="title">Checkout</div>
      <form action="home">
        <button type="submit" class="btn">Visit Restaurants</button>
      </form>
    </div>

    <div class="grid">
      <!-- Left: Delivery address -->
      <section class="panel">
        <div class="panel-body">
          <div class="section-title">Delivery address</div>
          <div class="form-grid full">
            <div class="field">
              <label for="address1">Address line 1</label>
              <input id="address1" type="text" placeholder="123 Main St" required />
            </div>
            <div class="field">
              <label for="address2">Address line 2</label>
              <input id="address2" type="text" placeholder="Apt, suite, etc. (optional)" />
            </div>
          </div>
          <div class="form-grid">
            <div class="field">
              <label for="city">City</label>
              <input id="city" type="text" placeholder="Benguluru" />
            </div>
          </div>

          <div class="actions">
            <a class="btn ghost" href="cart.jsp">Back to cart</a>
            <button class="btn primary" type="button">Place order</button>
          </div>
        </div>
      </section>

      <!-- Right: Order summary -->
      <aside class="panel">
        <div class="panel-body">
          <div class="section-title">Order summary</div>
          <div class="items">
            <%
              Cart cart = (Cart) session.getAttribute("cart");
              Integer restuarantId = (Integer) session.getAttribute("restaurantId");

              if(cart != null && !cart.getItems().isEmpty()){
                for(CartItem item : cart.getItems().values()){
            %>
            <div class="item">
              <div>
                <div class="item-name"><%=item.getName() %> × <%=item.getQuantity() %></div>
              </div>
              <div>Rs.<%=item.getPrice() %></div>
            </div>
            <% 
                }
              }
            %>
          </div>

          <div style="height:12px;"></div>
          <div class="summary-line muted"><span>Delivery</span><span>Rs. 50</span></div>
          <div class="summary-line muted"><span>Tax</span><span>Rs. 10</span></div>
          <div class="summary-line total"><span>Total</span><span><%=cart.getTotalPrice() + 50 + 10 %></span></div>
          
          <div class="actions">
            <a class="btn ghost" href="menu?restaurantId=<%= session.getAttribute("restaurantId")%>">➕ Add more items</a>
            <a class="btn primary" href="payment.jsp?total=<%=cart.getTotalPrice() + 50 + 10 %>">Confirm and pay</a>
          </div>
        </div>
      </aside>
    </div>
  </main>
</body>
</html>

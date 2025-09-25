<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Payment</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: radial-gradient(1000px 600px at 20% -10%, #1e293b 0%, transparent 60%),
                  radial-gradient(1000px 600px at 120% 10%, #0ea5e9 0%, transparent 55%),
                  #0f172a;
      color: #e5e7eb;
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100vh;
      margin: 0;
    }
    .payment-container {
      background: #0b1220;
      padding: 28px;
      border-radius: 16px;
      box-shadow: 0 10px 30px rgba(0,0,0,.45);
      width: 480px;
      border: 1px solid rgba(255,255,255,0.06);
    }
    h2 { margin: 0 0 16px; text-align: center; }
    .subtitle { text-align: center; color: #94a3b8; margin-bottom: 18px; font-size: 14px; }
    .amount {
      display: flex; align-items: center; justify-content: center; gap: 8px;
      font-size: 20px; font-weight: bold; margin-bottom: 18px;
    }
    .pill {
      background: #0a162a; border: 1px solid rgba(255,255,255,.08);
      padding: 6px 10px; border-radius: 999px; font-size: 12px; color: #a3a3a3;
    }
    .methods { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-top: 8px; }
    .tile { display: flex; gap: 10px; align-items: center; padding: 12px; border-radius: 12px; border: 1px solid rgba(255,255,255,.08); background: #0e1728; cursor: pointer; }
    .tile:hover { border-color: rgba(255,255,255,.18); }
    .tile .icon { font-size: 18px; }
    input[type="radio"] { display: none; }
    /* Active state */
    input[type="radio"]:checked + .tile { border-color: #22c55e; background: #0f1b30; }
    .btn {
      display: block; width: 100%; padding: 12px; margin-top: 16px;
      text-align: center; border-radius: 10px;
      background: linear-gradient(180deg, #22c55e, #16a34a);
      border: none; color: #051b0e; font-weight: bold; cursor: pointer;
    }
    .btn:hover { opacity: 0.92; }
    .divider { height: 1px; background: rgba(255,255,255,.06); margin: 16px 0; border-radius: 1px; }
    .foot { display: flex; gap: 8px; justify-content: center; flex-wrap: wrap; margin-top: 10px; }
  </style>
  </head>
<body>
  <div class="payment-container">
    <h2>Payment</h2>
    <div class="subtitle">Choose a method to complete your order</div>

    <div class="amount">
      <span>Total Payable:</span>
      <span>Rs.</span>
      <span>
        <%= request.getParameter("totalAmount") != null ? request.getParameter("totalAmount") : (request.getParameter("total") != null ? request.getParameter("total") : "0") %>
      </span>
    </div>

    <form action="orderConfirmed.jsp" method="post">
      <input type="hidden" name="totalAmount" value="<%= request.getParameter("totalAmount") != null ? request.getParameter("totalAmount") : (request.getParameter("total") != null ? request.getParameter("total") : "0") %>" />

      <div class="pill">Secure checkout • No extra fees • Fast confirmation</div>
      <div class="methods">
        <label>
          <input type="radio" name="paymentMethod" value="UPI" checked>
          <div class="tile"><div class="icon">🔗</div><div>UPI</div></div>
        </label>
        <label>
          <input type="radio" name="paymentMethod" value="Card">
          <div class="tile"><div class="icon">💳</div><div>Debit / Credit Card</div></div>
        </label>
        <label>
          <input type="radio" name="paymentMethod" value="NetBanking">
          <div class="tile"><div class="icon">🏦</div><div>Net Banking</div></div>
        </label>
        <label>
          <input type="radio" name="paymentMethod" value="COD">
          <div class="tile"><div class="icon">💵</div><div>Cash on Delivery</div></div>
        </label>
      </div>

      <div class="divider"></div>
      <button type="submit" class="btn">Pay Now</button>
      <div class="foot">
        <span class="pill">Visa</span>
        <span class="pill">Mastercard</span>
        <span class="pill">RuPay</span>
        <span class="pill">UPI</span>
        <span class="pill">All Banks</span>
      </div>
    </form>
  </div>
</body>
</html>









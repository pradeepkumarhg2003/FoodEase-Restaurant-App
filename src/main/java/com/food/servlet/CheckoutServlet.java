package com.food.servlet;

import java.io.IOException;

import com.food.dao.OrderDAO;
import com.food.daoimpl.OrderDAOImpl;
import com.food.daoimpl.OrderItemDAOImpl;
import com.food.model.Cart;
import com.food.model.CartItem;
import com.food.model.Order;
import com.food.model.OrderItem;
import com.food.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet{
	
	private OrderDAO orderDAO;
	private OrderItemDAOImpl orderItemDAOImpl;
	
	
	@Override
	public void init() {
		try {
			orderDAO = new OrderDAOImpl();
			
			orderItemDAOImpl = new OrderItemDAOImpl();
			
		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		Cart cart = (Cart)session.getAttribute("cart");
		User user = (User)session.getAttribute("loggedInUser");
		
		if(cart != null && user != null && !cart.getItems().isEmpty()) {
			String paymentMethod = req.getParameter("paymentMethod");
			String address = req.getParameter("address");
			
			Order order = new Order();
			order.setUserId(user.getUserId());
			order.setRestaurantId((int) session.getAttribute("restaurantId"));
//			order.setOrderDate(new Timestamp(new Date().getTime()));
			order.setStatus("Pending");
			
			double totalAmount = 0;
			for (CartItem item : cart.getItems().values()) {
				totalAmount += item.getPrice() * item.getQuantity();
			}
			
			order.setTotalAmount(totalAmount);
			
			int orderId = orderDAO.save(order);
			
			for (CartItem item : cart.getItems().values()) {

				int itemId = item.getItemId();
				String name = item.getName();
				double price = item.getPrice();
				int quantity = item.getQuantity();
				
				double totalPrice = price * quantity;
				
				OrderItem orderItem = new OrderItem(orderId, itemId, quantity, totalAmount);
				
				orderItemDAOImpl.save(orderItem);
			}
			
			session.removeAttribute("cart");
			session.setAttribute("order", order);
			resp.sendRedirect("order_confirmation.jsp");
		}
		else {
			resp.sendRedirect("cart.jsp");
		}
	}
}

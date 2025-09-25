package com.food.servlet;

import java.io.IOException;
import java.util.List;

import com.food.dao.MenuDAO;
import com.food.daoimpl.MenuDAOImpl;
import com.food.model.Cart;
import com.food.model.CartItem;
import com.food.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet{
	

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		Cart cart =(Cart) session.getAttribute("cart");
		Integer currentRestaurantid =(Integer)session.getAttribute("restaurantId");
		
		
		int newRestaurantId = Integer.parseInt(req.getParameter("restId"));
		
		if(cart == null || newRestaurantId != currentRestaurantid) {
			cart = new Cart();
			session.setAttribute("cart", cart);
			session.setAttribute("restaurantId", newRestaurantId);
		}
		
		
		String action = req.getParameter("action");
		
		if(action.equalsIgnoreCase("add")) {
			addItemToCart(req,cart);
		}
		else if(action.equalsIgnoreCase("update")) {
			updateItemToCart(req,cart);
		}
		else if(action.equalsIgnoreCase("delete")) {
			deleteItemToCart(req,cart);
		}
		resp.sendRedirect("cart.jsp");
			
	}

	private void addItemToCart(HttpServletRequest req, Cart cart) {

		int itemId = Integer.parseInt(req.getParameter("itemId"));
		int quantity = Integer.parseInt(req.getParameter("quantity"));

		MenuDAO impl = new MenuDAOImpl();
		Menu menuItem = impl.getMenu(itemId);
			
		System.out.println("The menu in cart Servlet"+menuItem);
			
		if(menuItem != null) {
			CartItem item = new CartItem(
					menuItem.getMenuId(), 
					menuItem.getRestaurantId(), 
					menuItem.getItemName(),
					menuItem.getPrice(), 
					quantity,
					menuItem.getImagePath()
			);
			
			cart.addCartItem(item);
		} 
	
	}
	
	private void updateItemToCart(HttpServletRequest req, Cart cart) {

		int itemId = Integer.parseInt(req.getParameter("itemId"));
		int quantity = Integer.parseInt(req.getParameter("quantity"));
		cart.updateCartItem(itemId, quantity);
	
	}
	
	private void deleteItemToCart(HttpServletRequest req, Cart cart) {
		int itemId = Integer.parseInt(req.getParameter("itemId"));
		cart.removeCartItem(itemId);
		
	}

	



}

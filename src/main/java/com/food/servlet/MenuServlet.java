package com.food.servlet;

import java.io.IOException;
import java.util.List;

import com.food.daoimpl.MenuDAOImpl;
import com.food.daoimpl.RestaurantDAOImpl;
import com.food.model.Menu;
import com.food.model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/menu")
public class MenuServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		System.out.println("Menu Servlet called");
		RestaurantDAOImpl rdao = new RestaurantDAOImpl();
		
		int rid = Integer.parseInt(req.getParameter("restaurantId"));
		
		Restaurant restaurant = rdao.findById(rid);
		req.setAttribute("restaurant", restaurant);
		
		try {
			MenuDAOImpl daoImpl = new MenuDAOImpl();
			List<Menu> menuList = daoImpl.getAllMenusByRestaurant(rid);
			
			session.setAttribute("menus", menuList);
			req.setAttribute("menus", menuList);
			
			RequestDispatcher rd = req.getRequestDispatcher("menu.jsp");
			rd.include(req, resp);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println(rid);
	}
}

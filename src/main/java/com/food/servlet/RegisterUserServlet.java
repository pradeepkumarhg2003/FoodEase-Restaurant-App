package com.food.servlet;

import java.io.IOException;

import com.food.dao.UserDAO;
import com.food.daoimpl.UserDAOImpl;
import com.food.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/registerServlet")
public class RegisterUserServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


//		int userId = Integer.parseInt(req.getParameter("userId"));
		String name = req.getParameter("name");
		String userName = req.getParameter("userName");
		String password = req.getParameter("password");
		String email = req.getParameter("email");
		String phoneNumber = req.getParameter("phoneNumber");
		String address = req.getParameter("address");
		String role = req.getParameter("role");
		
		User user = new User(name, userName, password, email, phoneNumber, address, role, null, null);
		
		UserDAO impl = new UserDAOImpl();
		
		impl.addUser(user);
		req.setAttribute("userName", name);
	    req.getRequestDispatcher("registerSuccess.jsp").forward(req, resp);
	}
	
//	@Override
//	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		
////		int userId = Integer.parseInt(req.getParameter("userId"));
//		String name = req.getParameter("name");
//		String userName = req.getParameter("userName");
//		String password = req.getParameter("password");
//		String email = req.getParameter("email");
//		String phoneNumber = req.getParameter("phoneNumber");
//		String address = req.getParameter("address");
//		String role = req.getParameter("role");
//		
//		User user = new User(name, userName, password, email, phoneNumber, address, role,null,null);
//		
//		UserDAO impl = new UserDAOImpl();
//		
//		impl.addUser(user);
//		
//		PrintWriter out = resp.getWriter();
//		out.println("HI "+ name + " registered successfully");
//	}

}


package com.food.servlet;

import java.io.IOException;

import com.food.daoimpl.UserDAOImpl;
import com.food.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
    int count = 3;   // max attempts
    private UserDAOImpl userDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDAOImpl();  // DAO for DB operations
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        resp.setContentType("text/html");

        HttpSession session = req.getSession();
        session.setAttribute("username", username);

        // ✅ Check credentials from DB
        User user = userDao.validateUser(username, password);

        if (user != null) {
            session = req.getSession();
            session.setAttribute("user", user); // store entire user object

            resp.sendRedirect("home");
        } else if (count > 0) {
        	count--;
            req.setAttribute("errorMessage", "Invalid Username or Password. " + count + " attempts left.");
            RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
            rd.forward(req, resp);
        } 
        else {
        	
        	  req.setAttribute("errorMessage", "⚠️ Too many failed attempts! Please register again.");
        	    RequestDispatcher rd = req.getRequestDispatcher("register.jsp");
        	    rd.forward(req, resp);
//            resp.sendRedirect("Servlet2");  // redirect to error page after max attempts
        }
    }
}

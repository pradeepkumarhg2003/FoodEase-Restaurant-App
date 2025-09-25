package com.food.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.food.dao.UserDAO;
import com.food.model.User;
import com.food.util.DBConnection;


public class UserDAOImpl implements UserDAO{

	public static final String INSERT_USER_QUERY = "INSERT into `users` (`name`,`username`,`password`,`email`,`phonenumber`,`address`,`role`) VALUES (?,?,?,?,?,?,?)";
	public static final String GET_USER_QUERY = "SELECT * FROM `users` WHERE `userid` = ?";	
	public static final String UPDATE_USER_QUERY = "UPDATE `users` SET `name` = ? `password` = ? `email` = ? `phonenumber` = ? `address` = ? `role` = ? " ;
	public static final String DELETE_USER_QUERY = "DELETE FROM `users` WHERE `userid` = ? ";
	public static final String GET_ALL_USERS_QUERY = "SELECT * FROM `users`";

	
	 Connection connection = null;

	 public UserDAOImpl() {
	     connection = DBConnection.getConnection(); // ✅ Initialize connection
	 }

	 
	public void addUser(User user) {


		try(Connection connection = DBConnection.getConnection();
				PreparedStatement prepareStatement = connection.prepareStatement(INSERT_USER_QUERY);) {

			prepareStatement.setString(1, user.getName());
			prepareStatement.setString(2, user.getUsername());
			prepareStatement.setString(3, user.getPassword());
			prepareStatement.setString(4, user.getEmail());
			prepareStatement.setString(5, user.getPhonenumber());
			prepareStatement.setString(6, user.getAddress());
			prepareStatement.setString(7, user.getRole());

			int rows = prepareStatement.executeUpdate();
			System.out.println("Rows inserted: " + rows); // ✅ Debug

		}
		catch(SQLException e) {
			e.printStackTrace();
		}

	}

	@Override
	public User getUser(int userId) {

		User user = null;

		try(Connection connection = DBConnection.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(GET_USER_QUERY);)
		{
			preparedStatement.setInt(1, userId);
			ResultSet res = preparedStatement.executeQuery();

			user = extractUser(res);

		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return user;
	}

	
	
	@Override
	public void updateUser(User user) {

		try {
			Connection connection = DBConnection.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USER_QUERY);

			preparedStatement.setString(1, user.getName());
			preparedStatement.setString(2, user.getPassword());
			preparedStatement.setString(3, user.getEmail());
			preparedStatement.setString(4, user.getPhonenumber());
			preparedStatement.setString(5, user.getAddress());
			preparedStatement.setString(6, user.getRole());

			preparedStatement.executeUpdate();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
	}

	
	
	@Override
	public void deleteUser(int userId) {

		try
		{
			Connection connection = DBConnection.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(DELETE_USER_QUERY);

			preparedStatement.setInt(1, userId);

			preparedStatement.executeUpdate();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
	}

	
	
	@Override
	public List<User> getAllUsers() {

		ArrayList<User> userList = new ArrayList<User>();

		try {
			Connection connection = DBConnection.getConnection();
			Statement statement = connection.createStatement();

			ResultSet res = statement.executeQuery(GET_ALL_USERS_QUERY);

			while(res.next()) {
				User user = extractUser(res);
				userList.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return userList;
	}

	
	
	User extractUser(ResultSet res) throws SQLException{

		int userId = res.getInt("userId");
		String name = res.getString("name");
		String username = res.getString("username");
		String password = res.getString("password");
		String email = res.getString("email");
		String phonenumber = res.getString("phonenumber");
		String address = res.getString("address");
		String role = res.getString("role");
		User user = new User(userId, name, username, password, email, phonenumber, address, role, null, null);
		return user;
	}
	
	
	public User validateUser(String username, String password) {
		User user = null;
	    try {
	        Connection connection = DBConnection.getConnection();
	        String sql = "SELECT * FROM users WHERE username=? AND password=?";
	        PreparedStatement ps = connection.prepareStatement(sql);
	        ps.setString(1, username);
	        ps.setString(2, password);
	        
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            user = new User();
	            user.setUserId(rs.getInt("userid"));
	            user.setName(rs.getString("name"));
	            user.setUsername(rs.getString("username"));
	            user.setEmail(rs.getString("email"));
	            user.setPhonenumber(rs.getString("phonenumber"));
	            user.setRole(rs.getString("role"));
	            // add more if needed
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return user ;
	}

}



package com.food.daoimpl;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.food.dao.MenuDAO;
import com.food.model.Menu;
import com.food.util.DBConnection;

public class MenuDAOImpl implements MenuDAO {

	
	public static final String INSERT_MENU_QUERY = "INSERT INTO menus(restaurantId, itemName, description, price, isAvailable, ratings, imagePath) VALUES (?,?,?,?,?,?,?)";
	public static final String UPDATE_MENU_QUERY = "UPDATE menus SET restaurantId=?, itemName=?, description=?, price=?, isAvailable=?, ratings=?, imagePath=? WHERE menuId=?";
	public static final String DELETE_MENU_QUERY = "DELETE FROM menus WHERE menuId=?";
	public static final String FIND_MENU_BY_ID = "SELECT * FROM menus WHERE menuId=?";
	public static final String FIND_ALL_MENUS = "SELECT * FROM menus";
	public static final String FIND_ALL_MENUS_BY_RESTAURANT = "SELECT * FROM menus WHERE restaurantId = ?";
    @Override
    public void save(Menu menu) {
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_MENU_QUERY)) {
            ps.setInt(1, menu.getRestaurantId());
            ps.setString(2, menu.getItemName());
            ps.setString(3, menu.getDescription());
            ps.setDouble(4, menu.getPrice());
            ps.setBoolean(5, menu.isAvailable());
            ps.setDouble(6, menu.getRatings());
            ps.setString(7, menu.getImagePath());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Menu menu) {
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_MENU_QUERY)) {
            ps.setInt(1, menu.getRestaurantId());
            ps.setString(2, menu.getItemName());
            ps.setString(3, menu.getDescription());
            ps.setDouble(4, menu.getPrice());
            ps.setBoolean(5, menu.isAvailable());
            ps.setDouble(6, menu.getRatings());
            ps.setString(7, menu.getImagePath());
            ps.setInt(8, menu.getMenuId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_MENU_QUERY)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Menu getMenu(int id) {
        
        Menu menu = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_MENU_BY_ID)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                menu = new Menu();
                menu.setMenuId(rs.getInt("menuId"));
                menu.setRestaurantId(rs.getInt("restaurantId"));
                menu.setItemName(rs.getString("itemName"));
                menu.setDescription(rs.getString("description"));
                menu.setPrice(rs.getDouble("price"));
                menu.setAvailable(rs.getBoolean("isAvailable"));
                menu.setRatings(rs.getDouble("ratings"));
                menu.setImagePath(rs.getString("imagePath"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menu;
    }

    @Override
    public List<Menu> findAll() {
        
        List<Menu> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(FIND_ALL_MENUS)) {
            while (rs.next()) {
                Menu menu = new Menu();
                menu.setMenuId(rs.getInt("menuId"));
                menu.setRestaurantId(rs.getInt("restaurantId"));
                menu.setItemName(rs.getString("itemName"));
                menu.setDescription(rs.getString("description"));
                menu.setPrice(rs.getDouble("price"));
                menu.setAvailable(rs.getBoolean("isAvailable"));
                menu.setRatings(rs.getDouble("ratings"));
                menu.setImagePath(rs.getString("imagePath"));
                list.add(menu);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<Menu> getAllMenusByRestaurant(int restaurantId) {
        List<Menu> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_ALL_MENUS_BY_RESTAURANT)) {

            ps.setInt(1, restaurantId); // ✅ Set parameter
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Menu menu = new Menu();
                menu.setMenuId(rs.getInt("menuId"));
                menu.setRestaurantId(rs.getInt("restaurantId"));
                menu.setItemName(rs.getString("itemName"));
                menu.setDescription(rs.getString("description"));
                menu.setPrice(rs.getDouble("price"));
                menu.setAvailable(rs.getBoolean("isAvailable"));
                menu.setRatings(rs.getDouble("ratings"));
                menu.setImagePath(rs.getString("imagePath"));
                list.add(menu);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}


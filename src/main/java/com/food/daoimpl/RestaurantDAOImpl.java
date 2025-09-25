package com.food.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.food.dao.RestaurantDAO;
import com.food.model.Restaurant;
import com.food.util.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO {

    @Override
    public void save(Restaurant restaurant) {
        String sql = "INSERT INTO restaurants(name, address, phoneNumber, cuisineType, deliveryTime, adminUserId, rating, isActive, imagePath) VALUES (?,?,?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, restaurant.getName());
            ps.setString(2, restaurant.getAddress());
            ps.setString(3, restaurant.getPhoneNumber());
            ps.setString(4, restaurant.getCuisineType());
            ps.setString(5, restaurant.getDeliveryTime());
            ps.setInt(6, restaurant.getAdminUserId());
            ps.setDouble(7, restaurant.getRating());
            ps.setBoolean(8, restaurant.isActive());
            ps.setString(9, restaurant.getImagePath());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Restaurant restaurant) {
        String sql = "UPDATE restaurants SET name=?, address=?, phoneNumber=?, cuisineType=?, deliveryTime=?, adminUserId=?, rating=?, isActive=?, imagePath=? WHERE restaurantId=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, restaurant.getName());
            ps.setString(2, restaurant.getAddress());
            ps.setString(3, restaurant.getPhoneNumber());
            ps.setString(4, restaurant.getCuisineType());
            ps.setString(5, restaurant.getDeliveryTime());
            ps.setInt(6, restaurant.getAdminUserId());
            ps.setDouble(7, restaurant.getRating());
            ps.setBoolean(8, restaurant.isActive());
            ps.setString(9, restaurant.getImagePath());
            ps.setInt(10, restaurant.getRestaurantId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM restaurants WHERE restaurantId=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Restaurant findById(int id) {
        String sql = "SELECT * FROM restaurants WHERE restaurantId=?";
        Restaurant restaurant = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                restaurant = new Restaurant();
                restaurant.setRestaurantId(rs.getInt("restaurantId"));
                restaurant.setName(rs.getString("name"));
                restaurant.setAddress(rs.getString("address"));
                restaurant.setPhoneNumber(rs.getString("phoneNumber"));
                restaurant.setCuisineType(rs.getString("cuisineType"));
                restaurant.setDeliveryTime(rs.getString("deliveryTime"));
                restaurant.setAdminUserId(rs.getInt("adminUserId"));
                restaurant.setRating(rs.getDouble("rating"));
                restaurant.setActive(rs.getBoolean("isActive"));
                restaurant.setImagePath(rs.getString("imagePath"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurant;
    }

    @Override
    public List<Restaurant> getAllRestaurants() {
        String sql = "SELECT * FROM restaurants";
        List<Restaurant> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Restaurant restaurant = new Restaurant();
                restaurant.setRestaurantId(rs.getInt("restaurantId"));
                restaurant.setName(rs.getString("name"));
                restaurant.setAddress(rs.getString("address"));
                restaurant.setPhoneNumber(rs.getString("phoneNumber"));
                restaurant.setCuisineType(rs.getString("cuisineType"));
                restaurant.setDeliveryTime(rs.getString("deliveryTime"));
                restaurant.setAdminUserId(rs.getInt("adminUserId"));
                restaurant.setRating(rs.getDouble("rating"));
                restaurant.setActive(rs.getBoolean("isActive"));
                restaurant.setImagePath(rs.getString("imagePath"));
                list.add(restaurant);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}

package com.food.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.food.dao.OrderDAO;
import com.food.model.Order;
import com.food.util.DBConnection;

public class OrderDAOImpl implements OrderDAO {

	int order_id=0;
    @Override
    public int save(Order order) {
        String sql = "INSERT INTO orders(restaurantId, userId, orderDate, totalAmount, status, paymentMode) VALUES (?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
//        		PreparedStatement ps = conn.prepareStatement(sql)
             PreparedStatement ps = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, order.getRestaurantId());
            ps.setInt(2, order.getUserId());
            ps.setTimestamp(3, new Timestamp(order.getOrderDate().getTime()));
            ps.setDouble(4, order.getTotalAmount());
            ps.setString(5, order.getStatus());
            ps.setString(6, order.getPaymentMode());
            ps.executeUpdate();
            
            ResultSet res = ps.getGeneratedKeys();
            
            while(res.next()) {
            	order_id = res.getInt(1);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order_id;
    }

    @Override
    public void update(Order order) {
        String sql = "UPDATE orders SET restaurantId=?, userId=?, orderDate=?, totalAmount=?, status=?, paymentMode=? WHERE orderId=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, order.getRestaurantId());
            ps.setInt(2, order.getUserId());
            ps.setTimestamp(3, new Timestamp(order.getOrderDate().getTime()));
            ps.setDouble(4, order.getTotalAmount());
            ps.setString(5, order.getStatus());
            ps.setString(6, order.getPaymentMode());
            ps.setInt(7, order.getOrderId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM orders WHERE orderId=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Order findById(int id) {
        String sql = "SELECT * FROM orders WHERE orderId=?";
        Order order = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                order = new Order();
                order.setOrderId(rs.getInt("orderId"));
                order.setRestaurantId(rs.getInt("restaurantId"));
                order.setUserId(rs.getInt("userId"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setTotalAmount(rs.getDouble("totalAmount"));
                order.setStatus(rs.getString("status"));
                order.setPaymentMode(rs.getString("paymentMode"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    @Override
    public List<Order> findAll() {
        String sql = "SELECT * FROM orders";
        List<Order> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("orderId"));
                order.setRestaurantId(rs.getInt("restaurantId"));
                order.setUserId(rs.getInt("userId"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setTotalAmount(rs.getDouble("totalAmount"));
                order.setStatus(rs.getString("status"));
                order.setPaymentMode(rs.getString("paymentMode"));
                list.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}

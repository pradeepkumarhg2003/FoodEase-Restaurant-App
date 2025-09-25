package com.food.dao;

import java.util.List;

import com.food.model.Order;

public interface OrderDAO {
    int save(Order order);
    void update(Order order);
    void delete(int id);
    Order findById(int id);
    List<Order> findAll();
}


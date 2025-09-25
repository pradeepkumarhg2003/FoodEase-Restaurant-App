package com.food.dao;


import java.util.List;

import com.food.model.OrderItem;

public interface OrderItemDAO {
    void save(OrderItem item);
    void update(OrderItem item);
    void delete(int id);
    OrderItem findById(int id);
    List<OrderItem> findAll();
}

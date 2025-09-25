package com.food.dao;

import java.util.List;

import com.food.model.Restaurant;

public interface RestaurantDAO {
    void save(Restaurant restaurant);
    void update(Restaurant restaurant);
    void delete(int id);
    Restaurant findById(int id);
    List<Restaurant> getAllRestaurants();
}

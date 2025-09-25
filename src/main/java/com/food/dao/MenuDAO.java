package com.food.dao;

import java.util.List;

import com.food.model.Menu;

public interface MenuDAO {
	Menu getMenu(int menuId);
	void update(Menu menu);
	void delete(int id);
	List<Menu> getAllMenusByRestaurant(int restuarantId);
	List<Menu> findAll();
    void save(Menu menu);
    
   
    
}

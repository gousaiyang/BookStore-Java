package bookstore.dao;

import java.util.List;

import bookstore.model.Order;

public interface OrderDao {
    
    @SuppressWarnings("rawtypes")
    public List getAllOrders();
    
    @SuppressWarnings("rawtypes")
    public List getUserOrders(int userId);
    
    public Order getOrderById(int id);
    
    public Object getCartSummary(int orderId);
    
    public Order getUserCart(int userId);

    public Integer save(Order order);
    
    public void update(Order order);

    public void softDelete(Order order);

}
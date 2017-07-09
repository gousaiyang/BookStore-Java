package bookstore.dao;

import java.util.List;

import bookstore.model.Order;
import bookstore.model.OrderItem;

public interface OrderItemDao {
    
    public List<OrderItem> getOrderItemsByOrder(Order order);
    
    @SuppressWarnings("rawtypes")
    public List getOrderItemsByOrder(Order order, boolean isAdmin);
    
    public OrderItem getOrderItemById(int id);
    
    public boolean orderHasBook(int orderId, int bookId);

    public Integer save(OrderItem orderItem);

    public void update(OrderItem orderItem);
    
    public void delete(OrderItem orderItem);

}
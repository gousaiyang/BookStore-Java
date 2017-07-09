package bookstore.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import bookstore.dao.OrderItemDao;
import bookstore.model.Order;
import bookstore.model.OrderItem;

public class OrderItemDaoImpl extends HibernateDaoSupport implements
        OrderItemDao {
    
    @SuppressWarnings("unchecked")
    public List<OrderItem> getOrderItemsByOrder(Order order) {
        return getHibernateTemplate().find("FROM OrderItem WHERE orderId = ?", order.getId());
    }
    
    @SuppressWarnings("rawtypes")
    public List getOrderItemsByOrder(Order order, boolean isAdmin) {
        if (order.getIsPaid()) {
            if (isAdmin)
                return getHibernateTemplate().find("SELECT oi.id, b.id, b.name, oi.price, oi.quantity, oi.quantity * oi.price, oi.createTime, oi.updateTime FROM OrderItem oi, Book b WHERE oi.orderId = ? AND oi.bookId = b.id", order.getId());
            else
                return getHibernateTemplate().find("SELECT b.name, oi.price, oi.quantity, oi.quantity * oi.price FROM OrderItem oi, Book b WHERE oi.orderId = ? AND oi.bookId = b.id", order.getId());
        }
        else {
            if (isAdmin)
                return getHibernateTemplate().find("SELECT oi.id, b.id, b.name, b.price, oi.quantity, oi.quantity * b.price, oi.createTime, oi.updateTime FROM OrderItem oi, Book b WHERE oi.orderId = ? AND oi.bookId = b.id", order.getId());
            else
                return getHibernateTemplate().find("SELECT oi.id, b.name, b.price, oi.quantity, b.price * oi.quantity FROM OrderItem oi, Book b WHERE oi.orderId = ? AND oi.bookId = b.id", order.getId());
        }
    }
    
    public OrderItem getOrderItemById(int id) {
        return getHibernateTemplate().get(OrderItem.class, id);
    }
    
    public boolean orderHasBook(int orderId, int bookId) {
        @SuppressWarnings("unchecked")
        List<Integer> result = getHibernateTemplate().find("SELECT id FROM OrderItem WHERE orderId = ? AND bookId = ?", orderId, bookId);
        
        return !(result == null || result.isEmpty());
    }
    
    public Integer save(OrderItem orderItem) {
        orderItem.markCreate();
        return (Integer) getHibernateTemplate().save(orderItem);
    }
    
    public void update(OrderItem orderItem) {
        orderItem.markUpdate();
        getHibernateTemplate().merge(orderItem);
    }
    
    public void delete(OrderItem orderItem) {
        getHibernateTemplate().delete(orderItem);
    }

}

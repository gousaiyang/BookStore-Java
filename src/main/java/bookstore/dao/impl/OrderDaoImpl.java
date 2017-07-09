package bookstore.dao.impl;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import bookstore.dao.OrderDao;
import bookstore.model.Order;

public class OrderDaoImpl extends HibernateDaoSupport implements OrderDao {
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List getAllOrders() {
        List unpaidOrder = getHibernateTemplate().find("SELECT oi.orderId, u.username, COUNT(*), SUM(oi.quantity), SUM(oi.quantity * b.price), o.isPaid, o.createTime, o.updateTime FROM Order o, OrderItem oi, User u, Book b WHERE o.isPaid = false AND o.id = oi.orderId AND o.userId = u.id AND oi.bookId = b.id GROUP BY oi.orderId");
        List paidOrder = getHibernateTemplate().find("SELECT oi.orderId, u.username, COUNT(*), SUM(oi.quantity), o.totalPrice, o.isPaid, o.createTime, o.updateTime FROM Order o, OrderItem oi, User u WHERE o.isPaid = true AND o.id = oi.orderId AND o.userId = u.id GROUP BY oi.orderId");
        return (List) Stream.concat(unpaidOrder.stream(), paidOrder.stream()).collect(Collectors.toList());
    }
    
    @SuppressWarnings("rawtypes")
    public List getUserOrders(int userId) {
        return getHibernateTemplate().find("SELECT oi.orderId, COUNT(*), SUM(oi.quantity), o.totalPrice, o.createTime, o.updateTime FROM Order o, OrderItem oi WHERE o.userId = ? AND o.isPaid = true AND o.deleteTime IS NULL AND o.id = oi.orderId GROUP BY oi.orderId", userId);
    }
    
    public Order getOrderById(int id) {
        return getHibernateTemplate().get(Order.class, id);
    }
    
    @SuppressWarnings("rawtypes")
    public Object getCartSummary(int orderId) {
        List result = getHibernateTemplate().find("SELECT COUNT(*), SUM(oi.quantity), SUM(oi.quantity * b.price) FROM OrderItem oi, Book b WHERE oi.orderId = ? AND oi.bookId = b.id", orderId);
        if (result == null || result.isEmpty())
            return null;
        return result.get(0);
    }
    
    public Order getUserCart(int userId) {
        @SuppressWarnings("unchecked")
        List<Order> result = getHibernateTemplate().find("FROM Order WHERE userId = ? AND isPaid = false", userId);
        if (result == null || result.isEmpty())
            return null;
        return result.get(0);
    }
    
    public Integer save(Order order) {
        order.markCreate();
        return (Integer) getHibernateTemplate().save(order);
    }
    
    public void update(Order order) {
        order.markUpdate();
        getHibernateTemplate().merge(order);
    }

    public void softDelete(Order order) {
        // User won't see, Admin can see.
        order.markDelete();
        getHibernateTemplate().merge(order);
    }

}

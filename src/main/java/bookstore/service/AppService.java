package bookstore.service;

import java.util.List;

import bookstore.model.Book;
import bookstore.model.Order;
import bookstore.model.OrderItem;
import bookstore.model.User;
import bookstore.util.BookDetail;
import bookstore.util.UserDetail;

public interface AppService {
	
	// Book
	
	@SuppressWarnings("rawtypes")
	public List getAllBooks(boolean isAdmin);
	
	public Book getBookById(int id);
	
	public BookDetail getBookDetailById(int id, boolean isAdmin);
	
	public Integer addBook(Book book);

	public void updateBook(Book book);
	
	public void deleteBook(Book book);
	
	
	// Category
	
	@SuppressWarnings("rawtypes")
	public List getAllCategories(boolean isAdmin);
	
	
	// Order
	
	@SuppressWarnings("rawtypes")
	public List getAllOrders();
	
	@SuppressWarnings("rawtypes")
	public List getUserOrders(int userId);

	public Order getOrderById(int id);
	
	public Order getUserCart(int userId);
	
	public Order createUserCart(int userId);

	public void updateOrder(Order order);
	
	public Object payOrder(Order order);
	
	public void deleteOrder(Order order);

	
	// OrderItem
	
	public List<OrderItem> getOrderItemsByOrder(Order order);
	
	@SuppressWarnings("rawtypes")
	public List getOrderItemsByOrder(Order order, boolean isAdmin);
	
	@SuppressWarnings("rawtypes")
	public List getUserCartItems(int userId);
	
	public int getUserCartCount(int userId);
	
	public Object getUserCartSummary(int userId);
	
	public OrderItem getOrderItemById(int id);
	
	public Integer addOrderItem(OrderItem orderItem);

	public void updateOrderItem(OrderItem orderItem);
	
	public void deleteOrderItem(OrderItem orderItem);


	// User

	@SuppressWarnings("rawtypes")
	public List getAllUsers();
	
	public User getUserById(int id);
	
	public User getUserByUsername(String username);
	
	public UserDetail getUserDetailById(int id);
	
	public boolean usernameExists(String username);
	
	public Integer addUser(User user);
	
	public void updateUser(User user);

	public void deleteUser(User user);

}

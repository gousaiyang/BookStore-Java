package bookstore.service.impl;

import java.util.List;

import bookstore.dao.BookDao;
import bookstore.dao.CategoryDao;
import bookstore.dao.OrderDao;
import bookstore.dao.OrderItemDao;
import bookstore.dao.UserDao;
import bookstore.model.Book;
import bookstore.model.Order;
import bookstore.model.OrderItem;
import bookstore.model.User;
import bookstore.service.AppService;
import bookstore.util.BookDetail;
import bookstore.util.FailureMessage;
import bookstore.util.SuccessMessage;
import bookstore.util.UserDetail;


public class AppServiceImpl implements AppService {

	private BookDao bookDao;
	private CategoryDao categoryDao;
	private OrderDao orderDao;
	private OrderItemDao orderItemDao;
	private UserDao userDao;

	public void setBookDao(BookDao bookDao) {
		this.bookDao = bookDao;
	}

	public void setCategoryDao(CategoryDao categoryDao) {
		this.categoryDao = categoryDao;
	}

	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}

	public void setOrderItemDao(OrderItemDao orderItemDao) {
		this.orderItemDao = orderItemDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	
	// Book

	@SuppressWarnings("rawtypes")
	public List getAllBooks(boolean isAdmin) {
		return bookDao.getAllBooks(isAdmin);
	}
	
	public Book getBookById(int id) {
		return bookDao.getBookById(id);
	}
	
	public BookDetail getBookDetailById(int id, boolean isAdmin) {
		Book book = bookDao.getBookById(id);
		if (book == null)
			return null;
		return new BookDetail(book, bookDao.getBookCategories(id), isAdmin);
	}

	public Integer addBook(Book book) {
		return bookDao.save(book);
	}

	public void updateBook(Book book) {
		bookDao.update(book);
	}
	
	public void deleteBook(Book book) {
		bookDao.softDelete(book);
	}
	
	
	// Category
	
	@SuppressWarnings("rawtypes")
	public List getAllCategories(boolean isAdmin) {
		return categoryDao.getAllCategories(isAdmin);
	}
	
	
	// Order
	
	@SuppressWarnings("rawtypes")
	public List getAllOrders() {
		return orderDao.getAllOrders();
	}
	
	@SuppressWarnings("rawtypes")
	public List getUserOrders(int userId) {
		return orderDao.getUserOrders(userId);
	}
	
	public Order getOrderById(int id) {
		return orderDao.getOrderById(id);
	}

	public Order getUserCart(int userId) {
		Order order = orderDao.getUserCart(userId);
		return order == null ? createUserCart(userId) : order;
	}
	
	public Order createUserCart(int userId) {
		Order order = new Order(userId);
		orderDao.save(order);
		return order;
	}

	public void updateOrder(Order order) {
		orderDao.update(order);
	}
	
	public Object payOrder(Order order) {
		
		int totalPrice = 0;
		
		List<OrderItem> items = getOrderItemsByOrder(order);
		if (items.isEmpty()) {
			return new FailureMessage("您的购物车为空，支付失败。");
		}
		
		for (OrderItem item: items) {
		
			Book book = getBookById(item.getBookId());
			
			int stock = book.getStock();
			int quantity = item.getQuantity();
			if (quantity > stock)
				return new FailureMessage("书籍 " + book.getName() + " 库存不足，支付失败。");
			
			int price = book.getPrice();
			totalPrice += quantity * price;
		}
		
		User user = getUserById(order.getUserId());
		int balance = user.getBalance();
		if (balance < totalPrice)
			return new FailureMessage("您的账户余额不足，支付失败。");
		
		for (OrderItem item: items) {
			Book book = getBookById(item.getBookId());
			book.setStock(book.getStock() - item.getQuantity());
			updateBook(book);

			item.setPrice(book.getPrice());
			updateOrderItem(item);
		}
		
		user.setBalance(balance - totalPrice);
		updateUser(user);
		
		order.setTotalPrice(totalPrice);
		order.setIsPaid(true);
		updateOrder(order);
		
		createUserCart(user.getId());
		
		return new SuccessMessage();
	}
	
	public void deleteOrder(Order order) {
		orderDao.softDelete(order);
	}

	
	// OrderItem
	
	public List<OrderItem> getOrderItemsByOrder(Order order) {
		return orderItemDao.getOrderItemsByOrder(order);
	}
	
	@SuppressWarnings("rawtypes")
	public List getOrderItemsByOrder(Order order, boolean isAdmin) {
		return orderItemDao.getOrderItemsByOrder(order, isAdmin);
	}
	
	@SuppressWarnings("rawtypes")
	public List getUserCartItems(int userId) {
		return orderItemDao.getOrderItemsByOrder(getUserCart(userId), false);
	}
	
	public int getUserCartCount(int userId) {
		return getUserCartItems(userId).size();
	}
	
	public Object getUserCartSummary(int userId) {
		return orderDao.getCartSummary(getUserCart(userId).getId());
	}
	
	public OrderItem getOrderItemById(int id) {
		return orderItemDao.getOrderItemById(id);
	}

	public Integer addOrderItem(OrderItem orderItem) {
		return orderItemDao.save(orderItem);
	}
	
	public void updateOrderItem(OrderItem orderItem) {
		orderItemDao.update(orderItem);
	}

	public void deleteOrderItem(OrderItem orderItem) {
		orderItemDao.delete(orderItem);
	}

	
	// User
	
	@SuppressWarnings("rawtypes")
	public List getAllUsers() {
		return userDao.getAllUsers();
	}

	public User getUserById(int id) {
		return userDao.getUserById(id);
	}
	
	public User getUserByUsername(String username) {
		return userDao.getUserByUsername(username);
	}
	
	public UserDetail getUserDetailById(int id) {
		User user = userDao.getUserById(id);
		if (user == null)
			return null;
		return new UserDetail(user, true);
	}
	
	public boolean usernameExists(String username) {
		return userDao.usernameExists(username);
	}
	
	public Integer addUser(User user) {
		int ret = userDao.save(user);
		createUserCart(user.getId());
		return ret;
	}

	public void updateUser(User user) {
		userDao.update(user);
	}
	
	public void deleteUser(User user) {
		userDao.softDelete(user);
	}

}

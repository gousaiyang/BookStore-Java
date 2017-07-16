package bookstore.service;

import java.io.File;
import java.util.List;

import bookstore.model.Book;
import bookstore.model.BookCategory;
import bookstore.model.Category;
import bookstore.model.Order;
import bookstore.model.OrderItem;
import bookstore.model.User;
import bookstore.model.result.BookDetail;
import bookstore.model.result.UserDetail;

public interface AppService {
    
    // Book
    
    @SuppressWarnings("rawtypes")
    public List getAllBooks(boolean isAdmin);
    
    @SuppressWarnings("rawtypes")
    public List searchBooks(int category, String keyword);
    
    public Book getBookById(int id);
    
    public BookDetail getBookDetailById(int id, boolean isAdmin);
    
    public Integer addBook(String name, String image, String author, String press, String price, String stock, String description);

    public void updateBook(Book book);
    
    public void updateBook(Book book, String name, String image, String author, String press, String price, String stock, String description);
    
    public void deleteBook(Book book);
    
    
    // Category
    
    @SuppressWarnings("rawtypes")
    public List getAllCategories(boolean isAdmin);
    
    public Category getCategoryById(int id);
    
    public Integer addCategory(String name);

    public void updateCategory(Category category, String name);
    
    public void deleteCategory(Category category);
    
    
    // BookCategory
    
    @SuppressWarnings("rawtypes")
    public List getCategoryBooks(int categoryId);
    
    public BookCategory getBCById(int id);
    
    public BookCategory findBC(int categoryId, int bookId);
    
    public Integer addBC(int categoryId, int bookId);
    
    public void deleteBC(BookCategory bc);
    
    
    // Order
    
    @SuppressWarnings("rawtypes")
    public List getAllOrders();
    
    @SuppressWarnings("rawtypes")
    public List getUserOrders(int userId);

    public Order getOrderById(int id);
    
    public Order getUserCart(int userId);
    
    public boolean userCartHasBook(int userId, int bookId);
    
    public Order createUserCart(int userId);

    public void updateOrder(Order order);
    
    public Object payOrder(Order order);
    
    public Object payCart(User user);
    
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
    
    public void addItemToCart(User user, int bookId, int quantity);

    public void updateOrderItem(OrderItem orderItem);
    
    public void updateOrderItem(OrderItem orderItem, int quantity);
    
    public void deleteOrderItem(OrderItem orderItem);


    // User

    @SuppressWarnings("rawtypes")
    public List getAllUsers();
    
    public User getUserById(int id);
    
    public User getUserByUsername(String username);
    
    public UserDetail getUserDetailById(int id, boolean isAdmin);
    
    public boolean usernameExists(String username);
    
    public Integer addUser(String username, String password, String nickname, String avatar, String balance, String role);
    
    public void updateUser(User user);
    
    public void updateUser(User user, String username, String password, String nickname, String avatar);
    
    public void updateUser(User user, String username, String password, String nickname, String avatar, String balance, String role);

    public void deleteUser(User user);
    
    public List<String> getUserAddress(int userId) throws Exception;
    
    public void updateUserAddress(int userId, List<String> addresses);
    
    
    // Stat
    
    public List<Integer> statCategory(int categoryId, String startDate, String endDate);
    
    public List<Integer> statBook(int bookId, String startDate, String endDate);
    
    public List<Integer> statUser(String username, String startDate, String endDate);
    
    
    // Upload Image
    
    public String uploadImage(String path, File file, String filename);

}

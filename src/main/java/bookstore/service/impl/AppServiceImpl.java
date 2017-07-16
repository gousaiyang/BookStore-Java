package bookstore.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;

import bookstore.dao.BookCategoryDao;
import bookstore.dao.BookDao;
import bookstore.dao.CategoryDao;
import bookstore.dao.OrderDao;
import bookstore.dao.OrderItemDao;
import bookstore.dao.StatDao;
import bookstore.dao.UserDao;
import bookstore.model.Book;
import bookstore.model.BookCategory;
import bookstore.model.Category;
import bookstore.model.Order;
import bookstore.model.OrderItem;
import bookstore.model.User;
import bookstore.model.result.BookDetail;
import bookstore.model.result.FailureMessage;
import bookstore.model.result.SuccessMessage;
import bookstore.model.result.UserDetail;
import bookstore.service.AppService;
import bookstore.util.HashUtil;
import bookstore.util.PasswordUtil;


public class AppServiceImpl implements AppService {

    private BookDao bookDao;
    private BookCategoryDao bookCategoryDao;
    private CategoryDao categoryDao;
    private OrderDao orderDao;
    private OrderItemDao orderItemDao;
    private UserDao userDao;
    private StatDao statDao;

    public void setBookDao(BookDao bookDao) {
        this.bookDao = bookDao;
    }

    public void setBookCategoryDao(BookCategoryDao bookCategoryDao) {
        this.bookCategoryDao = bookCategoryDao;
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
    
    public StatDao getStatDao() {
        return statDao;
    }

    public void setStatDao(StatDao statDao) {
        this.statDao = statDao;
    }
    
    
    // Book

    @SuppressWarnings("rawtypes")
    public List getAllBooks(boolean isAdmin) {
        return bookDao.getAllBooks(isAdmin);
    }
    
    @SuppressWarnings("rawtypes")
    public List searchBooks(int category, String keyword) {
        return bookDao.searchBooks(category, keyword);
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

    public Integer addBook(String name, String image, String author, String press, String price, String stock, String description) {
        Book book = new Book();
        book.setName(name);
        book.setImage(image);
        book.setAuthor(author);
        book.setPress(press);
        book.setPrice((int)(Float.parseFloat(price) * 100));
        book.setStock(Integer.parseInt(stock));
        book.setDescription(description);
        bookDao.save(book);
        return book.getId();
    }
    
    public void updateBook(Book book) {
        bookDao.update(book);
    }

    public void updateBook(Book book, String name, String image, String author, String press, String price, String stock, String description) {
        book.setName(name);
        book.setImage(image);
        book.setAuthor(author);
        book.setPress(press);
        book.setPrice((int)(Float.parseFloat(price) * 100));
        book.setStock(Integer.parseInt(stock));
        book.setDescription(description);
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
    
    public Category getCategoryById(int id) {
        return categoryDao.getCategoryById(id);
    }
    
    public Integer addCategory(String name) {
        Category category = new Category(name);
        categoryDao.save(category);
        return category.getId();
    }

    public void updateCategory(Category category, String name) {
        category.setName(name);
        categoryDao.update(category);
    }
    
    public void deleteCategory(Category category) {
        categoryDao.softDelete(category);
    }
    
    
    // BookCategory
    
    @SuppressWarnings("rawtypes")
    public List getCategoryBooks(int categoryId) {
        return bookCategoryDao.getCategoryBooks(categoryId);
    }
    
    public BookCategory getBCById(int id) {
        return bookCategoryDao.getBCById(id);
    }
    
    public BookCategory findBC(int categoryId, int bookId) {
        return bookCategoryDao.findBC(categoryId, bookId);
    }
    
    public Integer addBC(int categoryId, int bookId) {
        return bookCategoryDao.save(new BookCategory(categoryId, bookId));
    }
    
    public void deleteBC(BookCategory bc) {
        bookCategoryDao.delete(bc);
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
    
    public boolean userCartHasBook(int userId, int bookId) {
        Order order = getUserCart(userId);
        return orderItemDao.orderHasBook(order.getId(), bookId);
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
    
    public Object payCart(User user) {
        return payOrder(getUserCart(user.getId()));
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
    
    public void addItemToCart(User user, int bookId, int quantity) {
        Order cart = getUserCart(user.getId());
        orderItemDao.save(new OrderItem(cart.getId(), bookId, quantity));
    }
    
    public void updateOrderItem(OrderItem orderItem) {
        orderItemDao.update(orderItem);
    }
    
    public void updateOrderItem(OrderItem orderItem, int quantity) {
        orderItem.setQuantity(quantity);
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
    
    public UserDetail getUserDetailById(int id, boolean isAdmin) {
        User user = userDao.getUserById(id);
        if (user == null)
            return null;
        return new UserDetail(user, isAdmin);
    }
    
    public boolean usernameExists(String username) {
        return userDao.usernameExists(username);
    }
    
    public Integer addUser(String username, String password, String nickname, String avatar, String balance, String role) {
        User user = new User();
        user.setUsername(username);
        user.setPassword(PasswordUtil.passwordHash(password));
        user.setNickname(nickname);
        user.setAvatar(avatar);
        user.setBalance((int)(Float.parseFloat(balance) * 100));
        user.setRole(role.equals("1"));
        userDao.save(user);
        createUserCart(user.getId());
        return user.getId();
    }
    
    public void updateUser(User user) {
        userDao.update(user);
    }
    
    public void updateUser(User user, String username, String password, String nickname, String avatar) {
        user.setUsername(username);
        if (!password.isEmpty())
            user.setPassword(PasswordUtil.passwordHash(password));
        user.setNickname(nickname);
        user.setAvatar(avatar);
        userDao.update(user);
    }

    public void updateUser(User user, String username, String password, String nickname, String avatar, String balance, String role) {
        user.setUsername(username);
        if (!password.isEmpty())
            user.setPassword(PasswordUtil.passwordHash(password));
        user.setNickname(nickname);
        user.setAvatar(avatar);
        user.setBalance((int)(Float.parseFloat(balance) * 100));
        user.setRole(role.equals("1"));
        userDao.update(user);
    }
    
    public void deleteUser(User user) {
        userDao.softDelete(user);
    }
    
    public List<String> getUserAddress(int userId) throws Exception {
        return userDao.getUserAddress(userId);
    }
    
    public void updateUserAddress(int userId, List<String> addresses) {
        List<String> newAddresses = new ArrayList<String>();
        for (String address: addresses) {
            String addr = address.trim();
            if (!addr.isEmpty())
                newAddresses.add(addr);
        }
        userDao.updateUserAddress(userId, newAddresses);
    }

        
    // Stat
    
    public List<Integer> statCategory(int categoryId, String startDate, String endDate) {
        if (categoryId == 0)
            return statDao.statAll(startDate, endDate);
        else
            return statDao.statCategory(categoryId, startDate, endDate);
    }
    
    public List<Integer> statBook(int bookId, String startDate, String endDate) {
        return statDao.statBook(bookId, startDate, endDate);
    }
    
    public List<Integer> statUser(String username, String startDate, String endDate) {
        return statDao.statUser(username, startDate, endDate);
    }
    
    
    // Upload Image
    
    public String uploadImage(String path, File file, String filename) {
        try {
            String newName = HashUtil.sha1File(file) + "_"
                + Long.toString(System.currentTimeMillis()) + "_"
                + Integer.toString(ThreadLocalRandom.current().nextInt(1, 1001)) + "."
                + FilenameUtils.getExtension(filename);
            File newFile = new File(path, newName);
            FileUtils.copyFile(file, newFile);
            return newName;
        }
        catch (Exception e) {
            return "";
        }
    }
}

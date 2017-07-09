package bookstore.dao;

import java.util.List;

import bookstore.model.Book;

public interface BookDao {
    
    @SuppressWarnings("rawtypes")
    public List getAllBooks(boolean isAdmin);
    
    @SuppressWarnings("rawtypes")
    public List searchBooks(int category, String keyword);
    
    public Book getBookById(int id);
    
    public List<String> getBookCategories(int id);
    
    public Integer save(Book book);

    public void update(Book book);
    
    public void softDelete(Book book);

}
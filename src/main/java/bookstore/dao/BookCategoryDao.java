package bookstore.dao;

import java.util.List;

import bookstore.model.BookCategory;

public interface BookCategoryDao {
    
    @SuppressWarnings("rawtypes")
    public List getCategoryBooks(int categoryId);
    
    public BookCategory getBCById(int id);
    
    public BookCategory findBC(int categoryId, int bookId);
    
    public Integer save(BookCategory bc);
    
    public void delete(BookCategory bc);

}
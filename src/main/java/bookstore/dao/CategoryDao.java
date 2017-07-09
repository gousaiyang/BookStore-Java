package bookstore.dao;

import java.util.List;

import bookstore.model.Category;

public interface CategoryDao {
    
    @SuppressWarnings("rawtypes")
    public List getAllCategories(boolean isAdmin);
    
    public Category getCategoryById(int id);
    
    public Integer save(Category category);

    public void update(Category category);
    
    public void softDelete(Category category);

}
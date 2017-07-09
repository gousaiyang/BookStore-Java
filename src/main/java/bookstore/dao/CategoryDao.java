package bookstore.dao;

import java.util.List;

public interface CategoryDao {
	
	@SuppressWarnings("rawtypes")
	public List getAllCategories(boolean isAdmin);

}
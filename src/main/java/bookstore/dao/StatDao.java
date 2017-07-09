package bookstore.dao;

import java.util.List;

public interface StatDao {
    
    public List<Integer> statAll(String startDate, String endDate);
    
    public List<Integer> statCategory(int categoryId, String startDate, String endDate);
    
    public List<Integer> statBook(int bookId, String startDate, String endDate);
    
    public List<Integer> statUser(String username, String startDate, String endDate);

}
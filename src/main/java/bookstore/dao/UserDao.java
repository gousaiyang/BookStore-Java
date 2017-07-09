package bookstore.dao;

import java.util.List;

import bookstore.model.User;

public interface UserDao {
    
    @SuppressWarnings("rawtypes")
    public List getAllUsers();
    
    public User getUserById(int id);
    
    public User getUserByUsername(String username);
    
    public boolean usernameExists(String username);

    public Integer save(User user);

    public void update(User user);
    
    public void softDelete(User user);
    
    public List<String> getUserAddress(int userId) throws Exception;
    
    public void updateUserAddress(int userId, List<String> addresses);

}
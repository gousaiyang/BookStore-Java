package bookstore.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import bookstore.dao.UserDao;
import bookstore.model.Address;
import bookstore.model.User;

public class UserDaoImpl extends HibernateDaoSupport implements UserDao {
    
    @Autowired
    private MongoTemplate mongoTemplate;
    
    private String collectionName = "userAddresses";
    
    @SuppressWarnings("rawtypes")
    public List getAllUsers() {
        return getHibernateTemplate().find("SELECT id, username, nickname, balance, role, createTime, updateTime FROM User WHERE deleteTime IS NULL");
    }
    
    public User getUserById(int id) {
        User user = getHibernateTemplate().get(User.class, id);
        if (user != null && user.isDeleted())
            return null;
        return user;
    }
    
    public User getUserByUsername(String username) {
        @SuppressWarnings("unchecked")
        List<Integer> result = getHibernateTemplate().find("SELECT id FROM User WHERE username = ?", username);
        
        if (result == null || result.isEmpty())
            return null;
        
        return getUserById(result.get(0));
    }
    
    public boolean usernameExists(String username) {
        @SuppressWarnings("rawtypes")
        List result = getHibernateTemplate().find("FROM User WHERE username = ?", username);
        return !result.isEmpty();
    }

    public Integer save(User user) {
        user.markCreate();
        return (Integer) getHibernateTemplate().save(user);
    }
    
    public void update(User user) {
        user.markUpdate();
        getHibernateTemplate().merge(user);
    }

    public void softDelete(User user) {
        user.markDelete();
        getHibernateTemplate().merge(user);
    }
    
    public boolean userAddressExists(int userId) {
        List<Address> address = mongoTemplate.find(new Query(Criteria.where("userId").is(userId)), Address.class, collectionName);
        return address != null && !address.isEmpty();
    }
    
    public List<String> getUserAddress(int userId) throws Exception {
        List<Address> address = mongoTemplate.find(new Query(Criteria.where("userId").is(userId)), Address.class, collectionName);
        return (address == null || address.isEmpty()) ? new ArrayList<String>() : address.get(0).getAddress();
    }
    
    public void updateUserAddress(int userId, List<String> addresses) {
        if (userAddressExists(userId))
            mongoTemplate.updateFirst(new Query(Criteria.where("userId").is(userId)), new Update().set("address", addresses), collectionName);
        else
            mongoTemplate.insert(new Address(userId, addresses), collectionName);
            
    }
}

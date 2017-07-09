package bookstore.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import bookstore.dao.UserDao;
import bookstore.model.User;

public class UserDaoImpl extends HibernateDaoSupport implements UserDao {
	
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

}

package bookstore.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import bookstore.dao.CategoryDao;

public class CategoryDaoImpl extends HibernateDaoSupport implements CategoryDao {
	
	@SuppressWarnings("rawtypes")
	public List getAllCategories(boolean isAdmin) {
		if (isAdmin)
			return getHibernateTemplate().find("SELECT id, name, createTime, updateTime FROM Category WHERE deleteTime IS NULL");
		else
			return getHibernateTemplate().find("SELECT id, name FROM Category WHERE deleteTime IS NULL");
	}
	
}

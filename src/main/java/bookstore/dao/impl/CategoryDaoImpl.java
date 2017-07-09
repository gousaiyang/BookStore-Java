package bookstore.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import bookstore.dao.CategoryDao;
import bookstore.model.Category;

public class CategoryDaoImpl extends HibernateDaoSupport implements CategoryDao {
    
    @SuppressWarnings("rawtypes")
    public List getAllCategories(boolean isAdmin) {
        if (isAdmin)
            return getHibernateTemplate().find("SELECT id, name, createTime, updateTime FROM Category WHERE deleteTime IS NULL");
        else
            return getHibernateTemplate().find("SELECT id, name FROM Category WHERE deleteTime IS NULL");
    }
    
    public Category getCategoryById(int id) {
        return getHibernateTemplate().get(Category.class, id);
    }
    
    public Integer save(Category category) {
        category.markCreate();
        return (Integer) getHibernateTemplate().save(category);
    }

    public void update(Category category) {
        category.markUpdate();
        getHibernateTemplate().merge(category);
    }
    
    public void softDelete(Category category) {
        category.markDelete();
        getHibernateTemplate().merge(category);
    }
}

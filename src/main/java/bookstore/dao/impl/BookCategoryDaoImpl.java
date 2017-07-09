package bookstore.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import bookstore.dao.BookCategoryDao;
import bookstore.model.BookCategory;

public class BookCategoryDaoImpl extends HibernateDaoSupport implements BookCategoryDao {
    
    @SuppressWarnings("rawtypes")
    public List getCategoryBooks(int categoryId) {
        return getHibernateTemplate().find("SELECT bc.id, b.id, b.name FROM BookCategory bc, Book b WHERE bc.categoryId = ? AND bc.bookId = b.id", categoryId);
    }
    
    public BookCategory getBCById(int id) {
        return getHibernateTemplate().get(BookCategory.class, id);
    }
    
    public BookCategory findBC(int categoryId, int bookId) {
        @SuppressWarnings("unchecked")
        List<Integer> result = getHibernateTemplate().find("SELECT id FROM BookCategory WHERE categoryId = ? AND bookId = ?", categoryId, bookId); 
        
        if (result == null || result.isEmpty())
            return null;
        
        return getBCById(result.get(0));
    }
    
    public Integer save(BookCategory bc) {
        bc.markCreate();
        return (Integer) getHibernateTemplate().save(bc);
    }
    
    public void delete(BookCategory bc) {
        getHibernateTemplate().delete(bc);
    }
    
}

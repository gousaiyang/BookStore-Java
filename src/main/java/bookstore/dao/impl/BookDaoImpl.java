package bookstore.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import bookstore.dao.BookDao;
import bookstore.model.Book;
import bookstore.util.StringUtil;

public class BookDaoImpl extends HibernateDaoSupport implements BookDao {
    
    @SuppressWarnings("rawtypes")
    public List getAllBooks(boolean isAdmin) {
        if (isAdmin)
            return getHibernateTemplate().find("SELECT id, name, price, stock, createTime, updateTime FROM Book WHERE deleteTime IS NULL");
        else
            return getHibernateTemplate().find("SELECT id, name, image, price FROM Book WHERE deleteTime IS NULL");
    }
    
    @SuppressWarnings("rawtypes")
    public List searchBooks(int category, String keyword) {
        if (category == 0)
            return getHibernateTemplate().find("SELECT id, name, image, price FROM Book WHERE name LIKE ? ESCAPE '" + StringUtil.likeEscapeCharacter + "' AND deleteTime IS NULL", StringUtil.EscapeLike(StringUtil.decodeUTF8(keyword)));
        else
            return getHibernateTemplate().find("SELECT b.id, b.name, b.image, b.price FROM Book b, BookCategory bc WHERE bc.categoryId = ? AND b.name LIKE ? ESCAPE '" + StringUtil.likeEscapeCharacter + "' AND b.id = bc.bookId AND b.deleteTime IS NULL", category, StringUtil.EscapeLike(StringUtil.decodeUTF8(keyword)));
    }
    
    public Book getBookById(int id) {
        Book book = getHibernateTemplate().get(Book.class, id);
        if (book != null && book.isDeleted())
            return null;
        return book;
    }
    
    @SuppressWarnings("unchecked")
    public List<String> getBookCategories(int id) {
        return (List<String>)(getHibernateTemplate().find("SELECT c.name FROM BookCategory bc, Category c WHERE bc.bookId = ? AND bc.categoryId = c.id", id));
    }
    
    public Integer save(Book book) {
        book.markCreate();
        return (Integer) getHibernateTemplate().save(book);
    }

    public void update(Book book) {
        book.markUpdate();
        getHibernateTemplate().merge(book);
    }
    
    public void softDelete(Book book) {
        book.markDelete();
        getHibernateTemplate().merge(book);
    }
    
}

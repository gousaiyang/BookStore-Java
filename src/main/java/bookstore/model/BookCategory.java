package bookstore.model;

import java.util.Date;

public class BookCategory {

    private int id;
    private int categoryId;
    private int bookId;
    private Date createTime;

    public BookCategory() {}
    
    public BookCategory(int categoryId, int bookId) {
        this.categoryId = categoryId;
        this.bookId = bookId;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    
    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public void markCreate() {
        this.createTime = new Date();
    }

}

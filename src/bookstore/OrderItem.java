package bookstore;

import java.util.Date;

public class OrderItem {
    private Long id;
    private Long orderId;
    private Long bookId;
    private Long quantity;
    private Date createTime;
    private Date updateTime;

    public OrderItem() {}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }
    
    public Long getBookId() {
        return bookId;
    }

    public void setBookId(Long bookId) {
        this.bookId = bookId;
    }

    public Long getQuantity() {
        return quantity;
    }
    
    public void setQuantity(Long quantity) {
        this.quantity = quantity;
    }
    
    public Date getCreateTime() {
        return createTime;
    }
    
    public void setCreateTime(Date createTime) {
    	this.createTime = createTime;
    }
    
    public void markCreate() {
        this.createTime = new Date();
        this.updateTime = new Date();
    }
    
    public Date getUpdateTime() {
        return updateTime;
    }
    
    public void setUpdateTime(Date updateTime) {
    	this.updateTime = updateTime;
    }
    
    public void markUpdate() {
        this.updateTime = new Date();
    }
}

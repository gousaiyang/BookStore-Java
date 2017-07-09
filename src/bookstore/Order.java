package bookstore;

import java.util.Date;

public class Order {
    private Long id;
    private Long userId;
    private boolean isPaid;
    private Date createTime;
    private Date updateTime;

    public Order() {}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }
    
    public boolean getIsPaid() {
        return isPaid;
    }
    
    public void setIsPaid(boolean isPaid) {
        this.isPaid = isPaid;
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

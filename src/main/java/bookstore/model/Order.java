package bookstore.model;

import java.util.Date;

public class Order {
    
    private int id;
    private int userId;
    private boolean isPaid;
    private Integer totalPrice;
    private Date createTime;
    private Date updateTime;
    private Date deleteTime;

    public Order() {}
    
    public Order(int userId) {
        this.userId = userId;
        this.isPaid = false;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public boolean getIsPaid() {
        return isPaid;
    }

    public void setIsPaid(boolean isPaid) {
        this.isPaid = isPaid;
    }

    public Integer getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Integer totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    
    public void markCreate() {
        this.updateTime = this.createTime = new Date();
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

    public Date getDeleteTime() {
        return deleteTime;
    }

    public void setDeleteTime(Date deleteTime) {
        this.deleteTime = deleteTime;
    }
    
    public boolean isDeleted() {
        return deleteTime != null;
    }
    
    public void markDelete() {
        this.deleteTime = new Date();
    }

}

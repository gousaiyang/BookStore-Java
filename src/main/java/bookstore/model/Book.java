package bookstore.model;

import java.util.Date;

public class Book {
    
    private int id;
    private String name;
    private String image;
    private String author;
    private String press;
    private int price;
    private int stock;
    private String description;
    private Date createTime;
    private Date updateTime;
    private Date deleteTime;

    public Book() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    
    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }
    
    public String getPress() {
        return press;
    }

    public void setPress(String press) {
        this.press = press;
    }

    public int getPrice() {
        return price;
    }
    
    public void setPrice(int price) {
        this.price = price;
    }
    
    public int getStock() {
        return stock;
    }
    
    public void setStock(int stock) {
        this.stock = stock;
    }
    
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

package bookstore;

import java.util.Date;

public class Book {
	private Long id;
	private String name;
	private String image;
	private String author;
	private String press;
	private Long price;
	private Long stock;
	private String description;
	private Date createTime;
	private Date updateTime;
	private Date deleteTime;

    public Book() {}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
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

    public Long getPrice() {
        return price;
    }
    
    public void setPrice(Long price) {
        this.price = price;
    }
    
    public Long getStock() {
        return stock;
    }
    
    public void setStock(Long stock) {
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

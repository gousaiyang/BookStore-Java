package bookstore.util;

import java.util.Date;
import java.util.List;

import bookstore.model.Book;

public class BookDetail {
	
	private String name;
	private String image;
	private String author;
	private String press;
	private int price;
	private int stock;
	private String description;
	private Date createTime;
	private Date updateTime;
	private List<String> categories;
	
	public BookDetail(Book book, List<String> categories, boolean isAdmin) {
		
		this.name = book.getName();
		this.image = book.getImage();
		this.author = book.getAuthor();
		this.press = book.getPress();
		this.price = book.getPrice();
		this.description = book.getDescription();
		this.categories = categories;
		
		if (isAdmin) {
			this.stock = book.getStock();
			this.createTime = book.getCreateTime();
			this.updateTime = book.getUpdateTime();
		}
		
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
	
	public Date getUpdateTime() {
		return updateTime;
	}
	
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	
	public List<String> getCategories() {
		return categories;
	}
	
	public void setCategories(List<String> categories) {
		this.categories = categories;
	}
	
}

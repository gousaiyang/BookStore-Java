package bookstore.model;

import java.util.Date;

public class Category {
	
	private int id;
	private String name;
	private Date createTime;
	private Date updateTime;
	private Date deleteTime;
	
	public Category() {}
	
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

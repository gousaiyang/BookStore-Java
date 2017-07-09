package bookstore;

import java.util.Date;

public class User {
    private Long id;
    private String username;
    private String password;
    private String nickname;
    private boolean role;
    private Date createTime;
    private Date updateTime;
    private Date deleteTime;

    public User() {}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNickname() {
        return nickname;
    }
    
    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
    
    public boolean getRole() {
        return role;
    }
    
    public void setRole(boolean role) {
        this.role = role;
    }
    
    public boolean isAdmin() {
        return role;
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

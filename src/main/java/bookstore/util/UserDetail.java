package bookstore.util;

import java.util.Date;

import bookstore.model.User;

public class UserDetail {
	
	private String username;
	private String nickname;
	private String avatar;
	private int balance;
	private boolean role;
	private Date createTime;
	private Date updateTime;
	
	public UserDetail(User user, boolean admin) {
		
		this.username = user.getUsername();
		this.nickname = user.getNickname();
		this.avatar = user.getAvatar();
		this.balance = user.getBalance();
		
		if (admin) {
			this.role = user.getRole();
			this.createTime = user.getCreateTime();
			this.updateTime = user.getUpdateTime();
		}
		
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public int getBalance() {
		return balance;
	}

	public void setBalance(int balance) {
		this.balance = balance;
	}

	public boolean isRole() {
		return role;
	}

	public void setRole(boolean role) {
		this.role = role;
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
	
}

package bookstore.action;

import bookstore.model.User;
import bookstore.service.AppService;
import bookstore.util.FailureMessage;
import bookstore.util.PasswordUtil;
import bookstore.util.StringUtil;
import bookstore.util.SuccessMessage;
import bookstore.util.Validator;

public class AuthAction extends BaseAction {
	
	private static final long serialVersionUID = 1L;

	private String username;
	private String password;
	
	private Object retJson;
    
	private AppService appService;
	
	// Getters and setters
	
	public String getUsername() {
		return StringUtil.replaceNull(username);
	}

	public void setUsername(String username) {
		this.username = StringUtil.replaceNullAndTrim(username);
	}

	public String getPassword() {
		return StringUtil.replaceNull(password);
	}

	public void setPassword(String password) {
		this.password = StringUtil.replaceNull(password);
	}
	
	public Object getRetJson() {
		return retJson;
	}

	public void setRetJson(Object retJson) {
		this.retJson = retJson;
	}

	public AppService getAppService() {
		return appService;
	}

	public void setAppService(AppService appService) {
		this.appService = appService;
	}
	
	
	// Actions
	
	public String doLogin() {
		Validator vd = new Validator(getUsername(), "用户名");
		if (!vd.validateNotEmpty()) {
			retJson = vd.getFailureMessage();
			return ERROR;
		}
		vd = new Validator(getPassword(), "密码");
		if (!vd.validateNotEmpty()) {
			retJson = vd.getFailureMessage();
			return ERROR;
		}
		
		User user = appService.getUserByUsername(getUsername());
		if (user == null) {
			retJson = new FailureMessage("用户名或密码错误");
			return ERROR;
		}
		
		String hash = user.getPassword();
		if (!PasswordUtil.checkPassword(getPassword(), hash)) {
			retJson = new FailureMessage("用户名或密码错误");
			return ERROR;
		}
		
		session().setAttribute("user", user);
		
		retJson = new SuccessMessage();
		return SUCCESS;
	}
	
	public String doLogout() {
		session().removeAttribute("user");
		return SUCCESS;
	}
	
}

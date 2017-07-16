package bookstore.action;

import bookstore.model.User;
import bookstore.model.result.FailureMessage;
import bookstore.model.result.SuccessMessage;
import bookstore.service.AppService;
import bookstore.util.PasswordUtil;
import bookstore.util.StringUtil;
import bookstore.util.Validator;

public class AuthAction extends BaseAction {
    
    private static final long serialVersionUID = 1L;

    private String username;
    private String password;
    private String passwordConfirm;
    
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
    
    public String getPasswordConfirm() {
        return StringUtil.replaceNull(passwordConfirm);
    }

    public void setPasswordConfirm(String passwordConfirm) {
        this.passwordConfirm = StringUtil.replaceNull(passwordConfirm);
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
    
    public String doRegister() {
        Validator vd = new Validator(getUsername(), "用户名");
        if (!vd.validateNotEmpty() || !vd.validatePattern("^[-_0-9a-zA-Z]{5,}$", "用户名只能由字母、数字、破折号(-)和下划线(_)组成，且最小长度为 5 个字符。")) {
            retJson = vd.getFailureMessage();
            return ERROR;
        }
        vd = new Validator(getPassword(), "密码");
        if (!vd.validateNotEmpty() || !vd.validatePattern("^.{6,}$", "密码的最小长度为 6 个字符。")) {
            retJson = vd.getFailureMessage();
            return ERROR;
        }
        vd = new Validator(getPasswordConfirm(), "确认密码");
        if (!vd.validateNotEmpty()) {
            retJson = vd.getFailureMessage();
            return ERROR;
        }
        if (!getPassword().equals(getPasswordConfirm())) {
            retJson = new FailureMessage("密码与确认密码不一致。");
            return ERROR;
        }
        
        if (appService.usernameExists(getUsername())) {
            retJson = new FailureMessage("用户名 " + getUsername() + " 已经存在。");
            return ERROR;
        }
            
        Integer newUserId = appService.addUser(getUsername(), getPassword(), getUsername(), "", "0", "0");
        
        session().setAttribute("user", appService.getUserById(newUserId));
        
        retJson = new SuccessMessage();
        return SUCCESS;
    }
    
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
        
        retJson = new SuccessMessage(user.isAdmin());
        return SUCCESS;
    }
    
    public String doLogout() {
        session().removeAttribute("user");
        return SUCCESS;
    }
    
}

package bookstore.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import bookstore.model.User;

public class BaseAction extends ActionSupport {

    private static final long serialVersionUID = 1L;

    public HttpServletRequest request() {
        return ServletActionContext.getRequest();
    }

    public HttpSession session() {
        return ServletActionContext.getRequest().getSession();
    }

    public ServletContext application() {
        return ServletActionContext.getServletContext();
    }

    public HttpServletResponse response() {
        return ServletActionContext.getResponse();
    }
    
    public void setPageTitle(String title) {
        request().setAttribute("pageTitle", title);
    }
    
    public void setViewProfile() {
        User user = (User) session().getAttribute("user");
        
        if (user == null) {
            request().setAttribute("role", -1);
        }
        else {
            request().setAttribute("role", user.isAdmin() ? 1 : 0);
            request().setAttribute("currentUserId", user.getId());
            request().setAttribute("nickname", StringEscapeUtils.escapeHtml4(user.getNickname()));
            
            String avatar = user.getAvatar();
            if (avatar != null && !avatar.isEmpty()) {
                request().setAttribute("avatar", request().getContextPath() + "/img/upload/" + avatar);
            } else {
                request().setAttribute("avatar", request().getContextPath() + "/img/default/user.png");
            }
        }
    }

    @Override
    public String execute() throws Exception {
        return null;
    }
}

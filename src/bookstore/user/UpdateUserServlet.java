package bookstore.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Query;
import org.hibernate.Session;

import bookstore.User;
import bookstore.util.FailureMessage;
import bookstore.util.ParamGetter;
import bookstore.util.Validator;
import bookstore.HibernateUtil;

/**
 * Servlet implementation class UpdateUserServlet
 */
@WebServlet("/updateuser")
public class UpdateUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        String inputId = new ParamGetter().getTrimmedParam(request, "id");
        String inputUsername = new ParamGetter().getTrimmedParam(request, "username");
        String inputPassword = new ParamGetter().getParamStr(request, "password");
		String inputPasswordConfirm = new ParamGetter().getParamStr(request, "passwordConfirm");
		String inputNickname = new ParamGetter().getTrimmedParam(request, "nickname");
		String inputRole = new ParamGetter().getTrimmedParam(request, "role");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        
        Validator vd = new Validator();
        if (!vd.ValidateNotEmpty(inputId, "编号", out))
        	return;
        if (!vd.ValidatePatternEx(inputId, "^\\d+$", "编号 必须是一个正整数。", out))
        	return;
        if (!vd.ValidateNotEmpty(inputUsername, "用户名", out))
        	return;
        if (!vd.ValidatePatternEx(inputUsername, "^[-_0-9a-zA-Z]{5,}$", "用户名只能由字母、数字、破折号(-)和下划线(_)组成，且最小长度为 5 个字符。", out))
        	return;
        if (!inputPassword.equals("")) {
        	if (!vd.ValidatePatternEx(inputPassword, "^.{6,}$", "密码的最小长度为 6 个字符。", out))
        		return;
        }
        if (!inputPassword.equals(inputPasswordConfirm)) {
        	out.println(new FailureMessage("密码与确认密码不一致。").toJson());
            out.flush();
            out.close();
            return;
        }
        if (!vd.ValidateNotEmpty(inputNickname, "昵称", out))
        	return;
        if (!vd.ValidateNotEmpty(inputRole, "身份", out))
        	return;
        if (!vd.ValidatePatternEx(inputRole, "^0|1$", "身份的取值只能为 0 或 1 。", out))
        	return;
        
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        
        User user = (User)session.get(User.class, Long.parseLong(inputId));
        if (user == null) {
            out.println(new FailureMessage("该用户编号不存在。").toJson());
            out.flush();
            out.close();
            return;
        }
        
        if (!user.getUsername().equals(inputUsername)) {
            Query query = session.createQuery("FROM User WHERE username= :username");
            query.setString("username", inputUsername);
            @SuppressWarnings("rawtypes")
            List results = query.list();
            if (!results.isEmpty()) {
                out.println(new FailureMessage("用户名 " + inputUsername + " 已经存在。").toJson());
                out.flush();
                out.close();
                return;
            }
        }
        
        user.setUsername(inputUsername);
        if (!inputPassword.equals(""))
        	user.setPassword(inputPassword);
        user.setNickname(inputNickname);
        user.setRole(inputRole.equals("1"));
        user.markUpdate();
   
        session.save(user);
        session.getTransaction().commit();
        
        out.println("{\"result\":\"success\"}");
        out.flush();
        out.close();
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}

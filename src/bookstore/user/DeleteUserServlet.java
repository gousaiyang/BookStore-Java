package bookstore.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import bookstore.User;
import bookstore.util.FailureMessage;
import bookstore.util.ParamGetter;
import bookstore.util.Validator;
import bookstore.HibernateUtil;

/**
 * Servlet implementation class DeleteUserServlet
 */
@WebServlet("/deleteuser")
public class DeleteUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String inputId = new ParamGetter().getTrimmedParam(request, "id");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        
        Validator vd = new Validator();
        if (!vd.ValidateNotEmpty(inputId, "编号", out))
        	return;
        if (!vd.ValidatePatternEx(inputId, "^\\d+$", "编号 必须是一个正整数。", out))
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
   
        user.markDelete();
        
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

package bookstore.order;

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

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import bookstore.HibernateUtil;
import bookstore.util.FailureMessage;
import bookstore.util.ParamGetter;
import bookstore.util.Validator;

/**
 * Servlet implementation class GetOrderDetailServlet
 */
@WebServlet("/orderdetail")
public class GetOrderDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetOrderDetailServlet() {
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
        
        Query query1 = session.createQuery("FROM Order WHERE id = :id");
        query1.setString("id", inputId);
        @SuppressWarnings("rawtypes")
        List results1 = query1.list();
        if (results1.isEmpty()) {
        	out.println(new FailureMessage("该订单编号不存在。").toJson());
            out.flush();
            out.close();
            return;
        }
        
        Query query2 = session.createQuery("SELECT oi.id, oi.bookId, b.name, oi.quantity, oi.quantity * b.price, oi.createTime, oi.updateTime FROM OrderItem oi, Book b WHERE oi.bookId = b.id AND oi.orderId = :id");
        query2.setString("id", inputId);
        @SuppressWarnings("rawtypes")
        List results2 = query2.list();
        
        session.getTransaction().commit();
        
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        out.println(gson.toJson(results2));
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

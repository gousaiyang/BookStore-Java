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

/**
 * Servlet implementation class GetAllOrdersServlet
 */
@WebServlet("/allorders")
public class GetAllOrdersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetAllOrdersServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
	    session.beginTransaction();
        
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        
        Query query = session.createQuery("SELECT oi.orderId, u.username, SUM(oi.quantity), SUM(oi.quantity * b.price), o.isPaid, o.createTime, o.updateTime FROM Order o, OrderItem oi, User u, Book b WHERE o.id = oi.orderId AND o.userId = u.id AND oi.bookId = b.id GROUP BY oi.orderId");
        @SuppressWarnings("rawtypes")
        List result = query.list();
        
        session.getTransaction().commit();
        
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create(); 
        out.println(gson.toJson(result));
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

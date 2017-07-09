package bookstore.book;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import bookstore.Book;
import bookstore.HibernateUtil;
import bookstore.util.FailureMessage;
import bookstore.util.ParamGetter;
import bookstore.util.Validator;

/**
 * Servlet implementation class DeleteBookServlet
 */
@WebServlet("/deletebook")
public class DeleteBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteBookServlet() {
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
        
        Book book = (Book)session.get(Book.class, Long.parseLong(inputId));
        if (book == null) {
            out.println(new FailureMessage("该书籍编号不存在。").toJson());
            out.flush();
            out.close();
            return;
        }       
        
        book.markDelete();
        
        session.save(book);
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

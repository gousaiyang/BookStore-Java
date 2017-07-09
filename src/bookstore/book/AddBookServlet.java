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
import bookstore.util.ParamGetter;
import bookstore.util.Validator;

/**
 * Servlet implementation class AddBookServlet
 */
@WebServlet("/addbook")
public class AddBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddBookServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String inputName = new ParamGetter().getTrimmedParam(request, "name");
		//String inputImage = new ParamGetter().getTrimmedParam(request, "image"); // To be supported. 
		String inputAuthor = new ParamGetter().getTrimmedParam(request, "author");
		String inputPress = new ParamGetter().getTrimmedParam(request, "press");
        String inputPrice = new ParamGetter().getTrimmedParam(request, "price");
        String inputStock = new ParamGetter().getTrimmedParam(request, "stock");
        String inputDescription = new ParamGetter().getTrimmedParam(request, "description");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        
        Validator vd = new Validator();
        if (!vd.ValidateNotEmpty(inputName, "书名", out))
        	return;
        if (!vd.ValidateNotEmpty(inputPrice, "单价", out))
        	return;
        if (!vd.ValidatePattern(inputPrice, "^[0-9]+(?:\\.[0-9]{1,2})?$", "单价", out))
        	return;
        if (!vd.ValidateNotEmpty(inputStock, "库存", out))
        	return;
        if (!vd.ValidatePatternEx(inputStock, "^\\d+$", "库存 必须是一个正整数。", out))
        	return;
        
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        
        Book book = new Book();
        book.setName(inputName);
        //book.setImage(inputImage); // To be supported.
        book.setAuthor(inputAuthor);
        book.setPress(inputPress);
        book.setPrice((long)(Float.parseFloat(inputPrice) * 100));
        book.setStock(Long.parseLong(inputStock));
        book.setDescription(inputDescription);
        book.markCreate();
   
        session.save(book);
        session.getTransaction().commit();
        
        out.println("{\"result\":\"success\",\"id\":" + book.getId().toString() + "}");
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

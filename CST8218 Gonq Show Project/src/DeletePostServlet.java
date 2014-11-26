

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeletePostServlet
 */
@WebServlet("/DeletePostServlet.java")
public class DeletePostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeletePostServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String deleteID = request.getQueryString();
		String driver = "com.mysql.jdbc.Driver";  
		String userEmail = request.getSession().getAttribute("email").toString();
		
		try {
				Class.forName(driver).newInstance();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		try
		{
			Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/gonqshowdb", "gonqshow", "gonqshow");
				
			PreparedStatement statement;
			
			//delete all comments associated with post
			statement = connect.prepareStatement("DELETE FROM content WHERE on_id=?");
			statement.setString(1, deleteID);
			
			statement.executeUpdate();
			
			//delete post
			statement = connect.prepareStatement("DELETE FROM content WHERE content_id=?");
			statement.setString(1, deleteID);
		
			statement.executeUpdate();
		}
		catch(SQLException e)
		{
			
		}
	        
		request.getSession().setAttribute("email", userEmail);
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("homepage.jsp");
		requestDispatcher.include(request,response);

}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}

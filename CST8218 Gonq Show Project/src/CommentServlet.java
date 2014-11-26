import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

/**
 * Servlet implementation class CommentServlet
 */
@WebServlet("/CommentServlet")
@MultipartConfig
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private String content;
    private String userEmail;
    private String postID;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try
		{
			//List of file items - See Java API for more information
			ServletRequestContext context = new ServletRequestContext(request);
			List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(context);
				
			for(FileItem item : multiparts)
			{
				if (item.isFormField())
				{
					if (!item.getString().isEmpty())
					{
						content = item.getString();
					}
				}
			}
		}
		catch (Exception ex)
		{
			response.sendRedirect("homepage.jsp");
		}         
			          
   
		try
		{
			insertNewContent(request, response);
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void insertNewContent(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException
	{
		if ( content != null )
		{
			String driver = "com.mysql.jdbc.Driver";  
	        try {
				Class.forName(driver).newInstance();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        
			Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/gonqshowdb", "gonqshow", "gonqshow");
			userEmail = request.getSession().getAttribute("emailLogin").toString();
			postID = request.getSession().getAttribute("postID").toString();
			
			PreparedStatement statement;
				
			statement = connect.prepareStatement("INSERT INTO content (date_time, content, user_email, type, on_id) VALUES (?,?,?,?,?)");
			statement.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
			statement.setString(2, content);
			statement.setString(3, userEmail);
			statement.setString(4, "comment");
			statement.setString(5, postID);
				
			statement.executeUpdate();
	        
			request.getSession().setAttribute("emailLogin", userEmail);
		}
		
		response.sendRedirect("ViewPost.jsp?" + postID);
	}

}

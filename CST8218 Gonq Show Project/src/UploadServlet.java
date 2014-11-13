import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.RequestDispatcher;
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

@WebServlet("/UploadServlet")
@MultipartConfig
public class UploadServlet extends HttpServlet
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//Date and Time file is uploaded
	private Timestamp dateTime;
	//Path to file
	private String path;
	//User's email
	private String userEmail;
	//Type of file (document or image)
	private String fileType;
	//Content for posts/comments
	private String content;
	//File
	private File newFile = null;
	//Booleans to determine what has been submitted
	private boolean pic, comment;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadServlet()
    {
        // TODO Auto-generated constructor stub
    	super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		pic = false;
		comment = false;
		
		//Process only if its multipart content
		if(ServletFileUpload.isMultipartContent(request))
		{
			try
			{
				//List of file items - See Java API for more information
				ServletRequestContext context = new ServletRequestContext(request);
				List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(context);
				
				//Get current working directory
				path = request.getSession().getServletContext().getRealPath(request.getServletPath());
				//Go up on level, navigate to "Content" and the user's folder
				path = new File(path).getParentFile().getPath() + "/Content/" + request.getSession().getAttribute("email") + "/";
				
				for(FileItem item : multiparts)
				{
					if (!item.isFormField())
					{
						if (item.getName() != "")
						{
							//Check for valid file extension
							if (item.getName().contains(".doc") || item.getName().contains(".txt") || item.getName().contains(".rtf") ||
									item.getName().contains(".jpg") || item.getName().contains(".jpeg") || item.getName().contains(".bmp") || item.getName().contains(".png") )
							{
								//Check for valid file size (less than 5MB)
								if(((item.getSize() / 1024) / 1024) <= 5)
								{
									if(!item.isFormField())
									{
										String ext = null;
										
										if (item.getName().contains(".docx"))
										{
											ext = ".docx";
											fileType = "document";
										}
										else if (item.getName().contains(".doc"))
										{
											ext = ".doc";
											fileType = "document";
										}
										else if (item.getName().contains(".txt"))
										{
											ext = ".txt";
											fileType = "document";
										}
										else if (item.getName().contains(".rtf"))
										{
											ext = ".rtf";
											fileType = "document";
										}
										else if(item.getName().contains(".jpg"))
										{
											ext = ".jpg";
											fileType = "image";
										}
										else if(item.getName().contains(".jpeg"))
										{
											ext = ".jpeg";
											fileType = "image";
										}
										else if(item.getName().contains(".bmp"))
										{
											ext = ".bmp";
											fileType = "image";
										}
										else
										{
											//.png
											ext = ".png";
											fileType = "image";
										}
										
										dateTime = new Timestamp(System.currentTimeMillis());
										newFile = new File(path + dateTime.getTime() + ext);
										
										if(!newFile.getParentFile().exists())
										{
											newFile.getParentFile().mkdir();
										}
										
										if(!newFile.exists())
										{
											newFile.createNewFile();
										}
										
										item.write(newFile);
										
										//File uploaded successfully
										request.getSession().setAttribute("message", "File Uploaded Successfully");
										
										pic = true;
									}
								}
								else
								{
									request.getSession().setAttribute("message", "File Too Large (5MB Limit)");
								}
							}
							else
							{
								//Invalid file type
								request.getSession().setAttribute("message", "File Type Not Supported");
							}
						}
					}
					else
					{
						if (!item.getString().isEmpty())
						{
							content = item.getString();
							comment = true;
						}
					}
				}
			}
			catch (Exception ex)
			{
				request.getSession().setAttribute("message", "File Upload Failed due to " + ex);
			}         
			          
		}
		else
		{
			request.getSession().setAttribute("message", "Sorry this Servlet only handles file upload request");
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
		if ( pic == true || comment == true )
		{
			String driver = "com.mysql.jdbc.Driver";  
	        try {
				Class.forName(driver).newInstance();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/gonqshowdb", "gonqshow", "gonqshow");
			
			userEmail = request.getSession().getAttribute("email").toString();
			
			PreparedStatement statement;
			
			if ( pic == true && comment == true )
			{
				statement = connect.prepareStatement("INSERT INTO content (date_time, content, user_email, type) VALUES (?,?,?,?)");
				statement.setTimestamp(1, dateTime);
				statement.setString(2, newFile.getName());
				statement.setString(3, userEmail);
				statement.setString(4, fileType);
				
				statement.executeUpdate();
				statement.close();
				
				statement = connect.prepareStatement("SELECT * FROM content WHERE content=?");
				statement.setString(1, newFile.getName());
				
				ResultSet results = statement.executeQuery();
				
				while(results.next())
				{
					String id = results.getString(1);
				
					statement = connect.prepareStatement("INSERT INTO content (date_time, content, user_email, type, on_id) VALUES (?,?,?,?,?)");
					statement.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
					statement.setString(2, content);
					statement.setString(3, userEmail);
					statement.setString(4, "comment");
					statement.setString(5, id);
					
					statement.executeUpdate();
				}
			}
			else if ( pic == true )
			{
				statement = connect.prepareStatement("INSERT INTO content (date_time, content, user_email, type) VALUES (?,?,?,?)");
				statement.setTimestamp(1, dateTime);
				statement.setString(2, newFile.getName());
				statement.setString(3, userEmail);
				statement.setString(4, fileType);
				
				statement.executeUpdate();
			}
			else if ( comment == true )
			{
				statement = connect.prepareStatement("INSERT INTO content (date_time, content, user_email, type) VALUES (?,?,?,?)");
				statement.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
				statement.setString(2, content);
				statement.setString(3, userEmail);
				statement.setString(4, "post");
				
				statement.executeUpdate();
			}
	        
			request.getSession().setAttribute("email", userEmail);
		}
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("homepage.jsp");
		requestDispatcher.include(request,response);
	}
}

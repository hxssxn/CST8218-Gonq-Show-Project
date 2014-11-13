import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

/**
 * Servlet implementation class EditProfileServlet
 */
@WebServlet("/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//File name
	private Timestamp dateTime;
	//Path to file
	private String path;
	//User's email
	private String userEmail, fName, lName, about;
	//Type of file (document or image)
	private String fileType;
	//File
	private File newFile = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditProfileServlet() {
        super();
        // TODO Auto-generated constructor stub
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
				//If we are currently processing the profile picture
				if ( item.getFieldName().equals("profilePicture") )
				{
					//Check for valid file extension
					if (item.getName().toLowerCase().contains(".jpg") || item.getName().toLowerCase().contains(".jpeg") || item.getName().toLowerCase().contains(".bmp") || item.getName().toLowerCase().contains(".png") )
					{
						//Check for valid file size (less than 5MB)
						if(((item.getSize() / 1024) / 1024) <= 5)
						{
							if(!item.isFormField())
							{
								String ext = null;
								
								if(item.getName().toLowerCase().contains(".jpg"))
								{
									ext = ".jpg";
									fileType = "image";
								}
								else if(item.getName().toLowerCase().contains(".jpeg"))
								{
									ext = ".jpeg";
									fileType = "image";
								}
								else if(item.getName().toLowerCase().contains(".bmp"))
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
				else //If we are processing the form fields
				{
					switch(item.getFieldName())
					{
						case "fName": fName = item.getString();
							break;
						case "lName" : lName = item.getString();
							break;
						case "about" : if (!item.getString().isEmpty())
											about = item.getString();
										else
											about = null;
							break;
						default:
							break;
					}
				}
			}
		}
		catch (Exception ex)
		{
			request.getSession().setAttribute("message", "File Upload Failed due to " + ex);
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
		String driver = "com.mysql.jdbc.Driver";  
	    try
	    {
			Class.forName(driver).newInstance();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/gonqshowdb", "gonqshow", "gonqshow");
		userEmail = request.getSession().getAttribute("email").toString();
		
		if ( newFile != null )
		{
			PreparedStatement statement = connect.prepareStatement("INSERT INTO content (date_time, content, user_email, type) VALUES (?,?,?,?)");
			statement.setTimestamp(1, dateTime);
			statement.setString(2, newFile.getName());
			statement.setString(3, userEmail);
			statement.setString(4, fileType);
			statement.executeUpdate();
		}

		PreparedStatement statement = connect.prepareStatement("UPDATE user SET first_name = ?, last_name = ?, about_me = ?, profilePic = ? WHERE email = ?");
		statement.setString(1, fName);
		statement.setString(2, lName);
		
		if ( about != null )
			statement.setString(3, about);
		else
			statement.setString(3,  null);
		
		if ( newFile != null )
			statement.setString(4, newFile.getName());
		else
			statement.setString(4,  null);
		
		statement.setString(5, userEmail);
		
		statement.executeUpdate();
	        
		request.getSession().setAttribute("email", userEmail);
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("homepage.jsp");
		requestDispatcher.include(request,response);
	}
}

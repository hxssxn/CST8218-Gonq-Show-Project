/* SOURCE OF CODE FROM 
 * http://javaandj2eetutor.blogspot.ca/2014/01/login-application-using-jsp-servlet-and.html
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.Connection;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		request.getRequestDispatcher("homepage.jsp").include(request, response);
		//response.sendRedirect("homepage.jsp?language=" + request.getSession().getAttribute("language"));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		// Object created to send error message if email or password is incorrect
		PrintWriter out = response.getWriter();
		
		//Retrieve email and password from login.jsp
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		// Validation of email and password successful
		if (validate(email, password)) {
			setSession(email, request);
			// Redirect to homepage.jsp
			//RequestDispatcher requestDispatcher = request.getRequestDispatcher("homepage.jsp?language=" + request.getSession().getAttribute("language"));
			request.getRequestDispatcher("homepage.jsp").forward(request, response);
			// This line should work :( ---- response.sendRedirect("homepage.jsp?language=" + request.getSession().getAttribute("language"));
			//requestDispatcher.forward(request,response);  
		// Validation of email and password returns error
		} else {    
			// Print error to index.jsp and then redirect to the page
			request.getSession().setAttribute("invalidLogin", true);
			response.sendRedirect("index.jsp?language=" + request.getSession().getAttribute("language"));
		}
		// Close PrintWriter object to prevent leaks
		out.close(); 
	}
	
	public static void setSession(String email, HttpServletRequest request) {
        Connection connection = null;  
        PreparedStatement preparedStatement = null;  
        ResultSet resultSet = null;  
  
        String url = "jdbc:mysql://localhost:3306/";  
        String databaseName = "gonqshowdb";  
        String driver = "com.mysql.jdbc.Driver";  
        String dbUsername = "gonqshow";  
        String dbPassword = "gonqshow";  
        try {  
            Class.forName(driver).newInstance();  
            connection = DriverManager.getConnection(url + databaseName, dbUsername, dbPassword);  
  
            preparedStatement = connection.prepareStatement("SELECT first_name, last_name FROM user WHERE email=?"); 
            preparedStatement.setString(1, email);   
  
            resultSet = preparedStatement.executeQuery();
            resultSet.first(); // Required to place the cursor at the beginning of the result set, gets rid of SQLException
			
            // Set session
			HttpSession session = request.getSession();
			session.setAttribute("firstName", resultSet.getString(1));
			session.setAttribute("lastName", resultSet.getString(2));
			session.setAttribute("emailLogin", email);
			session.setMaxInactiveInterval(30*60);
            
        } catch (Exception e) {  
            System.out.println(e);  
        } finally {
        	// Close the connection to database
            if (connection != null) {  
                try {  
                    connection.close();  
                } catch (SQLException e) {  
                    e.printStackTrace();  
                }  
            } 
            // Close the Prepared Statement, releasing resources
            if (preparedStatement != null) {  
                try {  
                    preparedStatement.close();  
                } catch (SQLException e) {  
                    e.printStackTrace();  
                }  
            }
            // Close ResultSet, releasing resources
            if (resultSet != null) {  
                try {  
                    resultSet.close();  
                } catch (SQLException e) {  
                    e.printStackTrace();  
                }  
            }  
        }
	}
	
	public static boolean validate(String email, String password) {
        boolean status = false;  
        Connection connection = null;  
        PreparedStatement preparedStatement = null;  
        ResultSet resultSet = null;  
  
        String url = "jdbc:mysql://localhost:3306/";  
        String databaseName = "gonqshowdb";  
        String driver = "com.mysql.jdbc.Driver";  
        String dbUsername = "gonqshow";  
        String dbPassword = "gonqshow";  
        try {  
            Class.forName(driver).newInstance();  
            connection = DriverManager.getConnection(url + databaseName, dbUsername, dbPassword);  
  
            preparedStatement = connection.prepareStatement("SELECT * FROM user WHERE email=? AND password=PASSWORD(?)"); 
            preparedStatement.setString(1, email);  
            preparedStatement.setString(2, password);  
  
            resultSet = preparedStatement.executeQuery();
            // Method will return false when the entire table is traversed

            status = resultSet.next();
            
        } catch (Exception e) {  
            System.out.println(e);  
        } finally {
        	// Close the connection to database
            if (connection != null) {  
                try {  
                    connection.close();  
                } catch (SQLException e) {  
                    e.printStackTrace();  
                }  
            } 
            // Close the Prepared Statement, releasing resources
            if (preparedStatement != null) {  
                try {  
                    preparedStatement.close();  
                } catch (SQLException e) {  
                    e.printStackTrace();  
                }  
            }
            // Close ResultSet, releasing resources
            if (resultSet != null) {  
                try {  
                    resultSet.close();  
                } catch (SQLException e) {  
                    e.printStackTrace();  
                }  
            }  
        }
        // Return true or false status for if statement
        return status;  
    }  
}

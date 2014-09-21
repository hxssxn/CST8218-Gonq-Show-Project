/* SOURCE OF CODE FROM 
 * http://javaandj2eetutor.blogspot.ca/2014/01/login-application-using-jsp-servlet-and.html
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
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
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// WHAT DOES THIS DO?????????--------------------------------------------------------------------------------
		response.setContentType("text/html");
		// Object created to send error message if username or password is incorrect
		PrintWriter out = response.getWriter();
		
		//Retrieve username and password from login.jsp
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		// WHAT DOES THIS DO?????????--------------------------------------------------------------------------------
		HttpSession session = request.getSession(false);
		if (session != null)
			session.setAttribute("name", username);
		
		// Validation of username and password successful
		if (validate(username, password)) {
			// Redirect to homepage.jsp
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("homepage.jsp");
			// WHAT DOES THIS DO?????????--------------------------------------------------------------------------------
			requestDispatcher.forward(request,response);  
		// Validation of username and password returns error
		} else {    
			// Print error to index.jsp and then redirect to the page
			out.print("<p style=\"color:red\">Sorry username or password error</p>");    
			RequestDispatcher requestDispatcher=request.getRequestDispatcher("index.jsp");    
			requestDispatcher.include(request,response);    
		}
		// Close PrintWriter object to prevent leaks
		out.close(); 
	}

	public static boolean validate(String name, String password) {
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
  
            preparedStatement = connection.prepareStatement("SELECT * FROM users WHERE username=? AND password=PASSWORD(?)"); 
            preparedStatement.setString(1, name);  
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

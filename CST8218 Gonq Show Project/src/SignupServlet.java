

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
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

/**
 * Servlet implementation class SignupServlet
 */

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
	
	static String email;
	static String password1;
	static String password2;
	static String firstName;
	static String lastName;
	static String aboutMe;
	static String programDepartment;
	static String program;
	static String studentOrFaculty;
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignupServlet() {
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
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		email = request.getParameter("email");
		password1 = request.getParameter("password1");
		password2 = request.getParameter("password2");
		firstName = request.getParameter("firstName");
		lastName = request.getParameter("lastName");
		aboutMe = request.getParameter("aboutMe");
		programDepartment = request.getParameter("departmentDropDown");
		program = request.getParameter("programDropDown");
		studentOrFaculty = request.getParameter("sf");
		
		if (password1.equals(password2)){
			if (insertNewRecord()) {
				RequestDispatcher requestDispatcher = request.getRequestDispatcher("homepage.jsp");
				requestDispatcher.forward(request,response);
			} else {
				out.print("<p style=\"color:red\">Sorry sign up error</p>");    
				RequestDispatcher requestDispatcher=request.getRequestDispatcher("signup.jsp");    
				requestDispatcher.include(request,response); 
			}
		}
		else {
			out.print("<p style=\"color:red\">Password do not match</p>");    
			RequestDispatcher requestDispatcher=request.getRequestDispatcher("signup.jsp");    
			requestDispatcher.include(request,response); 
		}
		out.close();	
	}
	
	public static boolean insertNewRecord () {
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
  
            preparedStatement = connection.prepareStatement("INSERT INTO user "
            		+ "(email, password, first_name, last_name, program_department, program, student_faculty)"
            		+ "VALUES (?, PASSWORD(?), ?, ?, ?, ?, ?)"); 
            preparedStatement.setString(1, email);  
            preparedStatement.setString(2, password1); 
            preparedStatement.setString(3, firstName);
            preparedStatement.setString(4, lastName);
            preparedStatement.setString(5, programDepartment);
            preparedStatement.setString(6, program);
            if (studentOrFaculty == "student") {
            	preparedStatement.setInt(7, 0);
            } else if (studentOrFaculty == "faculty") {
            	preparedStatement.setInt(7, 1);
            } else {
            	preparedStatement.setInt(7, 0);
            }
  
            int updateStatus = preparedStatement.executeUpdate();
            // Method will return false when the entire table is traversed
            if (updateStatus > 0)
            	status = true;
  
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

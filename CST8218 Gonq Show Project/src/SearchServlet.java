

import java.io.IOException;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SearchServlet
 */
@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet 
{
	static String Query;
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchServlet() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		response.setContentType("text/html");
		
		Query = request.getParameter("Query");
		
		Connection connection = null;  
        PreparedStatement preparedStatement = null;  
        ResultSet resultSet = null;  

        String url = "jdbc:mysql://localhost:3306/";  
        String databaseName = "gonqshowdb";  
        String driver = "com.mysql.jdbc.Driver";  
        String dbUsername = "root";  
        String dbPassword = "root";  
        
        try 
        {  
            Class.forName(driver).newInstance();  
            connection = DriverManager.getConnection(url + databaseName, dbUsername, dbPassword);  
            preparedStatement = connection.prepareStatement("SELECT * FROM user WHERE first_name = '" + Query + "'");
            resultSet = preparedStatement.executeQuery();

            if(resultSet.isBeforeFirst())
            {
            	resultSet.next();
	            request.setAttribute("FullName", resultSet.getString(4) + " " + resultSet.getString(5));
	            request.setAttribute("About", resultSet.getString(6));
	            request.setAttribute("Department", resultSet.getString(7));
	            request.setAttribute("Program", resultSet.getString(8));
            }
            else
            {
            	request.setAttribute("SearchResults", false);
            }
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/users.jsp");
            rd.forward(request, response);
        }
        catch(Exception e)
        {
        	e.printStackTrace();
        }
        finally 
        {
        	// Close the connection to the database
        	if(connection != null)
        	{
        		try
        		{
        			connection.close();
        		}
        		catch (SQLException e)
        		{
        			e.printStackTrace();
        		}
        	}
        	// Close the prepared statement, releasing resources
        	if (preparedStatement != null) 
        	{  
                try
                {  
                    preparedStatement.close();  
                } catch (SQLException e)
                {  
                    e.printStackTrace();  
                }  
            }
            // Close ResultSet, releasing resources
            if (resultSet != null) 
            {  
                try 
                {  
                    resultSet.close();  
                } 
                catch (SQLException e)
                {  
                    e.printStackTrace();  
                }  
            }  
        }   
		
	}
}


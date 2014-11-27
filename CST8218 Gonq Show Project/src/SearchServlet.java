

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
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
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
        String dbUsername = "gonqshow";  
        String dbPassword = "gonqshow";  
        
        //if referer is not searchserlvet store as last referer
        
        try 
        {  
            Class.forName(driver).newInstance();  
            connection = DriverManager.getConnection(url + databaseName, dbUsername, dbPassword);  
            
            // First Query
            preparedStatement = connection.prepareStatement("SELECT * FROM user WHERE first_name = '" + Query + "'");
            resultSet = preparedStatement.executeQuery();
            
            if(resultSet.first())
            {
	            request.setAttribute("FullName", resultSet.getString(4) + " " + resultSet.getString(5));
	            RequestDispatcher rd = getServletContext().getRequestDispatcher("/ViewProfile.jsp?" + resultSet.getString(2));
	            rd.forward(request, response);
            }
            else
            {
            	preparedStatement.close();
            	resultSet.close();
            	try
            	{
                    preparedStatement = connection.prepareStatement("SELECT * FROM user WHERE last_name = '" + Query + "'");
                    resultSet = preparedStatement.executeQuery();
                    
                    if(resultSet.first())
                    {
        	            request.setAttribute("FullName", resultSet.getString(4) + " " + resultSet.getString(5));
        	            RequestDispatcher rd = getServletContext().getRequestDispatcher("/ViewProfile.jsp?" + resultSet.getString(2));
        	            rd.forward(request, response);
                    }
                    else
                    {
                    	preparedStatement.close();
                    	resultSet.close();
                    	try
                    	{
                            preparedStatement = connection.prepareStatement("SELECT * FROM user WHERE email = '" + Query + "'");
                            resultSet = preparedStatement.executeQuery();
                    		
                            if(resultSet.first())
                            {
                	            request.setAttribute("FullName", resultSet.getString(4) + " " + resultSet.getString(5));
                	            RequestDispatcher rd = getServletContext().getRequestDispatcher("/ViewProfile.jsp?" + resultSet.getString(2));
                	            rd.forward(request, response);
                            }
                            else
                            {
                            //	RequestDispatcher rd = getServletContext().getRequestDispatcher(referer);
                            	request.setAttribute("searchError", "No Results Found");
                            //	rd.forward(request, response);
                            	response.sendRedirect("/gonqshow/homepage.jsp");
                            }
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
            	catch(Exception e)
            	{
            		e.printStackTrace();
            	}
            }   
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


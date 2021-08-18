
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@include file="dbvars.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List of Users</title>
        <%@include file="extfiles.jsp"%>
    </head>
    <body>
        <%@include file="adminheader.jsp"%>
        `<!-- contact -->

<div class="container pt-lg-5">
<h2 class="heading text-center mb-sm-5 mb-4">List of Users</h2>
<div class="row agileinfo_mail_grids">
<div class="col-lg-8 agileinfo_mail_grid_right">
	<form action="#" method="post">
	
    <%
       
           try
             {
               Class.forName("com.mysql.jdbc.Driver");//CALLS DRIVER,,YOU HAVE TO ADD LIBRARY NAMED "MYSQL JDBC DRIVER" 
               Connection myconn=DriverManager.getConnection(dburl,dbuname,dbpass);//CONNECTION
              try
               {
                    String q="select * from signup where usertype=?";//THIS STATEMENT IS VERY IMP SINCE IT SELECTS EVERYTHING(*) FROM SIGN UP(NAME OF OUR DATABASE)
                    //"WHERE" - HERE IT IS CONDITION THAT IS CHECKED IN THE DATABASE IF IT MATCHES 
                    //executeUpdate works on insert,update or delete AND NOT ON SELECT SO WE USE RESULTSET(IT IS VERY SIMILAR TO ITERATOR)
                    PreparedStatement myst=myconn.prepareStatement(q);//Creates a PreparedStatement object for sending parameterized SQL statements to the database.
                    myst.setString(1, "normal");
                    ResultSet myres=myst.executeQuery();//RETURNS DATA PRODUCED BY THE QUERY AS A SET CALLED RESULTSET

                    if(myres.next()==true)//HERE IT CHECKS IF THERE IS NEXT LINE OR NOT,,EVEN IF THERE IS ONE LINE(IT IS IN CASE PRIMARY KEYWORD, SINCE IT IS UNIQUE e.g. username here, as there is unique username for everyone so there will be one line only)
                       //IT HAS INITIAL CURSOR BEFORE THE FIRST LINE                    
                     {
                         out.print("<table class='table table-striped'>"   //HERE WE DIRECTLY PRINT THE LISTOFMEMBERS
                                    + "<tr>"
                                    + "<th>Name</th>"
                                 + "<th>Username</th>"
                                    + "<th>Phone</th>"
                                    + "<th>Email</th>"
                                 + "<th>Update</th><th>Delete</th></tr>");//WE WRITE HTML CODE IN - ""
                            do  //HERE DO WHILE LOOP IS USED,IF WE USE WHILE LOOP,ITERATOR GOES TO NEXT LINE TWICE AND FIRST LINE IS SKIPPED,BCOZ "myres.next()" has moved cursor once in if statement
                            {    //IMP- HERE NOW CURSOR IS AT FIRST LINE/ROW OF OUR DATABASE AND WE CAN CALL ANY COLUMN USNG myres.getString("column name");
                                out.print("</tr>"
                                        + "<th>" + myres.getString("name") + "</th>"
                                                + "<th>" + myres.getString("Username") + "</th>"//myres.getString("column name")- GIVES THE VALUE OF THAT COLUMN AFTER WE ARE CONNECTED TO DATABASE
                                                + "<th>" + myres.getString("phonenumber") + "</th>"
                                                        + "<th>" + myres.getString("email") + "</th>"
                                                                        + "<td><a href='updateuser.jsp?uname=" + myres.getString("username") + "' style='color:black'>Update</a></td>"
                                                        + "<td><a href='deleteuser.jsp?uname=" + myres.getString("username") + "' style='color:black'>Delete</a></td>");
                                                                     
                            }
                            while(myres.next());
                            out.print("</table>");  //TABLE MUST BE CLOSED HERE
                            //LOOP IS USED TO PRINT ALL ROWS
                     }
                    else
                     {
                      out.print("No records found.");
                     }
           }
                catch(Exception e)
                 {
                   out.print("Error occured " + e.getMessage());   
                 }
                finally
                 {
                   myconn.close();
                 }
           }
          catch(Exception e)
          {
           out.print("Connection failed - " + e.getMessage());   
           }
        
                          %>
				</form>
			</div>
		</div>
	</div>
	

<!-- //contact -->
 <%@include file="footer.jsp"%>
    </body>
</html>

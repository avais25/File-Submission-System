<%-- 
    Document   : login
    Created on : May 20, 2016, 2:05:50 PM
    Author     : lenovo
--%>
<%@page import="java.io.*" %>                               <%-- importing necessary packages--%>
<%@page import="java.sql.*,java.text.*,java.util.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" type="text/css" href="index.css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        
        <div class="buttons">
        <%
         
        String email=request.getParameter("lemail");                        //Recievinging email from html textbox from login.html
        email=email.toLowerCase();                                          //converting email to lower case
        email=email.trim();                                                 //removing spaces before and after email
        String password=request.getParameter("lpassword");                  //Recievinging password from html textbox
        
        ResultSet rs=null;
        
        Class.forName("oracle.jdbc.driver.OracleDriver");                   //creating  connection to database
        Connection cn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","tcs","tcs");  
        Statement st1=cn.createStatement();
        
            
       rs=st1.executeQuery("select * from registration where email='"+email+"'");   //executinng query to get the record for the email
       
       
       
       if(rs.next()!=false)                                                     //check if email exist
       {
           String pass=rs.getString("password");                                //getting password from database 
           
           
           if(pass.equals(password))                                            //matching password
           {
               
              //out.write("Welcome  "+rs.getString("name")+"!  \n You are successfully logged in!  "); 
              String name=rs.getString("NAME");                                     //recieving name from database
              String userID = new String(email);                                    //recieving email from database
              Integer uid=rs.getInt("IDUPLOAD");                                   //getting boolean info wether id upload already done
              Integer cid=rs.getInt("CUPLOAD");                                   //getting boolean info wether ZIP upload already done
              
              
              session.setAttribute("userID", userID);              //adding attributes to the session
              session.setAttribute("nameKey", name);
              session.setAttribute("cKey", cid);
              session.setAttribute("idKey", uid);
                     
               String site = new String("option.jsp");         //will open option.html from where user can upload image or zip
               response.setStatus(response.SC_MOVED_TEMPORARILY);
               response.setHeader("Location", site);
              
           
              
           }
           else                                                                     //if password does not match
           {  
                %>
               <br><ins><b>Incorrect Password!</b></ins> 
               <br>Please try again!  
               <br><br><a href ="login.html"><span>
                <input type="button" value = "Try Again"></span></a>
               
               <a href ="index.html"><span>
               <input type="button" value = "Home"></span></a> 
               <% 
             }
           
           
       }
       else{                                                //if email was not present in database
         
        %>
        <br><ins><b>This email is not registered! </b></ins> 
        <br> Please Sign Up or try again!
        <br><br><a href ="reg.html"><span>
        <input type="button" value = "Sign Up"></span></a>
        <a href ="login.html"><span>
        <input type="button" value = "Try Again"></span></a>
      
        <a href ="index.html"><span>
        <input type="button" value = "Home"></span></a> 
        <%
        }
       
        %>
        </div>
    </body>
</html>

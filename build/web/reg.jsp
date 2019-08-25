<%-- 
    Document   : index
    Created on : May 18, 2016, 5:43:33 PM
    Author     : lenovo
--%>
<%@page import="java.io.*" %>                                <%-- importing required packages--%>
<%@page import="java.sql.*,java.text.*,java.util.*" %>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" type="text/css" href="index.css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration</title>
    </head>
    <div class="buttons">
    <%
        String name=request.getParameter("name");               //Recieving Name from html textbox from reg.html
        name=name.trim();                                       //removing spaces before and after Name
        String email=request.getParameter("email");             //Recieving email from html textbox from reg.html
        email=email.toLowerCase();                              //converting email to lower case
        email=email.trim();                                     //removing spaces before and after email
        String password=request.getParameter("password");       //Recieving password from html textbox from reg.html
        
        ResultSet rs=null;                                      //Result set to get output from databaase
        
        Class.forName("oracle.jdbc.driver.OracleDriver");       //creating connection with database
        Connection cn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","tcs","tcs");  
        Statement st1=cn.createStatement();
        
            
       rs=st1.executeQuery("select * from registration where email='"+email+"'");       //checking if email already exist and store its record in rs variable
       if(rs.next()){                                                                   //if there is any value in rs ,it means email is already registered
           %>
           <br><ins><b>You are already registered! </b></ins> 
           <br>Please Login!  
            <br><br><a href ="login.html"><span>
            <input type="button" value = "Login"></span></a>
            <a href ="index.html"><span>
            <input type="button" value = "Home"></span></a> 
         <%  
       }
       else{                                                                //if email is not registered
         
        st1.executeQuery("insert into registration values "+"('"+name+"','"+email+"','"+password+"','0','0')");        //Inserting all the details into database 
        
        out.write("<br><ins><b>"+name+
        " is successfully registered!</b></ins> "+
        " <br><br><a href =\"login.html\"><span> <input type=\"button\" value = \"Login\"></span></a>");                     //messege for successful registeration
        %>
        <a href ="index.html"><span>
            <input type="button" value = "Home"></span></a> 
       <%
        }
       
        %>
        <%!
       
            
            /* public void validate(String x,String y,String z,javax.servlet.jsp.JspWriter myOut)  
        {
            if(x==null) 
             try { myOut.println("aa");}
              catch(Exception eek) { }
                  }*/
            %> 
    </div>    
</html>

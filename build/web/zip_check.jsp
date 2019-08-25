<%-- 
    Document   : zip_check
    Created on : Jun 8, 2016, 11:11:56 PM
    Author     : lenovo
--%>
<%@page import="java.io.*" %>                               <%-- importing necessary packages--%>
<%@page import="java.sql.*,java.text.*,java.util.*" %>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checking</title>
    </head>
    <%
        ResultSet rs=null;
        String email=(String)session.getAttribute("userID") ; //getting email using session
        
        Class.forName("oracle.jdbc.driver.OracleDriver");                   //creating  connection to database
        Connection cn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","tcs","tcs");  
        Statement st1=cn.createStatement();
        
            
       rs=st1.executeQuery("select * from registration where email='"+email+"'");   //executinng query to get the record for the email
       if(rs.next()!=false)                                                     //check if email exist
       {
        Integer cid=rs.getInt("CUPLOAD");                                   //getting boolean info wether upload already done
        
        String filename = email+".zip";                                         //storing file in a variabe
           String filepath = "C:\\tcs_data\\";   
           File theFile = new File(filepath+filename);
        
        if(cid==0 || !theFile.exists())                                             //it will prompt to upload if bool in database on false or file does not exist on the server
        {
            String site = new String("czip.html");         //will open upload.html to upload user image
               response.setStatus(response.SC_MOVED_TEMPORARILY);
               response.setHeader("Location", site);
        }
        else
        {
            String site = new String("czip_u_comp.html");         //will open upload.html to upload user image
               response.setStatus(response.SC_MOVED_TEMPORARILY);
               response.setHeader("Location", site);   
        }
       }
        %>
</html>

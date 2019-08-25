<%-- 
    Document   : download_zip
    Created on : Jun 9, 2016, 2:06:50 PM
    Author     : lenovo
--%>

<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" type="text/css" href="index.css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Download</title>
    </head>
    <body>
        <div class="buttons">
       <%    
           int cid=(int)session.getAttribute("cKey") ;                      //getting boolean info wether zip upload already done
           String email=(String)session.getAttribute("userID") ;           //getting email using session
           
           String filename = email+".zip";                                   //storing file in a variabe  
           String filepath = "C:\\tcs_data\\";   
           File theFile = new File(filepath+filename);
            
           if(cid==1 && theFile.exists())                                   //it will download booloean in database is 1 and file exist on sever
           {
               // obtains ServletContext
        ServletContext context = getServletContext();
         
        // gets MIME type of the file
        String mimeType = context.getMimeType(filepath+filename);
        if (mimeType == null) {        
            // set to binary type if MIME mapping not found
            mimeType = "application/octet-stream";
        }
             
             // modifies response
             response.setContentType(mimeType);
             response.setContentLength((int) theFile.length());
          
             //response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");   
  
            java.io.FileInputStream fileInputStream=new java.io.FileInputStream(filepath + filename);  
            
            
            
            // forces download
        String headerKey = "Content-Disposition";
        String headerValue = String.format("attachment; filename=\"%s\"", theFile.getName());
        response.setHeader(headerKey, headerValue);
        
        
            // obtains response's output stream
            OutputStream outStream = response.getOutputStream();
         
             byte[] buffer = new byte[4096];
             int bytesRead = -1;
         
            while ((bytesRead = fileInputStream.read(buffer)) != -1) {
            outStream.write(buffer, 0, bytesRead);
        }
         
             fileInputStream.close();
             outStream.close();    
            /* int i;   
             while ((i=fileInputStream.read()) != -1) 
            {  
            out.write(i);   
             }   
            fileInputStream.close(); */
         }
            else  
            {
                %>
                <br><ins><b>No such file uploaded!</b></ins>
                <br>Please upload it first.
                <br><br><a href ="download_option.html"><span>
                <input type="button" value = "Go Back"></span></a>
               
               <a href ="czip.html"><span>
               <input type="button" value = "Upload"></span></a> 
            <%
                }
           

%>   
        </div>
        </body>
    
</html>

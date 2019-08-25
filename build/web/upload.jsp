<%@ page import="java.io.*,java.util.*, javax.servlet.*,java.text.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>

<link rel="stylesheet" type="text/css" href="index.css">
<div class="buttons">
    

<%
    
    String email=(String)session.getAttribute("userID") ;           //getting email using session
    File file ;                                             //file object to upload the file
   int maxFileSize = 5*1024 * 1024; //in bytes,  =5mb
   int maxMemSize = 5*1024 * 1024;
   
   ServletContext context = pageContext.getServletContext();
   String filePath = context.getInitParameter("file-upload");       //the path is fetched from web.xml in parameter file-upload

   // Verify the content type
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {

      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File("c:\\temp")); // \ is used for escape sequence to insert backslash

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      
      // maximum file size to be uploaded.
      //upload.setSizeMax( maxFileSize );
      
      
      try{ 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);

         // Process the uploaded file items
         Iterator i = fileItems.iterator();

         out.println("<html>");
         out.println("<head>");
         out.println("<title>JSP File upload</title>");  
         out.println("</head>");
         out.println("<body>");
         while ( i.hasNext () ) 
         {
            FileItem fi = (FileItem)i.next();           //add size and type checking, add session ,add logout
            if ( !fi.isFormField () )	
            {
                
            // Get the uploaded file parameters
            String fieldName = fi.getFieldName();
            String fileName = fi.getName();             //name with path of the file to be uploaded
            boolean isInMemory = fi.isInMemory();
            long sizeInBytes = fi.getSize();            //getting size of file to be uploaded
            String ext;                                 //stores the extension of the file to be uploaded
            ext=fileName.substring(fileName.lastIndexOf(".")) ;     //extracting the extension from the file name
            if (maxFileSize>=sizeInBytes)          
            {
                if(ext.equals(".jpg") || ext.equals(".jpeg"))           //checking if extension is .jpg or .jpeg
                {
                
            //initializing file variable with the file to be uploaded
            
            file = new File( filePath +                     //filePath has destination path
            email+".jpg");                                  //file will be stored with name of user id i.e. email , and file type must be jpg
                        
            fi.write( file ) ;           // Write the file
            Class.forName("oracle.jdbc.driver.OracleDriver");                   //creating  connection to database
            Connection cn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","tcs","tcs");  
            Statement st1=cn.createStatement();
            
            st1.executeQuery("UPDATE registration SET IDUPLOAD='1' WHERE email='"+email+"'"); //setting IDUPLOAD column to 1 for successful upload
            session.setAttribute("idKey", 1);
            out.println("<ins><b>Upload Successful!</ins></b><br> Filename: "  + 
            fileName + "<br>");             //message for successful upload
            }
                else                //else  block when extension type does not match
                {
                 %>
                 <ins><b>File not Uploaded.</ins></b> <br>  
                Unknown file format. Please upload only .jpg or .jpeg file format<br>
                <br><br><a href ="upload.html"><span>
                <input type="button" value = "Try Again"></span></a>
                
                <%   
                }
            }                               //end of if block to check extension type
            else                            //else block if size exceed the given limit                            
            {
             %>
             <ins><b>File not Uploaded.</ins></b> <br>   
             Size Limit Exceeded. Please make sure file size is less than 5MB.<br>
                <br><br><a href ="upload.html"><span>
                <input type="button" value = "Try Again"></span></a>
                
                <%          
            }//end of else
            }
         }

         out.println("</body>");
         out.println("</html>");
      }
      
      catch(Exception ex) {
         System.out.println(ex);
      }
   }
   
   else{
      out.println("<html>");
      out.println("<head>");
      out.println("<title>Servlet upload</title>");  
      out.println("</head>");
      out.println("<body>");
      out.println("<p>No file uploaded</p>"); 
      out.println("</body>");
      out.println("</html>");
   }
%>
        <br><br><a href ="option.jsp"><span>
        <input type="button" value = "Go Back"></span></a>        
        <a href ="logout.jsp"><span>
        <input type="button" value = "Logout"></span></a>
        </div>
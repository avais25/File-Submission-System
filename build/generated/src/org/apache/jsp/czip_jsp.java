package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import java.text.*;
import java.sql.*;
import javax.servlet.http.*;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.servlet.*;
import org.apache.commons.io.output.*;

public final class czip_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"index.css\">\n");
      out.write("<div class=\"buttons\">\n");
      out.write("    \n");

    
    String email=(String)session.getAttribute("userID") ;
    File file ;                                             //file object to upload the file
   int maxFileSize = 20*1024 * 1024; //in bytes,  =20mb
   int maxMemSize = 20*1024 * 1024;
   
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
                if(ext.equals(".zip") || ext.equals(".7z"))           //checking if extension is .jpg or .jpeg
                {
                
            //initializing file variable with the file to be uploaded
            
            file = new File( filePath +                     //filePath has destination path
            email+".zip");                                  //file will be stored with name of user id i.e. email , and file type must be jpg
                        
            fi.write( file ) ;           // Write the file
            Class.forName("oracle.jdbc.driver.OracleDriver");                   //creating  connection to database
            Connection cn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","tcs","tcs");  
            Statement st1=cn.createStatement();
            
            st1.executeQuery("UPDATE registration SET CUPLOAD='1' WHERE email='"+email+"'"); //setting IDUPLOAD column to 1 for successful upload
            
            out.println("Upload Successful!<br> Filename: "  + 
            fileName + "<br>");             //message for successful upload
            }
                else                //else  block when extension type does not match
                {
                 
      out.write("\n");
      out.write("                File not Uploaded. <br>  \n");
      out.write("                Unknown file format. Please upload only .zip or .7z file format\n");
      out.write("                <br><a href =\"czip.html\"><span>\n");
      out.write("                <input type=\"button\" value = \"Try Again\"></span></a>\n");
      out.write("                \n");
      out.write("                ");
   
                }
            }                               //end of if block to check extension type
            else                            //else block if size exceed the given limit                            
            {
             
      out.write("\n");
      out.write("             File not Uploaded. <br>   \n");
      out.write("             Size Limit Exceeded. Please make sure file size is less than 20MB.\n");
      out.write("                <br><a href =\"czip.html\"><span>\n");
      out.write("                <input type=\"button\" value = \"Try Again\"></span></a>\n");
      out.write("                \n");
      out.write("                ");
          
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

      out.write("\n");
      out.write("        <br><a href =\"option.html\"><span>\n");
      out.write("        <input type=\"button\" value = \"Go back.\">Go back and upload id .(will replace if already done).</span></a>        \n");
      out.write("        <br><a href =\"logout.jsp\"><span>\n");
      out.write("        <input type=\"button\" value = \"Logout\"></span></a>\n");
      out.write("</div>\n");
      out.write("        \n");
      out.write("        ");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}

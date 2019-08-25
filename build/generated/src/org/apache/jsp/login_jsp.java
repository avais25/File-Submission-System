package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.*;
import java.sql.*;
import java.text.*;
import java.util.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html;charset=UTF-8");
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
      out.write("                               ");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"index.css\">\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Login</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        \n");
      out.write("        <div class=\"buttons\">\n");
      out.write("        ");

         
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
           //Integer uid=rs.getInt("IDUPLOAD");                                   //getting boolean info wether upload already done
           
           if(pass.equals(password))                                            //matching password
           {
               
              //out.write("Welcome  "+rs.getString("name")+"!  \n You are successfully logged in!  "); 
              
              String userIDKey = new String("userID");
              String userID = new String(email);
              
              session.setAttribute(userIDKey, userID);
                     
               String site = new String("option.html");         //will open option.html from where user can upload image or zip
               response.setStatus(response.SC_MOVED_TEMPORARILY);
               response.setHeader("Location", site);
              
           
              
           }
           else                                                                     //if password does not match
           {  
                
      out.write("\n");
      out.write("               <br><ins><b>Incorrect Password!</b></ins> \n");
      out.write("               <br>Please try again!  \n");
      out.write("               <br><br><a href =\"login.html\"><span>\n");
      out.write("                <input type=\"button\" value = \"Try Again\"></span></a>\n");
      out.write("               ");
 
             }
           
           
       }
       else{                                                //if email was not present in database
         
        
      out.write("\n");
      out.write("        <br><ins><b>This email is not registered! </b></ins> \n");
      out.write("        <br> Please Sign Up or try again!\n");
      out.write("        <br><br><a href =\"reg.html\"><span>\n");
      out.write("        <input type=\"button\" value = \"Sign Up\"></span></a>\n");
      out.write("        <a href =\"login.html\"><span>\n");
      out.write("        <input type=\"button\" value = \"Try Again\"></span></a>\n");
      out.write("      ");

        }
       
        
      out.write("\n");
      out.write("        </div>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
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

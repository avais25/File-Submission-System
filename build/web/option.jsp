<%-- 
    Document   : option
    Created on : Jun 9, 2016, 2:26:25 AM
    Author     : lenovo
--%>

<html>
<head>
<link rel="stylesheet" type="text/css" href="index.css">
</head>
<body>

 <!-- Title -->
  <h1>User ID and Certificates upload.</h1>
  <h1>Welcome!<% String name=(String)session.getAttribute("nameKey") ; 
      out.write(" "+name);
      %>  </h1>

  <!-- Buttons Start!! -->
  <div class="buttons">
   
    <a class="btn green" href="id_check.jsp">CLICK HERE FOR UPLOADING USERID </a>
    
    <a class="btn purple" href="zip_check.jsp">CLICK HERE FOR UPLOADING CERTIFICATES</a>
    <br><br><br><br><a href ="download_option.html"><span>
    <input type="button" value = "Download"></span></a>
    <br><br><a href ="logout.jsp"><span>
    <input type="button" value = "Logout"></span></a>
    
  </div>
</body>
  </html>

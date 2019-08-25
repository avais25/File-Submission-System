<%-- 
    Document   : logout
    Created on : Jun 4, 2016, 1:23:50 PM
    Author     : lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LogOut</title>
    </head>
    <body>
        <%
            session.setAttribute("nameKey", null);
            session.setAttribute("userID", null);
            session.setAttribute("cKey", null);
            session.setAttribute("idKey", null);
            
            session.invalidate();      // will invalidate the session
            String site = new String("login.html");         //will open login.html to upload user image
               response.setStatus(response.SC_MOVED_TEMPORARILY);
               response.setHeader("Location", site);
            %>
    </body>
</html>

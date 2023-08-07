
<%@page import="com.learn.mycart.entites.User"%>
<%
    
User user=(User)session.getAttribute("current-user");
if(user==null){
    
    session.setAttribute("message", "You are not logged in !! login first");
    response.sendRedirect("login.jsp");
    return;
}else{
    
    if(user.getUserType().equals("normal")){
        session.setAttribute("message", "You are not admin! Do not access this page");
        response.sendRedirect("login.jsp");
        
        return;
    }
    
}
    
    %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>This is normal user panel</h1>
    </body>
</html>

<%@ page import="es.taw.welkarten.entity.Usuario" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: maria
  Date: 24/05/2021
  Time: 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Hola</title>
</head>

<%
    List<Usuario> lista = (List)request.getAttribute("lista");
%>

<body>
<h1>Hola somos un jsp</h1>
<%
    for(Usuario u : lista){
%>
    <p><%= u.getCorreo()%></p>
<%
    }
%>
</body>
</html>

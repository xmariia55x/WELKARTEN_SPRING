<%@ page import="es.taw.welkarten.entity.Usuario" %>
<%@ page import="es.taw.welkarten.entity.Conversacion" %><%--
    Document   : chat
    Created on : 13-may-2021, 13:14:44
    Author     : adric
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="styles.css" rel="stylesheet">
        <title>CHAT</title>
    </head>
    <%
        Usuario user = (Usuario) session.getAttribute("usuario");
        Conversacion conversacion = (Conversacion) request.getAttribute("conversacion");
    %>    

    <body onload="getMessages();">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <jsp:include page="Navbar.jsp" />
        <br/>
        <br/>
        <br/>
        <br/>
        <div style="padding: 2% 20%">


            <h3>Conversación de <%= user.getNombre()%></h3>
            <form>
                <table>

                    <td>Nombre:</td>
                    <td><input type="text" id="name" name="name" readonly="readonly" value="<%= user.getNombre()%>"/></td>
                    </tr>
                    <tr>
                        <td>Mensaje:</td>
                        <td><input type="text" id="message" name="message" /></td>
                    </tr>
                    <tr>
                        <td><input type="button" class="btn btn-primary" onclick="postMessage();" value="ENVIAR" /></td>
                    </tr>
                </table>
            </form>
            <br/>
            <h3> Mensajes Actuales </h3>

            <div id="content">
                <% if (application.getAttribute("messages") != null) {%>
                <%= application.getAttribute("messages")%>
                <% }%>
            </div> 
        </div>

<script>
    function postMessage() {
        var xmlhttp = new XMLHttpRequest();
        //xmlhttp.open("POST", "shoutServlet?t="+new Date(), false);
        xmlhttp.open("POST", "teleoperador/shoutPost/<%=conversacion.getId()%>", false);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        var nameText = escape(document.getElementById("name").value);
        var messageText = escape(document.getElementById("message").value);
        document.getElementById("message").value = "";
        xmlhttp.send("name=" + nameText + "&message=" + messageText);
    }
    var messagesWaiting = false;
    function getMessages() {
        if (!messagesWaiting) {
            messagesWaiting = true;
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    messagesWaiting = false;
                    var contentElement = document.getElementById("content");
                    contentElement.innerHTML = xmlhttp.responseText + contentElement.innerHTML;
                }
            }
            //xmlhttp.open("GET", "shoutServlet?t="+new Date(), true);
            xmlhttp.open("GET", "/teleoperador/shoutGet", true);
            xmlhttp.send();
        }
    }
    setInterval(getMessages, 1000);
</script>
</body>
</html>

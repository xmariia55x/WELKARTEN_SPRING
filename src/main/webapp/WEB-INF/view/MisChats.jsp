<%-- 
    Document   : MisChats
    Created on : 13-may-2021, 12:51:56
    Author     : adric
--%>


<%@page import="java.util.List"%>
<%@ page import="es.taw.welkarten.entity.Conversacion" %>
<%@ page import="es.taw.welkarten.dto.ConversacionDTO" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>MIS CHATS</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    </head>
    <%
        List<ConversacionDTO> misChats = (List<ConversacionDTO>)request.getAttribute("misChats");
    %>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
            <jsp:include page="Navbar.jsp" />
            <br>
            <div style="padding: 2% 15%">
                
          
        <!-- TABLA DE PETICIONES -->
                    <table class="table">
                        <thead class = "table-primary">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Teleoperador</th>
                                <th scope="col">Usuario</th>
                                <th scope="col">Chat</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for(ConversacionDTO c : misChats) {
                                    if(!c.getMensaje().isEmpty()) {
                            %>            
                                        <tr>
                                        <th scope="row">1</th>
                                        <td><%= c.getTeleoperador().getNombre() %></td>
                                        <td><%= c.getUsuario().getNombre() %></td>
                                        <td><button class="btn btn-outline-primary" type="submit" onclick="location.href = '/teleoperador/linkChat/<%= c.getId() %>'">Abrir chat</button></td>
                                        </tr> 
                            <%        
                                    }
                                }
                            %>    
                            
                        </tbody>
                    </table>
                              </div>
    </body>
</html>

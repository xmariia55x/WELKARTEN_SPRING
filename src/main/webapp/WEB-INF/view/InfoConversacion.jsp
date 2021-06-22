<%-- 
    Document   : InfoConversacion
    Created on : 12-may-2021, 11:36:26
    Author     : adric
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@ page import="es.taw.welkarten.entity.Usuario" %>
<%@ page import="es.taw.welkarten.entity.Conversacion" %>
<%@ page import="es.taw.welkarten.entity.Mensaje" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>INFO CONVERSACION</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <!--<link href="stylesTeleoperador.css" rel="stylesheet"> -->
    </head>

    <%
        Usuario user = (Usuario) session.getAttribute("usuario");
        Conversacion conversacion = (Conversacion) request.getAttribute("conversacion");
        List<Mensaje> mensajes = (List<Mensaje>) request.getAttribute("listaMensajes");
    %>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <jsp:include page="Navbar.jsp" />
        <br>
        <br>


        <div style="padding: 2% 15%">
        <div class="card mb-3" style="max-width: 1200px;">
            <div class="row g-0">
                <div class="col-md-4">
                    <img src="images/conversation2.jpg" alt="..." style="max-width: 400px;">
                </div>
                <div class="col-md-8">
                    <div class="card-body" style="padding:2% 20%; text-align: left">
                        <h5 class="card-title">Información de la conversación <%= conversacion.getId()%></h5>
                        <p class="card-text">Usuario: <%= conversacion.getUsuario().getNombre()%></p>
                        <p class="card-text"><small class="text-muted">Correo: <%= conversacion.getUsuario().getCorreo()%></small></p> 
                        <p class="card-text"><small class="text-muted">NIF: <%= conversacion.getUsuario().getNif()%></small></p> 
                        <p class="card-text">Teleoperador: <%= conversacion.getTeleoperador().getNombre()%></p>
                        <p class="card-text"><small class="text-muted">Correo: <%= conversacion.getTeleoperador().getCorreo()%></small></p> 
                        <p class="card-text"><small class="text-muted">NIF: <%= conversacion.getTeleoperador().getNif()%></small></p> 
                    </div>
                </div>
            </div>
        </div>
        </div>
        <!--TABLA DE LOS MENSAJES -->      
        <div style="padding: 2% 15%">


            <table class="table">
                <thead class = "table-primary">
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">ID mensaje</th>
                        <th scope="col">Cuerpo</th>
                        <th scope="col">Emisor</th>
                        <th scope="col">Fecha</th>
                        <th scope="col">Hora</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int i = 1;
                        for (Mensaje m : mensajes) {
                    %>
                    <tr>
                        <th scope="row"><%= i%></th>
                        <td><%= m.getId()%></td>
                        <td><%= m.getCuerpo()%></td>
                        <td><%= m.getEmisor().getNombre()%></td>
                        <td><%= new SimpleDateFormat("dd/MM/yyyy").format(m.getFecha())%></td>
                        <td><%= new SimpleDateFormat("hh:mm").format(m.getHora())%></td>
                    </tr>
                    <%
                            i++;
                        }
                    %>


                </tbody>
            </table>
        </div>    
    </body>
</html>

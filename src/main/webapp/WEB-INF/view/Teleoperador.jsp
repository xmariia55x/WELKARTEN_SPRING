<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
    Document   : Teleoperador
    Created on : 25-abr-2021, 12:20:13
    Author     : adric
--%>

<%@page import="java.util.List"%>
<%@ page import="es.taw.welkarten.entity.Usuario" %>
<%@ page import="es.taw.welkarten.dto.ConversacionDTO" %>
<%@ page import="es.taw.welkarten.dto.UsuarioDTO" %>

<html>
    <head>
        <title>TELEOPERADOR</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="stylesTeleoperador.css" rel="stylesheet">
        
    </head>
    
    <%
        UsuarioDTO user = (UsuarioDTO) session.getAttribute("usuario");
        List <ConversacionDTO> conversaciones = (List<ConversacionDTO>) request.getAttribute("conversaciones");
    %>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
            <jsp:include page="Navbar.jsp" />
            
            <form:form action="/teleoperador/filtrarConversacion" method="post" modelAttribute="filtro">
                <div class="filtros">
                <div class="form-floating">
                    <form:input path="teleoperador" class="form-control" id="filtroTeleoperador" name="filtroTeleoperador" placeholder="Password"></form:input>
                    <label>Filtrar teleoperador</label>
                </div>
                    <div class="form-floating">
                        <form:input path="usuario" type="text" class="form-control" id="filtroUsuario" name ="filtroUsuario" placeholder="Password"></form:input>
                        <label>Filtrar usuario</label>
                    </div>
                </div>
                <br/>

                <div class="d-grid gap-2 col-6 mx-auto">
                    <input type="submit" class="btn btn-primary btn-lg" value="Filtrar" name="filtrarTele"/>
                </div>

            </form:form>

                <!-- TABLA DE CONVERSACIONES -->
                <div style="padding: 2% 15%">
                    <table class="table">
                        <thead class = "table-primary">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Conversación</th>
                                <th scope="col">Teleoperador</th>
                                <th scope="col">Usuario</th>
                                <th scope="col">Info</th>
                                <th scope="col">Eliminar</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int i = 1;
                                for(ConversacionDTO c : conversaciones) {
                                    if(!c.getMensaje().isEmpty()) {
                            %>
                                        <tr>
                                        <th scope="row"><%= i %></th>
                                        <td><%= c.getId() %></td>
                                        <td><%= c.getTeleoperador().getNombre() %></td>
                                        <td><%= c.getUsuario().getNombre() %></td>
                                        <td><button class="btn btn-outline-primary" type="submit" onclick="location.href = '/teleoperador/infoConversacion/<%= c.getId() %>'">Info</button></td>
                                        <td><button class="btn btn-outline-danger" type="submit" onclick="location.href = '/teleoperador/eliminarConversacion/<%= c.getId() %>'">Eliminar</button></td>
                                        </tr>
                            <%
                                    }
                                i++;
                                }
                            %>
                            
                            
                        </tbody>
                    </table>
                </div>
                <!-- GRUPO DE BOTONCITOS -->
                <div class="d-grid gap-2 col-6 mx-auto">
                
                <input type="button" class="btn btn-primary btn-lg" id="peticiones_teleoperador" value="Peticiones" name="peticiones_teleoperador"
                                       onclick="location.href = '/teleoperador/cargaPeticiones'" />
                   
                <input type="button" class="btn btn-primary btn-lg" id="chats_teleoperador" value="Ver mis chats" name="chats_teleoperador"
                                       onclick="location.href = '/teleoperador/listaMisChats'" />
                </div>
              
                <br/>
    </body>
</html>

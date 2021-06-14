<%-- 
    Document   : Teleoperador
    Created on : 25-abr-2021, 12:20:13
    Author     : adric
--%>

<%@page import="java.util.List"%>
<%@page import="GestorEventos2021.entity.Conversacion"%>
<%@page import="GestorEventos2021.entity.Usuario"%>
<html>
    <head>
        <title>TELEOPERADOR</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="stylesTeleoperador.css" rel="stylesheet">
        
    </head>
    
    <%
        Usuario user = (Usuario)session.getAttribute("usuario");
        List <Conversacion> conversaciones = (List) request.getAttribute("listaConversaciones");
    %>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
            <jsp:include page="Navbar.jsp" />
            
            
            <form action="ServletListarConversaciones"> 
                <div class="filtros">
                <div class="form-floating">
                    <input type="text" class="form-control" id="filtroTeleoperador" name="filtroTeleoperador" placeholder="Password">
                    <label for="text">Filtrar teleoperador</label>
                </div>
                
                <div class="form-floating">
                    <input type="text" class="form-control" id="filtroUsuario" name ="filtroUsuario" placeholder="Password">
                    <label for="text">Filtrar usuario</label>
                </div>
                
                </div>
                <br/>
                
                <div class="d-grid gap-2 col-6 mx-auto">
                    <input type="submit" class="btn btn-primary btn-lg" id="filtrarTele" value="Filtrar" name="filtrarTele"/>
                </div>                    
            </form>
            
            
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
                                for(Conversacion c : conversaciones) {
                                    if(!c.getMensajeList().isEmpty()) {
                            %>
                                        <tr>
                                        <th scope="row"><%= i %></th>
                                        <td><%= c.getId() %></td>
                                        <td><%= c.getTeleoperador().getNombre() %></td>
                                        <td><%= c.getUsuario().getNombre() %></td>
                                        <td><button class="btn btn-outline-primary" type="submit" onclick="location.href = 'ServletInfoConversacion?id=<%= c.getId() %>'">Info</button></td>
                                        <td><button class="btn btn-outline-danger" type="submit" onclick="location.href = 'ServletEliminarConversacion?id=<%= c.getId() %>'">Eliminar</button></td>
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
                                       onclick="location.href = 'ServletCargarPeticiones'" />
                   
                <input type="button" class="btn btn-primary btn-lg" id="chats_teleoperador" value="Ver mis chats" name="chats_teleoperador"
                                       onclick="location.href = 'ServletListarMisChats'" />
                </div>
              
                <br/>
    </body>
</html>

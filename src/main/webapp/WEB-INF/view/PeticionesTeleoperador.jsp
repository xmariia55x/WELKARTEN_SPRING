
<%@ page import="java.util.List" %>
<%@ page import="es.taw.welkarten.dto.ConversacionDTO" %><%--
    Document   : PeticionesTeleoperador
    Created on : 25-abr-2021, 13:44:24
    Author     : adric
--%>



<html>
    <head>
        <title>PETICIONES</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    </head>
    <%
        List<ConversacionDTO> peticiones = (List<ConversacionDTO>)request.getAttribute("listaPeticiones");
    %>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <jsp:include page="Navbar.jsp" />
            
        <br>
        
        
            <!-- TABLA DE PETICIONES -->
            <div style="padding: 2% 15%">
                
            
                    <table class="table">
                        <thead class = "table-primary">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Teleoperador</th>
                                <th scope="col">Usuario</th>
                                <th scope="col">Conectar</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for(ConversacionDTO c : peticiones) {
                                    if(c.getMensaje().isEmpty()) {
                            %>            
                                        <tr>
                                        <th scope="row">1</th>
                                        <td><%= c.getTeleoperador().getNombre() %></td>
                                        <td><%= c.getUsuario().getNombre() %></td>
                                        <td><button class="btn btn-outline-primary" type="submit" onclick="location.href = '/teleoperador/iniciarConversacion/<%= c.getId() %>'">Aceptar Peticion</button></td>
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

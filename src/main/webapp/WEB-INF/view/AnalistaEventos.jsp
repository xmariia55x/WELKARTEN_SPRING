<%@page import="java.util.List"%>
<%@ page import="es.taw.welkarten.entity.Usuario" %>

<%@ page import="es.taw.welkarten.entity.Estudio" %>
<%@ page import="es.taw.welkarten.dto.UsuarioDTO" %>
<%@ page import="es.taw.welkarten.dto.EstudioDTO" %>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates eee
and open the template in the editor.fcxddxdnjnjjnjnj
-->
<html>
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="styles.css" rel="stylesheet">
        <title>Analista Eventos</title>
    </head>
    
        <%
            //------
            //Cambia esto que tiene que ser DTO cuando ya lo cambien !!!!!
            //------

            UsuarioDTO user = (UsuarioDTO) session.getAttribute("usuario");
            List <EstudioDTO> estudios = (List) request.getAttribute("estudios");
            
        %>
    
    <body>  
        
       
        <!-- Optional JavaScript; choose one of the two! -->

        <!-- Option 1: Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

        <!-- Option 2: Separate Popper and Bootstrap JS -->
        <!--
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js" integrity="sha384-SR1sx49pcuLnqZUnnPwx6FCym0wLsk5JZuNx2bPPENzswTNFaQU1RDvt3wT4gWFG" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.min.js" integrity="sha384-j0CNLUeiqtyaRmlzUHCPZ+Gy5fQu0dQ6eZ/xAww941Ai1SxSY+0EQqNXNE6DZiVc" crossorigin="anonymous"></script>
        -->
        
        <jsp:include page="Navbar.jsp" />
            
                <br>
                <br>

        <form>
            
            <div style="padding: 0% 10%;" class="analistaGlobal">
                <!-- TABLA DE CONVERSACIONES -->
                <table  class="table">
                        <thead class = "table-primary">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Descripcion estudio</th>
                                <th scope="col">Hacer copia</th>
                                <th scope="col">Modificar estudio</th> 
                                <th scope="col">Info estudio</th>
                                <th scope="col">Eliminar estudio</th>                                
                            </tr>
                        </thead>
                        <tbody>
                            
                            <%
                                for(EstudioDTO e: estudios) {
                                %>
                                <tr>
                                    <td> <%= e.getId() %> </td>                                    
                                    <td> <%= e.getDescripcion()%> </td>
                                    <td><button class="btn btn-outline-primary copia" type="button" onclick="location.href = '/analista/copiar/<%=e.getId()%>'">  Hacer copia</button></td>
                                    <td><button class="btn btn-outline-primary modificar" type="button" onclick="location.href = '/analista/modificar/<%=e.getId()%>'">  Modificar</button></td>
                                    <td><button class="btn btn-outline-primary info" type="button" onclick="location.href = '/analista/info/<%=e.getId()%>'">Info</button></td>
                                    <td><button class="btn btn-outline-danger eliminar" type="button" onclick="location.href = '/analista/eliminar/<%=e.getId()%>'">Eliminar</button></td>>
                                </tr>
                                <%
                                }
                                    %>
                        </tbody>
                    </table>

                <div class="d-grid gap-2 col-6 mx-auto">
                    <button type="button" class="btn btn-primary btn-lg" onclick="location.href = '/analista/crear'">Crear estudio</button>
                </div>
            </div>
        </form>
    </body>
</html>

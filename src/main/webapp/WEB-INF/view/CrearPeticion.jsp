<%-- 
    Document   : CrearPeticion
    Created on : 14-may-2021, 10:44:58
    Author     : adric
--%>

<%@page import="java.util.List"%>
<%@page import="GestorEventos2021.entity.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>CREAR PETICION</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <!--<link href="stylesTeleoperador.css" rel="stylesheet"> -->
    </head>

    <%
        List<Usuario> listaTeleoperadores = (List<Usuario>) request.getAttribute("listaTeleoperadores");
        String done = (String) request.getAttribute("done");
    %>

    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <jsp:include page="Navbar.jsp" />
     
        <div style="padding: 2% 20%">
            <div style="text-align: center">
                <form action = "ServletGuardarConversacion">
                    Elige un teleoperador: <select name="teleoperador">
                        <%
                            for (Usuario u : listaTeleoperadores) {
                        %>
                        <option value = "<%= u.getId()%>"> <%= u.getNombre()%> </option>
                        <%
                            }
                        %>

                    </select>
                    <br/>
                    <br/>
                    <div class="d-grid gap-2">
                        <input type="submit" class="btn btn-primary btn-lg" value="Crear Peticion" name="Crear Peticion" />
                    </div>
                    <br/>
                </form>


                <br/>


                <p class="fw-normal">O bien, puede ver los chats que ya tenga iniciados</p>



                <form action="ServletListarMisChats">
                    <div class="d-grid gap-2">
                        <input type="submit" class="btn btn-primary btn-lg" value="Ver chats" name="Ver chats" />
                    </div>
                </form>

            </div>
        </div>
    </body>
</html>

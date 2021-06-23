<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
    Document   : CrearPeticion
    Created on : 14-may-2021, 10:44:58
    Author     : adric
--%>

<%@page import="java.util.List"%>
<%@ page import="es.taw.welkarten.dto.UsuarioDTO" %>
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
        //List<UsuarioDTO> listaTeleoperadores = (List<UsuarioDTO>) request.getAttribute("listaTeleoperadores");
        String done = (String) request.getAttribute("done");
    %>

    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <jsp:include page="Navbar.jsp" />
     
        <div style="padding: 2% 20%">
            <div style="text-align: center">
                <form:form modelAttribute="teleoperador" method="post" action = "/guardarConversacion">
                    Elige un teleoperador:
                    <form:select path="id">
                        <form:options items="${listaTeleoperadores}" itemLabel="nombre" itemValue="id"></form:options>
                    </form:select>
                    <br/>
                    <br/>
                    <div class="d-grid gap-2">
                        <input type="submit" class="btn btn-primary btn-lg" value="Crear Peticion" name="Crear Peticion" />
                    </div>
                    <br/>
                </form:form>


                <br/>


                <p class="fw-normal">O bien, puede ver los chats que ya tenga iniciados</p>



                <form action="/teleoperador/listaMisChats">
                    <div class="d-grid gap-2">
                        <input type="submit" class="btn btn-primary btn-lg" value="Ver chats" name="Ver chats" />
                    </div>
                </form>

            </div>
        </div>
    </body>
</html>

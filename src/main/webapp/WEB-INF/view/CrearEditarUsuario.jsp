<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
    Document   : CrearEditarUsuario
    Created on : 25-abr-2021, 13:11:05
    Author     : maria
--%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Usuario</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="/css/styles.css" rel="stylesheet">
    </head>
    <% 
        String error = (String) request.getAttribute("error");
    %>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <!-- BARRA DE NAVEGACION -->
        <jsp:include page="Navbar.jsp" />
        <br>
        <br>
        <br>

        <!-- FORMULARIO PARA CREAR UN NUEVO EVENTO -->
        <div class="global_nuevo_evento">
            <form:form method="POST" action="/administrador/guardarUsuario" modelAttribute="usuarioDTO" >
                <%
                    if (error != null && error.equals("contraseniaIncorrecta")) {
                %>

                <div class="alert alert-danger" role="alert">
                    Las contraseñas no coinciden.
                </div>
                <%
                }
                %>
                <form:hidden path="id"></form:hidden>
                <div class="mb-3">
                    <label class="form-label">Nombre del usuario</label>
                    <form:input type="text" path="nombre" class="form-control" required="required"></form:input>
                </div>
                <div class="mb-3">
                    <label class="form-label">NIF del usuario</label>
                    <form:input type="text" path="nif" class="form-control" maxlength="9" size="9" required="required"></form:input>
                </div>

                <div class="mb-3" style="text-align: left">
                    <label class="form-label">Rol del usuario</label> <br/>
                    <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                        <form:radiobutton path="rol" value="3" class="btn-check" id="3" />
                        <label for="3" class="btn btn-outline-primary">Analista de eventos</label>

                        <form:radiobutton path="rol" value="5" class="btn-check" id="5" />
                        <label for="5" class="btn btn-outline-primary">Teleoperador</label>

                        <form:radiobutton path="rol" value="2" class="btn-check" id="2" />
                        <label for="2" class="btn btn-outline-primary">Creador de eventos</label>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Correo electrónico</label>
                    <form:input type="email" path="correo" class="form-control" placeholder="email@example.com" required="required"></form:input>
                </div>

                <div class="mb-3">
                    <label class="form-label">Contraseña</label>
                    <form:input type="password" path="password" class="form-control" required="required"></form:input>
                </div>

                <div class="mb-3">
                    <label class="form-label">Repetir contraseña</label>
                    <form:input type="password" path="contraseniaRepetida" class="form-control" required="required"></form:input>
                </div>

                <div class="d-grid gap-2 col-6 mx-auto">
                    <button type="submit" class="btn btn-primary btn-lg">Guardar cambios</button>
                </div>

            </form:form>


        </div>
    </body>

    
</html>

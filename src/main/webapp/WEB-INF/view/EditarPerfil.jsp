<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
    Document   : EditarPerfil
    Created on : 11-may-2021, 15:55:03
    Author     : maria
    ..
--%>

<%@ page import="es.taw.welkarten.dto.UsuarioDTO" %>
<%@ page import="es.taw.welkarten.dto.UsuarioeventosDTO" %>


<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
          crossorigin="anonymous">
    <!--<link href="styleVerPerfil.css" rel="stylesheet">-->
    <link href="/css/styles.css" rel="stylesheet">
    <title>Editar perfil</title>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<jsp:include page="Navbar.jsp"/>
<br>
<br>
<br>

<div class="global_editar_perfil_usuario_eventos">
    <%
        UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("usuario");
        UsuarioeventosDTO usuarioeventosDTO = null;
        if(usuario.getUsuarioeventos() != null) usuarioeventosDTO = usuario.getUsuarioeventos();
        String strError = (String) request.getAttribute("error");
        boolean esUsuarioEventos = false;
        if (strError != null) {
            if (strError.equals("contraseniaNoCoincide")) { %>

    <div class="alert alert-danger" role="alert">
        ERROR: Las contraseñas no coinciden.
    </div>
    <% }
    }

        if (usuario == null) {
        } else {
            esUsuarioEventos = usuario.getRol() == 4;

        }
    %>

    <form:form method="POST" action="/usuario/guardarInformacionPerfil" modelAttribute="usuarioDTO">
        <form:hidden path="id"></form:hidden>
        <div class="mb-3">
            <label class="form-label">Nombre</label>
            <form:input path="nombre" class="form-control" maxlength="50" required="required"></form:input>
        </div>
        <%
            if (esUsuarioEventos) {
        %>
        <div class="mb-3">
            <label class="form-label">Apellidos</label>
            <form:input path="usuarioeventos.apellidos" class="form-control" maxlength="50"
                        required="required"></form:input> </div>
            <%
                }
            %>

        <div class="mb-3">
            <label class="form-label">NIF</label>
            <form:input path="nif" class="form-control" maxlength="9" size="9" required="required"></form:input>

        </div>
        <%
            if (esUsuarioEventos) {
        %>
        <div class="mb-3">
            <label class="form-label">Sexo</label> <br/>
            <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                <form:radiobutton path="usuarioeventos.sexo" value="H" id="hombre" class="btn-check"/>
                <label for="hombre" class="btn btn-outline-primary">Hombre</label>

                <form:radiobutton path="usuarioeventos.sexo" value="M" id="mujer" class="btn-check"/>
                <label for="mujer" class="btn btn-outline-primary">Mujer</label>

                <form:radiobutton path="usuarioeventos.sexo" value="O" id="otro" class="btn-check"/>
                <label for="otro" class="btn btn-outline-primary">Otro</label>
            </div>

        </div>
        <div class="mb-3">
            <label class="form-label">Fecha de nacimiento</label>

            <form:input type="date" value="<%=usuarioeventosDTO.getFechaNacimiento()%>" path="usuarioeventos.fechaNacimientoFake" class="form-control" required="required"></form:input>
        </div>

        <div class="mb-3">
            <label class="form-label">Domicilio</label>
            <form:input path="usuarioeventos.domicilio" class="form-control" maxlength="100"
                        required="required"></form:input>

        </div>

        <div class="mb-3">
            <label class="form-label">Ciudad</label>
            <form:input path="usuarioeventos.ciudad" class="form-control" maxlength="50"
                        required="required"></form:input>
        </div>
        <%
            }
        %>
        <div class="mb-3">
            <label class="form-label">Correo electrónico</label>
            <form:input path="correo" class="form-control" maxlength="50" required="required"></form:input>
        </div>
        <div class="mb-3">
            <label class="form-label">Contraseña</label>
            <form:password path="password" class="form-control" maxlength="50" required="required"></form:password>
        </div>

        <div class="mb-3">
            <label class="form-label">Repetir contraseña</label>
            <form:password path="contraseniaRepetida" class="form-control" maxlength="50"
                           required="required"></form:password>
        </div>
        <div class="d-grid gap-2 col-6 mx-auto">
            <button type="submit" class="btn btn-primary btn-lg">Guardar cambios</button>
        </div>
    </form:form>


    <br>

    <div class="d-grid gap-2 col-6 mx-auto">
        <button type="button" class="btn btn-danger btn-lg" onclick="location.href='/usuario/borrarPerfil'">Eliminar
            perfil
        </button>
    </div>


</div>


</body>
</html>

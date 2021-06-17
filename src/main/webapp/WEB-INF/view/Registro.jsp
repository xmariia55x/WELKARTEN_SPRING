<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
    Document   : Registro
    Created on : 10-abr-2021, 13:02:12
    Author     : yeray
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Registro</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="/css/styles.css" rel="stylesheet">
    </head>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <div class="global_registro">
            <img src="/images/logo_pequeno.png" width="400" height="100">
        <%
            String strError = (String)request.getAttribute("error");
            
            if(strError != null) {
                if(strError.equals("v")) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        ERROR: Las contraseñas no coinciden
                    </div>
                    <%    
                    }
            }
            %>
            <form:form method="POST" action="/usuarioeventos/guardarUsuario" modelAttribute="usuarioEDTO">
                <form:hidden path="id"></form:hidden>

                <div class="mb-3">
                    <label class="form-label">Nombre</label>
                    <form:input path="usuario.nombre" class="form-control" maxlength="50" required="required"></form:input>
                </div>

                <div class="mb-3">
                    <label class="form-label">Apellidos</label>
                    <form:input path="apellidos" class="form-control" maxlength="50" required="required"></form:input>

                </div>
                <div class="mb-3">
                    <label class="form-label">NIF</label>
                    <form:input path="usuario.nif" class="form-control" maxlength="9" size="9" required="required"></form:input>

                </div>

                <div class="mb-3">
                    <label class="form-label">Sexo</label> <br/>
                    <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                        <form:radiobutton path="sexo" value="H" id="hombre" class="btn-check" />
                        <label for="hombre" class="btn btn-outline-primary">Hombre</label>

                        <form:radiobutton path="sexo" value="M" id="mujer" class="btn-check" />
                        <label for="mujer" class="btn btn-outline-primary">Mujer</label>

                        <form:radiobutton path="sexo" value="O" id="otro" class="btn-check" />
                        <label for="otro" class="btn btn-outline-primary">Otro</label>
                    </div>

                </div>
                <div class="mb-3">
                    <label class="form-label">Fecha de nacimiento</label>
                    <form:input type="date" path="fechaNacimiento" class="form-control" required="required"></form:input>
                </div>

                <div class="mb-3">
                    <label class="form-label">Domicilio</label>
                    <form:input path="domicilio" class="form-control" maxlength="100" required="required"></form:input>

                </div>

                <div class="mb-3">
                    <label class="form-label">Ciudad</label>
                    <form:input path="ciudad" class="form-control" maxlength="50" required="required"></form:input>
                </div>

                <div class="mb-3">
                    <label class="form-label">Correo electrónico</label>
                    <form:input path="usuario.correo" class="form-control" maxlength="50" required="required"></form:input>
                </div>
                <div class="mb-3">
                    <label class="form-label">Contraseña</label>
                    <form:password path="usuario.password" class="form-control" maxlength="50" required="required"></form:password>
                </div>

                <div class="mb-3">
                    <label class="form-label">Repetir contraseña</label>
                    <form:password path="contraseniaRepetida" class="form-control" maxlength="50" required="required"></form:password>
                </div>
                <div class="d-grid gap-2 col-6 mx-auto">
                    <button type="submit" class="btn btn-primary btn-lg">Regístrate</button>
                </div>
            </form:form>
        </div>
    </body>
</html>

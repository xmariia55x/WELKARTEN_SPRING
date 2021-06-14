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
        <link href="styles.css" rel="stylesheet">
    </head>
    <% 
        Boolean crear = true;
        String crearOEditar = "Crear usuario";
        if(!crear){
            crearOEditar = "Editar usuario";
        }
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
            <form name="CrearEditarUsuarioForm">
                <div class="mb-3">
                    <label for="exampleDropdownFormEmail2" class="form-label">Nombre del usuario</label>
                    <input type="text" name="nombre_usuario" class="form-control" id="nombre_usuario" required>
                </div>
                <div class="mb-3">
                    <label for="exampleDropdownFormEmail2" class="form-label">NIF del usuario</label>
                    <input type="text" name="nif_usuario" class="form-control" id="nif_usuario" required>
                </div>

                <div class="mb-3">
                    <label for="exampleDropdownFormEmail2" class="form-label">Correo electrónico</label>
                    <input type="email" name="correo_usuario" class="form-control" id="email_usuario_registrado" placeholder="email@example.com" required>
                </div>

                <div class="mb-3">
                    <label for="exampleDropdownFormPassword2" class="form-label">Contraseña</label>
                    <input type="password" name="contrasena1_usuario" class="form-control" id="contrasenia_usuario_registrado" required>
                </div>

                <div class="mb-3">
                    <label for="exampleDropdownFormPassword2" class="form-label">Repetir contraseña</label>
                    <input type="password" name="contrasena2_usuario" class="form-control" id="contrasenia_usuario_registrado_repetida" required>
                </div>

                <div class="mb-3">
                    <label for="exampleDropdownFormEmail2" class="form-label">Rol usuario</label> <br/>
                    <input class="form-check-input" type="radio" name="seleccion_rol" value="2" />Creador de eventos<br>
                    <input class="form-check-input" type="radio" name="seleccion_rol" value="3" />Analista<br>
                    <input class="form-check-input" type="radio" name="seleccion_rol" value="5" />Teleoperador<br>

                </div>

                <div class="d-grid gap-2 col-6 mx-auto">
                    <button type="submit" class="btn btn-primary btn-lg"><%= crearOEditar %></button>
                </div>
            </form>
        </div>
    </body>

    
</html>

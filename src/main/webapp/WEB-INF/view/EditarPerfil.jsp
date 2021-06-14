<%-- 
    Document   : EditarPerfil
    Created on : 11-may-2021, 15:55:03
    Author     : maria
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="GestorEventos2021.entity.Usuarioeventos"%>
<%@page import="GestorEventos2021.entity.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <!--<link href="styleVerPerfil.css" rel="stylesheet">-->
        <link href="styles.css" rel="stylesheet">
        <title>Editar perfil</title>
    </head>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <jsp:include page="Navbar.jsp" />
        <br>
        <br>
        <br>
      
        <div class="global_editar_perfil_usuario_eventos">
            <%
                Usuario usuario = (Usuario) session.getAttribute("usuario");
                String strError = (String) request.getAttribute("error");
                if (strError != null) {
                    if (strError.equals("contraseniaNoCoincide")) { %>

            <div class="alert alert-danger" role="alert">
                ERROR: Las contraseñas no coinciden.
            </div>
            <%        }
                }

                if (usuario == null) {
                } else {
                    boolean esUsuarioEventos = usuario.getRol() == 4;
                    Usuarioeventos usuarioEventos = null;
                    String seleccionM = "", seleccionH = "", seleccionO = "";
                    DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                    String fechaNacimiento = null;
                    if (esUsuarioEventos) {
                        usuarioEventos = usuario.getUsuarioeventos();
                        if (usuarioEventos.getSexo().equals("M")) {
                            seleccionM = "checked";
                        } else if (usuarioEventos.getSexo().equals("H")) {
                            seleccionH = "checked";
                        } else if (usuarioEventos.getSexo().equals("O")) {
                            seleccionO = "checked";
                        }
                        

                        fechaNacimiento = formatter.format(usuarioEventos.getFechaNacimiento());
                    }
            %>

            <form action="ServletEditarInformacionUsuario" method="POST">
                <input type="hidden" name="idUsuario" value="<%= usuario.getId()%>" />
                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label" >Nombre</label>
                    <input type="text" name="nombre_usuario" class="form-control" id="nombre_usuario_registrado" value="<%= usuario.getNombre()%>" maxlength="50" required>
                </div>

                <%
                    if (esUsuarioEventos) {

                %>
                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label">Apellidos</label>
                    <input type="text" name="apellidos_usuario" class="form-control" id="apellidos_usuario_registrado" value="<%= usuarioEventos.getApellidos()%>" maxlength="50" required>
                </div>
                <%
                    }
                %>
                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label" >NIF</label>
                    <input type="text" name="nif_usuario" class="form-control" id="nif_usuario_registrado" value="<%= usuario.getNif()%>" required size="9" maxlength="9">
                </div> 
                <%
                    if (esUsuarioEventos) {
                %> 
                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label">Sexo</label> <br/>
                    <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                        <input type="radio" class="btn-check" name="radio_sexo" id="hombre" value="H" autocomplete="off" <%= seleccionH%>/>
                        <label class="btn btn-outline-primary" for="hombre">Hombre</label>

                        <input type="radio" class="btn-check" name="radio_sexo" id="mujer" value="M" autocomplete="off" <%= seleccionM%>/>
                        <label class="btn btn-outline-primary" for="mujer">Mujer</label>

                        <input type="radio" class="btn-check" name="radio_sexo" id="otro" value="O" autocomplete="off" <%= seleccionO%>/>
                        <label class="btn btn-outline-primary" for="otro">Otro</label>
                    </div> 

                </div>

                <div class="mb-3" style="text-align: left">
                    <label for="birthday" class="form-label">Fecha de nacimiento</label>
                    <input type="date" class="form-control" id="fecha_nacimiento" name="fecha_nacimiento_usuario" value="<%= fechaNacimiento%>" required>
                </div> 

                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label">Domicilio</label>
                    <input type="text" name="domicilio_usuario" class="form-control" id="domicilio_usuario_registrado" maxlength="100" value="<%= usuarioEventos.getDomicilio()%>" required>
                </div> 

                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label">Ciudad</label>
                    <input type="text" name="ciudad_usuario" class="form-control" id="ciudad_usuario_registrado" maxlength="50" value="<%= usuarioEventos.getCiudad()%>" required>
                </div>
                <%
                    }
                %>



                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label">Correo electrónico</label>
                    <input type="email" name="correo_usuario" class="form-control" id="email_usuario_registrado" maxlength="50" placeholder="email@example.com" value="<%= usuario.getCorreo()%>" required>
                </div>

                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormPassword2" class="form-label">Contraseña</label>
                    <input type="password" name="contrasena1_usuario" class="form-control" id="contrasenia_usuario_registrado" maxlength="50" value="<%= usuario.getPassword()%>" required>
                </div>

                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormPassword2" class="form-label">Repetir contraseña</label>
                    <input type="password" name="contrasena2_usuario" class="form-control" id="contrasenia_usuario_registrado_repetida" maxlength="50" required>
                </div>                
                <%

                    }

                %>


                <div class="d-grid gap-2 col-6 mx-auto">
                    <button type="submit" class="btn btn-primary btn-lg">Guardar cambios</button>
                </div>
            </form>
                <br>
            <form action="ServletEliminarPerfil">
                <!--<input type="hidden" name="idUsuario" value="<%= usuario.getId()%>" />-->
                <div class="d-grid gap-2 col-6 mx-auto">
                    <button type="submit" class="btn btn-danger btn-lg">Eliminar perfil</button>
                </div>
            </form>
        </div>
    </body>
</html>

<%-- 
    Document   : CrearUsuarioAdministrador
    Created on : 13-may-2021, 12:38:57
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
        <title>Nuevo usuario</title>
    </head>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <jsp:include page="Navbar.jsp" />
        <br>
        <br>
        <br>
        <br>
        <div class="global_editar_perfil_usuario_eventos">


            <form action="ServletCrearUsuarioAdministrador" method="POST">
                <%
                    Usuario usuario = (Usuario) request.getAttribute("usuario");
                    String strError = (String) request.getAttribute("error");
                    if (strError != null && strError.equals("contrasenaIncorrecta")) {
                %>
                <div class="alert alert-danger" role="alert">
                    ERROR: Las contraseñas no coinciden.
                </div>
                <%
                    }
                    String nombre = "", apellidos = "", correo = "", contrasenia = "",
                    rol2 = "", rol3 = "", rol5 = "", sexoH = "", sexoM = "", sexoO = "", nif = "", domicilio = "",
                    ciudad = "", fechaNacimiento = "", textoBtn = "Crear", id = "";
                    boolean usuarioEventos = false;
                    DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                    if(usuario != null){
                        id = usuario.getId().toString();
                        textoBtn = "Editar";
                        nombre = usuario.getNombre();
                        nif = usuario.getNif();
                        correo = usuario.getCorreo();
                        contrasenia = usuario.getPassword();
                        if(usuario.getRol() == 4){
                            usuarioEventos = true;
                            Usuarioeventos uEventos = usuario.getUsuarioeventos();
                            apellidos = uEventos.getApellidos();
                            domicilio = uEventos.getDomicilio();
                            ciudad = uEventos.getCiudad();
                            fechaNacimiento = formatter.format(uEventos.getFechaNacimiento());
                            if(uEventos.getSexo().equals("H")) sexoH = "checked";
                            else if (uEventos.getSexo().equals("M")) sexoM = "checked";
                            else if (uEventos.getSexo().equals("O")) sexoO = "checked";
                        } else if(usuario.getRol() == 2) rol2 = "checked";
                          else if(usuario.getRol() == 3) rol3 = "checked";
                          else if (usuario.getRol() == 5) rol5 = "checked";
                    }
                %>
                <input type="hidden" name="id" value="<%= id%>"/>
                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label" >Nombre</label>
                    <input type="text" name="nombre_usuario" class="form-control" value="<%= nombre%>" maxlength="50" required>
                </div>

                <%
                    if (usuarioEventos) {

                %>
                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label">Apellidos</label>
                    <input type="text" name="apellidos_usuario" class="form-control" value="<%= apellidos%>" maxlength="50" required>
                </div>    
                <% 
                    }
                %>

                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label" >NIF</label>
                    <input type="text" name="nif_usuario" class="form-control" value="<%= nif%>" size="9" maxlength="9" required>
                </div> 

                <% 
                    if (usuarioEventos){
                    
                %>
                    <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label">Sexo</label> <br/>
                    <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                        <input type="radio" class="btn-check" name="radio_sexo" id="hombre" value="H" autocomplete="off" <%= sexoH%>/>
                        <label class="btn btn-outline-primary" for="hombre">Hombre</label>

                        <input type="radio" class="btn-check" name="radio_sexo" id="mujer" value="M" autocomplete="off" <%= sexoM%>/>
                        <label class="btn btn-outline-primary" for="mujer">Mujer</label>

                        <input type="radio" class="btn-check" name="radio_sexo" id="otro" value="O" autocomplete="off" <%= sexoO%>/>
                        <label class="btn btn-outline-primary" for="otro">Otro</label>
                    </div> 

                </div>

                <div class="mb-3" style="text-align: left">
                    <label for="birthday" class="form-label">Fecha de nacimiento</label>
                    <input type="date" class="form-control" id="fecha_nacimiento" name="fecha_nacimiento_usuario" value="<%= fechaNacimiento%>" required>
                </div> 

                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label">Domicilio</label>
                    <input type="text" name="domicilio_usuario" class="form-control" maxlength="100" value="<%= domicilio%>" required>
                </div> 

                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label">Ciudad</label>
                    <input type="text" name="ciudad_usuario" class="form-control" maxlength="50" value="<%= ciudad%>" required>
                </div>
                <% 
                    }
                %>
                
                <% 
                    if(!usuarioEventos){
                    
                %>
                <div style="text-align: left">
                    <label>Selecciona el tipo de usuario</label> <br>
                </div>
                <div class="form-check" style="text-align: left">
                    <input class="form-check-input" type="radio" name="rol" value="3" id="Analista" <%= rol3%>>
                    <label class="form-check-label" for="Analista">
                        Analista de eventos
                    </label>
                </div>
                <div class="form-check" style="text-align: left">
                    <input class="form-check-input" type="radio" name="rol" value="5" id="Teleoperador" <%= rol5%>>
                    <label class="form-check-label" for="Teleoperador">
                        Teleoperador
                    </label>
                </div>

                <div class="form-check" style="text-align: left">
                    <input class="form-check-input" type="radio" name="rol" value="2" id="Creador" <%= rol2%>>
                    <label class="form-check-label" for="Creador">
                        Creador de eventos
                    </label>
                </div>
                
                <br>
                <% 
                    }
                %>
                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label">Correo electrónico</label>
                    <input type="email" name="correo_usuario" class="form-control" maxlength="50" value="<%= correo%>" placeholder="email@example.com" required>
                </div>

                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormPassword2" class="form-label">Contraseña</label>
                    <input type="password" name="contrasena1_usuario" class="form-control" value="<%= contrasenia%>" maxlength="50" required>
                </div>

                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormPassword2" class="form-label">Repetir contraseña</label>
                    <input type="password" name="contrasena2_usuario" class="form-control" maxlength="50" required>
                </div>                

                <div class="d-grid gap-2 col-6 mx-auto">
                    <button type="submit" class="btn btn-primary btn-lg"><%= textoBtn%></button>
                </div>
            </form>

        </div>
    </body>
</html>

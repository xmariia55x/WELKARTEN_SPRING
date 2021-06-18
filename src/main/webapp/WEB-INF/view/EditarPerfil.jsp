<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
    Document   : EditarPerfil
    Created on : 11-may-2021, 15:55:03
    Author     : maria
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@ page import="es.taw.welkarten.entity.Usuario" %>
<%@ page import="es.taw.welkarten.entity.Usuarioeventos" %>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <!--<link href="styleVerPerfil.css" rel="stylesheet">-->
        <link href="/css/styles.css" rel="stylesheet">
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
                Usuario usuario = (Usuario) request.getAttribute("usuario");
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
                }
            %>

<form:form method="POST" action="/usuario/guardarInformacion">
    <div class="d-grid gap-2 col-6 mx-auto">
        <button type="submit" class="btn btn-primary btn-lg">Guardar cambios</button>
    </div>
</form:form>


    <br>

    <div class="d-grid gap-2 col-6 mx-auto">
        <button type="button" class="btn btn-danger btn-lg" onclick="location.href='/usuario/borrarPerfil'">Eliminar perfil</button>
    </div>





</div>
</body>
</html>

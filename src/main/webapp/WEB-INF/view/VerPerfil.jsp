<%-- 
    Document   : VerPerfil
    Created on : 28-abr-2021, 11:29:34
    Author     : maria
--%>

<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="es.taw.welkarten.entity.Usuario" %>
<%@ page import="es.taw.welkarten.entity.Usuarioeventos" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="/css/styleVerPerfil.css" rel="stylesheet">
        <title>Mi perfil</title>
    </head>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <jsp:include page="Navbar.jsp" />
        <br>
        <br>
        <br>
        <br>
        <%
    Usuario usuario = (Usuario)session.getAttribute("usuario");
    if (usuario == null) {
    }else {   
        String rol = "";
        if(usuario.getRol() == 1) rol = "Administrador";
        else if(usuario.getRol() == 2) rol = "Creador de eventos";
        else if(usuario.getRol() == 3) rol = "Analista de eventos";
        else if(usuario.getRol() == 4) {
            rol = "Usuario de eventos";
         
        }
        else if(usuario.getRol() == 5) rol = "Teleoperador";
%>
        <div class="page-content page-container" id="page-content">
    <div class="padding">
        <div class="row container d-flex justify-content-center">
            <div class="col-xl-6 col-md-12">
                <div class="card user-card-full">
                    <div class="row m-l-0 m-r-0">
                        <div class="col-sm-4 bg-c-lite-green user-profile">
                            <div class="card-block text-center text-white">


                                <%
                                    if(usuario.getUsuarioeventos() != null && usuario.getUsuarioeventos().getSexo().equals("M")){
                                %>
                                <div class="m-b-25"><img src="https://img.icons8.com/bubbles/100/000000/user-female.png" class="img-radius"></div>
                                    <%
                                    } else if (usuario.getUsuarioeventos() != null && usuario.getUsuarioeventos().getSexo().equals("H")){
                                    %>
                                <div class="m-b-25"><img src="https://img.icons8.com/bubbles/100/000000/user.png" class="img-radius"></div>

                                        <%
                                        } else {
                                        %>
                                <div class="m-b-25"><img src="https://img.icons8.com/bubbles/75/000000/gender-neutral-user.png" class="img-radius"></div>

                                            <%
                                                }
                                            %>


                                            <h6 class="f-w-600"><%= usuario.getNombre()%></h6>
                                <p><%=rol%></p> <i class=" mdi mdi-square-edit-outline feather icon-edit m-t-10 f-16"></i>
                            </div>
                        </div>
                        <div class="col-sm-8">
                            <div class="card-block">
                                <h6 class="m-b-20 p-b-5 b-b-default f-w-600">Información</h6>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <p class="m-b-10 f-w-600">Email</p>
                                        <h6 class="text-muted f-w-400"><%= usuario.getCorreo()%></h6>
                                    </div>
                                    <div class="col-sm-6">
                                        <p class="m-b-10 f-w-600">NIF</p>
                                        <h6 class="text-muted f-w-400"><%= usuario.getNif()%></h6>
                                    </div>
                                </div>
        <% if(usuario.getRol() == 4) { 
            Usuarioeventos usuarioEventos = usuario.getUsuarioeventos();
            String sexo = "Hombre";
            if(usuarioEventos.getSexo().equals("M")) sexo = "Mujer";
            else if(usuarioEventos.getSexo().equals("O")) sexo = "Otro";
            DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            String fechaNacimiento = formatter.format(usuarioEventos.getFechaNacimiento());
        %>
                                <h6 class="m-b-20 m-t-40 p-b-5 b-b-default f-w-600">Más información</h6>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <p class="m-b-10 f-w-600">Apellidos</p>
                                        <h6 class="text-muted f-w-400"><%= usuarioEventos.getApellidos()%></h6>
                                    </div>
                                    <div class="col-sm-6">
                                        <p class="m-b-10 f-w-600">Sexo</p>
                                        <h6 class="text-muted f-w-400"><%= sexo%></h6>
                                    </div>
                                    <div class="col-sm-6">
                                        <p class="m-b-10 f-w-600">Fecha de nacimiento</p>
                                        <h6 class="text-muted f-w-400"><%= fechaNacimiento%></h6>
                                    </div>
                                    <div class="col-sm-6">
                                        <p class="m-b-10 f-w-600">Domicilio</p>
                                        <h6 class="text-muted f-w-400"><%= usuarioEventos.getDomicilio()%></h6>
                                    </div>
                                    <div class="col-sm-6">
                                        <p class="m-b-10 f-w-600">Ciudad</p>
                                        <h6 class="text-muted f-w-400"><%= usuarioEventos.getCiudad()%></h6>
                                    </div>
                                    
                                    
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<% 
}
}%>
<div id="divfix">
            <button type="button" class="w-100 btn btn-lg btn-primary" onclick="location.href = '/usuario/editarPerfil'">Editar perfil</button>
        </div>
    </body>
</html>

<%-- 
    Document   : Administrador
    Created on : 25-abr-2021, 13:29:58
    Author     : maria

--%>


<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>

<%@page import="java.util.List"%>
<%@ page import="es.taw.welkarten.entity.Usuario" %>
<%@ page import="es.taw.welkarten.entity.Evento" %>
<%@ page import="es.taw.welkarten.entity.Etiqueta" %>
<%@ page import="es.taw.welkarten.dto.UsuarioeventosDTO" %>
<%@ page import="es.taw.welkarten.dto.UsuarioDTO" %>
<%@ page import="es.taw.welkarten.dto.EventoDTO" %>
<%@ page import="es.taw.welkarten.dto.EtiquetaDTO" %>

<html>
    <head>
        <title>Administrador</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="/css/administradorStyles.css" rel="stylesheet">
        <link href="/css/tarjetasStyles.css" rel="stylesheet">
    </head>

    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <jsp:include page="Navbar.jsp" />
        <br>

        <%
            UsuarioDTO administrador = (UsuarioDTO) session.getAttribute("usuario");
            List<UsuarioDTO> usuarios = (List<UsuarioDTO>) request.getAttribute("listaUsuarios");
            List<EventoDTO> eventos = (List<EventoDTO>) request.getAttribute("listaEventos");
            List<EtiquetaDTO> etiquetas = (List<EtiquetaDTO>) request.getAttribute("listaEtiquetas");
            //DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        %>
        <h4 class="display-4" style="text-align: center">Panel de control de usuarios y eventos</h4>
        <br>
        <div style="padding: 2% 15%">


        <div class="usuarios">
            <!-- BOTONACO DE CREAR USUARIOS -->
            <div class="row-auto">
                <input type="submit" class="btn btn-primary mb-3 btn-lg" value="Crear usuario" onclick="location.href = '/administrador/crearUsuarioAdministrador'"/>
            </div>
            <div class="row text-center">

                <%
                    if (usuarios != null && !usuarios.isEmpty()) {
                    for(UsuarioDTO user : usuarios) {
                        String rol = "";

                        if (user.getRol() == 1) {
                            rol = "Administrador";
                        } else if (user.getRol() == 2) {
                            rol = "Creador de eventos";
                        } else if (user.getRol() == 3) {
                            rol = "Analista de eventos";
                        } else if (user.getRol() == 4) {
                            rol = "Usuario de eventos";

                        } else if (user.getRol() == 5) {
                            rol = "Teleoperador";
                        }
                %>
                <div class="col-xl-4 col-sm-6 mb-5">
                    <%
                        if(user.getUsuarioeventos() != null && user.getUsuarioeventos().getSexo().equals("M")){
                    %>
                    <div class="bg-white rounded shadow-sm py-5 px-4"><img src="https://img.icons8.com/bubbles/100/000000/user-female.png" alt="" width="100" class="img-fluid rounded-circle mb-3 img-thumbnail shadow-sm">
                    <%
                        } else if (user.getUsuarioeventos() != null && user.getUsuarioeventos().getSexo().equals("H")){
                    %>
                        <div class="bg-white rounded shadow-sm py-5 px-4"><img src="https://img.icons8.com/bubbles/100/000000/user.png" alt="" width="100" class="img-fluid rounded-circle mb-3 img-thumbnail shadow-sm">

                    <%
                        } else {
                    %>
                    <div class="bg-white rounded shadow-sm py-5 px-4"><img src="https://img.icons8.com/bubbles/75/000000/gender-neutral-user.png" alt="" width="100" class="img-fluid rounded-circle mb-3 img-thumbnail shadow-sm">

                     <%
                         }
                     %>

                        <h5 class="mb-0"><%=user.getNombre()%></h5>
                        <span class="small text-muted"><%=user.getNif()%></span><br>
                        <span class="small text-muted"><%=user.getCorreo()%></span><br>
                        <span class="small text-muted"><%=rol%></span><br>

                        <ul class="social mb-0 list-inline mt-3">
                            <li class="list-inline-item"><img src="https://img.icons8.com/bubbles/75/000000/edit.png" onclick="location.href='/administrador/editarUsuario/id'"/></li>
                            <li class="list-inline-item"><img src="https://img.icons8.com/bubbles/75/000000/delete-sign.png" onclick="location.href = '/administrador/eliminarUsuario/id'"/></li>
                        </ul>
                    </div>
                </div>
                <%
                    }
                    } else {
                %>
                        <div class="alert alert-warning" role="alert">
                            PRECAUCION: ¡No hay usuarios en el sistema!
                        </div>
                <%
                     }
                %>
            </div>
        </div>

          <div class="eventos">
              <div class="row-auto">
                  <input type="submit" class="btn btn-primary mb-3 btn-lg" value="Crear evento" onclick="location.href = '/administrador/crearEventoAdministrador'"/>
              </div>
                <div class="row text-center">

            <%
                if (eventos != null && !eventos.isEmpty()) {
                for(EventoDTO event : eventos) {
                    //String fechaInicio = formatter.format(event.getFechaInicio());
                    //String fechaLimite = formatter.format(event.getFechaReserva());
            %>
                    <div class="col-xl-4 col-sm-6 mb-5">
                        <div class="bg-white rounded shadow-sm py-5 px-4"><img src="https://img.icons8.com/bubbles/75/000000/calendar.png" alt="" width="100" class="img-fluid rounded-circle mb-3 img-thumbnail shadow-sm">
                            <h5 class="mb-0"><%=event.getTitulo()%></h5>
                            <span class="small text-muted">Fecha de inicio: <%=event.getFechaInicioString()%></span><br>
                            <span class="small text-muted">Fecha limite entradas: <%=event.getFechaReservaString()%></span><br>
                            <span class="small text-muted">Precio: <%=event.getCosteEntrada()%></span><br>
                            <span class="small text-muted">Aforo: <%=event.getAforo()%></span><br>
                            <ul class="social mb-0 list-inline mt-3">
                                <li class="list-inline-item"><img src="https://img.icons8.com/bubbles/75/000000/edit.png" onclick="location.href='/administrador/editarEvento/id/<%=event.getId()%>'"/></li>
                                <li class="list-inline-item"><img src="https://img.icons8.com/bubbles/75/000000/delete-sign.png" onclick="location.href = '/administrador/eliminarEvento/id/<%=event.getId()%>'"/></li>
                            </ul>
                        </div>
                    </div>
            <%
                }
                } else {
            %>
                    <div class="alert alert-warning" role="alert">
                        PRECAUCION: ¡No hay eventos en el sistema!
                    </div>
            <%
                }
            %>
                </div>
            </div>


        </div>
        <!--<script>
            var acc = document.getElementsByClassName("accordion");
            var i;

            for (i = 0; i < acc.length; i++) {
                acc[i].addEventListener("click", function () {
                    this.classList.toggle("active");
                    var panel = this.nextElementSibling;
                    if (panel.style.maxHeight) {
                        panel.style.maxHeight = null;
                    } else {
                        panel.style.maxHeight = panel.scrollHeight + "px";
                    }
                });
            }
        </script> -->
    </body>
</html>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
    Document   : Administrador
    Created on : 25-abr-2021, 13:29:58
    Author     : maria

--%>




<%@page import="java.util.List"%>

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
            //List<EtiquetaDTO> etiquetas = (List<EtiquetaDTO>) request.getAttribute("listaEtiquetas");

        %>
        <h4 class="display-4" style="text-align: center">Panel de control de usuarios y eventos</h4>
        <br>
        <div style="padding: 2% 15%">


        <div class="usuarios">
            <form:form method="POST" action="/administrador/filtrarNombreUsuario" modelAttribute="filtroUsuariosDTO">
                <div class="col-auto">
                    <form:input type="text" class="form-control" path="nombreUsuario" placeholder="Escribe el nombre del usuario aqui"></form:input>
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-primary mb-3">Buscar usuarios</button>
                </div>
                </form:form>
                <form:form method="POST" action="/administrador/filtrarRolUsuario" modelAttribute="filtroUsuariosDTO">
                <div class="row-auto">
                    <label class="accordion">Filtrar usuarios</label>
                    <div class="panel">
                        <div class="card-body p-4">
                            <div class="col-md-4 mb-3">

                                Rol del usuario:
                                <br>
                                <form:checkboxes items = "${roles}" path = "rolesSeleccionados" element="br"/>

                            </div>
                            <button type="submit" class="btn btn-primary">Filtrar
                                <svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                                </svg>
                            </button>
                        </div>

                    </div>
                </div>
                </form:form>
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
                            <li class="list-inline-item"><img src="https://img.icons8.com/bubbles/75/000000/edit.png" onclick="location.href='/administrador/editarUsuario/id/<%=user.getId()%>'"/></li>
                            <li class="list-inline-item"><img src="https://img.icons8.com/bubbles/75/000000/delete-sign.png" onclick="location.href = '/administrador/eliminarUsuario/id/<%=user.getId()%>'"/></li>
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
        <form:form method="POST" action="/administrador/filtrarNombreEvento" modelAttribute="filtroEventosDTO">
            <div class="col-auto">
                <form:input type="text" class="form-control" path="nombreEvento" placeholder="Escribe el nombre del evento aqui"></form:input>
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-primary mb-3">Buscar eventos</button>
            </div>
        </form:form>
        <form:form method="POST" action="/administrador/filtrarCategoriaEvento" modelAttribute="filtroEventosDTO">
                  <div class="row-auto">

                      <label class="accordion">Filtrar eventos</label>
                      <div class="panel">
                          <div class="card-body p-4">
                              <div class="col-md-4 mb-3">

                                  Categoria del evento:
                                  <br>
                                  <form:checkboxes items = "${etiquetas}" path = "etiquetasSeleccionadas" element="br"/>

                              </div>
                              <button type="submit" class="btn btn-primary">Filtrar
                                  <svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                      <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                                  </svg>
                              </button>
                          </div>

                      </div>
                  </div>
        </form:form>
              <div class="row-auto">
                  <input type="submit" class="btn btn-primary mb-3 btn-lg" value="Crear evento" onclick="location.href = '/administrador/crearEventoAdministrador'"/>
              </div>
                <div class="row text-center">

            <%
                if (eventos != null && !eventos.isEmpty()) {
                for(EventoDTO event : eventos) {
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
        <script>
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
        </script>
    </body>
</html>

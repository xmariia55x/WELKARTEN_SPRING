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

<html>
    <head>
        <title>Administrador</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="/css/administradorStyles.css" rel="stylesheet">
    </head>

    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <jsp:include page="Navbar.jsp" />
        <br>

        <%
            Usuario administrador = (Usuario) session.getAttribute("usuario");
            List<Usuario> usuarios = (List<Usuario>) request.getAttribute("listaUsuarios");
            List<Evento> eventos = (List<Evento>) request.getAttribute("listaEventos");
            List<Etiqueta> etiquetas = (List<Etiqueta>) request.getAttribute("listaEtiquetas");
        %>
        <h4 class="display-4" style="text-align: center">Panel de control de usuarios y eventos</h4>
        <br>
        <div style="padding: 2% 15%">


            <div class="row">
                <div class="column">
                    <form action="ServletListarEventosUsuariosAdministrador" class="row g-3">
                        <div class="col-auto">
                            <input type="hidden" name="buscarUsuarios" value="S"/>
                            <input type="text" class="form-control" name="nombreUsuario">
                        </div>
                        <div class="col-auto">
                            <button type="submit" class="btn btn-primary mb-3">Buscar usuarios</button>
                        </div>
                    </form> 
                    <form action="ServletListarEventosUsuariosAdministrador">
                        <input type="hidden" name="filrarUsuarios" value="S"/>
                        <div class="row-auto">
                            <label class="accordion">Filtrar usuarios</label>
                            <div class="panel">
                                <div class="card-body p-4">
                                    <div class="col-md-4 mb-3">

                                        Rol del usuario: 
                                        <br>
                                        <input type="checkbox" name="rolUsuario" value="1" /> Administrador <br>
                                        <input type="checkbox" name="rolUsuario" value="2" /> Creador de eventos <br>
                                        <input type="checkbox" name="rolUsuario" value="3" /> Analista de eventos <br>
                                        <input type="checkbox" name="rolUsuario" value="4" /> Usuario de eventos <br>
                                        <input type="checkbox" name="rolUsuario" value="5" /> Teleoperador <br>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Filtrar
                                        <svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                        <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                                        </svg>
                                    </button>
                                </div>

                            </div>
                        </div>
                    </form>

                    <!-- BOTONACO DE CREAR USUARIOS -->
                    <div class="row-auto">
                        <input type="submit" class="btn btn-primary mb-3 btn-lg" value="Crear usuario" onclick="location.href = 'CrearUsuarioAdministrador.jsp'"/>
                    </div>
                    <!-- TABLA DE USUARIOS -->
                    <%
                        if (usuarios != null && !usuarios.isEmpty()) {
                    %>
                    <table class="table">
                        <thead class = "table-primary">
                            <tr>
                                <th scope="col">Nombre</th>
                                <th scope="col">NIF</th>
                                <th scope="col">Correo</th>
                                <th scope="col">Rol</th>
                                <th scope="col">Editar</th>
                                <th scope="col">Eliminar</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Usuario user : usuarios) {
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
                            <tr>
                                <th scope="row"><%=user.getNombre()%></th>
                                <td><%=user.getNif()%></td>
                                <td><%=user.getCorreo()%></td>
                                <td><%=rol%></td>
                                <td><input type="submit" class="btn btn-outline-primary" value="Editar" onclick="location.href = 'ServletCargarUsuarioEditarAdministrador?id=<%= user.getId()%>'"/></td>
                                <td><input type="submit" class="btn btn-outline-danger" value="Eliminar" onclick="location.href = 'ServletEliminarUsuarioAdministrador?id=<%= user.getId()%>'"/></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>

                    <%
                    } else { //no hay usuarios
                    %>

                    <div class="alert alert-warning" role="alert">
                        PRECAUCI�N: �No hay usuarios en el sistema!
                    </div>
                    <%
                        }
                    %>

                </div>
                <div class="column">
                    <br>
                    <!-- TABLA DE EVENTOS -->
                    <form action="ServletListarEventosUsuariosAdministrador" class="row g-3">
                        <input type="hidden" name="buscarEvento" value="S"/>
                        <div class="col-auto">
                            <input type="text" class="form-control" name="nombreEvento">
                        </div>
                        <div class="col-auto">
                            <button type="submit" class="btn btn-primary mb-3">Buscar eventos</button>
                        </div>
                    </form> 
                    <form action="ServletListarEventosUsuariosAdministrador">
                        <div class="row-auto">
                            <input type="hidden" name="filtrarEvento" value="S"/>
                            <label class="accordion">Filtrar eventos</label>
                            <div class="panel">
                                <div class="card-body p-4">
                                    <div class="col-md-4 mb-3">

                                        Categor�a del evento: 
                                        <br>
                                        <%
                                            for (Etiqueta etq : etiquetas) {
                                        %>
                                        <input type="checkbox" name="etiquetaEvento" value="<%=etq.getId()%>" /> <%= etq.getNombre()%> <br>
                                        <%
                                            }
                                        %>

                                    </div>
                                    <button type="submit" class="btn btn-primary">Filtrar
                                        <svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                        <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                                        </svg>
                                    </button>
                                </div>

                            </div>
                        </div>
                    </form>
                    <!-- BOTONACO DE CREAR EVENTOS -->
                    <form action="ServletCargarEventoEditarAdministrador">
                        <!--<div class="d-grid gap-2 col-6 mx-auto">-->
                        <div class="row-auto">
                            <input type="submit" class="btn btn-primary mb-3 btn-lg" value="Crear evento" />
                        </div>
                    </form>

                    <%
                        if (eventos != null && !eventos.isEmpty()) {
                            DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");

                    %>
                    <table class="table">
                        <thead class = "table-primary">
                            <tr>
                                <th scope="col">T�tulo</th>
                                <th scope="col">Fecha de inicio</th>
                                <th scope="col">Fecha l�mite para reservas</th>
                                <th scope="col">Coste entradas</th>
                                <th scope="col">Aforo</th>
                                <th scope="col">Editar</th>
                                <th scope="col">Eliminar</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%      for (Evento event : eventos) {
                                    String fechaInicio = formatter.format(event.getFechaInicio());
                                    String fechaLimite = formatter.format(event.getFechaReserva());
                            %>
                            <tr>
                                <th scope="row"><%= event.getTitulo()%></th>
                                <td><%= fechaInicio%></td>
                                <td><%= fechaLimite%></td>
                                <td><%= event.getCosteEntrada()%></td>
                                <td><%= event.getAforo()%></td>
                                <td><input type="submit" class="btn btn-outline-primary" value="Editar" onclick="location.href = 'ServletCargarEventoEditarAdministrador?id=<%= event.getId()%>'"/></td>
                                <td><input type="submit" class="btn btn-outline-danger" value="Eliminar" onclick="location.href = 'ServletEliminarEventoAdministrador?id=<%= event.getId()%>'"/></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>

                    <%
                    } else { //no hay eventos
                    %>
                    <div class="alert alert-warning" role="alert">
                        PRECAUCI�N: �No hay eventos en el sistema!
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

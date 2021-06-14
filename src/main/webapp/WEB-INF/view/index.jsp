<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="GestorEventos2021.entity.Etiquetasevento"%>
<%@page import="java.util.List"%>
<%@page import="GestorEventos2021.entity.Evento"%>
<%@page import="GestorEventos2021.entity.Evento"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<html>
    <head>
        <title>WELKARTEN</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="styles2.css" rel="stylesheet">
    </head>
    <%
        Integer registrado = (Integer) request.getAttribute("registrado");
        List<Evento> listaEventos = (List<Evento>) request.getAttribute("listaEventos");
        List<Evento> listaEventosHoy = (List<Evento>) request.getAttribute("listaEventosHoy");
        List<Evento> listaEventosEstaSemana = (List<Evento>) request.getAttribute("listaEventosEstaSemana");

        SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat formatoHora = new SimpleDateFormat("HH:mm");
        DecimalFormat moneyFormat = new DecimalFormat("#.00");
    %>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <jsp:include page="Navbar.jsp" />
        <br>
        <br>
        <br>
        <br>        
        <%
            if (registrado == null) {
            } else if (registrado.equals(1)) {
        %>
        <div class="alert alert-success">Usuario registrado con éxito!</div>
        <%
            }
        %>
        <!--<button onclick="location.href='InicioSesion.html'">Iniciar sesión</button> -->
        <h1 class="display-4">Miles de tickets al instante</h1>

        <!--CARRUSEL-->
        <div class="carrusel">
            <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
                    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
                </div>
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="images/concierto.jpg" class="d-block w-100" alt="...">
                        <div class="carousel-caption d-none d-md-block">
                            <h5>Eventos todas las semanas</h5>
                            <p>Disfruta de los mejores eventos de todas las categorías</p>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <img src="images/futbol.jpg" class="d-block w-100" alt="...">
                        <div class="carousel-caption d-none d-md-block">
                            <h5>Eventos deportivos</h5>
                            <p>Si eres un amante del deporte, compra tus entradas</p>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <img src="images/teatro.jpg" class="d-block w-100" alt="...">
                        <div class="carousel-caption d-none d-md-block">
                            <h5>Eventos artísticos</h5>
                            <p>Representaciones en cualquier parte del mundo</p>
                        </div>
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </div>
        <!--FIN CARRUSEL-->
        
        
        <!-- CONTENIDO -->
        <div class="eventos">
            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <button class="nav-link active" id="nav-todos-tab" data-bs-toggle="tab" data-bs-target="#nav-todos" type="button" role="tab" aria-controls="nav-todos" aria-selected="true">Todos</button>
                    <button class="nav-link" id="nav-hoy-tab" data-bs-toggle="tab" data-bs-target="#nav-hoy" type="button" role="tab" aria-controls="nav-hoy" aria-selected="false">Hoy</button>
                    <button class="nav-link" id="nav-estasemana-tab" data-bs-toggle="tab" data-bs-target="#nav-estasemana" type="button" role="tab" aria-controls="nav-estasemana" aria-selected="false">Esta semana</button>
                </div>
            </nav>
            <div class="tab-content" id="nav-tabContent">
                <div class="tab-pane fade show active" id="nav-todos" role="tabpanel" aria-labelledby="nav-todos-tab">
                    <div class="contenido">
                        <% if (listaEventos == null || listaEventos.isEmpty()) { %>
                                <h2>No hay resultados</h2>
                        <% } else {
                                for (Evento e : listaEventos) {
                                    List<Etiquetasevento> listaEtiquetas = e.getEtiquetaseventoList();
                                    String etiquetas = "";
                                    for (int i = 0; i < listaEtiquetas.size(); i++) {
                                        etiquetas += listaEtiquetas.get(i).getEtiqueta().getNombre();
                                        if (i < listaEtiquetas.size() - 1) {
                                            etiquetas += ", ";
                                        }
                                    }
                            %>
                            <div class="carta">
                                <div class="card" style="width: 18rem;">
                                    <img src="images/ticket.png" class="card-img-top" alt="Evento"/> 
                                    <div class="card-body">
                                        <h5 class="card-title"><%=e.getTitulo()%></h5>
                                        <p class="card-text"><%=e.getLugar()%></p>
                                        <p class="card-text"><%=formatoFecha.format(e.getFechaInicio()) + " " + formatoHora.format(e.getHora())%></p>
                                        <p class="card-text"><%=etiquetas%></p>
                                        <p class="card-text"><%=moneyFormat.format(e.getCosteEntrada())%>&#8364</p>
                                        <!-- Cambiar id 1 por //evento.getEventoId()// -->
                                        <a href="ServletEventoInfo?id=<%=e.getId()%>" class="btn btn-primary">Ver evento</a>
                                    </div>
                                </div>
                            </div>
                        <%      }
                            }       
                        %>
                    </div>
                </div>
                <div class="tab-pane fade" id="nav-hoy" role="tabpanel" aria-labelledby="nav-hoy-tab">
                    <div class="contenido">
                        <% if (listaEventosHoy == null || listaEventosHoy.isEmpty()) { %>
                                <h2>No hay resultados</h2>
                        <% } else {
                                for (Evento e : listaEventosHoy) {
                                    List<Etiquetasevento> listaEtiquetas = e.getEtiquetaseventoList();
                                    String etiquetas = "";
                                    for (int i = 0; i < listaEtiquetas.size(); i++) {
                                        etiquetas += listaEtiquetas.get(i).getEtiqueta().getNombre();
                                        if (i < listaEtiquetas.size() - 1) {
                                            etiquetas += ", ";
                                        }
                                    }
                            %>
                            <div class="carta">
                                <div class="card" style="width: 18rem;">
                                    <img src="images/ticket.png" class="card-img-top" alt="Evento"/> 
                                    <div class="card-body">
                                        <h5 class="card-title"><%=e.getTitulo()%></h5>
                                        <p class="card-text"><%=e.getLugar()%></p>
                                        <p class="card-text"><%=formatoFecha.format(e.getFechaInicio()) + " " + formatoHora.format(e.getHora())%></p>
                                        <p class="card-text"><%=etiquetas%></p>
                                        <p class="card-text"><%=moneyFormat.format(e.getCosteEntrada())%>&#8364</p>
                                        <!-- Cambiar id 1 por //evento.getEventoId()// -->
                                        <a href="ServletEventoInfo?id=<%=e.getId()%>" class="btn btn-primary">Ver evento</a>
                                    </div>
                                </div>
                            </div>
                        <%      }
                            }       
                        %>
                    </div>               
                </div>
                <div class="tab-pane fade" id="nav-estasemana" role="tabpanel" aria-labelledby="nav-estasemana-tab">
                    <div class="contenido">
                        <% if (listaEventosEstaSemana == null || listaEventosEstaSemana.isEmpty()) { %>
                                <h2>No hay resultados</h2>
                        <% } else {
                                for (Evento e : listaEventosEstaSemana) {
                                    List<Etiquetasevento> listaEtiquetas = e.getEtiquetaseventoList();
                                    String etiquetas = "";
                                    for (int i = 0; i < listaEtiquetas.size(); i++) {
                                        etiquetas += listaEtiquetas.get(i).getEtiqueta().getNombre();
                                        if (i < listaEtiquetas.size() - 1) {
                                            etiquetas += ", ";
                                        }
                                    }
                            %>
                            <div class="carta">
                                <div class="card" style="width: 18rem;">
                                    <img src="images/ticket.png" class="card-img-top" alt="Evento"/> 
                                    <div class="card-body">
                                        <h5 class="card-title"><%=e.getTitulo()%></h5>
                                        <p class="card-text"><%=e.getLugar()%></p>
                                        <p class="card-text"><%=formatoFecha.format(e.getFechaInicio()) + " " + formatoHora.format(e.getHora())%></p>
                                        <p class="card-text"><%=etiquetas%></p>
                                        <p class="card-text"><%=moneyFormat.format(e.getCosteEntrada())%>&#8364</p>
                                        <!-- Cambiar id 1 por //evento.getEventoId()// -->
                                        <a href="ServletEventoInfo?id=<%=e.getId()%>" class="btn btn-primary">Ver evento</a>
                                    </div>
                                </div>
                            </div>
                        <%      }
                            }       
                        %>
                    </div>
                </div>
            </div>
        </div>


        <!--
                <div class="mostrar_todos_los_eventos" style="visibility: hidden">
                    <h1 class="display-4">Eventos.</h1>
                </div>
        
                <div class="mostrar_eventos_hoy" style="visibility: hidden">
                    <h1 class="display-4">Eventos de hoy.</h1>
                </div>
        
                <div class="mostrar_eventos_semana" style="visibility: hidden">
                    <h1 class="display-4">Eventos de esta semana.</h1>
                </div>
        -->

        <!--<div class="row" >
        </div> -->


    </body>
</html>

<%@ taglib prefix="input" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="java.util.List"%>
<%@ page import="es.taw.welkarten.entity.Usuario" %>
<%@ page import="es.taw.welkarten.entity.Evento" %>
<%@ page import="es.taw.welkarten.entity.Etiquetasevento" %>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<html>
    <head>


        <title>CREADOR DE EVENTOS</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous"> 
        <link href="styles2.css" rel="stylesheet">    
        <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/pricing/"> 


        <style>

            .row {
                display: flex;
                margin-left:-5px;
                margin-right:-5px;
                justify-content: center

            }

            .column {
                flex: 50%;
                margin: auto;
                width: 60%;
                padding: 0px;
                justify-content: center
            }

            .proximos {

                justify-content: center
            }

            #divfix {
                bottom: 0;
                right: 0;
                position: fixed;
                z-index: 3000;
                margin-right: 2%;
                margin-bottom: 2%;
            }

            .panel {
                padding: 0 18px;
                background-color: white;
                max-height: 0;
                overflow: hidden;
                transition: max-height 0.2s ease-out;
            }
            .accordion:after {
                content: '\002B';
                color: #777;
                font-weight: bold;
                float: right;
                margin-left: 5px;
            }

            .intro {
                height: 100%;
            }

            .card-header {
                border-bottom: 3px solid #39c0ed;
            }

            /*.form-control {
                border-color: transparent;
            }*/

            .input-group>.form-control:focus {
                border-color: transparent;
                box-shadow: inset 0 0 0 1px transparent;
            }



        </style>

    </head>

    <%

        Usuario usuario = (Usuario) request.getAttribute("usuario");
        List<Usuario> creadores = (List) request.getAttribute("creadores");
        List<Evento> eventosFiltrados = (List) request.getAttribute("eventosFiltrados");
        List<Evento> eventosProximos = (List) request.getAttribute("eventosProximos");
        List<Evento> misEventos = (List) request.getAttribute("misEventos");
        SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat formatoHora = new SimpleDateFormat("HH:mm");
        HttpSession sesion = request.getSession();

        Boolean primeraCarga = (Boolean) sesion.getAttribute("primeraCarga");

        if (primeraCarga == null) {
            primeraCarga = true;
        }


    %>
    <body>




        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <jsp:include page="Navbar.jsp" />
        <br>
        <br>
        <br>
        <br>


        <!-- CONTENIDO -->

        <form:form modelAttribute="busqueda" action="/creadoreventos/busquedaavanzada" method="post">
            <section class="intro">
                <div class="bg-image h-100">
                    <div class="mask d-flex align-items-center h-100">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-10 col-lg-8 col-xl-7 mx-auto">
                                    <div class="card">
                                        <div class="card-header">
                                            <div class="input-group input-group-lg">

                                                <form:input path="nombre" class="form-control" id="filtroCreadorEventos" name="filtroCreadorEventos"></form:input>

                                                <button type="submit" class="btn btn-primary" onclick="ServletBusquedaAvanzadaEventos" >
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                                                    </svg>
                                                </button>

                                            </div>
                                        </div>

                                        <label class="accordion">Busqueda avanzada</label>
                                        <div class="panel">
                                            <div class="card-body p-4">
                                                <h6 class="text-muted text-uppercase mt-3 mb-4"></h6>
                                                <div class="row">
                                                    <div class="col-md-4 mb-3">
                                                        Precio Maximo : <form:input path="precio" class="form-control" id="filtroCreadorEventos" name="filtroCreadorEventos"></form:input>
                                                    </div>
                                                </div>
                                                <div class="col-md-4 mb-3">

                                                    Aforo Maximo : <form:input path="aforo" class="form-control" id="filtroCreadorEventos" name="filtroCreadorEventos"></form:input>

                                                </div>
                                            </div>
                                            <div class="col-md-4 mb-3">

                                                Creador del Evento : <form:select path="creador">

                                                <form:option value=""></form:option>
                                                <form:options items="${creadores}" itemLabel="nombre" itemValue="id"></form:options>


                                            </form:select>





                                            </div>
                                        </div>

                                        <button type="submit" class="btn btn-primary" onclick="ServletBusquedaAvanzadaEventos">Buscar</button>

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
            </section>


        </form:form>




        <div id="divfix">
            <!-- <button type="button" class="w-100 btn btn-lg btn-primary">Crear nuevo Evento</button> -->
            <a href="/CrearEditarEvento" class="btn btn-primary">Crear nuevo Evento</a>
        </div>



        <div class="column">
            <div class="row">



                <div class="tab-pane fade show active" id="filtrados" role="tabpanel" aria-labelledby="nav-todos-tab">
                    <div class="contenido">
                        <%

                        %> <h1 class="display-4">Resultados de la busqueda</h1><%
                        if (eventosFiltrados == null || eventosFiltrados.isEmpty()) {
                    %> <h2> No hay resultados</h2><%
                    } else {
                        for (Evento e : eventosFiltrados) {
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

                                    <a href="ServletEventoInfo?id=<%=e.getId()%>" class="btn btn-primary">Ver evento</a>
                                </div>
                            </div>
                        </div>
                        <%      }
                        }

                            sesion.setAttribute("primeraCarga", false);
                        %>
                    </div>
                </div>
            </div>
            <br/>
            <br/>
            <br/>



            <div class="row">
                <h1 class="display-4">Mis Eventos</h1>

                <div class="tab-pane fade show active" id="misEventos" role="tabpanel" aria-labelledby="nav-todos-tab">
                    <div class="contenido">
                        <% if (misEventos == null || misEventos.isEmpty()) { %>
                        <h2>No hay resultados</h2>
                        <% } else {
                            for (Evento e : misEventos) {
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
                                    <!-- Cambiar id 1 por //evento.getEventoId()// -->
                                    <a href="ServletEventoInfo?id=<%=e.getId()%>" class="btn btn-primary">Ver evento</a>
                                    <a href="ServletCargarEventoEditarAdministrador?id=<%=e.getId()%>" class="btn btn-primary">Editar</a>
                                    <a href="ServletEliminarEventoAdministrador?id=<%=e.getId()%>" class="btn btn-primary">Borrar</a>
                                </div>
                            </div>
                        </div>
                        <%      }
                            }
                        %>
                    </div>
                </div>
            </div>
            <br/>
            <br/>
            <br/>



            <div class="row">

                <h1 class="display-4">Eventos Proximos</h1>



                <div class="tab-pane fade show active" id="proximos" role="tabpanel" aria-labelledby="nav-todos-tab">
                    <div class="contenido">
                        <% if (eventosProximos == null || eventosProximos.isEmpty()) { %>
                        <h2>No hay resultados</h2>
                        <% } else {
                            for (Evento e : eventosProximos) {
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

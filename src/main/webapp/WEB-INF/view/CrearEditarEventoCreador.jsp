<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>

<%@page import="java.util.List"%>
<%@ page import="es.taw.welkarten.entity.Etiqueta" %>
<%@ page import="es.taw.welkarten.entity.Evento" %>
<%@ page import="es.taw.welkarten.entity.Etiquetasevento" %>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Evento</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link href="styles.css" rel="stylesheet">
</head>


    <%
        List<Etiqueta> listaEtiquetas = (List<Etiqueta>) request.getAttribute("listaEtiquetas");
        String error = (String) request.getAttribute("error");
        Evento evento = (Evento)request.getAttribute("evento");
        //Usuario usuario = (Usuario)session.getAttribute("usuario");
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatoHora = new SimpleDateFormat("HH:mm");
        String nombre = "", descripcion = "", lugar = "", coste = "", numMaxEntradas = "",aforo = "",
        filasAsiento = "", asientosPorFila = "", fechaEvento = "", fechaLimite = "", hora = "", asientoS="", 
                asientoN="",textoBtn = "Crear", idEvento = "";
        List<Etiquetasevento> etiquetasEvento = new ArrayList();
        Boolean edicion = true;
        if(evento != null){ // edicion
            idEvento = evento.getId().toString();
            textoBtn = "Editar";
            nombre = evento.getTitulo();
            descripcion = evento.getDescripcion();
            lugar = evento.getLugar();
            coste = String.valueOf(evento.getCosteEntrada());
            numMaxEntradas = String.valueOf(evento.getEntradasMax());
            aforo = String.valueOf(evento.getAforo());
            filasAsiento = String.valueOf(evento.getFilas());
            asientosPorFila = String.valueOf(evento.getAsientosFila());
            if(!filasAsiento.equals("null") && !asientosPorFila.equals("null")){
                asientoS = "checked";
            } else {
                asientoN = "checked";
                filasAsiento = ""; 
                asientosPorFila = "";
            }
            fechaEvento = formatter.format(evento.getFechaInicio());
            fechaLimite = formatter.format(evento.getFechaReserva());
            hora = formatoHora.format(evento.getHora());
            etiquetasEvento = evento.getEtiquetaseventoList();
        }else{ // creación
            edicion = false;
        }
    %>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <jsp:include page="Navbar.jsp" />
        <br>
        <br>

        <!-- FORMULARIO PARA CREAR O EDITAR UN NUEVO EVENTO -->
        <div class="global_nuevo_evento">

            <form:form action="/creadoreventos/guardar" modelattribute="evento" method="post">
                
                <%
                    if (error != null && error.equals("etiquetasIncorrectas")) {
                %>

                <div class="alert alert-danger" role="alert">
                    Seleccione como mínimo 1 etiqueta y como máximo 2 etiquetas.
                </div>
                <%
                    } else if (error != null && error.equals("fechasIncorrectas")) {
                %>
                <div class="alert alert-danger" role="alert">
                    ERROR: La fecha límite para comprar entradas debe ser anterior a la fecha del evento.
                </div>
                <% 
                    } else if (error != null && error.equals("seleccionIncorrecta")) {
                %>
                <div class="alert alert-danger" role="alert">
                    ERROR: Introduzca correctamente el numero de asientos y filas.
                </div>
                <% 
                    }
                %>
                <input type="hidden" name="idEvento" value="<%= idEvento%>"/>
                <div style="padding: 2% 15%">
                    
                
                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label" >Nombre del evento</label>
                    <form:input path="nombre" required="required" class="form-control"></form:input>

                </div>
                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label">Descripción del evento</label>
                    <form:input path="descripcion" required="required" class="form-control"></form:input>
                </div>

                <div class="mb-3" style="text-align: left">
                    <label for="birthday" class="form-label">Fecha del evento</label>
                    <form:input path="fechaInicio" required="required" class="form-control"></form:input>
                </div> 

                <div class="mb-3" style="text-align: left">
                    <label for="inputMDEx1" class="form-label">Hora del evento</label>
                    <form:input path="hora" required="required" class="form-control"></form:input>

                </div>

                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label">Lugar del evento</label>
                    <form:input path="lugar" required="required" class="form-control"></form:input>
                </div>

                <div class="mb-3" style="text-align: left">
                    <label for="birthday" class="form-label">Fecha límite para comprar entradas</label>
                    <form:input path="fechaReserva" required="required" class="form-control"></form:input>
                </div> 

                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label">Coste de la entrada</label>
                    <form:input path="costeEntrada" required="required" class="form-control"></form:input>
                </div>

                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label">Número máximo de entradas por persona</label>
                    <form:input path="entradasMax" required="required" class="form-control"></form:input>
                </div>

                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label">Aforo máximo del evento</label>
                    <form:input path="aforo" required="required" class="form-control"></form:input>
                </div>

                <div style="text-align: left">
                    <label>Selecciona las etiquetas del evento (mínimo 1, máximo 2)</label> <br>
                </div>


                <%
                    for (Etiqueta etiqueta : listaEtiquetas) {
                        String seleccion = "";
                        for(Etiquetasevento etiquetaEv : etiquetasEvento){
                           if(etiquetaEv.getEtiqueta().equals(etiqueta)) {
                               seleccion = "checked";
                           }
                        }
                %>
                <div class="form-check" style="text-align: left">
                    <input class="form-check-input"  type="checkbox" name="etiquetas_evento" value="<%=etiqueta.getId()%>" id="defaultCheck1" <%= seleccion%>>
                    <label class="form-check-label"  for="defaultCheck1"><%=etiqueta.getNombre()%></label>
                </div> 
                <%
                    }
                %>

                
                <br>
                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label" <% if(edicion){ %> readonly <%}%> >Asientos</label> <br/>
                    <form:radiobutton path="seleccionAsientos" class="form-check-input" value="S" <%= asientoS%> <% if(edicion && asientoN.equals("checked")){ %> disabled <%}%> />Sí <br>
                    <form:radiobutton path="seleccionAsientos" class="form-check-input" value="N" <%= asientoS%> <% if(edicion && asientoN.equals("checked")){ %> disabled <%}%> />No <br>


                </div>

                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label" <% if(edicion){ %> readonly <%}%> >Número de filas de asientos</label>
                    <input type="text" name="filas_evento" class="form-control" value="<%= filasAsiento%>" <% if(edicion){ %> readonly <%}%>>
                </div> 

                <div class="mb-3" style="text-align: left">
                    <label for="exampleDropdownFormEmail2" class="form-label" <% if(edicion){ %> readonly <%}%> >Número de asientos por fila del evento</label>
                    <input type="text" name="asientos_fila_evento" class="form-control" value="<%= asientosPorFila%>" <% if(edicion){ %> readonly <%}%>>
                </div> 
                
                

                <div class="d-grid gap-2 col-6 mx-auto">
                    <button type="submit" class="btn btn-primary btn-lg"><%= textoBtn%></button>
                </div>
                </div>
                
            </form:form>
        </div>
    </body>
</html>

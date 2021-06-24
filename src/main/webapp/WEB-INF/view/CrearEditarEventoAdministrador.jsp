<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@ page import="es.taw.welkarten.entity.Etiqueta" %>
<%@page import="java.util.List"%>
<%@ page import="es.taw.welkarten.entity.Evento" %>
<%@ page import="es.taw.welkarten.entity.Etiquetasevento" %>
<%@ page import="es.taw.welkarten.dto.EtiquetaDTO" %>
<%@ page import="es.taw.welkarten.dto.EventoDTO" %>
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
        <link href="/css/styles.css" rel="stylesheet">
    </head>
    <%

        String error = (String) request.getAttribute("error");
        EventoDTO evento = (EventoDTO)request.getAttribute("eventoDTO");
        //Usuario usuario = (Usuario)session.getAttribute("usuario");
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatoHora = new SimpleDateFormat("HH:mm");
        String filasAsiento = "", asientosPorFila = "", asientoS="",
                asientoN="",textoBtn = "Crear";

        Boolean edicion = false;
        //if(evento != null){ // edicion
           /* textoBtn = "Editar";
            filasAsiento = String.valueOf(evento.getFilas());
            asientosPorFila = String.valueOf(evento.getAsientosFila());
            if(!filasAsiento.equals("null") && !asientosPorFila.equals("null")){
                asientoS = "checked";
            } else {
                asientoN = "checked";
            }
            */
        //}else{ // creación
        //    edicion = false;
        //}
    %>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <jsp:include page="Navbar.jsp" />
        <br>
        <br>

        <div class="global_nuevo_evento">
<form:form method="POST" action="/administrador/guardarEvento" modelAttribute="eventoDTO">
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
    <form:hidden path="id"></form:hidden>


    <div class="mb-3" style="text-align: left">
        <label class="form-label">Nombre del evento</label>
        <form:input type="text" path="titulo" class="form-control" required="required"></form:input>
    </div>
    <div class="mb-3" style="text-align: left">
        <label class="form-label">Descripción del evento</label>
        <form:input type="text" path="descripcion" class="form-control" required="required"></form:input>
    </div>

    <div class="mb-3" style="text-align: left">
        <label class="form-label">Fecha del evento</label>
        <form:input type="date" path="fechaInicioString" class="form-control" required="required"></form:input>
    </div>

    <div class="mb-3" style="text-align: left">
        <label class="form-label">Hora del evento</label>
        <form:input type="time" path="horaString" class="form-control" required="required"></form:input>
    </div>

    <div class="mb-3" style="text-align: left">
        <label class="form-label">Lugar del evento</label>
        <form:input type="text" path="lugar" class="form-control" required="required"></form:input>
    </div>

    <div class="mb-3" style="text-align: left">
        <label class="form-label">Fecha límite para comprar entradas</label>
        <form:input type="date" class="form-control" path="fechaReservaString" required="required"></form:input>
    </div>

    <div class="mb-3" style="text-align: left">
        <label class="form-label">Coste de la entrada</label>
        <form:input type="text" path="costeEntrada" class="form-control" required="required"></form:input>
    </div>

    <div class="mb-3" style="text-align: left">
        <label class="form-label">Número máximo de entradas por persona</label>
        <form:input type="text"  path="entradasMax" class="form-control" required="required"></form:input>
    </div>

    <div class="mb-3" style="text-align: left">
        <label class="form-label">Aforo máximo del evento</label>
        <form:input type="text" path="aforo" class="form-control" required="required"></form:input>
    </div>

    <div style="text-align: left">
        <label>Selecciona las etiquetas del evento (mínimo 1, máximo 2)</label> <br>
    </div>

    <div class="form-check" style="text-align: left">
        <form:checkboxes items = "${listaEtiquetas}" itemLabel="nombre" itemValue="nombre" path = "etiquetas"/>
    </div>

    <br>
    <div class="mb-3" style="text-align: left">
        <label class="form-label" <% if(edicion){ %> readonly <%}%> >Asientos</label> <br/>
        <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
            <form:radiobutton path="seleccionAsientos" value="S" class="btn-check" id="S" />
            <label for="S" class="btn btn-outline-primary">Sí</label>

            <form:radiobutton path="seleccionAsientos" value="N" class="btn-check" id="N" />
            <label for="N" class="btn btn-outline-primary">No</label>
        </div>
    </div>
    <div class="mb-3" style="text-align: left">
        <label class="form-label" <% if(edicion){ %> readonly <%}%> >Número de filas de asientos</label>
        <form:input type="text" path="filas" class="form-control" ></form:input>
    </div>

    <div class="mb-3" style="text-align: left">
        <label class="form-label" <% if(edicion){ %> readonly <%}%> >Número de asientos por fila del evento</label>
        <form:input type="text" path="asientosFila" class="form-control" ></form:input>
    </div>
    <div class="d-grid gap-2 col-6 mx-auto">
        <button type="submit" class="btn btn-primary btn-lg"><%= textoBtn%></button>
    </div>
</form:form>
        </div>
    </body>
</html>

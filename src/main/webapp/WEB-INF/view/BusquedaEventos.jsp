<%-- 
    Document   : BusquedaEventos
    Created on : 13-may-2021, 9:39:09
    Author     : yeray
--%>

<%@page import="GestorEventos2021.entity.Etiquetasevento"%>
<%@page import="java.util.List"%>
<%@page import="GestorEventos2021.entity.Evento"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>WELKARTEN</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="styles2.css" rel="stylesheet">
    </head>
    <%
        List<Evento> listaEventos = (List<Evento>) request.getAttribute("listaEventos");
        String filtro = (String) request.getAttribute("filtro");
        
        SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat formatoHora = new SimpleDateFormat("HH:mm");    
    %>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <jsp:include page="Navbar.jsp" />
        <br>
        <br>
        <br>

        <h1>Resultados para la búsqueda: <%=filtro%></h1>
        
        <% if (listaEventos == null || listaEventos.isEmpty()){ %>
            <h2>No hay resultados para la búsqueda</h2>
        <% } else { %>
        <div class="contenido">
            <% for (Evento e : listaEventos) {
                List<Etiquetasevento> listaEtiquetas = e.getEtiquetaseventoList();
                String etiquetas = "";
                for (int i = 0; i < listaEtiquetas.size(); i++) {
                    etiquetas += listaEtiquetas.get(i).getEtiqueta().getNombre();
                    if (i < listaEtiquetas.size() - 1) etiquetas += ", ";
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
            <% } %>
        </div>
        <% } %>
    </body>
</html>

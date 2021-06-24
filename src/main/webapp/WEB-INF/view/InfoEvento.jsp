<%-- 
    Document   : InfoEvento
    Created on : 20-abr-2021, 12:17:36
    Author     : yeray
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="es.taw.welkarten.entity.Usuario" %>
<%@ page import="es.taw.welkarten.entity.Evento" %>
<%@ page import="es.taw.welkarten.dto.EventoDTO" %>
<%@ page import="es.taw.welkarten.dto.UsuarioDTO" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>WELKARTEN</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="/css/stylesInfoEvento.css" rel="stylesheet">
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var comprarEntradas = document.querySelector('#comprarEntradas');
                var selectorEntradas = document.querySelector('#nEntradas');
                var nEntradas;

                /* Almacenar cuantas entradas quiere comprar */
                comprarEntradas.addEventListener('click', function () {
                    nEntradas = Number(selectorEntradas.value);
                    localStorage.setItem("nEntradas", nEntradas);
                });
            });
        </script>
    </head>
    <%
        EventoDTO evento = (EventoDTO) request.getAttribute("evento");
        SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat formatoHora = new SimpleDateFormat("HH:mm");
        String fecha = formato.format(evento.getFechaInicio());
        DecimalFormat moneyFormat1 = new DecimalFormat("#.00");
        String precio = moneyFormat1.format(evento.getCosteEntrada());
        String desactivado = "";
        UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("usuario");
    %>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

        <!-- BARRA DE NAVEGACION -->
        <jsp:include page="Navbar.jsp"></jsp:include>
        <!-- FIN BARRA DE NAVEGACION -->
        <br>
        <br>
        <br>
        <br>

        <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
    <symbol id="check-circle-fill" fill="currentColor" viewBox="0 0 16 16">
        <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
    </symbol>
    <symbol id="info-fill" fill="currentColor" viewBox="0 0 16 16">
        <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"/>
    </symbol>
    <symbol id="exclamation-triangle-fill" fill="currentColor" viewBox="0 0 16 16">
        <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
    </symbol>
    </svg>

    <%
        boolean cond1 = evento.getFechaReserva().before(new Date());
        boolean cond2 = evento.getEntradaList().size() >= evento.getAforo();
        if (cond1 || cond2) {
            desactivado = "disabled";
            String alerta = "";

            if (cond1) {
                alerta = "La fecha máxima de reserva del evento era el " + formato.format(evento.getFechaReserva());
            } else {
                alerta = "Entradas agotadas";
            }
    %>

    <div class="alert alert-danger d-flex align-items-center" role="alert">
        <svg class="bi flex-shrink-0 me-2" width="24" height="24"><use xlink:href="#exclamation-triangle-fill"/></svg>
        <div><%=alerta%></div>
    </div>
    <% } else {%>
    <div class="alert alert-primary d-flex align-items-center" role="alert">
        <svg class="bi flex-shrink-0 me-2" width="24" height="24"><use xlink:href="#info-fill"/></svg>
        <div>
            La fecha máxima de reserva del evento es el <%=formato.format(evento.getFechaReserva())%>
        </div>
    </div>
    <% }%>

    <h1 class="display-4"><strong><%=evento.getTitulo()%></strong></h1>


    <!-- IMAGEN DEL EVENTO -->
    <img src="/images/teatro.jpg" class="img-fluid image-info" alt="">

    <!-- APARTADO DE COMPRA DEL EVENTO -->
    <!-- 3 CASOS -->
    <!-- 1. Si el usuario no ha iniciado sesión, al pulsar el botón de comprar le redirige a iniciar sesión -->
    <!-- 2. Si el evento no tiene asientos, aparece un selector del número de tickets.-->
    <!-- 3. Si el evento tiene asientos, no aparece el selector del número de tickets y le redirige a una ventana de selección de asientos -->
    <div class="comprarTicket">
        <div class ="infoEvento">
            <form action="/usuarioeventos/evento/comprarTickets" method="POST">
                <input type="hidden" name="idEvento" value="<%=evento.getId()%>" />
                <strong>Fecha del evento:  </strong><label><%=fecha%></label><br><br>
                <strong>Hora:  </strong><label><%=formatoHora.format(evento.getHora())%></label><br><br>
                <strong>Lugar:  </strong><label></label><%=evento.getLugar()%><br><br>
                <strong>Precio:  </strong><label><%=precio%>&euro;</label><br><br>
                <strong>Nº de entradas: </strong>
                <input type="number" min="1" max="<%=evento.getEntradasMax()%>" id ="nEntradas" name="nEntradas" value="1"/></br></br>

                <input type="submit" <%=desactivado%> id="comprarEntradas" class="btn btn-primary btn-lg" value="Comprar"/>
            </form>
        </div>
    </div>

    <div class="descripcion_evento">
        <h2><strong>Descripción</strong></h2>
        <p><%=evento.getDescripcion()%></p>        
    </div>
</body>
</html>

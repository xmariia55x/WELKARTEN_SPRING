<%-- 
    Document   : ImprimirTicket
    Created on : 11-may-2021, 9:08:40
    Author     : yeray
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="GestorEventos2021.entity.Entrada"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>WELKARTEN</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="styles2.css" rel="stylesheet">
        <link href="stylesImprimirTicket.css" rel="stylesheet">
    </head>
    <%
        List<Entrada> listaEntradas = (List<Entrada>) request.getAttribute("listaEntradas");
        Integer compra = (Integer) request.getAttribute("compra");
        Boolean hayFilas = listaEntradas.get(0).getFila() != null;

        SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat formatoHora = new SimpleDateFormat("HH:mm");
        String strEtiqueta = "";
        
        Date fechaHoy = new Date();
        boolean reservaValida = listaEntradas.get(0).getEvento().getFechaReserva().after(fechaHoy);
    %>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="jsImprimirTicket.js" defer></script>

        <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
    <symbol id="check-circle-fill" fill="currentColor" viewBox="0 0 16 16">
        <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
    </symbol>
    <symbol id="info-fill" fill="currentColor" viewBox="0 0 16 16">
        <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"/>
    </symbol>
    </svg>

    <!-- BARRA DE NAVEGACION -->
    <jsp:include page="Navbar.jsp"></jsp:include>
        <!-- FIN BARRA DE NAVEGACION -->
        <br>
        <br>
        <br>
        <br>

    <% if (compra == null) {  %>
    <div class="alert alert-primary d-flex align-items-center" role="alert">
        <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Info:"><use xlink:href="#info-fill"/></svg>
        <div>
            Pulsa click derecho e imprimir para imprimir tus entradas.
        </div>
    </div>
        
    <%      if (reservaValida) { %>

                <% if (hayFilas) { %>
                <button type="button" class="btn btn-warning" id="editar" onclick="editar()">Editar seleccionadas</button>
                <% } %>
                <button type="button" class="btn btn-danger" id="eliminar" onclick="eliminar()">Eliminar seleccionadas</button>
    <%      }
      } else if (compra == 1) { %>
    <div class="alert alert-success d-flex align-items-center" role="alert">
        <svg class="bi flex-shrink-0 me-2" width="24" height="24"><use xlink:href="#check-circle-fill"/></svg>
        <div>
            ¡Compra completada con éxito!
        </div>
    </div>   
    <% }%>
    
        </br>
        </br>
    <!-- TICKETS -->
    <% for (Entrada e : listaEntradas) {%>
        <div class="cardWrap">
            <div class="card cardLeft">
                <img src="images/logo_pequeno.png" width="200" height="45" id="titulo">
                <div class="title">
                    <h2><%=e.getEvento().getTitulo()%></h2>
                    <span>evento</span>
                </div>
                <div class="name">
                    <h2><%=e.getUsuario().getNombre() + " " + e.getUsuario().getUsuarioeventos().getApellidos()%></h2>
                    <span>nombre</span>
                </div>
                <div class="name">
                    <h2><%=e.getEvento().getLugar()%></h2>
                    <span>lugar</span>
                </div>
                <div class="informacion_mini">
                    <div class="time">
                        <h2><%=formatoFecha.format(e.getEvento().getFechaInicio())%></h2>
                        <span>fecha</span>
                    </div>
                    <div class="time">
                        <h2><%=formatoHora.format(e.getEvento().getHora())%></h2>
                        <span>hora</span>
                    </div>

                    <% if (e.getFila() != null) {
                            strEtiqueta = "asiento";
                    %>
                    <div class="time">
                        <h2><%=e.getFila()%></h2>
                        <span>fila</span>
                    </div>
                    <% } else {
                            strEtiqueta = "numero";
                        }%>
                    <div class="time">
                        <h2><%=e.getNumero()%></h2>
                        <span><%=strEtiqueta%></span>
                    </div>
                </div>
            </div>
            <div class="card cardRight">
                <div class="number">
                    <img src="images/ticket.png" width="80" height="80">
                </div>
                <div class="precio"><%=String.format("%.2f", e.getEvento().getCosteEntrada())%>€</div>
                <div class="barcode"></div>
            </div>

        </div>
        <% if (compra == null && reservaValida) { %>
            <input type="checkbox" class="selector" name="entradasSeleccionadas" value="<%=e.getId()%>" /> Seleccionar
            </br>
            </br>
        <% } } %>
        </br>
        </br>
</body>
</html>

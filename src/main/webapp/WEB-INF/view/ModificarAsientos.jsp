<%-- 
    Document   : ModificarAsientos
    Created on : 15-may-2021, 10:18:19
    Author     : yeray
--%>

<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="GestorEventos2021.entity.Evento"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>WELKARTEN</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="styles2.css" rel="stylesheet">
        <link href="stylesComprarTicket.css" rel="stylesheet">
    </head>
    <%
        Evento evento = (Evento) request.getAttribute("evento");

        List<Integer> listaEntradas = (List<Integer>) request.getAttribute("listaEntradas");
        boolean hayEntradasCompradas = listaEntradas != null;
        String[] entradasId = (String[]) request.getAttribute("entradasId");

        Integer nEntradas = entradasId.length;
    %>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="jsModificarTicket.js" defer></script>

        <div class="cabecera2" style="float:none">
            <div class="welkarten">
                <img src="images/ticket.png" width="150" height="150" >
            </div>
        </div>

        <form action="ServletEditarEntrada?entradas=<%=Arrays.asList(entradasId)%>" id="formulario">
            <% for (String s : entradasId) { %>
                <input type="hidden" value="<%=s%>" name="entradas"/>
            <% } %>
            <div class="plane">
                <div class="espectaculo">
                    <h1>Espectáculo</h1>
                </div>
                <div class="asientos">
                    <ol class="cabin fuselage">
                        <%  int medio = (evento.getAsientosFila() / 2) - 1;
                            String estilo = "";
                            String desactivado = "";
                            for (int i = 0; i < evento.getFilas(); i++) {%>
                        <li class="row row--<%=i%>">
                            <ol class="seats" type="A">

                                <% for (int j = 0; j < evento.getAsientosFila(); j++) {
                                        int id = (evento.getAsientosFila() * i) + j + 1;

                                        if (j == medio) {
                                            estilo = "margin-right: 7%;";
                                        };

                                        if (hayEntradasCompradas && listaEntradas.contains(id)) {
                                            desactivado = "disabled";
                                        }
                                %>
                                <li class="seat" style="<%=estilo%>">
                                    <input type="checkbox" <%=desactivado%> value="<%=id%>" id="<%=id%>" name="asientosSeleccionados" class="seleccion" onclick="checkear(<%=id%>)"/>
                                    <label for="<%=id%>"><%=id%></label>
                                </li>
                                <%    estilo = "";
                                        desactivado = "";
                                    }
                                %>

                            </ol>
                        </li>
                        <% }%> 
                    </ol>
                </div>
            </div>
            </br>
            <div style="float:left; padding-left: 10%;">
                <input type="button" class="btn btn-secondary btn-lg" value="Cancelar" onclick="location.href = 'ServletMisEventos'" />
            </div>
            <div style="float: right; padding-right: 10%;">
                <input type="button" class="btn btn-primary btn-lg" value="Confirmar" onclick="enviar()" />
            </div>
        </form>
        <br>
        <br>
    </body>
</html>

<%-- 
    Document   : ComprarTicketEventoSinAsientos
    Created on : 10-may-2021, 16:28:02
    Author     : yeray
--%>

<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
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
        SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat formatoHora = new SimpleDateFormat("HH:mm");
        String fecha = formato.format(evento.getFechaInicio());

        Integer nEntradas = Integer.parseInt((String) request.getAttribute("nEntradas"));

        DecimalFormat moneyFormat1 = new DecimalFormat("#.00");
        String precioTotal = moneyFormat1.format(evento.getCosteEntrada() * nEntradas);
    %>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="jsComprarTicket.js" defer></script>

        <div class="cabecera">
            <div class="welkarten" style="clear:right">
                <img src="images/ticket.png" width="150" height="150" >
            </div>
        </div>

        <form class="contenido2" action="ServletGuardarTicket">
            <input type="hidden" name="idEvento" value="<%=evento.getId()%>" />
            <input type="hidden" name="nEntradas" value="<%=nEntradas%>" />
            <div class="credit-card-div2">
                <div class="panel panel-default" >
                    <div class="panel-heading">
                        <img src="images/tarjetas_credito.jpg" width="150" height="100"/>
                        <div class="form-pago2">
                            <div class="row filaPago">
                                <div class="col-md-8">
                                    <span class="help-block text-muted medium-font" > Nombre del titular</span>
                                    <input type="text" class="form-control" placeholder="Name On The Card" />
                                </div>
                            </div>
                            <div class="row filaPago">
                                <div class="col-md-6">
                                    <span class="help-block text-muted medium-font" > Número de tarjeta</span>
                                    <input type="text" class="form-control" placeholder="Enter Card Number" maxlength="16" />
                                </div>
                            </div>
                            <div class="row filaPago">
                                <div class="col-md-2 col-sm-2 col-xs-2">
                                    <span class="help-block text-muted small-font" > Mes de expiración</span>
                                    <input type="text" class="form-control" placeholder="MM" maxlength="2" />
                                </div>
                                <div class="col-md-2 col-sm-2 col-xs-2">
                                    <span class="help-block text-muted small-font" >  Año de expiración</span>
                                    <input type="text" class="form-control" placeholder="YY" maxlength="2" />
                                </div>
                                <div class="col-md-2 col-sm-2 col-xs-2">
                                    <span class="help-block text-muted small-font" >  CVV</span>
                                    <input type="text" class="form-control" placeholder="CCV" maxlength="4" />
                                </div>
                                <div class="col-md-3 col-sm-3 col-xs-3" style="margin-top: -10px;">
                                    <img src="images/cvv.png" width="80" height="80"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class = "resumen">
                <div class = "contenido_resumen">
                    <strong>EVENTO: </strong><label><%=evento.getTitulo()%></label></br>
                    <strong>LUGAR: </strong><label><%=evento.getLugar()%></label></br>
                    <strong>FECHA: </strong><label><%=fecha%></label></br>
                    <strong>HORA: </strong><label><%=formatoHora.format(evento.getHora())%></label></br>
                    <strong>NÚMERO DE ENTRADAS: </strong><label><%=nEntradas%></label></br></br>

                    <strong>PRECIO TOTAL (IVA INCLUIDO): </strong><label><%=precioTotal%>€</label>
                </div>
            </div>
            <div style="float: right; margin-right: 10%">
                <input type="button" class="btn btn-light btn-lg" value="Cancelar" onclick="location.href='ServletEventoInfo?id=<%=evento.getId()%>'" />
                <input type="submit" class="btn btn-primary btn-lg" value="Confirmar"/>
            </div>
        </form>
    </body>
</html>

<%-- 
    Document   : ComprarTicketEvento
    Created on : 21-abr-2021, 9:40:41
    Author     : yeray
--%>
<%@page import="GestorEventos2021.dao.EntradaFacade"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@page import="GestorEventos2021.entity.Entrada"%>
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
        
        List<Integer> listaEntradas = (List<Integer>) request.getAttribute("listaEntradas");
        boolean hayEntradasCompradas = listaEntradas != null;
    %>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="jsComprarTicket.js" defer></script>

        <div class="cabecera2">
            <div class="welkarten">
                <img src="images/ticket.png" width="150" height="150" >
            </div>
        </div>

        <!-- WIZARD -->        
        <form id="regForm" action="ServletGuardarTicket">
            <input type="hidden" name="idEvento" value="<%=evento.getId()%>" />
            <input type="hidden" name="nEntradas" value="<%=nEntradas%>" />
            <!-- Circles which indicates the steps of the form: -->
            <div class="pasos">
                <div class="paso">
                    <span class="step">1</span><br/>
                    <h4 class="tipo_paso">Selecciona tus asientos</h4>
                </div>
                <div class="paso">
                    <span class="step">2</span><br/>
                    <h4 class="tipo_paso">Método de pago</h4>
                </div>
                <div class="paso">
                    <span class="step">3</span><br/>
                    <h4 class="tipo_paso">Resumen</h4>
                </div>
            </div>

            <!-- One "tab" for each step in the form: -->
            <div class="wizard">
                <div class="tab">
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
                                                
                                                if (hayEntradasCompradas && listaEntradas.contains(id)){
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
                </div>
                <div class="tab">
                    <div class="credit-card-div">
                        <div class="panel panel-default" >
                            <div class="panel-heading">
                                <img src="images/tarjetas_credito.jpg" width="150" height="100"/>
                                <div class="form-pago">
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
                                            <input type="text" class="form-control" placeholder="CCV" maxlength="3" />
                                        </div>
                                        <div class="col-md-3 col-sm-3 col-xs-3" style="margin-top: -10px;">
                                            <img src="images/cvv.png" width="80" height="80"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab">
                    <div class = "contenido_resumen">
                        <strong>EVENTO: </strong><label><%=evento.getTitulo()%></label></br>
                        <strong>LUGAR: </strong><label><%=evento.getLugar()%></label></br>
                        <strong>FECHA: </strong><label><%=fecha%></label></br>
                        <strong>HORA: </strong><label><%=formatoHora.format(evento.getHora())%></label></br>
                        <strong>NÚMERO DE ENTRADAS: </strong><label><%=nEntradas%></label></br>
                        <strong>ASIENTOS SELECCIONADOS: </strong><label id="asientosSeleccionados"></label></br>

                        <strong>PRECIO TOTAL (IVA INCLUIDO): </strong><label><%=precioTotal%>€</label>

                    </div>
                </div>
            </div>
            </br>
            <div style="float:left">
                <input type="button" class="btn btn-secondary btn-lg" id="cancelarBtn" value="Cancelar" onclick="location.href='ServletEventoInfo?id=<%=evento.getId()%>'" />
            </div>
            <div style="float: right">
                <input type="button" class="btn btn-info btn-lg" id="prevBtn" value="Anterior" onclick="nextPrev(-1)" />
                <input type="button" class="btn btn-primary btn-lg" id="nextBtn" value="Siguiente" onclick="nextPrev(1)" />
            </div>
        </form>
    </body>
</html>

<%-- 
    Document   : MisEventos
    Created on : 13-may-2021, 23:46:12
    Author     : yeray
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="GestorEventos2021.entity.Etiquetasevento"%>
<%@page import="GestorEventos2021.entity.Evento"%>
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
    </head>
    <%
        List<Evento> listaEventosRecientes = (List<Evento>) request.getAttribute("listaEventosRecientes");
        List<Evento> listaEventosFinalizados = (List<Evento>) request.getAttribute("listaEventosFinalizados");

        SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat formatoHora = new SimpleDateFormat("HH:mm");
    %>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <jsp:include page="Navbar.jsp" />
        <br>
        <br>
        <br>
        <br>

        <h1 class="display-4">Mis eventos</h1>

        <div class="eventosProximos">
            <h2 class="pb-2 border-bottom">Mis eventos próximos</h2>
            <div class="">
                <% if (listaEventosRecientes == null || listaEventosRecientes.isEmpty()) { %>
                <h4>No hay resultados</h4>
                <% } else {%>
                <table class="table">
                    <thead>
                        <tr class="table-primary">
                            <th scope="col">Titulo</th>
                            <th scope="col">Lugar</th>
                            <th scope="col">Fecha</th>
                            <th scope="col">Hora</th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Evento e : listaEventosRecientes) { %>
                            <tr>
                                <td><%=e.getTitulo()%></td>
                                <td><%=e.getLugar()%></td>
                                <td><%=formatoFecha.format(e.getFechaInicio())%></td>
                                <td><%=formatoHora.format(e.getHora())%></td>
                                <td><input type="button" class="btn btn-outline-primary" onclick="location.href = 'ServletMisEntradas?eventoid=<%=e.getId()%>'" value="Ver mis entradas" /></td>
                            </tr>
                <% 
                            }
                    }
                %>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="eventosFinalizados">
            <h2 class="pb-2 border-bottom">Mis eventos finalizados</h2>

            <div class="">
                <% if (listaEventosFinalizados == null || listaEventosFinalizados.isEmpty()) { %>
                <h4>No hay resultados</h4>
                <% } else {%>
                <table class="table">
                    <thead>
                        <tr class="table-primary">
                            <th scope="col">Titulo</th>
                            <th scope="col">Lugar</th>
                            <th scope="col">Fecha</th>
                            <th scope="col">Hora</th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Evento e : listaEventosFinalizados) { %>
                            <tr>
                                <td><%=e.getTitulo()%></td>
                                <td><%=e.getLugar()%></td>
                                <td><%=formatoFecha.format(e.getFechaInicio())%></td>
                                <td><%=formatoHora.format(e.getHora())%></td>
                                <td><input type="button" class="btn btn-outline-primary" onclick="location.href = 'ServletMisEntradas?eventoid=<%=e.getId()%>'" value="Ver mis entradas" /></td>
                            </tr>
                <% 
                            }
                    }
                %>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>

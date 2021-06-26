
<%@ page import="es.taw.welkarten.dto.EstudioDTO" %>
<%@ page import="es.taw.welkarten.dto.UsuarioDTO" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>INFO Estudio</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">

    </head>
    
    <%

        EstudioDTO e = (EstudioDTO)request.getAttribute("estudio");
        UsuarioDTO u = (UsuarioDTO) request.getAttribute("usuario");
    %>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <jsp:include page="Navbar.jsp" />
        <br>
        <br>
        <br>

        <div style="padding: 2% 15%;">


            <div class="card mb-3"  style="max-width: 1400px" >
                 <div class="row g-0">
                    <div class="col-md-4">
                        <img src="/images/stats.png"  style="max-width: 400px;">
                    </div>
                    <div class="col-md-8">
                        <div class="card-body" style="padding: 2% 20%;text-align: left;">
                            <h5 class="card-title">Información del estudio <%= e.getId()%></h5>
                            <p class="card-text">Usuario: <%= u.getNombre()%></p>
                            <p class="card-text"><small class="text-muted">Correo: <%= u.getCorreo()%></small></p>
                            <p class="card-text"><small class="text-muted">NIF: <%= u.getNif()%></small></p>
                            <p class="card-text">Estudio: </p>
                            <p class="card-text"><small class="text-muted">Descripción: <%= e.getDescripcion()%></small></p> 
                            <p class="card-text"><small class="text-muted">Resultado: <%= e.getResultado()%></small></p> 
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
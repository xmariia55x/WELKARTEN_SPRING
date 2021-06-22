<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="es.taw.welkarten.entity.Estudio" %><%--
    Document   : CrearEditarEstudio
    Created on : 12-may-2021, 16:48:13
    Author     : david
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="styles.css" rel="stylesheet">
        <title>Editar Estudio</title>
    </head>
    <%
        Estudio e = (Estudio)request.getAttribute("estudio");
       
        
    %>
    
    <body>
        
        <!-- Optional JavaScript; choose one of the two! -->

        <!-- Option 1: Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

        <!-- Option 2: Separate Popper and Bootstrap JS -->
        <!--
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js" integrity="sha384-SR1sx49pcuLnqZUnnPwx6FCym0wLsk5JZuNx2bPPENzswTNFaQU1RDvt3wT4gWFG" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.min.js" integrity="sha384-j0CNLUeiqtyaRmlzUHCPZ+Gy5fQu0dQ6eZ/xAww941Ai1SxSY+0EQqNXNE6DZiVc" crossorigin="anonymous"></script>
        -->
        
        <jsp:include page="Navbar.jsp" />
            
                <br>
                <br>
                <br>
       <!--- FORMULARIO PARA EDITAR UN ESTUDIO --->
       
       <div class="global_editar_estudio" style="padding: 2% 15%">
           <form:form method="post" modelAttribute="estudioDTO" action="/analista/crearDTO">
               <form:hidden path="id"></form:hidden>
                <div class="mb-3">
                    <label  class="form-label">Correo del analista</label>
                    <form:input type="text"  path="correo" class="form-control" ></form:input>
                </div>
                <div class="mb-3">
                    <label  class="form-label">Descripción del estudio</label>
                    <form:input type="text" path="descripcion" class="form-control" ></form:input>
                </div>

                <div class="mb-3">
                    <label  class="form-label">Resultado del estudio</label>
                    <form:input type="text" path="resultado" class="form-control" ></form:input>
                </div> 

                <div class="d-grid gap-2 col-6 mx-auto">
                    <button type="submit" class="btn btn-primary btn-lg" >Guardar estudio</button>
                </div>
             </form:form>
        </div>
       
    </body>
</html>

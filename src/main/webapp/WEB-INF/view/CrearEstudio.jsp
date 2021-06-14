<%@page import="GestorEventos2021.entity.Evento"%>
<%@page import="GestorEventos2021.entity.Usuario"%>
<%@page import="GestorEventos2021.entity.Estudio"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates eee
and open the template in the editor.fcxddxdnjnjjnjnj
-->
<html>
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="styles.css" rel="stylesheet">
        <title>Crear Estudio</title>
    </head>
    
        <%
            Usuario user = (Usuario) session.getAttribute("usuario");
            //List <Estudio> estudios = (List) request.getAttribute("listaEstudios");
            List<Evento> eventos = (List) request.getAttribute("eventos");
            
        %>
    
    <body>  
        
       
        <!-- Optional JavaScript; choose one of the two! -->

        <!-- Option 1: Bootstrap Bundle with Popper -->
        <!---HAS QUITAO ESTE<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

        <!-- Option 2: Separate Popper and Bootstrap JS -->
        <!--
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js" integrity="sha384-SR1sx49pcuLnqZUnnPwx6FCym0wLsk5JZuNx2bPPENzswTNFaQU1RDvt3wT4gWFG" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.min.js" integrity="sha384-j0CNLUeiqtyaRmlzUHCPZ+Gy5fQu0dQ6eZ/xAww941Ai1SxSY+0EQqNXNE6DZiVc" crossorigin="anonymous"></script>
        -->
       
        
        <jsp:include page="Navbar.jsp" />
            
                <br>
                <br>
                <br>

       
        
        
         <div class="global_nuevo_evento">
              <h1>Estudio sobre los asistentes de un evento</h1> <br/>
              
             <form name="CrearEditarUsuarioForm" action="ServletCrearEstudio">
                 
                <div class="mb-3">
                    <label for="exampleDropdownFormEmail2" class="form-label">Selecciona el evento a estudiar</label>
                    <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" name="selectEvento" >
                        
                    
                    <%
                                for(Evento e : eventos){
                                %>
                            <li><a class="dropdown-item" >
                                    <option value="<%=e.getTitulo()%>"> <%=e.getTitulo()%>  </option>
                            <%}
                                %>
                     </select>           
                        
                     </div>
                
                <div class="mb-3" >
                    
                    
                        
                              <label for="exampleDropdownFormEmail2" class="form-label">Selecciona el signo</label>
                        <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" name="selectSigno" >
                            <option value="<"> <  </option>
                            <option value="="> =  </option>
                            <option value=">"> >  </option>
                        </select>
                </div>

                 <div class="mb-3"  >
                    <label for="exampleDropdownFormEmail2" class="form-label">Introduce la edad:</label>
                    <input type="text" width="20" name="edad" class="form-control" id="edad"  required>                
                </div>
                 
                 <div class="mb-3" >
                    <label for="exampleDropdownFormEmail2" class="form-label">Introduce la descripción del estudio:</label>
                    <input type="text" width="20" name="descripcion" class="form-control" id="descripcion"  required>                
                </div>
                
                 <div class="d-grid gap-2 col-6 mx-auto">
                    <button type="submit" class="btn btn-primary btn-lg">Crear estudio</button>
                </div>
                 
            </form>
        </div>
        
        
        
        
         <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>

    </body>
</html>

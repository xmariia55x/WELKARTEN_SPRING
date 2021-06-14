<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="styles.css" rel="stylesheet">
        <title>Iniciar sesi�n</title>
    </head>
        
    <body>

        <!-- Optional JavaScript; choose one of the two! -->

        <!-- Option 1: Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

        <!-- Option 2: Separate Popper and Bootstrap JS -->
        <!--
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js" integrity="sha384-SR1sx49pcuLnqZUnnPwx6FCym0wLsk5JZuNx2bPPENzswTNFaQU1RDvt3wT4gWFG" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.min.js" integrity="sha384-j0CNLUeiqtyaRmlzUHCPZ+Gy5fQu0dQ6eZ/xAww941Ai1SxSY+0EQqNXNE6DZiVc" crossorigin="anonymous"></script>
        -->
        <div class="global_inicio_sesion">
            
            <%
            String strError = (String)request.getAttribute("error");
            
            if(strError != null) {
                if(strError.equals("v")) {
                    %>
                    <div class="alert alert-danger" role="alert">
                    ERROR: Campos vac�os
                    </div>
                    <%    
                    } else if(strError.equals("n")) {
                    %>
                    <div class="alert alert-danger" role="alert">
                    ERROR: Usuario o contrase�a incorrectos
                    </div>
                    <%
                    }
            }
            %>
            
            
            <img src="images/ticket.png" width="200" height="200">

            <form method = "POST" action="ServletIniciarSesion">
                <input type="hidden" name="ruta" value="" />
                <input type="hidden" name="evento" value="" />
                <div class="mb-3">
                    <label for="exampleDropdownFormEmail2" class="form-label">Correo electr�nico</label>
                    <input type="email" name="email" class="form-control" id="email_usuario" placeholder="email@example.com">
                </div>
                <div class="mb-3">
                    <label for="exampleDropdownFormPassword2" class="form-label">Contrase�a</label>
                    <input type="password" name="password" class="form-control" id="contrasenia_usuario">
                </div>
                <div class="d-grid gap-2 col-6 mx-auto">
                    <button type="submit" id="btnInicioSesion" class="btn btn-primary btn-lg">Iniciar sesi�n</button>

                    <div class="registro">
                        <a href="Registro.jsp">�A�n no tienes cuenta? Reg�strate</a>
                    </div>
                </div>
            </form>

        </div>
        
    </body>
    
    
</html>

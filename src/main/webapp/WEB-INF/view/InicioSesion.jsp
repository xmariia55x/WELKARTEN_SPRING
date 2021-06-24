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
        <link href="/css/styles.css" rel="stylesheet">
        <title>Iniciar sesión</title>
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
                    ERROR: Campos vacios
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
            
            
            <img src="/images/ticket.png" width="200" height="200">

            <form method = "POST" action="/autenticar">
                <input type="hidden" name="ruta" value="" />
                <input type="hidden" name="evento" value="" />
                <div class="mb-3">
                    <label class="form-label">Correo electronico</label>
                    <input type="email" name="email" class="form-control" id="email_usuario" placeholder="email@example.com">
                </div>
                <div class="mb-3">
                    <label class="form-label">Contrasena</label>
                    <input type="password" name="password" class="form-control" id="contrasenia_usuario">
                </div>
                <div class="d-grid gap-2 col-6 mx-auto">
                    <button type="submit" id="btnInicioSesion" class="btn btn-primary btn-lg">Iniciar sesion</button>

                    <div class="registro">
                        <a href="/usuarioeventos/registro">Aun no tienes cuenta? Registrate</a>
                    </div>
                </div>
            </form>

        </div>
        
    </body>

</html>

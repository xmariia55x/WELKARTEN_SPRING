
    <head>

        <title>Formulario de contacto</title>

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="styles2.css" rel="stylesheet">      
        <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/pricing/">
        <link href="/docs/5.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">

    </head>
    <%
       String done = (String)request.getAttribute("done");
       String strError = (String)request.getAttribute("strErr");
    %>
    <body>  

         <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <jsp:include page="Navbar.jsp" />

        <br/>
        <br/>
        <br/>
        <br/>
        
        
        <%
            if(done != null) {
        %>        
                <div class="alert alert-success" role="alert">
                Conversaci&oacute;n creada con &eacute;xito
                </div>
        <%
            }    
            if(strError != null) {
                if(strError.equals("v")) {
                    %>
                    <div class="alert alert-danger" role="alert">
                    ERROR: Debe iniciar sesi&oacute;n para poder contactarnos
                    </div>
                    <%    
                } else if(strError.equals("i")) {
                    %>
                    <div class="alert alert-danger" role="alert">
                    ERROR: Recuerde que debe estar registrado como usuario o creador de eventos para poder contactarnos
                    </div>
                    <%
                    }
                }   
            %>
        
        <div class="d-grid gap-2 col-6 mx-auto gridazo">
                   
        <input type="button" class="btn btn-primary btn-lg" id="btnContacto" value="Quiere ponerse en contacto con un teleoperador?" name="btnContacto"
                                       onclick="location.href = '/crearConversacion'" />

            <p class="fw-light">NOTA: Para poder contactarnos, debe estar registrado como usuario o ser un creador de eventos</p>

        </div>

        
        <!--
        <div class="contact_form">

            <div class="formulario">    
                <br/>
                <h1>Formulario de contacto</h1>
                <h3>Escr�benos y en breve nos pondremos en contacto contigo</h3>


                <form action="submeter-formulario.php" method="post">       


                    <p>
                        <label for="nombre" class="colocar_nombre" >Nombre
                            <span class="obligatorio">*</span>
                        </label>
                        <input type="text" name="introducir_nombre" id="nombre" required="obligatorio">
                    </p>

                    <p>
                        <label for="email" class="colocar_email">Email
                            <span class="obligatorio">*</span>
                        </label>
                        <input type="email" name="introducir_email" id="email" required="obligatorio" >
                    </p>

                    <p>
                        <label for="telefone" class="colocar_telefono">Tel�fono
                        </label>
                        <input type="tel" name="introducir_telefono" id="telefono" >
                    </p>    

                    <p>
                        <label for="website" class="colocar_website">Sitio web
                        </label>
                        <input type="url" name="introducir_website" id="website" >
                    </p>    

                    <p>
                        <label for="asunto" class="colocar_asunto">Asunto
                            <span class="obligatorio">*</span>
                        </label>
                        <input type="text" name="introducir_asunto" id="assunto" required="obligatorio" >
                    </p>    

                    <p>
                        <label for="mensaje" class="colocar_mensaje">Mensaje
                            <span class="obligatorio">*</span>
                        </label>                     
                        <textarea name="introducir_mensaje" class="texto_mensaje" id="mensaje" required="obligatorio" placeholder="Deja aqu� tu comentario..."></textarea> 
                    </p>                    

                    <button type="submit" name="enviar_formulario" id="enviar"><p>Enviar</p></button>

                    <p class="aviso">
                        <span class="obligatorio"> * </span>los campos son obligatorios.
                    </p>          

                </form>
            </div>  

        </div>
        <br/>
        -->
        
    </body>



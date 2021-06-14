<%-- 
    Document   : conocenos
    Created on : 27-abr-2021, 16:13:21
    Author     : Javi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>JSP Page</title>

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="/css/styles2.css" rel="stylesheet">
        <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/pricing/">
        <link href="/docs/5.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">

        <style>
            .imagenes {
                border-radius: 50%;
            }

            .row {
                display: flex;
                margin-left:-5px;
                margin-right:-5px;
                justify-content: center

            }

            .column {
                flex: 50%;
                margin: auto;
                width: 60%;
                padding: 0px;
            }
        </style>
    </head>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <jsp:include page="Navbar.jsp" />

        <br/>
        <br/>
        <br/>
        <br/>
        <br/>
        <br/>


        <!--
        
                <section class="card card-column bg-transparent rounded-0 border-0 align-items-stretch w-100 pos-rel">
                    <section class="card-body pb-1 pos-rel z-4" style="opacity: 1;">
                        <figure class="section-img text-center mb-2"><img width="451" height="451" src="https://digitaluncut.com/wp-content/uploads/2020/05/DSC05118-square-2.jpg" class="attachment-square size-square" alt="Sam" loading="lazy" srcset="https://digitaluncut.com/wp-content/uploads/2020/05/DSC05118-square-2.jpg 451w, https://digitaluncut.com/wp-content/uploads/2020/05/DSC05118-square-2-300x300.jpg 300w, https://digitaluncut.com/wp-content/uploads/2020/05/DSC05118-square-2-150x150.jpg 150w, https://digitaluncut.com/wp-content/uploads/2020/05/DSC05118-square-2-110x110.jpg 110w, https://digitaluncut.com/wp-content/uploads/2020/05/DSC05118-square-2-240x240.jpg 240w" sizes="(max-width: 451px) 100vw, 451px"></figure>
                        <div class="column-text mt-1"><h4 class="h5 mb-1">Sam Martin-Ross</h4>
                            <p>Fundador y CEO</p>
                            <ul>
                                <li>Comenzó Digital Uncut en Julio de 2016</li>
                            </ul>
                            <p><a class="font-weight-medium" href="/cdn-cgi/l/email-protection#2053414d604449474954414c554e4355540e434f4d"><span class="__cf_email__" data-cfemail="aeddcfc3eecac7c9c7dacfc2dbc0cddbda80cdc1c3">[email&nbsp;protected]</span></a></p>
                            <p><a class="font-weight-medium" href="https://www.linkedin.com/in/sammartinross/" target="_blank" rel="noopener">LinkedIn</a></p>
                        </div>
                    </section>
                </section>
                
        -->

        <div class="row">
            <div class="column">
                <div class="card-body" style="opacity: 1;">
                    <img class="imagenes" src="/images/FotoPerfilJavi.jpg" alt="Javi" width="300" height="300">
                    <div class="column-text mt-1"><h4 class="h5 mb-1">Javier Blanco Navarro</h4>
                        <p>Estudiante de ingeniería de software en la UMA </p>

                          Aficionado a la lectura <br/>
                          Amante de los videojuegos <br/>
                          Avanzando en el desarrollo personal y la programación<br/>
                          Apasionado de la permacultura y la sostenibilidad <br/>
                        <br/>
                        <h5> Email: javiblanco2000@gmail.com </h5>

                    </div>
                </div>
            </div>

            <div class="column">
                <div class="card-body" style="opacity: 1;">
                    <img class="imagenes" src="/images/FotoPerfilMaria.jpg" alt="Maria" width="300" height="300">
                    <div class="column-text mt-1"><h4 class="h5 mb-1">María Gálvez Manceras</h4>
                        <p>Estudiante de ingeniería de software en la UMA </p>

                        Aficionada a la lectura <br/>
                        Amante de los idiomas y de viajar <br/>
                        Apasionada de la música y el deporte <br/>
                        <br/>
                        <h5> Email: mariagalvez12345@gmail.com </h5>

                    </div>
                </div>
            </div>

            <div class="column">
                <div class="card-body" style="opacity: 1;">
                    <img class="imagenes" src="/images/FotoPerfilAdri.jpg" alt="Adri" width="300" height="300">
                    <div class="column-text mt-1"><h4 class="h5 mb-1">Adrián Corrales Moreno</h4>
                        <p>Estudiante de ingeniería de software en la UMA </p>

                        Aficionado a la fotografía <br/>
                        Apasionado de la música, viajar y el deporte <br/>
                        
                        <br/>
                        <h5> Email: adricorrales1234@gmail.com </h5>
                    </div>
                </div>
            </div>
        </div>



        <div class="row">
            <div class="column">
                <div class="card-body" style="opacity: 1;">
                    <img  class="imagenes" src="/images/FotoPerfilDavid.jpg" alt="David" width="300" height="300">
                    <div class="column-text mt-1"><h4 class="h5 mb-1">David Gerena Comino</h4>
                        <p>Estudiante de ingeniería de software en la UMA </p>


                        Aficionado a las series <br/>
                        Apasionado de los videojuegos y el deporte <br/>
                        
                        Iniciándose en el tenis <br/>
                        <br/>
                        <h5> Email: davidgerecomi@gmail.com </h5>


                    </div>
                </div>
            </div>
            <div class="column">
                <div class="card-body" style="opacity: 1;">
                    <img class="imagenes" src="/images/FotoPerfilYeray.jpg" alt="Yeray" width="300" height="300">
                    <div class="column-text mt-1"><h4 class="h5 mb-1">Yeray Ruiz Suárez</h4>
                        <p>Estudiante de ingeniería de software en la UMA </p>

                        Entrenador de fútbol <br/>
                        Aficionado al desarrollo de aplicaciones web <br>
                        Apasionado del diseño de páginas web <br>
                        <br/>
                        <h5> Email: yeray.r7@uma.es </h5>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

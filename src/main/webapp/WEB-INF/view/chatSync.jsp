<%@ page import="es.taw.welkarten.entity.Usuario" %>
<%@ page import="es.taw.welkarten.dto.UsuarioDTO" %>
<%@ page import="es.taw.welkarten.dto.ConversacionDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
    <title>Chat</title>
    <link rel="stylesheet" href="/css/main.css" />
</head>
<%
    UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("usuario");
    ConversacionDTO conversacion = (ConversacionDTO) request.getAttribute("conversacion");
    session.setAttribute("conversacion", conversacion);
%>
<body background="maxresdefault.jpg"
      style="background-position: center; background-repeat: no-repeat; background-size: cover;">
<noscript>
    <h2>ERROR: El navegador no soporta JavaScript</h2>
</noscript>

<div id="username-page">
    <div class="username-page-container">

        <form id="usernameForm" name="usernameForm">
            <div class="form-group">
                <br/>
                <br/>
                <input type="text" value="<%= usuario.getNombre() %>" id="name" placeholder="Nome"
                       autocomplete="off" class="form-control" readonly="readonly" />
            </div>
            <div class="form-group">
                <button type="submit" class="accent username-submit">Empiece a chatear!</button>
            </div>
        </form>
    </div>
</div>

<div id="chat-page" class="hidden">
    <div class="chat-container">
        <div class="chat-header">
            <h2>Chat entre <%= conversacion.getUsuario().getNombre() %> y <%= conversacion.getTeleoperador().getNombre() %></h2>
        </div>
        <div class="connecting">Conectando al chat...</div>
        <ul id="messageArea">

        </ul>
        <form id="messageForm" name="messageForm" nameForm="messageForm">
            <div class="form-group">
                <div class="input-group clearfix">
                    <input type="text" id="message" placeholder="Escriba aqu&iacute; su mensaje..."
                           autocomplete="off" class="form-control" />
                    <button type="submit" class="primary">Enviar</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script
        src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
<script
        src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="/js/main.js"></script>
</body>
</html>
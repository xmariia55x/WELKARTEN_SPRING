<%-- 
    Document   : Navbar
    Created on : 22-abr-2021, 11:15:26
    Author     : yeray
--%>


<%@page import="java.util.List"%>
<%@ page import="es.taw.welkarten.entity.Usuario" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
%>
<header>
    <nav class="navbar navbar-expand-lg navbar-light bg-light" >
        <div class="container-fluid">
            <a class="navbar-brand" href="ServletInicio">
                <img src="/images/logo_pequeno.png" alt="" width="200" height="50">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" href="ServletInicio">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/conocenos">Conócenos</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/contactanos">Contáctanos</a>
                    </li>
                </ul>
                <form class="d-flex" style="margin-right: 2em" action="ServletFiltrarEvento">
                    <input class="form-control me-2" type="search" name="busqueda" placeholder="Search" aria-label="Search">
                        <button class="btn btn-outline-primary" type="submit">Buscar</button>
                </form>
                <br/>
                <% if (usuario == null) { %>
                <input type="button" class="btn btn-primary btn-lg" id="inicio_sesion_principal_button" value="Iniciar sesión" name="inicio_sesion_principal_button"
                       onclick="location.href = '/login'" />
                <% } else { %>
                <div class="btn-group">
                    <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
                            <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
                        </svg>
                        <label>Mi cuenta</label>
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="VerPerfil.jsp">Mi perfil</a></li>
                        <li><a class="dropdown-item" href="ServletMisEventos">Mis eventos</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="ServletCerrarSesion">
                                Salir
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-right" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M10 12.5a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v2a.5.5 0 0 0 1 0v-2A1.5 1.5 0 0 0 9.5 2h-8A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-2a.5.5 0 0 0-1 0v2z"/>
                                    <path fill-rule="evenodd" d="M15.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L14.293 7.5H5.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/>
                                </svg>
                            </a>
                        </li>
                    </ul>
                </div>
                <% }%>
            </div>
        </div>
    </nav>
</header>

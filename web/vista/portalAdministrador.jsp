<%@page import="modelo.Usuario"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
%>

<script>
    alert('<%= mensaje %>');
</script>

<%
    session.removeAttribute("mensaje");
    }

    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("/index.jsp");
        return;
    }

    if (!usuario.getRol().equals("administrador")) {
        session.removeAttribute("usuarii");
        response.sendRedirect("/index.jsp");
    }

    String nombre = usuario.getNombre();
    String rol = usuario.getRol();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Portal de Administrador</title>
    <link rel="stylesheet" href="/vista/css/portalAdministrador.css?v=1.2">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="admin-container">
        <header class="admin-header">
            <h1>Bienvenido, <%= nombre %> 👋</h1>
            <p class="rol">Rol: <%= rol %></p>
        </header>

        <main class="admin-content">
            <h2><i class="fa-solid fa-screwdriver-wrench"></i> Panel de Administración</h2>
            <p>Desde aquí puedes gestionar usuarios y materias del sistema.</p>

            <div class="admin-actions">
                <form action="/AdministrarUsuarios" method="get">
                    <button type="submit" class="btn primary">
                        <i class="fa-solid fa-users-gear"></i> Administrar usuarios
                    </button>
                </form>

                <form action="/AdministrarMaterias" method="get">
                    <button type="submit" class="btn primary">
                        <i class="fa-solid fa-book-open"></i> Administrar materias
                    </button>
                </form>

                <form action="/CerrarSesion" method="post">
                    <button type="submit" class="btn danger">
                        <i class="fa-solid fa-right-from-bracket"></i> Cerrar sesión
                    </button>
                </form>
            </div>
        </main>
    </div>
</body>
</html>
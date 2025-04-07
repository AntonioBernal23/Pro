<%@page import="modelo.Usuario"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
%>
    <script type='text/javascript'>
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

    Integer ID = usuario.getId();
    String nombre = usuario.getNombre();
    String usuarioNombre = usuario.getUsuario();
    String correo = usuario.getCorreo();
    String contrasena = usuario.getContraseña();
    String rol = usuario.getRol();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Portal de Administrador</title>
    <link rel="stylesheet" href="/vista/css/portalAdministrador.css?v=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="header">
        <h1>Bienvenido, <%= nombre %> 👋</h1>
        <p class="rol">Rol: <%= rol %></p>
    </div>

    <div class="contenido">
        <h2>Panel de Administración</h2>
        <p>Desde aquí puedes gestionar los usuarios y otras configuraciones del sistema.</p>

        <div class="acciones">
            <form action="/AdministrarUsuarios" method="get">
                <button type="submit" class="boton naranja">
                    <i class="fa-solid fa-users-gear"></i> Administrar usuarios
                </button>
            </form>

            <form action="/AdministrarMaterias" method="get">
                <button type="submit" class="boton naranja">
                    Administrar tareas
                </button>                    
            </form>
            
            <form action="/CerrarSesion" method="post">
                <button type="submit" class="boton salir">
                    <i class="fa-solid fa-right-from-bracket"></i> Cerrar sesión
                </button>
            </form>
        </div>
    </div>
</body>
</html>
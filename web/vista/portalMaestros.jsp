<%@page import="modelo.Usuario"%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>Portal de Maestro</title>
    <link rel="stylesheet" href="/vista/css/portalMaestros.css?v=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script>
        function toggleForm(id) {
            const form = document.getElementById(id);
            form.style.display = form.style.display === 'none' ? 'block' : 'none';
        }
    </script>
</head>
<body>
    <div class="header">
        <h1>¡Hola, <%= nombre %>! 👨‍🏫</h1>
        <p class="rol">Rol: <%= rol %></p>
    </div>

    <div class="contenido">
        <h2>Panel de Control</h2>
        <p>Gestiona tus tareas y eventos desde aquí.</p>

        <div class="acciones">
            <button class="boton naranja" onclick="toggleForm('formAgregarTarea')">
                <i class="fa-solid fa-plus"></i> Agregar Tarea
            </button>
            <button class="boton naranja" onclick="toggleForm('formModificarTarea')">
                <i class="fa-solid fa-pen-to-square"></i> Modificar Tarea
            </button>
            <button class="boton naranja" onclick="toggleForm('formAgregarEvento')">
                <i class="fa-solid fa-calendar-plus"></i> Agregar Evento
            </button>
        </div>

        <!-- Formulario Agregar Tarea -->
        <form id="formAgregarTarea" class="formulario" action="/AgregarTarea" method="post" style="display: none;">
            <h3>Agregar Tarea</h3>
            <input type="text" name="nombreTarea" placeholder="Nombre de la tarea" required>
            <input type="date" name="fechaEntrega" required>
            
            <button type="submit" class="boton naranja">Guardar Tarea</button>
        </form>

        <!-- Formulario Modificar Tarea -->
        <form id="formModificarTarea" class="formulario" action="/ModificarTarea" method="post" style="display: none;">
            <h3>Modificar Tarea</h3>
            <input type="text" name="nombreTarea" placeholder="Nuevo nombre de la tarea" required>
            <input type="date" name="nuevaFechaEntrega" required>
            
            <button type="submit" class="boton naranja">Modificar</button>
        </form>

        <!-- Formulario Agregar Evento -->
        <form id="formAgregarEvento" class="formulario" action="/AgregarEvento" method="post" style="display: none;">
            <h3>Agregar Evento</h3>
            <input type="text" name="nombreEvento" placeholder="Nombre del evento" required>
            <input type="date" name="fechaEvento" required>
            <input type="text" name="duracion" placeholder="Duración (ej: 2h)" required>
            <button type="submit" class="boton naranja">Guardar Evento</button>
        </form>

        <!-- Cerrar sesión -->
        <form action="/CerrarSesion" method="post">
            <button type="submit" class="boton salir">
                <i class="fa-solid fa-right-from-bracket"></i> Cerrar sesión
            </button>
        </form>
    </div>
</body>
</html>

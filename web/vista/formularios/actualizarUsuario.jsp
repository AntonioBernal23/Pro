<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="modelo.Usuario" %>

<%
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
        out.println("<script type='text/javascript'>");
        out.println("alert('" + mensaje + "');");
        out.println("</script>");
        session.removeAttribute("mensaje");
    }

    String roleAdmin = request.getParameter("roleAdmin");
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if (usuario == null || !"administrador".equals(roleAdmin)) {
        response.sendRedirect("/index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Actualizar Usuario</title>
        <link rel="stylesheet" href="/vista/css/formularios.css?v=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <div class="calendar-container">
            <div class="calendar">
                <header class="calendar-header">
                    <h2><i class="fa-solid fa-user-pen"></i> Actualizar Usuario</h2>
                    <p class="subtitulo">Modifica los datos del usuario</p>
                </header>

                <section class="calendar-table-container">
                    <div class="form-card">
                        <form action="/ActualizarUsuario" method="post" class="form">
                            <input type="hidden" name="id" value="<%= request.getParameter("id")%>">

                            <div class="field-group">
                                <label for="nombre">Nombre:</label>
                                <input type="text" name="nombre" id="nombre" value="<%= request.getParameter("nombre")%>" required>
                            </div>

                            <div class="field-group">
                                <label for="usuario">Usuario:</label>
                                <input type="text" name="usuario" id="usuario" value="<%= request.getParameter("usuario")%>" required>
                            </div>

                            <div class="field-group">
                                <label for="correo">Correo:</label>
                                <input type="email" name="correo" id="correo" value="<%= request.getParameter("correo")%>" required>
                            </div>

                            <div class="field-group">
                                <label for="contrasena">Contraseña:</label>
                                <input type="password" name="contrasena" id="contrasena" placeholder="Nueva contraseña..." required>
                            </div>

                            <div class="field-group">
                                <label for="confirmacion">Confirmar contraseña:</label>
                                <input type="password" name="confirmacion" id="confirmacion" placeholder="Confirmar..." required>
                            </div>

                            <input type="hidden" name="rol" value="<%= request.getParameter("rol")%>">

                            <button type="submit" class="btn submit-btn">
                                <i class="fa-solid fa-floppy-disk"></i> Actualizar
                            </button>
                        </form>
                    </div>
                </section>
            </div>
        </div>
    </body>
</html>

<%@page import="modelo.Usuario"%>

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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Agregar Administrador</title>
    <link rel="stylesheet" href="/vista/css/formularios.css?v=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="calendar-container">
        <div class="calendar">
            <header class="calendar-header">
                <h2><i class="fa-solid fa-user-shield"></i> Agregar Administrador</h2>
                <p class="subtitulo">Rellena los campos para registrar un nuevo administrador</p>
            </header>

            <section class="calendar-table-container">
                <div class="form-card">
                    <form action="/Registro" method="post" class="form">
                        <div class="field-group">
                            <label for="nombre">Nombre completo</label>
                            <input type="text" name="nombre" id="nombre" placeholder="Nombre..." required>
                        </div>

                        <div class="field-group">
                            <label for="usuario">Usuario</label>
                            <input type="text" name="usuario" id="usuario" placeholder="Usuario..." required>
                        </div>

                        <div class="field-group">
                            <label for="correo">Correo electrónico</label>
                            <input type="email" name="correo" id="correo" placeholder="Correo..." required>
                        </div>

                        <div class="field-group">
                            <label for="contrasena">Contraseña</label>
                            <input type="password" name="contrasena" id="contrasena" placeholder="Contraseña..." required>
                        </div>

                        <div class="field-group">
                            <label for="confirmacion">Confirmar contraseña</label>
                            <input type="password" name="confirmacion" id="confirmacion" placeholder="Confirmar contraseña..." required>
                        </div>

                        <!-- Hidden fields -->
                        <input type="hidden" name="rol" value="administrador">
                        <input type="hidden" name="origen" value="/vista/formularios/agregarUsuario.jsp">
                        <input type="hidden" name="destino" value="/vista/administrarUsuario.jsp">

                        <button type="submit" class="btn submit-btn">
                            <i class="fa-solid fa-user-plus"></i> Registrar
                        </button>
                    </form>
                </div>
            </section>
        </div>
    </div>
</body>
</html>

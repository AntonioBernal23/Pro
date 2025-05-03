<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
        out.println("<script type='text/javascript'>");
        out.println("alert('" + mensaje + "');");
        out.println("</script>");
        session.removeAttribute("mensaje");
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/vista/css/registro.css?v=2.0"> <!-- Reutilizar estilo -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="registro-container">
        <form action="InicioSesion" method="post" class="registro-form">
            <h1 class="registro-titulo">Iniciar Sesión</h1>

            <div class="input-group">
                <i class="fa fa-user"></i>
                <input type="text" name="usuario" placeholder="Nombre de usuario" required>
            </div>

            <div class="input-group">
                <i class="fa fa-lock"></i>
                <input type="password" name="contrasena" placeholder="Contraseña" required>
            </div>

            <button type="submit" class="btn-registro">
                <i class="fa-solid fa-right-to-bracket"></i> Ingresar
            </button>

            <p style="text-align: center; margin-top: 15px;">
                ¿No tienes cuenta? <a href="vista/registro.jsp?from=index" style="color: #1abc9c;">Crea una aquí.</a>
            </p>
        </form>
    </div>
</body>
</html>

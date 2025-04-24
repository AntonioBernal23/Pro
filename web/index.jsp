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
<html>
    <head>
        <title>Sesion</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="/vista/css/index.css">
    </head>
    <body>
        <form action="InicioSesion" method="post" class="container">
            <h1>Hola Inicio de sesion</h1>
            <input type="text" name="usuario" placeholder="Usuario..." class="entrada" required>
            <input type="password" name="contrasena" placeholder="Contraseña..." class="entrada" required>

            <button type="submit" class="submit">
                <i class="fa-solid fa-right-to-bracket"></i>
            </button>
            <p>¿No tienes cuenta?. <a href="vista/registro.jsp?from=index">Crea una aqui.</a></p>
        </form>
    </body>
</html>

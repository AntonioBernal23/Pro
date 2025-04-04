<%
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
        out.println("<script type='text/javascript'>");
        out.println("alert('" + mensaje + "');");
        out.println("</script>");
        session.removeAttribute("mensaje"); // Se el artributo borra después de mostrarlo
    }
%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="modelo.Usuario" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Actualizar Usuario</title>
    </head>
    <body>
        <h2>Actualizar Usuario</h2>
        <form action="/ActualizarUsuario" method="post">
            <input type="hidden" name="id" value="<%= request.getParameter("id")%>">

            <label for="nombre">Nombre:</label><br>
            <input type="text" name="nombre" value="<%= request.getParameter("nombre")%>" required><br><br>

            <label for="usuario">Usuario:</label><br>
            <input type="text" name="usuario" value="<%= request.getParameter("usuario")%>" required><br><br>

            <label for="correo">Correo:</label><br>
            <input type="email" name="correo" value="<%= request.getParameter("correo")%>" required><br><br>

            <label for="contrasena">Contraseña:</label><br>
            <input type="password" name="contrasena" required><br><br>

            <label for="confirmacion">Confirmar contrasela</label><br>
            <input type="password" name="confirmacion" required=""><br><br>

            <input type="hidden" name="rol" value="<%= request.getParameter("rol")%>" required><br><br>

            <input type="submit" value="Actualizar">
        </form>
    </body>
</html>

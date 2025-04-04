<%
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
        out.println("<script type='text/javascript'>");
        out.println("alert('" + mensaje + "');");
        out.println("</script>");
        session.removeAttribute("mensaje"); // Se el artributo borra después de mostrarlo
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Administrador</title>
    </head>
    <body>
        <form action="/Registro" method="post" class="container">
            <h1>Agreagar administrador</h1>
            <input type="text" name="nombre" placeholder="Nombre..." class="entrada" required>
            <input type="text" name="usuario" placeholder="Usuario..." class="entrada" required>
            <input type="text" name="correo" placeholder="Correo..." class="entrada" required>
            <input type="password" name="contrasena" placeholder="Contraseña..." class="entrada" required>
            <input type="password" name="confirmacion" placeholder="Confirmar contraseña..." class="entrada" required>
            <input type="hidden" name="rol" value="administrador">
            <input type="hidden" name="origen" value="/vista/formularios/agregarUsuario.jsp">
            <input type="hidden" name="destino" value="/vista/administrarUsuario.jsp">
            <input type="submit" value="Registrar" class="submit">
        </form>
    </body>
</html>

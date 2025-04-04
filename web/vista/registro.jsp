<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
        out.println("<script type='text/javascript'>");
        out.println("alert('" + mensaje + "');");
        out.println("</script>");
        session.removeAttribute("mensaje"); // Se el artributo borra después de mostrarlo
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="/vista/css/index.css?v=1.0">
        <title>Registro</title>
    </head>
    <body>
        <form action="/Registro" method="post" class="container">
            <h1>Registro</h1>
            <input type="text" name="nombre" placeholder="Nombre..." class="entrada" required>
            <input type="text" name="usuario" placeholder="Usuario..." class="entrada" required>
            <input type="text" name="correo" placeholder="Correo..." class="entrada" required>
            <input type="password" name="contrasena" placeholder="Contraseña..." class="entrada" required>
            <input type="password" name="confirmacion" placeholder="Confirmar contraseña..." class="entrada" required>
            <select name="rol" required>
                <option value="alumno">Alumno</option>
                <option value="maestro">Maestro</option>
            </select>
            <input type="hidden" name="origen" value="/vista/registro.jsp">
            <input type="hidden" name="destino" value="index.jsp">
            <input type="submit" value="Registrar" class="submit">
        </form>
    </body>
</html>
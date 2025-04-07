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
        <title>Agregar Materia</title>
    </head>
    <body>
        <form action="/RegistroMateria" method="post" class="container">
            <h1>Agreagar administrador</h1>
            <input type="text" name="nombre" placeholder="Nombre..." class="entrada" required>
            <input type="text" name="codigo" placeholder="Codigo..." class="entrada" required>
            <input type="text" name="descripcion" placeholder="Descripcion..." class="entrada" required>
            <input type="password" name="contrasena" placeholder="Contraseña..." class="entrada" required>
            <select name="dia" required>
                <option value="">Selecciona el dia</option>
                <option value="alumno">Lunes</option>
                <option value="maestro">Martes</option>
                <option value="alumno">Miercoles</option>
                <option value="alumno">Jueves</option>
                <option value="alumno">Viernes</option>
            </select>
            <input type="submit" value="Registrar" class="submit">
        </form>
    </body>
</html>

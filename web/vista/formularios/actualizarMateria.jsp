<%
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
        out.println("<script type='text/javascript'>");
        out.println("alert('" + mensaje + "');");
        out.println("</script>");
        session.removeAttribute("mensaje");
    }
%>

<%@ page import="modelo.Materia" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Actualizar Materia</title>
    </head>
    <body>
        <h2>Actualizar materia</h2>
        <form action="/ActualizarMateria" method="post">
            <input type="hidden" value="<%= request.getParameter("id")%>" name="id">
            
            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" name="nombre" required>
            
            <label for="codigo">Codigo:</label>
            <input type="text" id="codigo" name="codigo" required>
            
            <label for="cupos">Cupos:</label>
            <input type="number" id="cupos" name="cupos" min="1" max="20" required="">
            
            <label for="descripcion">Descripcion:</label>
            <input type="text" id="descripcion" name="descripcion" required>
            
            <label for="dia">Dia:</label>
            <select id="dia" name="dia" required>
                <option value="">Selecciona el dia</option>
                <option value="lunes">Lunes</option>
                <option value="martes">Martes</option>
                <option value="miercoles">Miercoles</option>
                <option value="jueves">Jueves</option>
                <option value="viernes">Viernes</option>
            </select>
            
            <label for="hora_comienzo">Hora comienzo:</label>
            <select id="hora_comienzo" name="hora_comienzo" required>
                <option value="08:00">08:00</option>
                <option value="09:00">09:00</option>
                <option value="10:00">10:00</option>
                <option value="11:00">11:00</option>
                <option value="12:00">12:00</option>
                <option value="13:00">13:00</option>
                <option value="14:00">14:00</option>
            </select>
            
            <label for="hora_fin">Hora fin:</label>
            <select id="hora_fin" name="hora_fin" required>
                <option value="08:00">08:00</option>
                <option value="09:00">09:00</option>
                <option value="10:00">10:00</option>
                <option value="11:00">11:00</option>
                <option value="12:00">12:00</option>
                <option value="13:00">13:00</option>
                <option value="14:00">14:00</option>
            </select>
            <input type="submit" value="Actualizar" class="submit">
        </form>
    </body>
</html>

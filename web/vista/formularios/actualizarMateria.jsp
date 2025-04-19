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
            <input type="text" id="nombre" name="nombre" value="<%= request.getParameter("nombre")%>" required>

            <label for="codigo">Codigo:</label>
            <input type="text" id="codigo" name="codigo" value="<%= request.getParameter("codigo")%>" required>

            <label for="cupos">Cupos:</label>
            <input type="number" id="cupos" name="cupos" min="1" max="20" value="<%= request.getParameter("cupos")%>" required="">

            <label for="descripcion">Descripcion:</label>
            <input type="text" id="descripcion" name="descripcion" value="<%= request.getParameter("descripcion")%>" required>

            <label for="dia">Día:</label>
            <select id="dia" name="dia" required>
                <option value="">Selecciona el día</option>
                <option value="lunes" <%= "lunes".equals(request.getParameter("dia")) ? "selected" : ""%>>Lunes</option>
                <option value="martes" <%= "martes".equals(request.getParameter("dia")) ? "selected" : ""%>>Martes</option>
                <option value="miercoles" <%= "miercoles".equals(request.getParameter("dia")) ? "selected" : ""%>>Miércoles</option>
                <option value="jueves" <%= "jueves".equals(request.getParameter("dia")) ? "selected" : ""%>>Jueves</option>
                <option value="viernes" <%= "viernes".equals(request.getParameter("dia")) ? "selected" : ""%>>Viernes</option>
            </select>

            <label for="hora_comienzo">Hora comienzo:</label>
            <select id="hora_comienzo" name="hora_comienzo" required>
                <%
                    String[] horas = {"08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00"};
                    String horaComienzo = request.getParameter("hora_comienzo");
                    for (String hora : horas) {
                %>
                <option value="<%= hora%>" <%= hora.equals(horaComienzo) ? "selected" : ""%>><%= hora%></option>
                <%
                    }
                %>
            </select>

            <label for="hora_fin">Hora fin:</label>
            <select id="hora_fin" name="hora_fin" required>
                <%
                    String horaFin = request.getParameter("hora_fin");
                    for (String hora : horas) {
                %>
                <option value="<%= hora%>" <%= hora.equals(horaFin) ? "selected" : ""%>><%= hora%></option>
                <%
                    }
                %>
            </select>
            
            <input type="submit" value="Actualizar" class="submit">
        </form>
    </body>
</html>

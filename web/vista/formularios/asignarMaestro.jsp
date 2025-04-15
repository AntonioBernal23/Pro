
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("/index.jsp");
        return;
    }
%>

<%
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
        out.println("<script type='text/javascript'>");
        out.println("alert('" + mensaje + "');");
        out.println("</script>");
        session.removeAttribute("mensaje"); // Se el artributo borra después de mostrarlo
    }

    String idMateria = (String) request.getAttribute("idMateria");

    String nombreMateria = (String) request.getAttribute("nombreMateria");
%>

<%@ page import="java.util.List" %>
<%@ page import="modelo.Usuario" %>
<%@ page import="modelo.Materia" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="/AsignarMaestro" method="post">
            <p>Nombre de materia: <%= nombreMateria%></p>

            <label for="maestro">Maestro:</label>
            <select id="maestro" name="idMaestro">
                <%
                    List<Usuario> maestros = (List<Usuario>) request.getAttribute("usuarios");
                    if (maestros != null) {
                        for (Usuario m : maestros) {
                %>
                <option value="<%= m.getId()%>"><%= m.getNombre()%></option>
                <%
                    }
                } else {
                %>
                <!-- No hay maestros disponibles -->
                <%}%>
            </select>

            <input type="hidden" value="<%= idMateria%>" name="idMateria">

            <input type="submit" value="Asignar">
        </form>
    </body>
</html>

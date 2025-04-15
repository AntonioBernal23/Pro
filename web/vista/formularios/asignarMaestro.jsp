
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
        <form>
            <label for="maestro">Maestro:</label>
            <select id="maestro">
                <%
                    List<Usuario> maestros = (List<Usuario>) request.getAttribute("usuarios");
                    if (maestros != null) {
                        for(Usuario m : maestros) {
                %>
                <option><%= m.getNombre()%></option>
                <%
                        }
                    } else {

                %>
                <!-- No hay maestros disponibles -->
                <%
                    }
                %>
            </select>
        </form>
    </body>
</html>

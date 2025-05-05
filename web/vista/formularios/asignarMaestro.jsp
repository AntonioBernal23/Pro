<%@ page import="java.util.List" %>
<%@ page import="modelo.Usuario" %>
<%@ page import="modelo.Materia" %>

<%
    String roleAdmin = request.getParameter("roleAdmin");
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if (usuario == null || !"administrador".equals(roleAdmin)) {
        response.sendRedirect("/index.jsp");
        return;
    }

    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
        out.println("<script type='text/javascript'>");
        out.println("alert('" + mensaje + "');");
        out.println("</script>");
        session.removeAttribute("mensaje");
    }

    String idMateria = (String) request.getAttribute("idMateria");
    String nombreMateria = (String) request.getAttribute("nombreMateria");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Asignar Maestro</title>
    <link rel="stylesheet" href="/vista/css/formularios.css?v=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="calendar-container">
        <div class="calendar">
            <header class="calendar-header">
                <h2><i class="fa-solid fa-chalkboard-user"></i> Asignar Maestro</h2>
                <p class="subtitulo">Selecciona el maestro para la materia</p>
            </header>

            <section class="calendar-table-container">
                <div class="form-card">
                    <form action="/AsignarMaestro" method="post" class="form">
                        <!-- Mostrar nombre de la materia -->
                        <div class="field-group">
                            <label>Materia:</label>
                            <input type="text" value="<%= nombreMateria %>" readonly>
                        </div>

                        <!-- Selector de maestro -->
                        <div class="field-group">
                            <label for="maestro">Maestro:</label>
                            <select id="maestro" name="idMaestro" required>
                                <%
                                    List<Usuario> maestros = (List<Usuario>) request.getAttribute("usuarios");
                                    if (maestros != null && !maestros.isEmpty()) {
                                        for (Usuario m : maestros) {
                                %>
                                    <option value="<%= m.getId() %>"><%= m.getNombre() %></option>
                                <%
                                        }
                                    } else {
                                %>
                                    <option disabled selected>No hay maestros disponibles</option>
                                <%
                                    }
                                %>
                            </select>
                        </div>

                        <!-- Hidden input para ID materia -->
                        <input type="hidden" name="idMateria" value="<%= idMateria %>">

                        <!-- Botón de enviar -->
                        <button type="submit" class="btn submit-btn">
                            <i class="fa-solid fa-user-plus"></i> Asignar
                        </button>
                    </form>
                </div>
            </section>
        </div>
    </div>
</body>
</html>

<%@page import="modelo.Usuario"%>
<%@page import="modelo.Materia"%>

<%
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
        out.println("<script type='text/javascript'>");
        out.println("alert('" + mensaje + "');");
        out.println("</script>");
        session.removeAttribute("mensaje");
    }

    String roleAdmin = request.getParameter("roleAdmin");
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !"administrador".equals(roleAdmin)) {
        response.sendRedirect("/index.jsp");
        return;
    }

    String[] horas = {"08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00"};
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Actualizar Materia</title>
    <link rel="stylesheet" href="/vista/css/formularios.css?v=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="calendar-container">
        <div class="calendar">
            <header class="calendar-header">
                <h2><i class="fa-solid fa-book"></i> Actualizar Materia</h2>
                <p class="subtitulo">Edita los datos de la materia seleccionada</p>
            </header>

            <section class="calendar-table-container">
                <div class="form-card">
                    <form action="/ActualizarMateria" method="post" class="form">
                        <input type="hidden" name="id" value="<%= request.getParameter("id") %>">

                        <div class="field-group">
                            <label for="nombre">Nombre:</label>
                            <input type="text" id="nombre" name="nombre" value="<%= request.getParameter("nombre") %>" required>
                        </div>

                        <div class="field-group">
                            <label for="codigo">Código:</label>
                            <input type="text" id="codigo" name="codigo" value="<%= request.getParameter("codigo") %>" required>
                        </div>

                        <div class="field-group">
                            <label for="cupos">Cupos:</label>
                            <input type="number" id="cupos" name="cupos" min="1" max="20" value="<%= request.getParameter("cupos") %>" required>
                        </div>

                        <div class="field-group">
                            <label for="descripcion">Descripción:</label>
                            <input type="text" id="descripcion" name="descripcion" value="<%= request.getParameter("descripcion") %>" required>
                        </div>

                        <div class="field-group">
                            <label for="dia">Día:</label>
                            <select id="dia" name="dia" required>
                                <option value="">Selecciona el día</option>
                                <option value="lunes" <%= "lunes".equals(request.getParameter("dia")) ? "selected" : "" %>>Lunes</option>
                                <option value="martes" <%= "martes".equals(request.getParameter("dia")) ? "selected" : "" %>>Martes</option>
                                <option value="miercoles" <%= "miercoles".equals(request.getParameter("dia")) ? "selected" : "" %>>Miércoles</option>
                                <option value="jueves" <%= "jueves".equals(request.getParameter("dia")) ? "selected" : "" %>>Jueves</option>
                                <option value="viernes" <%= "viernes".equals(request.getParameter("dia")) ? "selected" : "" %>>Viernes</option>
                            </select>
                        </div>

                        <div class="field-row">
                            <div class="field-group">
                                <label for="hora_comienzo">Hora comienzo:</label>
                                <select id="hora_comienzo" name="hora_comienzo" required>
                                    <%
                                        String horaComienzo = request.getParameter("hora_comienzo");
                                        for (String hora : horas) {
                                    %>
                                    <option value="<%= hora %>" <%= hora.equals(horaComienzo) ? "selected" : "" %>><%= hora %></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="field-group">
                                <label for="hora_fin">Hora fin:</label>
                                <select id="hora_fin" name="hora_fin" required>
                                    <%
                                        String horaFin = request.getParameter("hora_fin");
                                        for (String hora : horas) {
                                    %>
                                    <option value="<%= hora %>" <%= hora.equals(horaFin) ? "selected" : "" %>><%= hora %></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>

                        <button type="submit" class="btn submit-btn">
                            <i class="fa-solid fa-pen-to-square"></i> Actualizar
                        </button>
                    </form>
                </div>
            </section>
        </div>
    </div>
</body>
</html>

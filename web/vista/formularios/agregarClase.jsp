<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelo.Materia" %>
<%@ page import="java.util.List" %>
<%
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
%>
<script type="text/javascript">
    alert('<%= mensaje %>');
</script>
<%
    session.removeAttribute("mensaje");
}
String idAlumno = request.getParameter("id");
List<Materia> materias = (List<Materia>) request.getAttribute("materias");
String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Agregar Clase</title>
    <link rel="stylesheet" href="<%= contextPath %>/vista/estilos/AgregarClase.css?v=2.0">
    <script>
        const materiasData = [
        <%
            if (materias != null) {
                for (int i = 0; i < materias.size(); i++) {
                    Materia m = materias.get(i);
        %>
        {
            id: "<%= m.getId() %>",
            nombre: "<%= m.getNombre() %>",
            codigo: "<%= m.getCodigo() %>",
            cupos: "<%= m.getCupos() %>",
            descripcion: "<%= m.getDescripcion() %>",
            dia: "<%= m.getDia() %>",
            horaInicio: "<%= m.getHora_comienzo() %>",
            horaFin: "<%= m.getHora_fin() %>"
        }<%= (i < materias.size() - 1) ? "," : "" %>
        <%
                }
            }
        %>
        ];
    </script>
    <script src="<%= contextPath %>/vista/script/agregarClase.js" defer></script>
</head>
<body>
    <div class="agregar-clase-container">
        <form action="<%= contextPath %>/AgregarClase" method="post" class="agregar-clase-form">
            <h1 class="titulo">Agregar Clase</h1>
            <input type="hidden" name="idAlumno" value="<%= idAlumno %>">
            <input type="hidden" id="materiaIdHidden" name="idMateria">

            <label for="materiaInput">Materia</label>
            <input list="materias" id="materiaInput" name="materiaInput" placeholder="Escribe o selecciona una materia" required>
            <datalist id="materias">
                <%
                    if (materias != null) {
                        for (Materia m : materias) {
                %>
                <option data-id="<%= m.getId() %>" value="<%= m.getNombre() %>"></option>
                <%
                        }
                    }
                %>
            </datalist>

            <div id="materiaInfo" style="display: none;">
                <h3>Información de la materia</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Código</th>
                            <th>Cupos</th>
                            <th>Descripción</th>
                            <th>Día</th>
                            <th>Hora de inicio</th>
                            <th>Hora de fin</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td id="tdNombre"></td>
                            <td id="tdCodigo"></td>
                            <td id="tdCupos"></td>
                            <td id="tdDescripcion"></td>
                            <td id="tdDia"></td>
                            <td id="tdHoraInicio"></td>
                            <td id="tdHoraFin"></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <button type="submit">Agregar</button>
        </form>
    </div>
</body>
</html>

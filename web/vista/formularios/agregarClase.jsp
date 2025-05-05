<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelo.Materia" %>
<%@ page import="java.util.List" %>
<%
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
%>
<script type="text/javascript">
    alert('<%= mensaje%>');
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
        <link rel="stylesheet" href="<%= contextPath%>/vista/css/formularios.css?v=2.0">
        <script>
            const materiasData = [
            <%
                if (materias != null) {
                    for (int i = 0; i < materias.size(); i++) {
                        Materia m = materias.get(i);
            %>
            {
            id: "<%= m.getId()%>",
                    nombre: "<%= m.getNombre()%>",
                    codigo: "<%= m.getCodigo()%>",
                    cupos: "<%= m.getCupos()%>",
                    descripcion: "<%= m.getDescripcion()%>",
                    dia: "<%= m.getDia()%>",
                    horaInicio: "<%= m.getHora_comienzo()%>",
                    horaFin: "<%= m.getHora_fin()%>"
            }<%= (i < materias.size() - 1) ? "," : ""%>
            <%
                    }
                }
            %>
            ];
        </script>
        <script src="<%= contextPath%>/vista/script/agregarClase.js" defer></script>
    </head>
    <body>
        <div class="calendar-container">
            <div class="calendar">
                <header class="calendar-header">
                    <h2><i class="fa-solid fa-plus"></i> Agregar Clase</h2>
                    <p class="subtitulo">Selecciona y agrega una materia para el alumno</p>
                </header>

                <section class="calendar-table-container">
                    <div class="form-card">
                        <form action="<%= contextPath%>/AgregarClase" method="post" class="form">
                            <input type="hidden" name="idAlumno" value="<%= idAlumno%>">
                            <input type="hidden" id="materiaIdHidden" name="idMateria">

                            <div class="field-group">
                                <label for="materiaInput">Materia</label>
                                <input list="materias" id="materiaInput" name="materiaInput" placeholder="Escribe o selecciona una materia" required>
                                <datalist id="materias">
                                    <%
                                        if (materias != null) {
                                            for (Materia m : materias) {
                                    %>
                                    <option data-id="<%= m.getId()%>" value="<%= m.getNombre()%>"></option>
                                    <%
                                            }
                                        }
                                    %>
                                </datalist>
                            </div>

                            <div id="materiaInfo" style="display: none; margin-bottom: 20px;">
                                <h3 style="color: #ffffff;">Información de la materia</h3>
                                <div style="overflow-x: auto;">
                                    <table style="width: 100%; border-collapse: collapse; color: #e0e0e0;">
                                        <thead>
                                            <tr>
                                                <th>Nombre</th>
                                                <th>Código</th>
                                                <th>Cupos</th>
                                                <th>Descripción</th>
                                                <th>Día</th>
                                                <th>Inicio</th>
                                                <th>Fin</th>
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
                            </div>

                            <button type="submit" class="btn submit-btn">
                                <i class="fa-solid fa-plus-circle"></i> Agregar
                            </button>
                        </form>
                    </div>
                </section>
            </div>
        </div>
    </body>
</html>

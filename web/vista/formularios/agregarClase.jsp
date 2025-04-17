<%
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
        out.println("<script type='text/javascript'>");
        out.println("alert('" + mensaje + "');");
        out.println("</script>");
        session.removeAttribute("mensaje");
    }

    String idAlumno = (String) request.getAttribute("idAlumno");
    List<Materia> materias = (List<Materia>) request.getAttribute("materias");
%>

<%@ page import="modelo.Materia" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="/vista/script/agregarClase.js" defer></script>
        <title>Agregar clase</title>

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

    </head>
    <body>
        <form action="/AgregarClase" method="post">
            <input type="hidden" name="idAlumno" value="<%= idAlumno%>">

            <input type="hidden" id="materiaIdHidden" name="idMateria">
            
            <input list="materias" id="materiaInput" name="materiaInput" placeholder="Escribe o selecciona una materia">
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


            <div id="materiaInfo" style="margin-top: 10px; display:none;">
                <h3>Información de la materia:</h3>
                <p id="materiaId"></p>
                <p id="materiaNombre"></p>
                <table border="1">
                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Código</th>
                            <th>Cupos</th>
                            <th>Descripción</th>
                            <th>Día</th>
                            <th>Hora de comienzo</th>
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

            <input type="submit" value="Agregar">
        </form>
    </body>
</html>

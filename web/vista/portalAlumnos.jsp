<%@page import="java.util.Random"%>
<%@page import="modelo.Materia"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Usuario"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
        out.println("<script type='text/javascript'>");
        out.println("alert('" + mensaje + "');");
        out.println("</script>");
        session.removeAttribute("mensaje");
    }
%>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("/index.jsp");
        return;
    }

    Integer ID = usuario.getId();
    String nombre = usuario.getNombre();
    String usuarioNombre = usuario.getUsuario();
    String correo = usuario.getCorreo();
    String contrasena = usuario.getContraseña();
    String rol = usuario.getRol();
%>

<%
    List<Materia> materias = (List<Materia>) request.getAttribute("materias");

    if (materias == null || materias.isEmpty()) {
        out.println("<script type='text/javascript'>");
        out.println("alert('No estás inscrito a ninguna materia.');");
        out.println("</script>");
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="/vista/script/portalAlumnos.js" defer></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="/vista/css/portalAlumnos.css?v=1.0">
        <title>Portal de alumnos</title>
    </head>
    <body>
        <div class="calendar-container">
            <div class="calendar">
                <div class="calendar-header">
                    <button class="btn">⬅️ Semana Anterior</button>
                    <h2>Semana del 18 - 24 de Marzo</h2>
                    <button class="btn">Semana Siguiente ➡️</button>
                </div>
                <div class="week-days">
                    <div>🕒</div>
                    <div>Lunes 18</div><div>Martes 19</div><div>Miércoles 20</div><div>Jueves 21</div>
                    <div>Viernes 22</div><div>Sábado 23</div><div>Domingo 24</div>
                </div>
                <div class="calendar-table-container">
                    <table class="calendar-table">
                        <tbody id="calendar-body">
                            <%
                                String[] dias = {"Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"};

                                for (int i = 0; i < 24; i++) {
                                    out.println("<tr>");
                                    out.println("<td>" + String.format("%02d:00", i) + "</td>");

                                    for (String dia : dias) {
                                        boolean found = false;

                                        if (materias != null) {
                                            for (Materia m : materias) {
                                                if (m.getDia().equalsIgnoreCase(dia)) {
                                                    String[] inicio = m.getHora_comienzo().split(":");
                                                    String[] fin = m.getHora_fin().split(":");

                                                    int horaInicio = Integer.parseInt(inicio[0]);
                                                    int horaFin = Integer.parseInt(fin[0]);

                                                    if (i == horaInicio) {
                                                        int duracion = horaFin - horaInicio;

                                                        Random rand = new Random();
                                                        int r = rand.nextInt(156) + 100;
                                                        int g = rand.nextInt(156) + 100;
                                                        int b = rand.nextInt(156) + 100;
                                                        String color = "rgb(" + r + "," + g + "," + b + ")";

                                                        out.println("<td rowspan='" + duracion + "' style='background-color: " + color + "; cursor:pointer;' onclick=\"mostrarPopup('" + m.getNombre() + "', '" + m.getId() + "', '" + m.getMaestroAsignado() + "')\" class=\"materia-celda\">" + m.getNombre() + "</td>");
                                                        found = true;
                                                        break;
                                                    }

                                                    if (i > horaInicio && i < horaFin) {
                                                        found = true;
                                                        break;
                                                    }
                                                }
                                            }
                                        }

                                        if (!found) {
                                            out.println("<td></td>");
                                        }
                                    }

                                    out.println("</tr>");
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="sidebar">
                <button>📝 Agregar Tarea</button>
                <button>✏️ Modificar Tarea</button>
                <button>📅 Agregar Evento</button>
                <button>📖 Clases</button>
                <button id="btnAgregarClase" onclick="agregarClase(<%= usuario.getId() %>)">➕ Agregar Clases</button>
                <form action="/CerrarSesion" method="post">
                    <button type="submit">
                        🚪 <i class="fa-solid fa-right-from-bracket"></i>
                    </button>
                </form>
            </div>
        </div>

        <!-- POPUP -->
        <div id="popup" class="popup-hidden">
            <div class="popup-content">
                <span class="popup-close" onclick="cerrarPopup()">✖</span>
                <h2 id="popup-title"></h2>
                <p>ID: <span id="popup-id"></span></p>
                <p>Maestro: <span id="popup-maestro"></span></p>
            </div>
        </div>
    </body>   
</html>

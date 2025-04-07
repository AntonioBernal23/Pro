<%@page import="modelo.Usuario"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
        out.println("<script type='text/javascript'>");
        out.println("alert('" + mensaje + "');");
        out.println("</script>");
        session.removeAttribute("mensaje"); // Se el artributo borra después de mostrarlo
    }
%>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario"); // Obtén el objeto Usuario desde la sesión
    if (usuario == null) {
        response.sendRedirect("/index.jsp"); // Redirigir a la página de login si no hay usuario
        return; // Termina la ejecución del código JSP para evitar que se imprima contenido adicional
    }

    Integer ID = usuario.getId();
    String nombre = usuario.getNombre();
    String usuarioNombre = usuario.getUsuario();
    String correo = usuario.getCorreo();
    String contrasena = usuario.getContraseña();
    String rol = usuario.getRol();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="css/portalAlumnos.css">
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
                            for(int i = 0; i < 24; i++) {
                                out.println("<tr>");
                                out.println("<td>" + i + ":00</td>");
                                out.println("<td></td>");
                                out.println("<td></td>");
                                out.println("<td></td>");
                                out.println("<td></td>");
                                out.println("<td></td>");
                                out.println("<td></td>");
                                out.println("<td></td>");
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
            <button>➕ Agregar Clases</button>
           <form action="/CerrarSesion" method="post">
            <button type="submit">
                🚪 
                <i class="fa-solid fa-right-from-bracket"></i>
            </button>
        </form>
        </div>
    </div>

        <h1>Bienvenido, <%= usuario.getNombre()%>!</h1>

        <p>Acceso al portal de estudiantes.</p>

        <p>ROL: <%=usuario.getRol()%></p>
    </body>   
</html>

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
        <link rel="stylesheet" href="/vista/css/administrarUsuarios.css?v=1.0">
        <script src="/vista/script/administrarMaterias.js" defer></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <title>Administrar Materias</title>
    </head>
    <body>
        <div class="grid-container">
            <div class="tabla-container">
                <table border="1">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Codigo</th>
                        <th>Cupos</th>
                        <th>Descripcion</th>
                        <th>Dia</th>
                        <th>Hora comienzo</th>
                        <th>Hora fin</th>
                        <th>Maestro</th>
                        <th></th>
                    </tr>
                    <%
                        List<Materia> materias = (List<Materia>) request.getAttribute("materias");
                        if (materias != null) {
                            for (Materia m : materias) {
                    %>
                    <tr class="fila-usuario" 
                        onclick="seleccionarFila(this, <%= m.getId()%>, '<%= m.getNombre()%>', '<%= m.getCodigo()%>', '<%= m.getCupos()%>', '<%= m.getDescripcion()%>', '<%= m.getDia()%>', '<%= m.getHora_comienzo()%>', '<%= m.getHora_fin()%>', 'maestro')">
                        <td><%= m.getId()%></td>
                        <td><%= m.getNombre()%></td>
                        <td><%= m.getCodigo()%></td>
                        <td><%= m.getCupos()%></td>
                        <td><%= m.getDescripcion()%></td>
                        <td><%= m.getDia()%></td>
                        <td><%= m.getHora_comienzo()%></td>
                        <td><%= m.getHora_fin()%></td>
                        
                        <!-- Mostrar nombre de maestro -->
                        <%
                            if (m.getMaestroAsignado() != null) {
                        %>
                        <td><%= m.getMaestroAsignado()%></td>
                        <%} else {%>
                        <td><p style="color: red;">Sin maestro</p></td>
                        <%}%>
                        
                        <!-- Formulario para eliminar materia -->
                        <td>
                            <form action="/EliminarMateria" method="post">
                                <input type="hidden" name="id" value="<%= m.getId()%>">
                                <button type="submit" id="btnEliminar">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr><td colspan="10">No hay materias disponibles.</td></tr>
                    <%
                        }
                    %>
                </table>
            </div>
            <div class="botones-container">
                <button id="btnAgregar" onclick="agregarMateria()">
                    <i class="fas fa-plus"></i>
                </button>
                <button id="btnAsignar" style="display: none;" onclick="asignarMaestro()">
                    <i class="fas fa-chalkboard-teacher"></i>
                </button>
                <button id="btnActualizar" style="display: none;" onclick="actualizarMateria()">
                    <i class="fa-solid fa-pencil"></i>
                </button>
                <button id="btnCancelar" style="display:none;" onclick="cancelarSeleccion()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        </div>
    </body>
</html>

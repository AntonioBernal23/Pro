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

<%@ page import="java.util.List" %>
<%@ page import="modelo.Usuario" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="/vista/css/administrarUsuarios.css?v=1.0">
        <script src="/vista/script/administrarUsuarios.js" defer></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <title>Administrar usuarios</title>
    </head>
    <body>
        <%
            String mensaje = (String) session.getAttribute("mensaje");
            if (mensaje != null) {
                out.println("<script type='text/javascript'>");
                out.println("alert('" + mensaje + "');");
                out.println("</script>");
                session.removeAttribute("mensaje"); // Se el artributo borra después de mostrarlo
            }
        %>

        <div class="grid-container">
            <div class="tabla-container">
                <table border="1">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Usuario</th>
                        <th>Correo</th>
                        <th>Rol</th>
                        <th></th>
                    </tr>
                    <%
                        List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios");
                        if (usuarios != null) {
                            for (Usuario u : usuarios) {
                    %>
                    <tr class="fila-usuario" 
                        onclick="seleccionarFila(this, <%= u.getId()%>, '<%= u.getNombre()%>', '<%= u.getUsuario()%>', '<%= u.getCorreo()%>', '<%= u.getRol()%>')">
                        <td><%= u.getId()%></td>
                        <td><%= u.getNombre()%></td>
                        <td><%= u.getUsuario()%></td>
                        <td><%= u.getCorreo()%></td>
                        <td><%= u.getRol()%></td>
                        <td>
                            <%if (!ID.equals(u.getId())) {%>
                            <form action="/EliminarUsuario" method="post">
                                <input type="hidden" name="id" value="<%= u.getId()%>">
                                <button type="submit" id="btnEliminar">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </form>
                            <%}%>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr><td colspan="6">No hay usuarios disponibles.</td></tr>
                    <%
                        }
                    %>
                </table>
            </div>
            <div class="botones-container">
                <button id="btnAgregar" onclick="agregarUsuario()">
                    <i class="fas fa-plus"></i>
                </button>
                <button id="btnActualizar" style="display: none;" onclick="actualizarUsuario()">
                    <i class="fa-solid fa-pencil"></i>
                </button>
                <button id="btnCancelar" style="display:none;" onclick="cancelarSeleccion()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        </div>
    </body>
</html>
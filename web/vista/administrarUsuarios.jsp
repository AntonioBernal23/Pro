<%@page import="modelo.Usuario"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // Mostrar mensaje de sesión si existe
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
%>
    <script>alert('<%= mensaje %>');</script>
<%
        session.removeAttribute("mensaje");
    }

    // Validar sesión
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("/index.jsp");
        return;
    }

    List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Administrar Usuarios</title>
    <link rel="stylesheet" href="/vista/css/portalAlumnos.css?v=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .calendar-header {
            justify-content: center;
        }

        .table-toolbar {
            margin-bottom: 10px;
        }

        .tabla-usuarios {
            width: 100%;
            border-collapse: collapse;
        }

        .tabla-usuarios th, .tabla-usuarios td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: center;
        }

        .tabla-usuarios th {
            background-color: #f2f2f2;
        }

        .action-small {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }

        #searchUsuario {
            width: 100%;
            padding: 5px;
        }
    </style>

    <script>
        function filtrarUsuarios() {
            const term = document.getElementById('searchUsuario').value.toLowerCase();
            document.querySelectorAll('.tabla-usuarios tbody tr').forEach(row => {
                const texto = row.innerText.toLowerCase();
                row.style.display = texto.includes(term) ? '' : 'none';
            });
        }

        function seleccionarFila(fila, id, nombre, usuario, correo, rol) {
            // Aquí puedes implementar selección si la necesitas más adelante
            console.log(`Seleccionado: ${id}, ${nombre}`);
        }
    </script>
</head>
<body>
    <div class="calendar-container">
        <div class="calendar">
            <div class="calendar-header">
                <h2><i class="fa-solid fa-users"></i> Administrar Usuarios</h2>
            </div>
            <div class="calendar-table-container">
                <div class="table-toolbar">
                    <input
                        type="text"
                        id="searchUsuario"
                        placeholder="🔍 Buscar usuario..."
                        oninput="filtrarUsuarios()"
                    >
                </div>
                <table class="calendar-table tabla-usuarios">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Usuario</th>
                            <th>Correo</th>
                            <th>Rol</th>
                            <th>Acción</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (usuarios != null && !usuarios.isEmpty()) {
                                for (Usuario u : usuarios) {
                        %>
                        <tr onclick="seleccionarFila(this,
                                                      <%=u.getId()%>,
                                                      '<%=u.getNombre()%>',
                                                      '<%=u.getUsuario()%>',
                                                      '<%=u.getCorreo()%>',
                                                      '<%=u.getRol()%>')">
                            <td><%=u.getId()%></td>
                            <td><%=u.getNombre()%></td>
                            <td><%=u.getUsuario()%></td>
                            <td><%=u.getCorreo()%></td>
                            <td><%=u.getRol()%></td>
                            <td>
                                <form action="/EliminarUsuario" method="post">
                                    <input type="hidden" name="id" value="<%=u.getId()%>">
                                    <button type="submit" class="action-small">
                                        <i class="fa-solid fa-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr><td colspan="6">No hay usuarios disponibles.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Sidebar de acciones -->
        <div class="sidebar">
            <button id="btnAgregar" class="btn action" onclick="agregarUsuario()">
                ➕ Agregar Usuario
            </button>
            <form action="/CerrarSesion" method="post">
                <button type="submit" class="btn logout">
                    🚪 <i class="fa-solid fa-right-from-bracket"></i> Cerrar sesión
                </button>
            </form>
        </div>
    </div>
</body>
</html>

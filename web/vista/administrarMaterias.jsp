<%@page import="modelo.Materia"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Usuario"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("/index.jsp");
        return;
    }
    
    if (!usuario.getRol().equals("administrador")) {
        session.removeAttribute("usuarii");
        response.sendRedirect("/index.jsp");
    }
    
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
%>
<script>alert('<%= mensaje %>');</script>
<%
        session.removeAttribute("mensaje");
    }
    List<Materia> materias = (List<Materia>) request.getAttribute("materias");
%>

<script>
    let roleAdmin = "<%= usuario.getRol() %>";
</script>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Administrar Materias</title>
  <link rel="stylesheet" href="/vista/css/portalAlumnos.css?v=1.0">
  <script src="/vista/script/administrarMaterias.js" defer></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
  <div class="calendar-container">
    <div class="calendar">
      <div class="calendar-header">
        <h2><i class="fa-solid fa-book-open"></i> Administrar Materias</h2>
      </div>

      <div class="calendar-table-container">
        <div class="table-toolbar">
          <input
            type="text"
            id="searchMateria"
            placeholder="🔍 Buscar materia..."
            oninput="filtrarMaterias()"
          >
        </div>

        <table class="calendar-table tabla-materias">
          <thead>
            <tr>
              <th>ID</th>
              <th>Nombre</th>
              <th>Código</th>
              <th>Cupos</th>
              <th>Descripción</th>
              <th>Día</th>
              <th>Inicio</th>
              <th>Fin</th>
              <th>Maestro</th>
              <th>Acción</th>
            </tr>
          </thead>
          <tbody>
            <%
              if (materias != null && !materias.isEmpty()) {
                  for (Materia m : materias) {
            %>
            <tr onclick="seleccionarFila(this,
                                           <%=m.getId()%>,
                                           '<%=m.getNombre()%>',
                                           '<%=m.getCodigo()%>',
                                           '<%=m.getCupos()%>',
                                           '<%=m.getDescripcion()%>',
                                           '<%=m.getDia()%>',
                                           '<%=m.getHora_comienzo()%>',
                                           '<%=m.getHora_fin()%>',
                                           '<%=m.getMaestroAsignado()%>')">
              <td><%=m.getId()%></td>
              <td><%=m.getNombre()%></td>
              <td><%=m.getCodigo()%></td>
              <td><%=m.getCupos()%></td>
              <td><%=m.getDescripcion()%></td>
              <td><%=m.getDia()%></td>
              <td><%=m.getHora_comienzo()%></td>
              <td><%=m.getHora_fin()%></td>
              <td>
                <%= (m.getMaestroAsignado() != null) 
                     ? m.getMaestroAsignado() 
                     : "<span class='sin-maestro'>Sin maestro</span>" %>
              </td>
              <td>
                <form action="/EliminarMateria" method="post">
                  <input type="hidden" name="id" value="<%=m.getId()%>">
                  <button type="submit" class="btn action-small" title="Eliminar materia">
                    <i class="fa-solid fa-trash"></i>
                  </button>
                </form>
              </td>
            </tr>
            <%
                  }
              } else {
            %>
            <tr>
              <td colspan="10">No hay materias disponibles.</td>
            </tr>
            <% } %>
          </tbody>
        </table>
      </div>
    </div>

    <div class="sidebar">
      <button id="btnAgregar" class="btn action" onclick="agregarMateria()">
        <i class="fa-solid fa-plus"></i> Agregar
      </button>
      <button id="btnAsignar" class="btn action" style="display:none;" onclick="asignarMaestro()">
        <i class="fa-solid fa-chalkboard-teacher"></i> Asignar
      </button>
      <button id="btnActualizar" class="btn action" style="display:none;" onclick="actualizarMateria()">
        <i class="fa-solid fa-pencil"></i> Actualizar
      </button>
      <button id="btnCancelar" class="btn action" style="display:none;" onclick="cancelarSeleccion()">
        <i class="fa-solid fa-times"></i> Cancelar
      </button>
      <form action="/CerrarSesion" method="post" class="logout-form">
        <button type="submit" class="btn logout">
          <i class="fa-solid fa-right-from-bracket"></i> Cerrar sesión
        </button>
      </form>
    </div>
  </div>

  <script>
    function filtrarMaterias() {
      const term = document.getElementById('searchMateria').value.toLowerCase();
      document.querySelectorAll('.tabla-materias tbody tr').forEach(row => {
        row.style.display = row.innerText.toLowerCase().includes(term) ? '' : 'none';
      });
    }
  </script>
</body>
</html>

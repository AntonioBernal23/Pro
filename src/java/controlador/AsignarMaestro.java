package controlador;

import dao.MateriaDAO;
import dao.UsuarioDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Conex;
import modelo.Usuario;

@WebServlet(name = "AsignarMaestro", urlPatterns = {"/AsignarMaestro"})
public class AsignarMaestro extends HttpServlet {

    private java.sql.Connection conexion; // Creamos el objeto "conexion" de tipo Connection

    @Override
    public void init() throws ServletException {
        try {
            conexion = Conex.conectar();
        } catch (SQLException ex) {
            Logger.getLogger(AdministrarUsuarios.class.getName()).log(Level.SEVERE, "Error al conectar a la base de datos", ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idMateria = request.getParameter("id");
        String nombreMateria = request.getParameter("nombre");

        UsuarioDAO dao = new UsuarioDAO(conexion);

        try {
            List<Usuario> usuarios = dao.obtenerMaestros();

            if (usuarios != null && !usuarios.isEmpty()) {
                request.setAttribute("usuarios", usuarios);
                request.setAttribute("idMateria", idMateria);
                request.setAttribute("nombreMateria", nombreMateria);
            } else {
                request.getSession().setAttribute("mensaje", "No se encontraron maestros.");
            }

            RequestDispatcher rd = request.getRequestDispatcher("/vista/formularios/asignarMaestro.jsp");
            rd.forward(request, response);
        } catch (IOException | ServletException e) {
            Logger.getLogger(AdministrarUsuarios.class.getName()).log(Level.SEVERE, "Error al obtener maestros", e);
            request.getSession().setAttribute("mensaje", "Hubo un error al obtener los maestros.");

            RequestDispatcher rd = request.getRequestDispatcher("/vista/formularios/asignarMaestro.jsp");
            rd.forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(AdministrarMaterias.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idMateria = request.getParameter("idMateria");
        String idMaestro = request.getParameter("idMaestro");

        MateriaDAO dao = new MateriaDAO(conexion);

        HttpSession session = request.getSession();

        try {
            String mensaje = dao.asignarMaestro(idMateria, idMaestro);

            session.setAttribute("mensaje", mensaje);

            response.setContentType("text/html");
            response.getWriter().println("<script>");

            if (mensaje.equals("Maestro asignado correctamente.")) {
                response.getWriter().println("window.opener.location.reload();");
                response.getWriter().println("window.close();");
            } else {
                response.getWriter().println("alert('Error: " + mensaje + "');");
                response.getWriter().println("window.location.href='/vista/formularios/asignarMaestro.jsp';");
            }

            response.getWriter().println("</script>");
        } catch (SQLException e) {
            session.setAttribute("mensaje", "Error al asignar: " + e.getMessage());
            e.printStackTrace();  // Imprimir la traza completa de la excepción para obtener más detalles del error
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error en la base de datos.");
        } catch (IOException e) {
            session.setAttribute("mensaje", "Error de entrada/salida: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void destroy() {
        try {
            if (conexion != null) {
                conexion.close();
            }
        } catch (SQLException e) {
        }
    }

}

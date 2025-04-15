package controlador;

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
        String id_materia = request.getParameter("id");
        
        UsuarioDAO dao = new UsuarioDAO(conexion);
        
        try {
            List<Usuario> usuarios = dao.obtenerMaestros();

            if (usuarios != null && !usuarios.isEmpty()) {
                request.setAttribute("usuarios", usuarios);
                request.setAttribute("id_materia", id_materia);
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
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

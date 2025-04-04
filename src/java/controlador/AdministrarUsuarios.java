package controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelo.Usuario;
import dao.UsuarioDAO;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import modelo.Conex;

@WebServlet(name = "AdministrarUsuarios", urlPatterns = {"/AdministrarUsuarios"})
public class AdministrarUsuarios extends HttpServlet {

    private java.sql.Connection conexion; // Creamos el objeto "conexion" de tipo Connection

    @Override
    public void init() throws ServletException {
        try {
            // Creamos una instancia de conexion que es igual al metodo conectar() del modelo Conex
            conexion = Conex.conectar();
        } catch (SQLException ex) {
            // Registra el error en los logs con nivel SEVERE si ocurre una excepción en la conexion
            Logger.getLogger(AdministrarUsuarios.class.getName()).log(Level.SEVERE, "Error al conectar a la base de datos", ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UsuarioDAO dao = new UsuarioDAO(conexion);
        try {
            List<Usuario> usuarios = dao.obtenerUsuarios();

            if (usuarios != null && !usuarios.isEmpty()) {
                request.setAttribute("usuarios", usuarios);
            } else {
                request.getSession().setAttribute("mensaje", "No se encontraron usuarios.");
            }

            RequestDispatcher rd = request.getRequestDispatcher("/vista/administrarUsuarios.jsp");
            rd.forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(AdministrarUsuarios.class.getName()).log(Level.SEVERE, "Error al obtener usuarios", ex);
            // Enviar mensaje de error a la vista
            request.getSession().setAttribute("mensaje", "Hubo un error al obtener los usuarios.");

            RequestDispatcher rd = request.getRequestDispatcher("/vista/administrarUsuarios.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    public void destroy() {
        try {
            if (conexion != null && !conexion.isClosed()) {
                conexion.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(AdministrarUsuarios.class.getName()).log(Level.SEVERE, "Error al cerrar la conexión", ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para administrar usuarios";
    }
}
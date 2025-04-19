package controlador;

import dao.MateriaDAO;
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
import modelo.Materia;

@WebServlet(name = "ObtenerHorario", urlPatterns = {"/ObtenerHorario"})
public class ObtenerHorario extends HttpServlet {

    private java.sql.Connection conexion;

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
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        MateriaDAO dao = new MateriaDAO(conexion);

        try {
            List<Materia> materias = dao.obtenerHorarioAlumno(usuario.getId());

            if (materias != null) {
                request.setAttribute("materias", materias);
            } else {
                request.getSession().setAttribute("mensaje", "No se encontraron materias");
            }

            RequestDispatcher rd = request.getRequestDispatcher("/vista/portalAlumnos.jsp");
            rd.forward(request, response);
        } catch (IOException | ServletException e) {
            Logger.getLogger(AdministrarUsuarios.class.getName()).log(Level.SEVERE, "Error al obtener materias", e);
            request.getSession().setAttribute("mensaje", "Hubo un error al obtener las materias.");

            RequestDispatcher rd = request.getRequestDispatcher("/vista/portalAlumnos.jsp");
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
    public void destroy() {
        try {
            if (conexion != null) {
                conexion.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}

package controlador;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Conex;
import modelo.Materia;
import dao.MateriaDAO;
import java.util.List;
import javax.servlet.RequestDispatcher;

@WebServlet(name = "AgregarClase", urlPatterns = {"/AgregarClase"})
public class AgregarClase extends HttpServlet {

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
        String idAlumno = request.getParameter("id");

        MateriaDAO dao = new MateriaDAO(conexion);

        try {
            List<Materia> materias = dao.obtenerMateriasConMaestro();
            
            if (materias != null && !materias.isEmpty()) {
                request.setAttribute("materias", materias);
                request.setAttribute("idAlumno", idAlumno);
            } else {
                request.getSession().setAttribute("mensaje", "No se encontraron materias con maestros.");
            }

            RequestDispatcher rd = request.getRequestDispatcher("/vista/formularios/agregarClase.jsp");
            rd.forward(request, response);
        } catch (IOException | ServletException e) {
            Logger.getLogger(AdministrarUsuarios.class.getName()).log(Level.SEVERE, "Error al obtener materias", e);
            request.getSession().setAttribute("mensaje", "Hubo un error al obtener las materias.");

            RequestDispatcher rd = request.getRequestDispatcher("/vista/formularios/agregarClase.jsp");
            rd.forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(AdministrarMaterias.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idAlumno = request.getParameter("idAlumno");
        String idMateria = request.getParameter("idMateria");

        MateriaDAO dao = new MateriaDAO(conexion);

        try {
            String idMaestro = dao.obtenerIdMaestro(idMateria);
            
            String mensaje = dao.inscribirAlumno(idAlumno, idMateria, idMaestro);
            
            response.setContentType("text/html");
            response.getWriter().println("<script>");
            if (mensaje.equals("Alumno inscrito correctamente.")) {
                response.getWriter().println("window.opener.location.reload();");
                response.getWriter().println("window.close();");
            } else {
                response.getWriter().println("alert('Error: " + mensaje + "');");
                response.getWriter().println("window.location.href='/vista/formularios/agregarClase.jsp';");
            }
            response.getWriter().println("</script>");
            
        } catch (SQLException ex) {
            Logger.getLogger(AgregarClase.class.getName()).log(Level.SEVERE, null, ex);
            request.getSession().setAttribute("mensaje", "Error al realizar la inscripción.");
            response.sendRedirect("/vista/formularios/agregarClase.jsp");
        }
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

package controlador;

import java.io.IOException;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Conex;

import dao.MateriaDAO;
import java.util.List;
import javax.servlet.RequestDispatcher;
import modelo.Materia;

@WebServlet(name = "AdministrarMaterias", urlPatterns = {"/AdministrarMaterias"})
public class AdministrarMaterias extends HttpServlet {
    
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
        MateriaDAO dao = new MateriaDAO(conexion);
        try {
            List<Materia> materias = dao.obtenerMaterias();
            
            if(materias != null && !materias.isEmpty()) {
                request.setAttribute("materias", materias);
            } else {
                request.getSession().setAttribute("mensaje", "No se encontraron materias.");
            }
            
            RequestDispatcher rd = request.getRequestDispatcher("/vista/administrarMaterias.jsp");
            rd.forward(request, response);
        } catch (IOException | ServletException e) {
            Logger.getLogger(AdministrarUsuarios.class.getName()).log(Level.SEVERE, "Error al obtener materias", e);
            request.getSession().setAttribute("mensaje", "Hubo un error al obtener las materias.");

            RequestDispatcher rd = request.getRequestDispatcher("/vista/administrarMaterias.jsp");
            rd.forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(AdministrarMaterias.class.getName()).log(Level.SEVERE, null, ex);
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
        return "Servlet para administrar Materias";
    }
}

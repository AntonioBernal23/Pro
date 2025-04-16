package controlador;

import dao.MateriaDAO;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Conex;


@WebServlet(name = "EliminarMateria", urlPatterns = {"/EliminarMateria"})
public class EliminarMateria extends HttpServlet {
    
    private Connection conexion;
    private MateriaDAO dao;
    
    @Override
    public void init() throws ServletException { 
        try {
            conexion = Conex.conectar();
        } catch (SQLException ex) {
            Logger.getLogger(Registro.class.getName()).log(Level.SEVERE, null, ex);
        }
        dao = new MateriaDAO(conexion);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        
        HttpSession session = request.getSession();
        
        try {
            String mensaje = dao.eliminarMateria(id);
            
            if (mensaje.equals("Materia eliminada correctamente.")) {
                session.setAttribute("mensaje", mensaje);
                response.sendRedirect("/AdministrarMaterias");
            }
        } catch (SQLException ex) {
            Logger.getLogger(EliminarUsuario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

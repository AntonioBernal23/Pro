package controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.*;
import dao.UsuarioDAO;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import modelo.Conex;

@WebServlet(name = "EliminarUsuario", urlPatterns = {"/EliminarUsuario"})
public class EliminarUsuario extends HttpServlet {
    
    private Connection conexion;
    private UsuarioDAO usuarioDAO;
    
    @Override
    public void init() throws ServletException { 
        try {
            conexion = Conex.conectar();
        } catch (SQLException ex) {
            Logger.getLogger(Registro.class.getName()).log(Level.SEVERE, null, ex);
        }
        usuarioDAO = new UsuarioDAO(conexion);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        
        HttpSession session = request.getSession();
        
        try {
            String mensaje = usuarioDAO.eliminarUsuario(id);
            
            if (mensaje.equals("Usuario eliminado correctamente.")) {
                session.setAttribute("mensaje", mensaje);
                response.sendRedirect("/AdministrarUsuarios");
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

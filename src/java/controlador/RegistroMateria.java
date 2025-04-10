package controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.*;
import java.util.logging.*;
import javax.servlet.http.HttpSession;

import modelo.Conex;
import modelo.Materia;
import dao.MateriaDAO;

@WebServlet(name = "RegistroMateria", urlPatterns = {"/RegistroMateria"})
public class RegistroMateria extends HttpServlet {

    private Connection conexion; //Creamos el objeto "conexion" de tipo Connection
    private MateriaDAO materiaDAO;

    @Override
    public void init() throws ServletException { //Metodo que se ejecuta una vez al cargar el servlet
        try {
            //Creamos una instancia de conexion que es igual al metodo conectar() del modelo Conex
            conexion = Conex.conectar();
        } catch (SQLException ex) {
            //Registra el error en los logs con nivel SEVERE si ocurre una excepción en la conexion
            Logger.getLogger(Registro.class.getName()).log(Level.SEVERE, null, ex);
        }
        materiaDAO = new MateriaDAO(conexion);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String codigo = request.getParameter("codigo");
        String cupos = request.getParameter("cupos");
        String descripcion = request.getParameter("descripcion");
        String dia = request.getParameter("dia");
        String hora_comienzo = request.getParameter("hora_comienzo");
        String hora_fin = request.getParameter("hora_fin");

        HttpSession session = request.getSession();

        Materia nuevaMateria = new Materia(nombre, codigo, cupos, descripcion, dia, hora_comienzo, hora_fin);

        try {
            String mensaje = materiaDAO.registrarMateria(nuevaMateria);

            session.setAttribute("mensaje", mensaje);

            response.setContentType("text/html");
            response.getWriter().println("<script>");
            
            if (mensaje.equals("Materia registrada correctamente.")) {
                response.getWriter().println("window.opener.location.reload();");
                response.getWriter().println("window.close();");
            } else {
                response.getWriter().println("alert('Error: " + mensaje + "');");
                response.getWriter().println("window.location.href='/vista/formularios/agregarMateria.jsp';");
            }
            
            response.getWriter().println("</script>");
        } catch (SQLException e) {
            session.setAttribute("mensaje", "Error en el registro: " + e.getMessage());
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

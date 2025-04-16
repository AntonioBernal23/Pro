package controlador;

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
import modelo.Conex;
import dao.MateriaDAO;
import modelo.Materia;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ActualizarMateria", urlPatterns = {"/ActualizarMateria"})
public class ActualizarMateria extends HttpServlet {

    private Connection conexion;
    private MateriaDAO dao;

    @Override
    public void init() throws ServletException { //Metodo que se ejecuta una vez al cargar el servlet
        try {
            //Creamos una instancia de conexion que es igual al metodo conectar() del modelo Conex
            conexion = Conex.conectar();
        } catch (SQLException ex) {
            //Registra el error en los logs con nivel SEVERE si ocurre una excepción en la conexion
            Logger.getLogger(Registro.class.getName()).log(Level.SEVERE, null, ex);
        }
        //Creamos una instancia de usuarioServicio y pasamos como parametro la conexion
        dao = new MateriaDAO(conexion);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String codigo = request.getParameter("codigo");
        String cupos = request.getParameter("cupos");
        String descripcion = request.getParameter("descripcion");
        String dia = request.getParameter("dia");
        String horaComienzo = request.getParameter("hora_comienzo");
        String horaFin = request.getParameter("hora_fin");

        System.out.println("Id desde servlet: " + id);
        
        HttpSession session = request.getSession();

        Materia nuevaMateria = new Materia(id, nombre, codigo, cupos, descripcion, dia, horaComienzo, horaFin);

        try {
            String mensaje = dao.actualizarMateria(nuevaMateria);
            session.setAttribute("mensaje", mensaje);

            response.setContentType("text/html");
            response.getWriter().println("<script>");
            if (mensaje.equals("Materia actualizada correctamente.")) {
                response.getWriter().println("window.opener.location.reload();");
                response.getWriter().println("window.close();");
            } else {
                response.getWriter().println("alert('Error: " + mensaje + "');");
                response.getWriter().println("window.location.href='/vista/formularios/actualizarMateria.jsp';");
            }
            response.getWriter().println("</script>");

        } catch (Exception e) { // catch genérico opcional
            System.out.println("Hubo error: " + e);
            session.setAttribute("mensaje", "Error inesperado: " + e.getMessage());
            response.setContentType("text/html");
            response.getWriter().println("<script>");
            response.getWriter().println("alert('Error inesperado: " + e.getMessage() + "');");
            response.getWriter().println("window.location.href='/vista/formularios/actualizarMateria.jsp';");
            response.getWriter().println("</script>");
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

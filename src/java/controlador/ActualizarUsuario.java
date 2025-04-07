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
import javax.servlet.http.HttpSession;
import modelo.Conex;
import modelo.Usuario;
import servicio.UsuarioServicio;

@WebServlet(name = "ActualizarUsuario", urlPatterns = {"/ActualizarUsuario"})
public class ActualizarUsuario extends HttpServlet {

    private Connection conexion; //Creamos el objeto "conexion" de tipo Connection
    private UsuarioServicio usuarioServicio; //Creamos el objeto "usuarioServicio" de tipo UsuarioServicio

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
        usuarioServicio = new UsuarioServicio(conexion);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String usuario = request.getParameter("usuario");
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");
        String confirmacion = request.getParameter("confirmacion");
        String rol = request.getParameter("rol");
        
        //Creamos una sesion para almacenar mensajes temporales 
        HttpSession session = request.getSession();

        //Confirmamos que las contraseñas coincidan
        if (!contrasena.equals(confirmacion)) {
            session.setAttribute("mensaje", "Las contraseñas no coinciden.");
            response.sendRedirect("/vista/formularios/actualizarUsuario.jsp");
            return;
        }

        Usuario nuevoUsuario = new Usuario(id, nombre, usuario, correo, contrasena, rol);

        try {
            String mensaje = usuarioServicio.actualizarUsuario(nuevoUsuario);
            session.setAttribute("mensaje", mensaje);

            response.setContentType("text/html");
            response.getWriter().println("<script>");
            if (mensaje.equals("Usuario actualizado correctamente.")) {
                // Recargar la tabla y cerrar la ventana emergente
                response.getWriter().println("window.opener.location.reload();");
                response.getWriter().println("window.close();");
            } else {
                // Mostrar error y redirigir a la página de actualización
                response.getWriter().println("alert('Error: " + mensaje + "');");
                response.getWriter().println("window.location.href='/vista/formularios/actualizarUsuario.jsp';");
            }
            response.getWriter().println("</script>");

        } catch (SQLException e) {
            System.out.println("Hubo error: " + e);
            session.setAttribute("mensaje", "Error en la actualización: " + e.getMessage());
            response.setContentType("text/html");
            response.getWriter().println("<script>");
            response.getWriter().println("alert('Error en la actualización: " + e.getMessage() + "');");
            response.getWriter().println("window.location.href='/vista/formularios/actualizarUsuario.jsp';");
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

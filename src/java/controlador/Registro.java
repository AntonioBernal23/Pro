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
import modelo.Usuario;
import servicio.UsuarioServicio;

@WebServlet(name = "Registro", urlPatterns = {"/Registro"})
public class Registro extends HttpServlet {

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

        //Obtenemos los valores de parametros enviados desde el formulario
        String nombre = request.getParameter("nombre");
        String usuario = request.getParameter("usuario");
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");
        String confirmacion = request.getParameter("confirmacion");
        String rol = request.getParameter("rol");
        String origen = request.getParameter("origen"); //Pagina de donde se enviaron los datos
        String destino = request.getParameter("destino"); //Pagina a donde se debe de redirigir

        //Creamos una sesion para almacenar mensajes temporales 
        HttpSession session = request.getSession();

        //Confirmamos que las contraseñas coincidan
        if (!contrasena.equals(confirmacion)) {
            session.setAttribute("mensaje", "Las contraseñas no coinciden.");
            response.sendRedirect("/vista/registro.jsp");
            return;
        }

        //Creamos un objeto Usuario con los datos ingresados desde el formulario
        Usuario nuevoUsuario = new Usuario(nombre, usuario, correo, contrasena, rol);

        try {
            /*Creamos un mensaje que sera igual a lo que retorne el metodo 
              registrarUsuario() del servicio usuarioServicio y pasamos como 
              parametro nuevoUsuario y sus valores*/
            String mensaje = usuarioServicio.registrarUsuario(nuevoUsuario);

            //Guarda el mensaje en la session
            session.setAttribute("mensaje", mensaje);

            response.setContentType("text/html");
            response.getWriter().println("<script>");
            /*Si registrarUsuario() retorna "Usuario registrado correctamente.",
              significa que el usuario se inserto en la base de datos y se redirige
              a la pagina indicada en "destino", de lo contrario, se regresa a "origen".*/
            if (mensaje.equals("Usuario registrado correctamente.")) {
                if (destino.equals("/vista/administrarUsuario.jsp")) {
                    response.getWriter().println("window.opener.location.reload();");
                    response.getWriter().println("window.close();");
                } else {
                    response.sendRedirect(destino);
                }
            } else {
                if (origen.equals("/vista/formularios/agregarUsuario.jsp")) {
                    response.getWriter().println("alert('Error: " + mensaje + "');");
                    response.getWriter().println("window.location.href='/vista/formularios/agregarUsuario.jsp';");
                }
                response.sendRedirect(origen);
            }
            response.getWriter().println("</script>");
        } catch (SQLException e) {
            session.setAttribute("mensaje", "Error en el registro: " + e.getMessage());
            response.sendRedirect(origen);
        }
    }

    @Override
    public void destroy() {
        try {
            if (conexion != null) {
                conexion.close();
            }
        } catch (SQLException e) {
        }
    }
}
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

@WebServlet(name = "InicioSesion", urlPatterns = {"/InicioSesion"})
public class InicioSesion extends HttpServlet {

    private Connection conexion; //Creamos el objeto "conexion" de tipo Connection
    private UsuarioServicio usuarioServicio; //Creamos el objeto "usuarioServicio" de tipo UsuarioServicio

    @Override
    public void init() throws ServletException {
        try {
            conexion = Conex.conectar();
            if (conexion != null) {
                System.out.println("Conexión exitosa");
            } else {
                System.out.println("Conexión fallida");
            }
        } catch (SQLException ex) {
            Logger.getLogger(InicioSesion.class.getName()).log(Level.SEVERE, "Error al conectar con la base de datos", ex);
        }
        usuarioServicio = new UsuarioServicio(conexion);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0); // Proxies

        //Obtenemos los valores de parametros enviados desde el formulario
        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        //Creamos una sesion para almacenar mensajes temporales
        HttpSession session = request.getSession(true);

        //Validamos si hay campos vacios antes de consultar en la base de datos
        if (usuario == null || usuario.trim().isEmpty()
                || contrasena == null || contrasena.trim().isEmpty()) {
            session.setAttribute("mensaje", "No puede haber campos vacíos.");
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            /*Creamos el objeto usuarioAutenticado de tipo Usuario(modelo) que es igual a lo que
              retorne el metodo autenticarUsuario del servicio usuarioServicio y le pasamos 
              como parametros los valores optenidos desde el formulario*/
            Usuario usuarioAutenticado = usuarioServicio.autenticarUsuario(usuario, contrasena);

            if (usuarioAutenticado != null) {
                //Si usuarioAutenticado es diferente a null lo almacenamos en la sesion
                session.setAttribute("usuario", usuarioAutenticado);

                /*Creamos un switch donde segun lo que sea el rol del usuario es a 
                  donde lo va a redirigir*/
                switch (usuarioAutenticado.getRol()) {
                    case "alumno" ->
                        response.sendRedirect("/ObtenerHorario");
                        //response.sendRedirect("vista/portalAlumnos.jsp");
                    case "maestro" ->
                        response.sendRedirect("vista/portalMaestros.jsp");
                    default ->
                        response.sendRedirect("vista/portalAdministrador.jsp");
                }
                return;
            }

            //Si el usuario no existe o la contraseña es incorrecta 
            session.setAttribute("mensaje", "Usuario o contraseña incorrectos.");
            response.sendRedirect("index.jsp");
        } catch (SQLException e) {
            session.setAttribute("mensaje", "Error al iniciar sesión: " + e.getMessage());
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

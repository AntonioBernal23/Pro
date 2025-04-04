package servicio;

import dao.UsuarioDAO;
import modelo.Usuario;
import java.sql.*;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class UsuarioServicio {

    //Creamos el objeto usuarioDAO de tipo UsuarioDAO(modelo)
    private final UsuarioDAO usuarioDAO;

    //Constructor de UsuarioServicio que recibe como parametro "conexion" de tipo Connection
    public UsuarioServicio(Connection conexion) {
        //Creamos una instancia de usuarioDAO y pasamos "conexion" como parametro
        this.usuarioDAO = new UsuarioDAO(conexion);
    }

    public String actualizarUsuario(Usuario usuario) throws SQLException {
        //Verificamos que lo que se mando no este vacio
        if (usuario.getUsuario() == null || usuario.getUsuario().trim().isEmpty()
                || usuario.getNombre() == null || usuario.getNombre().trim().isEmpty()
                || usuario.getCorreo() == null || usuario.getCorreo().trim().isEmpty()
                || usuario.getContraseña() == null || usuario.getContraseña().trim().isEmpty()
                || usuario.getRol() == null || usuario.getRol().trim().isEmpty()) {

            return "No puede haber campos vacíos.";
        }

        String contraseñaEncriptada = encriptarSHA256(usuario.getContraseña());
        usuario.setContraseña(contraseñaEncriptada);

        boolean actualizado = usuarioDAO.actualizarUsuario(usuario);
        return actualizado ? "Usuario actualizado correctamente." : "Error al actualizar el usuario.";
    }

    /*Metodo para registrar usuarios y recibre usuario y sus atributos como parametro
      Es de tipo String por que va a retornar una string*/
    public String registrarUsuario(Usuario usuario) throws SQLException {
        //Verificamos que lo que se mando no este vacio
        if (usuario.getNombre() == null || usuario.getNombre().trim().isEmpty()
                || usuario.getNombre() == null || usuario.getUsuario().trim().isEmpty()
                || usuario.getCorreo() == null || usuario.getCorreo().trim().isEmpty()
                || usuario.getContraseña() == null || usuario.getContraseña().trim().isEmpty()
                || usuario.getRol() == null || usuario.getRol().trim().isEmpty()) {

            return "No puede haber campos vacios.";
        }

        /*Le pasamos como parametros usuario y correo al metodo usuarioExiste de usuarioDAO para
          comprobar que no exista un usuario con ese correo o usuario*/
        if (usuarioDAO.usuarioExiste(usuario.getUsuario(), usuario.getCorreo())) {
            return "El usuario ya existe.";
        }

        //Encripta la contraseña antes de enviarla al DAO
        String contraseñaEncriptada = encriptarSHA256(usuario.getContraseña());
        usuario.setContraseña(contraseñaEncriptada);

        /*Mandamos como parametro usuario y sus atributos al metodo registrarUsuario de usuarioDAO
          Si retorna verdadero manda la String de "Usuario registrado correctamente."
          de lo contrario manda "Error al registrar el usuario."*/
        boolean registrado = usuarioDAO.registrarUsuario(usuario);
        return registrado ? "Usuario registrado correctamente." : "Error al registrar el usuario.";
    }

    /*Metodo para autenticar el usuario cuando se quiere iniciar sesion, recibe como 
      parametros usuario y contrasena*/
    public Usuario autenticarUsuario(String usuario, String contrasena) throws SQLException {
        //Encripta la contraseña antes de buscar en la BD
        String contrasenaEncriptada = encriptarSHA256(contrasena);
        /*Creamos el objeto usuarioEncontrado de tipo Usiario(modelo) que es igual a lo que retorne
          el metodo ini iarSesion de usuarioDAO y pasamos como parametro usuario y 
          contrasenaEncriptada*/
        Usuario usuarioEncontrado = usuarioDAO.iniciarSesion(usuario, contrasenaEncriptada);

        /*Si lo que retorno usuarioEncontrado es null el metodo retorna null
          de lo contrario retorna usuarioEncontrado y sus atributos*/
        if (usuarioEncontrado == null) {
            return null;
        }

        return usuarioEncontrado; // Inicio de sesión exitoso
    }

    /**
     *
     * @param usuario
     * @param contrasena
     * @return
     * @throws SQLException
     */
    //Metodo para encriptar en SHA-256
    private String encriptarSHA256(String contrasena) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(contrasena.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error al encriptar la contraseña", e);
        }
    }

}

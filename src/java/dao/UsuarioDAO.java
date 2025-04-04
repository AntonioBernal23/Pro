package dao;

import modelo.Usuario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {
    private final Connection conexion;

    public UsuarioDAO(Connection conexion) {
        this.conexion = conexion;
    }

    //Metodo para eliminar usuario
    public String eliminarUsuario(String id) throws SQLException {
        String query = "DELETE FROM usuarios WHERE ID = ?";
        
        PreparedStatement stmt = conexion.prepareStatement(query);
        stmt.setString(1, id);
        
        int ejecucion = stmt.executeUpdate();
        
        String mensaje;
        if (ejecucion > 0) {
            mensaje = "Usuario eliminado correctamente.";
        } else {
            mensaje = "Error al eliminar.";
        }
        return mensaje;
    }
    
    //Metodo para actualizar usuarii
    public boolean actualizarUsuario(Usuario usuario) throws SQLException {
        String query = "UPDATE usuarios SET nombre = ?, usuario = ?, correo = ?, contrasena = ?, rol = ? WHERE ID = ?;";
        PreparedStatement stmt = conexion.prepareStatement(query);
        stmt.setString(1, usuario.getNombre());
        stmt.setString(2, usuario.getUsuario());
        stmt.setString(3, usuario.getCorreo());
        stmt.setString(4, usuario.getContraseña());
        stmt.setString(5, usuario.getRol());
        stmt.setInt(6, usuario.getId());
        return stmt.executeUpdate() > 0;
    }
    
    //Metodo para sacar usuarios
    public List<Usuario> obtenerUsuarios() throws SQLException {
        String query = "SELECT * FROM usuarios;";

        List<Usuario> lista = new ArrayList<>();
        try {
            Statement stmt = conexion.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                
                lista.add(new Usuario(
                        rs.getInt("ID"),
                        rs.getString("nombre"),
                        rs.getString("usuario"),
                        rs.getString("correo"),
                        rs.getString("contrasena"),
                        rs.getString("rol")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    //Verifica si un usuario con el musmo usuario o correo ya existe 
    public boolean usuarioExiste(String usuario, String correo) throws SQLException {
        String query = "SELECT * FROM usuarios WHERE usuario = ? OR correo = ?;";
        PreparedStatement stmt = conexion.prepareStatement(query);
        stmt.setString(1, usuario);
        stmt.setString(2, correo);
        ResultSet rs = stmt.executeQuery();
        return rs.next();
    }

    //Registra un usuario en la base de datos
    public boolean registrarUsuario(Usuario usuario) throws SQLException {
        String query = "INSERT INTO usuarios(nombre, usuario, correo, contrasena, rol) VALUES (?, ?, ?, ?, ?);";
        PreparedStatement stmt = conexion.prepareStatement(query);
        stmt.setString(1, usuario.getNombre());
        stmt.setString(2, usuario.getUsuario());
        stmt.setString(3, usuario.getCorreo());
        stmt.setString(4, usuario.getContraseña());
        stmt.setString(5, usuario.getRol());
        return stmt.executeUpdate() > 0;
    }

    //Busca si hay un registro en la base de datos con el usuario y contraseña mandados
    public Usuario iniciarSesion(String usuario, String contrasena) throws SQLException {
        System.out.println("Usuario: " + usuario);
        System.out.println("Contraseña" + contrasena);
        String query = "SELECT * FROM usuarios WHERE usuario = ? AND contrasena = ?;";
        try (PreparedStatement stmt = conexion.prepareStatement(query)) {
            stmt.setString(1, usuario);
            stmt.setString(2, contrasena);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Usuario(rs.getInt("ID"),
                        rs.getString("nombre"),
                        rs.getString("usuario"),
                        rs.getString("correo"),
                        rs.getString("contrasena"),
                        rs.getString("rol"));
            }
        } catch (SQLException e) {
            System.out.println("Error al consultar usuario: " + e.getMessage());
            throw e; // Vuelve a lanzar la excepción para ser manejada en el servicio
        }
        return null;
    }
}

package dao;

import com.mysql.cj.Messages;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.Materia;

public class MateriaDAO {
    private final Connection conexion;

    public MateriaDAO(Connection conexion) {
        this.conexion = conexion;
    }

    public String registrarMateria(Materia materia) throws SQLException{
        String query = "INSERT INTO materias(nombre, codigo, cupos, descripcion, dia, hora_comienzo, hora_fin) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        PreparedStatement stmt = conexion.prepareStatement(query);
        stmt.setString(1, materia.getNombre());
        stmt.setString(2, materia.getCodigo());
        stmt.setString(3, materia.getCupos());
        stmt.setString(4, materia.getDescripcion());
        stmt.setString(5, materia.getDia());
        stmt.setString(6, materia.getHora_comienzo());
        stmt.setString(7, materia.getHora_fin());
        
        String mensaje = null;
        
        if(stmt.executeUpdate() > 0) {
            mensaje = "Materia registrada correctamente.";
        } else {
            mensaje = "Fallo al registrar materia.";
        }
        
        return mensaje;
    }
    
    //Metodo para sacar materias
    public List<Materia> obtenerMaterias() throws SQLException {
        String query = "SELECT * FROM materias;";
        
        List<Materia> lista = new ArrayList<>();
        try {
            Statement stmt = conexion.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            
            while(rs.next()) {
                lista.add(new Materia(
                        rs.getInt("ID"),
                        rs.getString("nombre"),
                        rs.getString("codigo"),
                        rs.getString("cupos"),
                        rs.getString("descripcion"),
                        rs.getString("dia"),
                        rs.getString("hora_comienzo"),
                        rs.getString("hora_fin")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    } 
    
}

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
                        rs.getString("descripcion"),
                        rs.getString("dia"),
                        rs.getString("hora")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    } 
    
}

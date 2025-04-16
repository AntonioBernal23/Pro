package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.Materia;

public class MateriaDAO {

    private final Connection conexion;

    public MateriaDAO(Connection conexion) {
        this.conexion = conexion;
    }

    public String registrarMateria(Materia materia) throws SQLException {
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

        if (stmt.executeUpdate() > 0) {
            mensaje = "Materia registrada correctamente.";
        } else {
            mensaje = "Fallo al registrar materia.";
        }

        return mensaje;
    }

    //Metodo para asignar maestro
    /*public String asignarMaestro(String idMateria, String idMaestro) throws SQLException {
        String query = "INSERT INTO materia_usuario (id_materia, id_maestro) VALUES (?, ?);";

        PreparedStatement stmt = conexion.prepareStatement(query);
        stmt.setString(1, idMateria);
        stmt.setString(2, idMaestro);

        String mensaje = null;
        if (stmt.executeUpdate() > 0) {
            mensaje = "Maestro asignado correctamente.";
        }

        return mensaje;
    }*/
    
    //Verificar si ya hay maestro asignado
    public String asignarMaestroAMateria(String idMateria, String idMaestro) throws SQLException {
        // Verificar si ya existe un maestro asignado para esa materia
        String checkQuery = "SELECT * FROM materia_usuario WHERE id_materia = ?";

        try (PreparedStatement psCheck = conexion.prepareStatement(checkQuery)) {
            psCheck.setString(1, idMateria);
            ResultSet rs = psCheck.executeQuery();

            if (rs.next()) {
                // Si ya hay una asignación de maestro para esa materia, actualizamos el maestro
                String updateQuery = "UPDATE materia_usuario SET id_maestro = ? WHERE id_materia = ?";
                try (PreparedStatement psUpdate = conexion.prepareStatement(updateQuery)) {
                    psUpdate.setString(1, idMaestro);
                    psUpdate.setString(2, idMateria);
                    psUpdate.executeUpdate();
                }
                return "Maestro asignado correctamente.";
            } else {
                // Si no existe asignación, insertamos el nuevo maestro
                String insertQuery = "INSERT INTO materia_usuario (id_materia, id_maestro) VALUES (?, ?)";
                try (PreparedStatement psInsert = conexion.prepareStatement(insertQuery)) {
                    psInsert.setString(1, idMateria);
                    psInsert.setString(2, idMaestro);
                    psInsert.executeUpdate();
                }
                return "Maestro asignado correctamente.";
            }
        }
    }

    //Metodo para sacar materias
    public List<Materia> obtenerMaterias() throws SQLException {
        String query = "SELECT m.*, u.nombre AS nombre_maestro "
                + "FROM materias m "
                + "LEFT JOIN materia_usuario mu ON m.ID = mu.id_materia AND mu.id_maestro IS NOT NULL "
                + "LEFT JOIN usuarios u ON mu.id_maestro = u.ID AND u.rol = 'maestro' "
                + "GROUP BY m.ID, u.nombre;"; // Esto asegura una fila por materia

        List<Materia> lista = new ArrayList<>();
        try (Statement stmt = conexion.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Materia materia = new Materia(
                        rs.getInt("ID"),
                        rs.getString("nombre"),
                        rs.getString("codigo"),
                        rs.getString("cupos"),
                        rs.getString("descripcion"),
                        rs.getString("dia"),
                        rs.getString("hora_comienzo"),
                        rs.getString("hora_fin")
                );

                // Setear nombre del maestro asignado (si hay uno)
                materia.setMaestroAsignado(rs.getString("nombre_maestro"));

                lista.add(materia);
            }
        }
        return lista;
    }

}

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

    //Metodo para eliminar materia
    public String eliminarMateria(String id) throws SQLException {
        String query = "DELETE FROM materias WHERE ID = ?";

        PreparedStatement stmt = conexion.prepareStatement(query);
        stmt.setString(1, id);

        String mensaje;
        if (stmt.executeUpdate() > 0) {
            mensaje = "Materia eliminada correctamente.";
        } else {
            mensaje = "Error al eliminar.";
        }
        return mensaje;
    }

    //Metodo para actualizar materia
    public String actualizarMateria(Materia materia) {
        String query = "UPDATE materias SET nombre = ?, codigo = ?, cupos = ?, descripcion = ?, dia = ?, hora_comienzo = ?, hora_fin = ? WHERE ID = ?;";
        String mensaje;

        try (PreparedStatement stmt = conexion.prepareStatement(query)) {
            stmt.setString(1, materia.getNombre());
            stmt.setString(2, materia.getCodigo());
            stmt.setString(3, materia.getCupos()); // O setInt si es entero
            stmt.setString(4, materia.getDescripcion());
            stmt.setString(5, materia.getDia());
            stmt.setString(6, materia.getHora_comienzo());
            stmt.setString(7, materia.getHora_fin());
            stmt.setInt(8, materia.getId());

            if (stmt.executeUpdate() > 0) {
                mensaje = "Materia actualizada correctamente.";
            } else {
                mensaje = "Error al actualizar materia: No se encontró la materia con ese ID.";
            }
        } catch (Exception e) {
            // Incluye el tipo de error y el mensaje
            mensaje = "Error al actualizar materia: " + e.getClass().getSimpleName() + " - " + e.getMessage();
        }

        return mensaje;
    }

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

    //Metodo para incribir alumno
    public String inscribirAlumno(String idAlumno, String idMateria, String idMaestro) throws SQLException {
        String mensaje = null;

        // Primero, verifica si hay cupos disponibles
        String checkCuposQuery = "SELECT cupos FROM materias WHERE ID = ?";
        int cuposDisponibles = 0;

        try (PreparedStatement checkCuposStmt = conexion.prepareStatement(checkCuposQuery)) {
            checkCuposStmt.setString(1, idMateria);
            ResultSet rs = checkCuposStmt.executeQuery();

            if (rs.next()) {
                cuposDisponibles = rs.getInt("cupos");
            }
        }

        // Si no hay cupos disponibles, no permitir la inscripción
        if (cuposDisponibles <= 0) {
            return "Error: No hay cupos disponibles para esta materia.";
        }

        // Luego, intenta actualizar si ya existe un registro con alumno = NULL
        String updateQuery = "UPDATE materia_usuario SET id_alumno = ? "
                + "WHERE id_materia = ? AND id_maestro = ? AND id_alumno IS NULL";

        try (PreparedStatement updateStmt = conexion.prepareStatement(updateQuery)) {
            updateStmt.setString(1, idAlumno);
            updateStmt.setString(2, idMateria);
            updateStmt.setString(3, idMaestro);

            int rowsUpdated = updateStmt.executeUpdate();

            if (rowsUpdated > 0) {
                // Si se actualizó la inscripción, resta 1 al número de cupos disponibles
                String updateCuposQuery = "UPDATE materias SET cupos = cupos - 1 WHERE ID = ?";
                try (PreparedStatement updateCuposStmt = conexion.prepareStatement(updateCuposQuery)) {
                    updateCuposStmt.setString(1, idMateria);
                    updateCuposStmt.executeUpdate();
                }
                mensaje = "Alumno inscrito correctamente.";
            } else {
                // Si no se actualizó, verifica si el alumno ya está inscrito en la materia
                String checkQuery = "SELECT COUNT(*) FROM materia_usuario WHERE id_alumno = ? AND id_materia = ?";

                try (PreparedStatement checkStmt = conexion.prepareStatement(checkQuery)) {
                    checkStmt.setString(1, idAlumno);
                    checkStmt.setString(2, idMateria);

                    ResultSet rs = checkStmt.executeQuery();
                    if (rs.next() && rs.getInt(1) > 0) {
                        mensaje = "Error: El alumno ya está inscrito en esta materia.";
                    } else {
                        // Si no está inscrito, inserta el nuevo registro
                        String insertQuery = "INSERT INTO materia_usuario (id_alumno, id_materia, id_maestro) VALUES (?, ?, ?)";

                        try (PreparedStatement insertStmt = conexion.prepareStatement(insertQuery)) {
                            insertStmt.setString(1, idAlumno);
                            insertStmt.setString(2, idMateria);
                            insertStmt.setString(3, idMaestro);

                            int rowsInserted = insertStmt.executeUpdate();

                            if (rowsInserted > 0) {
                                // Después de insertar, resta 1 al número de cupos disponibles
                                String updateCuposQuery = "UPDATE materias SET cupos = cupos - 1 WHERE ID = ?";
                                try (PreparedStatement updateCuposStmt = conexion.prepareStatement(updateCuposQuery)) {
                                    updateCuposStmt.setString(1, idMateria);
                                    updateCuposStmt.executeUpdate();
                                }

                                mensaje = "Alumno inscrito correctamente.";
                            } else {
                                mensaje = "Error al inscribir al alumno.";
                            }
                        }
                    }
                }
            }
        } catch (SQLIntegrityConstraintViolationException e) {
            mensaje = "Error: El alumno ya está inscrito en esta materia.";
        } catch (SQLException e) {
            mensaje = "Error al inscribir al alumno: " + e.getMessage();
        }

        return mensaje;
    }

    //Metodo para obtener id maestro
    public String obtenerIdMaestro(String idMateria) throws SQLException {
        String query = "SELECT mu.id_maestro "
                + "FROM materia_usuario mu "
                + "WHERE mu.id_materia = ?";
        String idMaestro = null;

        try (PreparedStatement stmt = conexion.prepareStatement(query)) {
            stmt.setString(1, idMateria);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    idMaestro = rs.getString("id_maestro");
                }
            }
        }

        return idMaestro;
    }

    //Metodo para obtener materias con maestro asignado
    public List<Materia> obtenerMateriasConMaestro() throws SQLException {
        String query = "SELECT m.ID, m.nombre, m.codigo, m.cupos, m.descripcion, m.dia, m.hora_comienzo, m.hora_fin, u.nombre AS nombre_maestro "
                + "FROM materias m "
                + "JOIN materia_usuario mu ON m.ID = mu.id_materia "
                + "JOIN usuarios u ON mu.id_maestro = u.ID "
                + "WHERE u.rol = 'maestro' AND mu.id_maestro IS NOT NULL "
                + "GROUP BY m.ID, m.nombre, m.codigo, m.cupos, m.descripcion, m.dia, m.hora_comienzo, m.hora_fin, u.nombre"; // Agrupamos por todas las columnas

        List<Materia> lista = new ArrayList<>();

        try (PreparedStatement stmt = conexion.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
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

                // Setear el nombre del maestro
                materia.setMaestroAsignado(rs.getString("nombre_maestro"));

                lista.add(materia);
            }
        }

        return lista;
    }

}

package modelo;

import java.sql.*;

public class Conex {

    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/proyecto_final";  // Cambia esto si es necesario
    private static final String USER = "root";
    private static final String PASS = "1234";

    public static Connection conectar() throws SQLException {
        int intentos = 0;
        while (intentos < 5) {
            try {
                Class.forName(DRIVER);
                Connection conexion = DriverManager.getConnection(URL, USER, PASS);
                if (conexion != null) {
                    System.out.println("Conexión exitosa a la base de datos.");
                }
                return conexion;
            } catch (SQLException e) {
                intentos++;
                System.out.println("Intento " + intentos + " fallido. Esperando para reintentar...");
                try {
                    Thread.sleep(5000); // Espera 5 segundos
                } catch (InterruptedException ie) {
                    Thread.currentThread().interrupt();
                }
            } catch (ClassNotFoundException e) {
                throw new SQLException("Driver no encontrado", e);
            }
        }
        throw new SQLException("No se pudo conectar a la base de datos tras varios intentos");
    }
}

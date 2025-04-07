package modelo;

import java.sql.*;

public class Conex {

    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://mysql:3306/proyecto_final";  // Cambia esto si es necesario
    private static final String USER = "root";
    private static final String PASS = "rootpassword";

    public static Connection conectar() throws SQLException {
        try {
            // Cargar el driver JDBC
            Class.forName(DRIVER);
            // Establecer la conexión
            Connection conexion = DriverManager.getConnection(URL, USER, PASS);
            if (conexion != null) {
                System.out.println("Conexión exitosa a la base de datos.");
            }
            return conexion;
        } catch (ClassNotFoundException e) {
            throw new SQLException("El controlador JDBC no fue encontrado: " + DRIVER, e);
        } catch (SQLException e) {
            throw new SQLException("Error al conectar con la base de datos: " + URL, e);
        }
    }
}

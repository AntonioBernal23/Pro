<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro</title>
    <link rel="stylesheet" href="/vista/css/registro.css?v=1.0">
</head>
<body>
    <div class="container">
        <form action="/Registro" method="post" class="formulario">
            <h1 class="titulo">Crear Cuenta</h1>

            <input type="text" name="nombre" placeholder="Nombre completo" required>
            <input type="text" name="usuario" placeholder="Nombre de usuario" required>
            <input type="text" name="correo" placeholder="Correo electrónico" required>
            <input type="password" name="contrasena" placeholder="Contraseña" required>
            <input type="password" name="confirmacion" placeholder="Confirmar contraseña" required>

            <select name="rol" required>
                <option value="">Selecciona tu rol</option>
                <option value="alumno">Alumno</option>
                <option value="maestro">Maestro</option>
            </select>

            <input type="hidden" name="origen" value="/vista/registro.jsp">
            <input type="hidden" name="destino" value="index.jsp">

            <button type="submit">Registrarse</button>
        </form>
    </div>
</body>
</html>
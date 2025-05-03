<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Crear Cuenta</title>
    <link rel="stylesheet" href="/vista/css/registro.css?v=2.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="registro-container">
        <form action="/Registro" method="post" class="registro-form">
            <h1 class="registro-titulo">Crear Cuenta</h1>

            <div class="input-group">
                <i class="fa fa-user"></i>
                <input type="text" name="nombre" placeholder="Nombre completo" required>
            </div>

            <div class="input-group">
                <i class="fa fa-user-circle"></i>
                <input type="text" name="usuario" placeholder="Nombre de usuario" required>
            </div>

            <div class="input-group">
                <i class="fa fa-envelope"></i>
                <input type="email" name="correo" placeholder="Correo electrónico" required>
            </div>

            <div class="input-group">
                <i class="fa fa-lock"></i>
                <input type="password" name="contrasena" placeholder="Contraseña" required>
            </div>

            <div class="input-group">
                <i class="fa fa-lock"></i>
                <input type="password" name="confirmacion" placeholder="Confirmar contraseña" required>
            </div>

            <div class="input-group">
                <i class="fa fa-user-tag"></i>
                <select name="rol" required>
                    <option value="">Selecciona tu rol</option>
                    <option value="alumno">Alumno</option>
                    <option value="maestro">Maestro</option>
                </select>
            </div>

            <input type="hidden" name="origen" value="/vista/registro.jsp">
            <input type="hidden" name="destino" value="index.jsp">

            <button type="submit" class="btn-registro">Registrarse</button>
        </form>
    </div>
</body>
</html>

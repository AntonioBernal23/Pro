<%@page import="modelo.Usuario"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
        out.println("<script type='text/javascript'>");
        out.println("alert('" + mensaje + "');");
        out.println("</script>");
        session.removeAttribute("mensaje"); // Se el artributo borra después de mostrarlo
    }
%>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario"); // Obtén el objeto Usuario desde la sesión
    if (usuario == null) {
        response.sendRedirect("/index.jsp"); // Redirigir a la página de login si no hay usuario
        return; // Termina la ejecución del código JSP para evitar que se imprima contenido adicional
    }

    Integer ID = usuario.getId();
    String nombre = usuario.getNombre();
    String usuarioNombre = usuario.getUsuario();
    String correo = usuario.getCorreo();
    String contrasena = usuario.getContraseña();
    String rol = usuario.getRol();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <title>Portal de alumnos</title>
    </head>
    <body>

        <h1>Bienvenido, <%= usuario.getNombre()%>!</h1>

        <p>Acceso al portal de estudiantes.</p>

        <p>ROL: <%=usuario.getRol()%></p>

        <form action="/CerrarSesion" method="post">
            <button type="submit">
                <i class="fa-solid fa-right-from-bracket"></i>
            </button>
        </form>
    </body>   
</html>

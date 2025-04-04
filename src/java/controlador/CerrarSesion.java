package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;
import java.net.URLEncoder;

@WebServlet(name = "CerrarSesion", urlPatterns = {"/CerrarSesion"})
public class CerrarSesion extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        //Si la session es diferente de null la invalida
        if (session != null) {
            session.invalidate(); // Invalidar la sesión
        }
        
        //Creamos una string que codifica con UTF-8 y lo manda por URL
        String mensaje = URLEncoder.encode("Sesión cerrada.", "UTF-8");

        response.sendRedirect("/index.jsp?mensaje=" + mensaje);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

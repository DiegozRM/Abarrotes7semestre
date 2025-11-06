package Beans;

import Mapeos.Empleado;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "CrearAdminServlet", urlPatterns = {"/crearAdmin"})
public class CrearAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            EmpleadoDAO empleadoDAO = new EmpleadoDAO();
            
            Empleado admin = new Empleado(
                "Admin",                // nombreEmpleado
                "admin123",             // password
                "Sistema",              // apellPatEmpleado
                "Sistema",              // apellMatEmpleado
                "1990-01-01",          // fechaNac
                "ADMIN000000XXX",      // rfce
                50000,                 // salario
                "Soltero",             // estadoCivil
                "Activo",              // estatus
                "Licenciatura",        // nivelEstudio
                "Administrador"        // tipoUsuario
            );
            
            int id = empleadoDAO.guardaEmpleado(admin);
            
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Crear Administrador</title>");
            out.println("<style>");
            out.println("body { font-family: Arial, sans-serif; max-width: 600px; margin: 50px auto; padding: 20px; background-color: #f5f5f5; }");
            out.println(".container { background-color: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }");
            out.println(".success { color: #28a745; padding: 10px; background-color: #d4edda; border: 1px solid #c3e6cb; border-radius: 4px; margin: 10px 0; }");
            out.println(".error { color: #dc3545; padding: 10px; background-color: #f8d7da; border: 1px solid #f5c6cb; border-radius: 4px; margin: 10px 0; }");
            out.println(".info { background-color: #e7f3ff; padding: 15px; border-left: 4px solid #2196F3; margin: 15px 0; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            out.println("<div class='container'>");
            out.println("<h1>Crear Usuario Administrador</h1>");
            
            if (id > 0) {
                out.println("<div class='success'>");
                out.println("Usuario administrador creado exitosamente con ID: " + id);
                out.println("</div>");
                out.println("<div class='info'>");
                out.println("<h3>Credenciales de acceso:</h3>");
                out.println("<p><strong>Usuario:</strong> Admin</p>");
                out.println("<p><strong>Contraseña:</strong> admin123</p>");
                out.println("<p><strong>Tipo:</strong> Administrador</p>");
                out.println("</div>");
            } else {
                out.println("<div class='error'>");
                out.println("Error al crear el usuario administrador");
                out.println("</div>");
            }
            
            out.println("<p><a href='index.jsp'>Volver al inicio</a></p>");
            out.println("</div>");
            out.println("</body>");
            out.println("</html>");
            
        } catch (Exception e) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head><title>Error</title></head>");
            out.println("<body>");
            out.println("<h1>Error</h1>");
            out.println("<div class='error'>");
            out.println("<p>Error: " + e.getMessage() + "</p>");
            out.println("</div>");
            out.println("</body>");
            out.println("</html>");
            e.printStackTrace();
        }
    }
}

import Beans.EmpleadoDAO;
import Mapeos.Empleado;

public class CrearAdmin {
    public static void main(String[] args) {
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
            
            if (id > 0) {
                System.out.println("Usuario administrador creado exitosamente con ID: " + id);
                System.out.println("Usuario: Admin");
                System.out.println("Contraseña: admin123");
            } else {
                System.out.println("Error al crear el usuario administrador");
            }
            
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}

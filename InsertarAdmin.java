import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;

public class InsertarAdmin {
    public static void main(String[] args) {
        String url = "jdbc:sqlite:SQLite3DB/abarrotes.db";
        
        try (Connection conn = DriverManager.getConnection(url)) {
            if (conn != null) {
                Statement stmt = conn.createStatement();
                
                // Insertar el administrador
                String insertSQL = "INSERT INTO empleado (" +
                    "Nombre_empleado, password, Apell_pat_empleado, Apell_mat_empleado, " +
                    "Fecha_nac, RFCE, Salario, estado_civil, estatus, nivel_estudio, tipoUsuario" +
                    ") VALUES (" +
                    "'Admin', 'admin123', 'Sistema', 'Sistema', " +
                    "'1990-01-01', 'ADMIN000000XXX', 50000, 'Soltero', 'Activo', 'Licenciatura', 'Administrador'" +
                    ")";
                
                stmt.executeUpdate(insertSQL);
                System.out.println("✓ Usuario administrador creado exitosamente!");
                System.out.println("\nCredenciales:");
                System.out.println("  Usuario: Admin");
                System.out.println("  Contraseña: admin123");
                System.out.println("  Tipo: Administrador");
                
                // Verificar
                ResultSet rs = stmt.executeQuery("SELECT No_empleado, Nombre_empleado, tipoUsuario FROM empleado WHERE tipoUsuario = 'Administrador'");
                System.out.println("\nUsuarios administradores:");
                while (rs.next()) {
                    System.out.println("  ID: " + rs.getInt("No_empleado") + 
                                     " | Nombre: " + rs.getString("Nombre_empleado") + 
                                     " | Tipo: " + rs.getString("tipoUsuario"));
                }
                
                stmt.close();
            }
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}

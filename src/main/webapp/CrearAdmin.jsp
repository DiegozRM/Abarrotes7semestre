<%@page import="Beans.EmpleadoDAO"%>
<%@page import="Mapeos.Empleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Crear Usuario Administrador</title>
    <style>
        body {
            font-family: Helvetica, sans-serif;
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .success {
            color: #28a745;
            padding: 10px;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            border-radius: 4px;
            margin: 10px 0;
        }
        .error {
            color: #dc3545;
            padding: 10px;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            border-radius: 4px;
            margin: 10px 0;
        }
        h1 {
            color: #333;
        }
        .info {
            background-color: #e7f3ff;
            padding: 15px;
            border-left: 4px solid #2196F3;
            margin: 15px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Crear Usuario Administrador</h1>
        
        <%
            String resultado = "";
            boolean exito = false;
            
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
                    exito = true;
                    resultado = "Usuario administrador creado exitosamente con ID: " + id;
                } else {
                    resultado = "Error al crear el usuario administrador";
                }
                
            } catch (Exception e) {
                resultado = "Error: " + e.getMessage();
            }
        %>
        
        <% if (exito) { %>
            <div class="success">
                <%= resultado %>
            </div>
            <div class="info">
                <h3>Credenciales de acceso:</h3>
                <p><strong>Usuario:</strong> Admin</p>
                <p><strong>Contrasea:</strong> admin123</p>
                <p><strong>Tipo:</strong> Administrador</p>
            </div>
        <% } else { %>
            <div class="error">
                <%= resultado %>
            </div>
        <% } %>
        
        <p><a href="index.jsp">Volver al inicio</a></p>
    </div>
</body>
</html>



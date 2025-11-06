-- Script para crear usuario administrador
-- Ejecuta este archivo en la base de datos abarrotes.db

INSERT INTO empleado (
    Nombre_empleado,
    password,
    Apell_pat_empleado,
    Apell_mat_empleado,
    Fecha_nac,
    RFCE,
    Salario,
    estado_civil,
    estatus,
    nivel_estudio,
    tipoUsuario
) VALUES (
    'Admin',
    'admin123',
    'Sistema',
    'Sistema',
    '1990-01-01',
    'ADMIN000000XXX',
    50000,
    'Soltero',
    'Activo',
    'Licenciatura',
    'Administrador'
);

-- Verificar que se insertó correctamente
SELECT * FROM empleado WHERE tipoUsuario = 'Administrador';

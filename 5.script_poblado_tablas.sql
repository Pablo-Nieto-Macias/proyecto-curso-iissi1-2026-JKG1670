-- =====================================================
-- POBLAR DATOS - BLOB S.A.
-- Ejecutar despues del script de creacion de tablas.
-- Los id AUTO_INCREMENT se asignan en orden de insercion (empiezan en 1),
-- y las tablas hijas los referencian por ese orden.
-- =====================================================

-- Insertar datos en la tabla Usuarios
-- Usuarios 1-3: clientes | 4: administrador | 5-6: comerciales | 7: gestor | 8-11: mecanicos
INSERT INTO Usuarios (dni, nombreCompleto, telefono, email, contrasena, fechaRegistro) VALUES
('11111111A', 'Ana Lopez Ruiz', '600111001', 'ana.lopez@example.com', 'password123', '2026-01-15'),               -- id 1
('22222222B', 'Luis Perez Gomez', '600111002', 'luis.perez@example.com', 'password123', '2026-02-03'),            -- id 2
('33333333C', 'Marta Soler Vega', '600111003', 'marta.soler@example.com', 'password123', '2026-03-20'),            -- id 3
('44444444D', 'Carlos Admin Ortega', '600222001', 'carlos.admin@blob.example.com', 'password123', '2025-06-01'),   -- id 4
('55555555E', 'Elena Navarro Cruz', '600222002', 'elena.navarro@blob.example.com', 'password123', '2025-09-01'),   -- id 5
('66666666F', 'Pablo Dominguez Gil', '600222003', 'pablo.dominguez@blob.example.com', 'password123', '2025-11-10'), -- id 6
('77777777G', 'Rosa Campos Ibanez', '600222004', 'rosa.campos@blob.example.com', 'password123', '2025-07-15'),     -- id 7
('88888888H', 'Jorge Martin Rey', '600222005', 'jorge.martin@blob.example.com', 'password123', '2025-05-20'),      -- id 8
('99999999J', 'Sofia Vidal Mora', '600222006', 'sofia.vidal@blob.example.com', 'password123', '2025-08-05'),       -- id 9
('10101010K', 'Raul Castro Pena', '600222007', 'raul.castro@blob.example.com', 'password123', '2026-01-08'),      -- id 10
('12121212L', 'Irene Sanz Molina', '600222008', 'irene.sanz@blob.example.com', 'password123', '2026-02-17');       -- id 11

-- Insertar datos en la tabla Clientes
-- Corresponde a los usuarios cliente (1, 2 y 3)
INSERT INTO Clientes (id) VALUES
(1),
(2),
(3);

-- Insertar datos en la tabla Empleados
-- Corresponde a los usuarios empleado (4 al 11). La fecha de contratacion coincide con la de registro.
INSERT INTO Empleados (id, salario, fechaContratacion, fechaBaja) VALUES
(4, 42000.00, '2025-06-01', NULL),   -- Administrador
(5, 28000.00, '2025-09-01', NULL),   -- Comercial
(6, 27500.00, '2025-11-10', NULL),   -- Comercial
(7, 30000.00, '2025-07-15', NULL),   -- Gestor
(8, 24000.00, '2025-05-20', NULL),   -- Mecanico
(9, 25500.00, '2025-08-05', NULL),   -- Mecanico
(10, 24500.00, '2026-01-08', NULL),  -- Mecanico
(11, 26000.00, '2026-02-17', NULL);  -- Mecanico

-- Insertar datos en la tabla Administradores
INSERT INTO Administradores (id) VALUES
(4);

-- Insertar datos en la tabla Establecimientos
-- Establecimientos 1-2: puntos de venta | 3: gestoria | 4-5: talleres
INSERT INTO Establecimientos (direccion, nombre, telefono) VALUES
('Calle Betis 12, Sevilla', 'BLOB Ocasion Aljarafe', '954000001'),                    -- id 1
('Avenida de la Innovacion 5, Sevilla', 'BLOB Ventas Centro', '954000002'),           -- id 2
('Calle Gestoria 3, Mairena del Aljarafe', 'Gestoria Aljarafe', '954000003'),         -- id 3
('Poligono Store, nave 8, Sevilla', 'Taller BLOB Norte', '954000004'),                -- id 4
('Poligono Calonge, nave 2, Sevilla', 'Taller BLOB Sur', '954000005');                -- id 5

-- Insertar datos en la tabla PuntosDeVenta
INSERT INTO PuntosDeVenta (id) VALUES
(1),
(2);

-- Insertar datos en la tabla Gestorias
INSERT INTO Gestorias (id) VALUES
(3);

-- Insertar datos en la tabla Talleres
INSERT INTO Talleres (id) VALUES
(4),
(5);

-- Insertar datos en la tabla Horarios
INSERT INTO Horarios (establecimientoId, diaSemana, horaApertura, horaCierre) VALUES
(1, 'L-V', '09:00:00', '14:00:00'),     -- Punto de venta 1, turno de manana
(1, 'L-J', '16:00:00', '20:00:00'),     -- Punto de venta 1, turno de tarde (no se solapa)
(1, 'S', '10:00:00', '14:00:00'),
(2, 'L-V', '10:00:00', '20:00:00'),     -- Punto de venta 2, jornada continua
(3, 'L-V', '08:30:00', '15:00:00'),     -- Gestoria
(4, 'L-V', '08:00:00', '17:00:00'),     -- Taller Norte
(4, 'S', '09:00:00', '13:00:00'),
(5, 'L-J', '08:00:00', '17:00:00'),     -- Taller Sur
(5, 'V', '08:00:00', '15:00:00');

-- Insertar datos en la tabla Comerciales
-- Corresponde a los empleados 5 y 6, cada uno en un punto de venta
INSERT INTO Comerciales (id, puntoVentaId) VALUES
(5, 1),
(6, 2);

-- Insertar datos en la tabla Gestores
-- Corresponde al empleado 7, en la gestoria 3
INSERT INTO Gestores (id, gestoriaId) VALUES
(7, 3);

-- Insertar datos en la tabla Mecanicos
-- Corresponde a los empleados 8 al 11. Cada mecanico pertenece a un taller (4 o 5).
INSERT INTO Mecanicos (id, especialidad, tallerId) VALUES
(8, 'FrenosYSuspension', 4),   -- Taller Norte
(9, 'Electricas', 5),          -- Taller Sur
(10, 'Mecanicas', 4),          -- Taller Norte
(11, 'ITV', 5);                -- Taller Sur

-- Insertar datos en la tabla Vehiculos
-- clienteId solo se rellena en los vehiculos ya vendidos
INSERT INTO Vehiculos (matricula, precio, modelo, marca, tipo, combustible, estado, clienteId) VALUES
('1234ABC', 18500.00, 'Corolla', 'Toyota', 'Coche', 'Hibrido', 'Vendido', 1),           -- id 1, vendido a Ana
('5678DEF', 12900.00, 'Ibiza', 'SEAT', 'Coche', 'Gasolina', 'Disponible', NULL),        -- id 2
('9012GHI', 7800.00, 'MT-07', 'Yamaha', 'Moto', 'Gasolina', 'Disponible', NULL),        -- id 3
('3456JKL', 45000.00, 'Actros', 'Mercedes', 'Camion', 'Diesel', 'Vendido', 2),          -- id 4, vendido a Luis
('7890MNO', 32000.00, 'Model 3', 'Tesla', 'Coche', 'Electrico', 'Vendido', 3),          -- id 5, vendido a Marta
('2468PQR', 9900.00, 'Clio', 'Renault', 'Coche', 'Diesel', 'EnReparacion', NULL);       -- id 6, en reparacion

-- Insertar datos en la tabla Fotos
-- Un maximo de una foto principal por vehiculo
INSERT INTO Fotos (vehiculoId, enlace, fechaSubida, esPrincipal) VALUES
(1, 'https://blob.example.com/fotos/1234ABC_1.jpg', '2026-01-20', TRUE),
(1, 'https://blob.example.com/fotos/1234ABC_2.jpg', '2026-01-20', FALSE),
(2, 'https://blob.example.com/fotos/5678DEF_1.jpg', '2026-10-01', TRUE),
(2, 'https://blob.example.com/fotos/5678DEF_2.jpg', '2026-10-01', FALSE),
(3, 'https://blob.example.com/fotos/9012GHI_1.jpg', '2026-10-15', TRUE),
(5, 'https://blob.example.com/fotos/7890MNO_1.jpg', '2026-04-10', TRUE);

-- Insertar datos en la tabla Seguros
-- Todos gestionados por la gestoria 3
INSERT INTO Seguros (vehiculoId, gestoriaId, fechaContratacion, fechaInicioSeguro, fechaFinSeguro, sistemaPagos, tipo) VALUES
(1, 3, '2026-03-01', '2026-03-05', '2027-03-05', 'Anual', 'Completo'),          -- Corolla
(4, 3, '2026-05-10', '2026-05-10', '2027-05-10', 'Trimestral', 'Obligatorio'),  -- Actros
(5, 3, '2026-06-01', '2026-06-15', '2027-06-15', 'Mensual', 'Parcial');         -- Model 3

-- Insertar datos en la tabla Servicios
-- Servicios 1-3: ventas | 4-7: reparaciones
INSERT INTO Servicios (fecha, vehiculoId) VALUES
('2026-03-01', 1),   -- id 1, venta del Corolla
('2026-05-10', 4),   -- id 2, venta del Actros
('2026-05-25', 5),   -- id 3, venta del Model 3
('2026-10-20', 5),   -- id 4, reparacion del Model 3
('2026-09-01', 1),   -- id 5, reparacion del Corolla
('2026-11-05', 6),   -- id 6, reparacion del Clio
('2026-11-20', 2);   -- id 7, reparacion del Ibiza

-- Insertar datos en la tabla Ventas
-- La fecha de publicacion es anterior o igual a la fecha del servicio
INSERT INTO Ventas (id, fechaPublicacion, tipo, precioVenta, compradorId, comercialId) VALUES
(1, '2026-02-10', 'SemiNuevo', 18200.00, 1, 5),   -- Ana compra el Corolla a Elena
(2, '2026-04-20', 'Ocasion', 44000.00, 2, 6),     -- Luis compra el Actros a Pablo
(3, '2026-05-01', 'Nuevo', 31500.00, 3, 5);       -- Marta compra el Model 3 a Elena

-- Insertar datos en la tabla Reparaciones
-- El mecanico siempre pertenece al taller de la reparacion y su especialidad coincide con el tipo
INSERT INTO Reparaciones (id, descripcion, precio, duracion, fechaCita, estado, tipoReparacion, tallerId, mecanicoId) VALUES
(4, 'Revision del sistema de carga de la bateria', 180.00, 90, '2026-10-22', 'Finalizada', 'Electricas', 5, 9),
(5, 'Cambio de pastillas y discos de freno delanteros', 320.50, 120, '2026-09-10', 'Finalizada', 'FrenosYSuspension', 4, 8),
(6, 'Cambio de aceite y filtros', 95.00, 60, '2026-11-23', 'EnCurso', 'Mecanicas', 4, 10),
(7, 'Revision ITV previa a la venta', 45.00, 45, '2026-12-02', 'Pendiente', 'ITV', 5, 11);

-- Insertar datos en la tabla Resenas
-- Cada cliente resena un servicio suyo, con fecha posterior al servicio
INSERT INTO Resenas (clienteId, servicioId, puntuacion, comentario, fechaPublicacion) VALUES
(1, 1, 5, 'Trato excelente y proceso muy rapido', '2026-03-05'),                           -- Ana, venta del Corolla
(1, 5, 4, 'Buen trabajo con los frenos, aunque hubo algo de espera', '2026-09-12'),         -- Ana, reparacion del Corolla
(2, 2, 5, 'Todo correcto con la compra del camion', '2026-05-15'),                         -- Luis, venta del Actros
(3, 4, 3, 'Reparacion correcta pero el coste fue mayor del esperado', '2026-10-25');       -- Marta, reparacion del Model 3

-- Insertar datos en la tabla Recambios
-- El stock es el stock inicial (no se descuenta automaticamente al insertar usos)
INSERT INTO Recambios (nombre, precio, stock, descripcion, esOriginal) VALUES
('Pastillas de freno delanteras', 45.90, 12, 'Juego de 4 pastillas', TRUE),         -- id 1
('Disco de freno ventilado', 62.50, 8, 'Disco delantero ventilado', TRUE),          -- id 2
('Filtro de aceite', 9.95, 40, 'Filtro de aceite universal', FALSE),                -- id 3
('Aceite de motor 5W30 (5L)', 34.00, 25, 'Aceite sintetico', TRUE),                 -- id 4
('Modulo de carga de bateria', 210.00, 3, 'Modulo de carga para electricos', TRUE), -- id 5
('Escobillas limpiaparabrisas', 14.99, 30, 'Juego de 2 escobillas', FALSE);         -- id 6

-- Insertar datos en la tabla PedidosRecambios
-- Los pedidos sin fecha de llegada estan pendientes de recibir
INSERT INTO PedidosRecambios (fechaSolicitud, fechaLlegada, cantidad, mecanicoId, recambioId) VALUES
('2026-08-25', '2026-08-28', 10, 8, 1),    -- Pastillas de freno, recibido
('2026-10-10', '2026-10-14', 2, 9, 5),     -- Modulo de carga, recibido
('2026-11-10', NULL, 20, 10, 3),           -- Filtros de aceite, pendiente
('2026-11-18', NULL, 10, 10, 4);           -- Aceite de motor, pendiente

-- Insertar datos en la tabla UsosRecambios
INSERT INTO UsosRecambios (reparacionId, recambioId, cantidad) VALUES
(5, 1, 1),   -- Frenos del Corolla: pastillas
(5, 2, 2),   -- Frenos del Corolla: discos
(4, 5, 1),   -- Bateria del Model 3: modulo de carga
(6, 3, 1),   -- Aceite del Clio: filtro
(6, 4, 1);   -- Aceite del Clio: aceite de motor

-- Insertar datos en la tabla VehiculosRecambios
-- Recambios compatibles con cada vehiculo (incluye los usados en sus reparaciones)
INSERT INTO VehiculosRecambios (vehiculoId, recambioId) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(2, 3),
(2, 4),
(5, 5),
(6, 3),
(6, 4);

-- Insertar datos en la tabla EmpleadosVehiculos
-- Empleado asignado a cada vehiculo (comerciales y mecanicos)
INSERT INTO EmpleadosVehiculos (empleadoId, vehiculoId) VALUES
(5, 2),    -- Elena (comercial) gestiona el Ibiza
(5, 3),    -- Elena (comercial) gestiona la Yamaha
(6, 6),    -- Pablo (comercial) gestiona el Clio
(8, 1),    -- Jorge (mecanico) asignado al Corolla
(9, 5),    -- Sofia (mecanica) asignada al Model 3
(10, 6),   -- Raul (mecanico) asignado al Clio
(11, 2);   -- Irene (mecanica) asignada al Ibiza

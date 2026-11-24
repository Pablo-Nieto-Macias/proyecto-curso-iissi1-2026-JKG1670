DROP TABLE IF EXISTS UsosRecambios;
DROP TABLE IF EXISTS VehiculosRecambios;
DROP TABLE IF EXISTS EmpleadosVehiculos;
DROP TABLE IF EXISTS PedidosRecambios;
DROP TABLE IF EXISTS Recambios;
DROP TABLE IF EXISTS Seguros;
DROP TABLE IF EXISTS Fotos;
DROP TABLE IF EXISTS Resenas;
DROP TABLE IF EXISTS Reparaciones;
DROP TABLE IF EXISTS Ventas;
DROP TABLE IF EXISTS Servicios;
DROP TABLE IF EXISTS Vehiculos;
DROP TABLE IF EXISTS Mecanicos;
DROP TABLE IF EXISTS Gestores;
DROP TABLE IF EXISTS Comerciales;
DROP TABLE IF EXISTS Horarios;
DROP TABLE IF EXISTS Talleres;
DROP TABLE IF EXISTS Gestorias;
DROP TABLE IF EXISTS PuntosDeVenta;
DROP TABLE IF EXISTS Establecimientos;
DROP TABLE IF EXISTS Administradores;
DROP TABLE IF EXISTS Empleados;
DROP TABLE IF EXISTS Clientes;
DROP TABLE IF EXISTS Usuarios;

-- =====================================================
-- USUARIOS
-- =====================================================
CREATE TABLE Usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    dni VARCHAR(9) UNIQUE NOT NULL,
    nombreCompleto VARCHAR(255) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,  -- RN 4
    contrasena VARCHAR(255) NOT NULL,
    fechaRegistro DATE NOT NULL,
    CONSTRAINT RN9 CHECK(CHAR_LENGTH(contrasena) >= 8)
);

CREATE TABLE Clientes (
    id INT PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES Usuarios(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Empleados (
    id INT PRIMARY KEY,
    salario DECIMAL(10, 2) NOT NULL,
    fechaContratacion DATE NOT NULL,
    fechaBaja DATE,
    FOREIGN KEY (id) REFERENCES Usuarios(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT RN10 CHECK (fechaBaja IS NULL OR fechaBaja >= fechaContratacion),
    CONSTRAINT RN11 CHECK (salario >= 0)
);

CREATE TABLE Administradores (
    id INT PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES Empleados(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =====================================================
-- ESTABLECIMIENTOS
-- =====================================================
CREATE TABLE Establecimientos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    direccion VARCHAR(255) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    telefono VARCHAR(15) NOT NULL
);

CREATE TABLE PuntosDeVenta (
    id INT PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES Establecimientos(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Gestorias (
    id INT PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES Establecimientos(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Talleres (
    id INT PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES Establecimientos(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Horarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    establecimientoId INT NOT NULL,
    diaSemana VARCHAR(10) NOT NULL CHECK (diaSemana IN
        ('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo')),
    horaApertura TIME NOT NULL,
    horaCierre TIME NOT NULL,
    FOREIGN KEY (establecimientoId) REFERENCES Establecimientos(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT RN12 CHECK (horaCierre > horaApertura),
    UNIQUE (establecimientoId, diaSemana, horaApertura)
);

-- =====================================================
-- ROLES DE EMPLEADO
-- =====================================================
CREATE TABLE Comerciales (
    id INT PRIMARY KEY,
    puntoVentaId INT NOT NULL,
    FOREIGN KEY (id) REFERENCES Empleados(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (puntoVentaId) REFERENCES PuntosDeVenta(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE Gestores (
    id INT PRIMARY KEY,
    gestoriaId INT NOT NULL,
    FOREIGN KEY (id) REFERENCES Empleados(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (gestoriaId) REFERENCES Gestorias(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE Mecanicos (
    id INT PRIMARY KEY,
    especialidad VARCHAR(30) NOT NULL CHECK (especialidad IN
        ('ITV', 'Mecanicas', 'Electricas', 'ChapaYPintura',
         'FrenosYSuspension', 'NeumaticosYDireccion')),
    tallerId INT NOT NULL,
    FOREIGN KEY (id) REFERENCES Empleados(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (tallerId) REFERENCES Talleres(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    UNIQUE (id, tallerId)  -- necesario para la FK compuesta de Reparaciones
);

-- =====================================================
-- VEHICULOS
-- =====================================================
CREATE TABLE Vehiculos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    matricula VARCHAR(10) UNIQUE NOT NULL,  -- RN-1
    precio DECIMAL(10, 2) NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    marca VARCHAR(100) NOT NULL,
    tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('Coche', 'Moto', 'Camion')),
    combustible VARCHAR(10) NOT NULL CHECK (combustible IN
        ('Electrico', 'Hibrido', 'Gasolina', 'Diesel')),
    estado VARCHAR(15) NOT NULL CHECK (estado IN
        ('Disponible', 'Vendido', 'EnReparacion')),
    clienteId INT,
    FOREIGN KEY (clienteId) REFERENCES Clientes(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CONSTRAINT RN13 CHECK (precio >= 0)
);

CREATE TABLE Fotos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    vehiculoId INT NOT NULL,
    enlace VARCHAR(255) NOT NULL,
    fechaSubida DATE NOT NULL,
    esPrincipal BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (vehiculoId) REFERENCES Vehiculos(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Seguros (
    id INT PRIMARY KEY AUTO_INCREMENT,
    vehiculoId INT NOT NULL,
    gestoriaId INT NOT NULL,
    fechaContratacion DATE NOT NULL,
    fechaInicioSeguro DATE NOT NULL,
    fechaFinSeguro DATE NOT NULL,
    sistemaPagos VARCHAR(15) NOT NULL CHECK (sistemaPagos IN
        ('Mensual', 'Trimestral', 'Anual')),
    tipo VARCHAR(15) NOT NULL CHECK (tipo IN
        ('Obligatorio', 'Parcial', 'Completo')),
    FOREIGN KEY (vehiculoId) REFERENCES Vehiculos(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (gestoriaId) REFERENCES Gestorias(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT RN14 CHECK (fechaFinSeguro > fechaInicioSeguro),
    CONSTRAINT RN23 CHECK (fechaContratacion <= fechaInicioSeguro)
);

-- =====================================================
-- SERVICIOS (ventas y reparaciones)
-- =====================================================
CREATE TABLE Servicios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    vehiculoId INT NOT NULL,
    FOREIGN KEY (vehiculoId) REFERENCES Vehiculos(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE Ventas (
    id INT PRIMARY KEY,
    fechaPublicacion DATE NOT NULL,
    tipo VARCHAR(15) NOT NULL CHECK (tipo IN
        ('Ocasion', 'KM0', 'Nuevo', 'SemiNuevo', 'SegundaMano')),
    precioVenta DECIMAL(10, 2) NOT NULL,
    compradorId INT NOT NULL,
    comercialId INT NOT NULL,
    FOREIGN KEY (id) REFERENCES Servicios(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (compradorId) REFERENCES Clientes(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (comercialId) REFERENCES Comerciales(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT RN22 CHECK (precioVenta >= 0)
);

CREATE TABLE Reparaciones (
    id INT PRIMARY KEY,
    descripcion TEXT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    duracion INT NOT NULL, -- en minutos
    fechaCita DATE NOT NULL,
    estado VARCHAR(15) NOT NULL CHECK (estado IN
        ('Pendiente', 'EnCurso', 'Finalizada', 'Cancelada')),
    tipoReparacion VARCHAR(30) NOT NULL CHECK (tipoReparacion IN
        ('ITV', 'Mecanicas', 'Electricas', 'ChapaYPintura',
         'FrenosYSuspension', 'NeumaticosYDireccion')),
    tallerId INT NOT NULL,
    mecanicoId INT NOT NULL,
    FOREIGN KEY (id) REFERENCES Servicios(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    -- FK compuesta: el mecanico tiene que pertenecer al taller de la reparacion
    FOREIGN KEY (mecanicoId, tallerId) REFERENCES Mecanicos(id, tallerId)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT RN15 CHECK (precio >= 0),
    CONSTRAINT RN16 CHECK (duracion > 0)
);

CREATE TABLE Resenas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    clienteId INT NOT NULL,
    servicioId INT NOT NULL,
    puntuacion INT NOT NULL,
    comentario TEXT,
    fechaPublicacion DATE NOT NULL,
    FOREIGN KEY (clienteId) REFERENCES Clientes(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (servicioId) REFERENCES Servicios(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    UNIQUE (clienteId, servicioId),
    CONSTRAINT RN17 CHECK (puntuacion BETWEEN 1 AND 5)
);

-- =====================================================
-- RECAMBIOS
-- =====================================================
CREATE TABLE Recambios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    descripcion TEXT,
    esOriginal BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT RN18 CHECK (precio >= 0),
    CONSTRAINT RN19 CHECK (stock >= 0)
);

CREATE TABLE PedidosRecambios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fechaSolicitud DATE NOT NULL,
    fechaLlegada DATE,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    mecanicoId INT NOT NULL,
    recambioId INT NOT NULL,
    FOREIGN KEY (mecanicoId) REFERENCES Mecanicos(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (recambioId) REFERENCES Recambios(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT RN20 CHECK (fechaLlegada IS NULL OR fechaLlegada >= fechaSolicitud)
);

CREATE TABLE UsosRecambios (
    reparacionId INT NOT NULL,
    recambioId INT NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (reparacionId, recambioId),
    FOREIGN KEY (reparacionId) REFERENCES Reparaciones(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (recambioId) REFERENCES Recambios(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT RN21 CHECK (cantidad > 0)
);

CREATE TABLE VehiculosRecambios (
    vehiculoId INT NOT NULL,
    recambioId INT NOT NULL,
    PRIMARY KEY (vehiculoId, recambioId),
    FOREIGN KEY (vehiculoId) REFERENCES Vehiculos(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (recambioId) REFERENCES Recambios(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE EmpleadosVehiculos (
    empleadoId INT NOT NULL,
    vehiculoId INT NOT NULL,
    PRIMARY KEY (empleadoId, vehiculoId),
    FOREIGN KEY (empleadoId) REFERENCES Empleados(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (vehiculoId) REFERENCES Vehiculos(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

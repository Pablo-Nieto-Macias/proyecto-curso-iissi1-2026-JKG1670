-- =====================================================
-- TRIGGERS - BLOB S.A.
-- Ejecutar despues del script de creacion de tablas (y antes o despues de poblar).
--
-- Reglas que NO necesitan trigger (ya estan en el script de creacion de tablas):
--   RN-1: matricula UNIQUE en Vehiculos.
--   RN-4: email UNIQUE en Usuarios.
--   RN-3: FK compuesta de Reparaciones (mecanicoId, tallerId, tipoReparacion)
--         hacia Mecanicos (id, tallerId, especialidad).
--
-- Reglas implementadas aqui con trigger: RN-2, RN-5, RN-6 y RN-7.
-- =====================================================

DROP TRIGGER IF EXISTS RN2_reparacion_vehiculo_con_cliente;
DROP TRIGGER IF EXISTS RN5_comerciales_insert;
DROP TRIGGER IF EXISTS RN5_comerciales_update;
DROP TRIGGER IF EXISTS RN5_gestores_insert;
DROP TRIGGER IF EXISTS RN5_gestores_update;
DROP TRIGGER IF EXISTS RN5_mecanicos_insert;
DROP TRIGGER IF EXISTS RN5_mecanicos_update;
DROP TRIGGER IF EXISTS RN6_venta_vehiculo_vendido;
DROP TRIGGER IF EXISTS RN7_reparacion_dia_cliente_insert;
DROP TRIGGER IF EXISTS RN7_reparacion_dia_cliente_update;
DROP PROCEDURE IF EXISTS comprobar_un_establecimiento_por_empleado;
DROP PROCEDURE IF EXISTS comprobar_una_reparacion_por_dia;

DELIMITER //

-- =====================================================
-- RN-2: para abrir una orden de reparacion sobre un vehiculo,
-- este debe estar asociado a un cliente.
-- =====================================================
CREATE TRIGGER RN2_reparacion_vehiculo_con_cliente
BEFORE INSERT ON Reparaciones
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1
               FROM Servicios s
               JOIN Vehiculos v ON v.id = s.vehiculoId
               WHERE s.id = NEW.id AND v.clienteId IS NULL) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'RN-2: no se puede abrir una reparacion sobre un vehiculo sin cliente asociado';
    END IF;
END //

-- =====================================================
-- RN-5: un empleado no puede trabajar en mas de un establecimiento a la vez;
-- si tiene varios roles, todos deben ser del mismo establecimiento.
-- El procedimiento mira los otros dos roles del empleado (el de la tabla
-- que dispara el trigger se excluye para no compararlo con su propia fila antigua).
-- =====================================================
CREATE PROCEDURE comprobar_un_establecimiento_por_empleado(
    IN p_empleadoId INT,
    IN p_establecimientoId INT,
    IN p_origen VARCHAR(15))
BEGIN
    IF (p_origen <> 'Comerciales' AND EXISTS (
            SELECT 1 FROM Comerciales WHERE id = p_empleadoId AND puntoVentaId <> p_establecimientoId))
       OR (p_origen <> 'Gestores' AND EXISTS (
            SELECT 1 FROM Gestores WHERE id = p_empleadoId AND gestoriaId <> p_establecimientoId))
       OR (p_origen <> 'Mecanicos' AND EXISTS (
            SELECT 1 FROM Mecanicos WHERE id = p_empleadoId AND tallerId <> p_establecimientoId)) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'RN-5: un empleado solo puede trabajar en un establecimiento (todos sus roles deben ser del mismo)';
    END IF;
END//

CREATE TRIGGER RN5_comerciales_insert
BEFORE INSERT ON Comerciales
FOR EACH ROW
BEGIN
    CALL comprobar_un_establecimiento_por_empleado(NEW.id, NEW.puntoVentaId, 'Comerciales');
END//

CREATE TRIGGER RN5_comerciales_update
BEFORE UPDATE ON Comerciales
FOR EACH ROW
BEGIN
    CALL comprobar_un_establecimiento_por_empleado(NEW.id, NEW.puntoVentaId, 'Comerciales');
END//

CREATE TRIGGER RN5_gestores_insert
BEFORE INSERT ON Gestores
FOR EACH ROW
BEGIN
    CALL comprobar_un_establecimiento_por_empleado(NEW.id, NEW.gestoriaId, 'Gestores');
END//

CREATE TRIGGER RN5_gestores_update
BEFORE UPDATE ON Gestores
FOR EACH ROW
BEGIN
    CALL comprobar_un_establecimiento_por_empleado(NEW.id, NEW.gestoriaId, 'Gestores');
END//

CREATE TRIGGER RN5_mecanicos_insert
BEFORE INSERT ON Mecanicos
FOR EACH ROW
BEGIN
    CALL comprobar_un_establecimiento_por_empleado(NEW.id, NEW.tallerId, 'Mecanicos');
END//

CREATE TRIGGER RN5_mecanicos_update
BEFORE UPDATE ON Mecanicos
FOR EACH ROW
BEGIN
    CALL comprobar_un_establecimiento_por_empleado(NEW.id, NEW.tallerId, 'Mecanicos');
END//

-- =====================================================
-- RN-6: cuando se registre una nueva venta en la que el concesionario
-- vende un vehiculo a un cliente, el estado del vehiculo correspondiente
-- debe cambiar automaticamente a Vendido.
-- Solo aplica si hay comprador: si el cliente vende al concesionario
-- (compradorId NULL, vendedorId informado) el vehiculo no pasa a Vendido.
-- =====================================================
CREATE TRIGGER RN6_venta_vehiculo_vendido
AFTER INSERT ON Ventas
FOR EACH ROW
BEGIN
    IF NEW.compradorId IS NOT NULL THEN
        UPDATE Vehiculos v
        JOIN Servicios s ON s.vehiculoId = v.id
        SET v.estado = 'Vendido'
        WHERE s.id = NEW.id;
    END IF;
END//

-- =====================================================
-- RN-7: un cliente no puede tener agendada mas de una reparacion
-- en el mismo dia. El cliente de una reparacion es el del vehiculo reparado,
-- y las reparaciones canceladas no cuentan como agendadas.
-- =====================================================
CREATE PROCEDURE comprobar_una_reparacion_por_dia(
    IN p_reparacionId INT,
    IN p_fechaCita DATE,
    IN p_estado VARCHAR(15))
BEGIN
    DECLARE v_clienteId INT;

    IF p_estado <> 'Cancelada' THEN
        SELECT v.clienteId INTO v_clienteId
        FROM Servicios s
        JOIN Vehiculos v ON v.id = s.vehiculoId
        WHERE s.id = p_reparacionId;

        IF v_clienteId IS NOT NULL AND EXISTS (
                SELECT 1
                FROM Reparaciones r
                JOIN Servicios s2 ON s2.id = r.id
                JOIN Vehiculos v2 ON v2.id = s2.vehiculoId
                WHERE v2.clienteId = v_clienteId
                  AND r.fechaCita = p_fechaCita
                  AND r.estado <> 'Cancelada'
                  AND r.id <> p_reparacionId) THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'RN-7: el cliente ya tiene una reparacion agendada ese dia';
        END IF;
    END IF;
END//

CREATE TRIGGER RN7_reparacion_dia_cliente_insert
BEFORE INSERT ON Reparaciones
FOR EACH ROW
BEGIN
    CALL comprobar_una_reparacion_por_dia(NEW.id, NEW.fechaCita, NEW.estado);
END//

CREATE TRIGGER RN7_reparacion_dia_cliente_update
BEFORE UPDATE ON Reparaciones
FOR EACH ROW
BEGIN
    CALL comprobar_una_reparacion_por_dia(NEW.id, NEW.fechaCita, NEW.estado);
END //

DELIMITER ;

-- =====================================================
-- PRUEBAS (con los datos de 5.script_poblado_tablas.sql). Descomentar de una en una.
-- =====================================================

-- RN-2: debe FALLAR (el vehiculo 2, Ibiza, no tiene cliente)
-- INSERT INTO Servicios (fecha, vehiculoId) VALUES ('2026-11-25', 2);
-- INSERT INTO Reparaciones (id, descripcion, precio, duracion, fechaCita, estado, tipoReparacion, tallerId, mecanicoId)
-- VALUES (LAST_INSERT_ID(), 'Prueba RN-2', 50.00, 30, '2026-12-10', 'Pendiente', 'Mecanicas', 4, 10);

-- RN-3: debe FALLAR (el mecanico 10 es de Mecanicas, no de Electricas)
-- INSERT INTO Servicios (fecha, vehiculoId) VALUES ('2026-11-25', 1);
-- INSERT INTO Reparaciones (id, descripcion, precio, duracion, fechaCita, estado, tipoReparacion, tallerId, mecanicoId)
-- VALUES (LAST_INSERT_ID(), 'Prueba RN-3', 50.00, 30, '2026-12-10', 'Pendiente', 'Electricas', 4, 10);

-- RN-5: debe FALLAR (el empleado 5 es comercial en el establecimiento 1 y la gestoria es el 3)
-- INSERT INTO Gestores (id, gestoriaId) VALUES (5, 3);

-- RN-6: debe cambiar el estado del vehiculo 2 a Vendido (vende el concesionario, hay comprador)
-- INSERT INTO Servicios (fecha, vehiculoId) VALUES ('2026-11-25', 2);
-- INSERT INTO Ventas (id, fechaPublicacion, tipo, precioVenta, compradorId, vendedorId, comercialId)
-- VALUES (LAST_INSERT_ID(), '2026-11-01', 'Ocasion', 12500.00, 1, NULL, 5);
-- SELECT id, estado FROM Vehiculos WHERE id = 2;

-- RN-6: NO debe cambiar el estado del vehiculo 3 (el cliente 1 vende su vehiculo al concesionario)
-- INSERT INTO Servicios (fecha, vehiculoId) VALUES ('2026-11-25', 3);
-- INSERT INTO Ventas (id, fechaPublicacion, tipo, precioVenta, compradorId, vendedorId, comercialId)
-- VALUES (LAST_INSERT_ID(), NULL, 'SegundaMano', 7000.00, NULL, 1, 5);
-- SELECT id, estado FROM Vehiculos WHERE id = 3;   -- sigue Disponible

-- RN-7: debe FALLAR (el cliente 1 ya tiene la reparacion 7 agendada el 2026-12-02)
-- INSERT INTO Servicios (fecha, vehiculoId) VALUES ('2026-11-25', 1);
-- INSERT INTO Reparaciones (id, descripcion, precio, duracion, fechaCita, estado, tipoReparacion, tallerId, mecanicoId)
-- VALUES (LAST_INSERT_ID(), 'Prueba RN-7', 50.00, 30, '2026-12-02', 'Pendiente', 'Mecanicas', 4, 10);

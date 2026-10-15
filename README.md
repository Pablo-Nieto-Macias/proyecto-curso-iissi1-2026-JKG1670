# Concesionario de coches: BLOB S.A.

## Miembros del grupo L4-FJO-8

1. Ruda Adorna, Daniel
2. González Pagador, Iván
3. Gómez Botana, José Carlos
4. Nieto Macías, Pablo

## 1. Introducción al problema

Fernando Sol Domecq es el propietario de una cadena de concesionarios de coches llamada BLOB S.A. que se ha quedado un poco atrás en la adaptación al mundo digital. Fernando acude a nosotros, SOLUCIONES INFORMÁTICAS ALJARAFE en búsqueda de darle un aire nuevo a la empresa y al mismo tiempo poder competir en buenas condiciones con el resto del sector.

A nivel de estructura, su empresa cuenta con numerosos establecimientos por toda España uniformemente repartidos que cuentan con buena reputación. Tiene un buen público pero en comparación al resto de la competencia se queda atrás. Por lo tanto, él busca llegar a más clientes para que estos puedan tramitar sus pedidos, reparaciones, etc. desde la comodidad de su hogar, además de tener un sistema unificado y coherente con las propiedades del negocio general, es decir, que se incluya información de todos los establecimientos del país. En resumen, buscar ofrecer lo mismo a lo que ha llegado la competencia pero con el sello de calidad y experiencia de BLOB S.A. y facilitando la gestión de la empresa en sí en el proceso.

En cuanto a sus expectativas, él espera que el negocio crezca exponencialmente además de que gané buena fama a través de las reseñas y, ya que nuestros servicios son los líderes en calidad-precio y el buen resultado de este proyecto nos propulsaría aún más lejos

<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/e1c37026-a2d1-49bd-a08d-a912095cda89" />

## 2. Glosario de términos

- Clientes: usuarios que compran vehículos o solicitan una reparación.

- Comercial: empleado que trabaja en el punto de venta encargado de vender los vehículos.
<center><img width="330" height="181" alt="image" src="https://github.com/user-attachments/assets/4ad987d6-d08f-43b2-9705-95e4df5e42d1" />
</center>

- Empleados: tienen permisos de administrador en el sistema. Además se diferencian en ser mecánico, que trabajan en talleres, o comercial, que está enfocado en la venta de coches y trabajan en los puntos de venta.

- Fotos: imagen de los vehículos a vender.

- Gestoría: empresa externa encargada de los seguros de los vehículos vendidos y el resto de documentación.

- Mecánico: empleados que trabajan en talleres reparando vehículos enviados para clientes.

- Punto de venta: espacio físico en donde se venden los vehículos.

- Recambios: piezas que se le cambiarán al vehículo cuando esté defectuoso durante las reparaciones, podrán ser originales o no.

- Talleres: espacios con los que cuenta el concesionario en donde se reparan vehículos.
<center><img width="330" height="181" alt="image" src="https://github.com/user-attachments/assets/85f8076d-a982-475a-a07a-40b907f9db78" /></center>

- Usuario: toda persona que puede acceder al sistema. Son o bien clientes, que compran vehículos, o bien empleados del punto de venta, con distintos privilegios.

- Vehículo: sean motos, coches, camiones… serán arreglados en los talleres y vendidos en los puntos de venta.
<center><img width="330" height="181" alt="image" src="https://github.com/user-attachments/assets/2754d09d-1169-493e-82b6-6817df50d41c" /></center>

- Vehículo de ocasión: vehículo de segunda mano que se vende con garantía de que funcione correctamente.


## 3. Visión general del sistema

### 3.1. Requisitos generales

**RG-01.** Sistema unificado y centralizado. El sistema integrará la información de todos los establecimientos de BLOB S.A.

**RG-02.** Gestión de usuarios y roles. El sistema distinguirá entre clientes y empleados, y dentro de estos, entre comerciales y mecánicos.

**RG-03.** Gestión de reparaciones. Cubrirá las reparaciones realizadas en los talleres, incluidos los recambios.

**RG-04.** Reseñas y valoraciones. Los clientes podrán valorar su experiencia, dado que la reputación es un objetivo explícito del cliente.

**RG-05.** Integridad y consistencia de los datos. La información debe ser coherente entre establecimientos.

### 3.2. Usuarios del sistema

#### 1. Cliente

Se trata del consumidor del servicio. Sus funciones se limitan a:

- Consultar el catálogo de coches disponibles en la base de datos aplicando filtros de búsqueda.
- Hacer uso del servicio de taller del concesionario y consultar información sobre sus reparaciones
- Escribir, publicar y editar reseñas de su experiencia.
- Publicar anuncios de sus propios vehículos para su posterior venta.

#### 2. Comercial

Se trata de la cara al público de los puntos de ventas del concesionario.

Sus funciones se limitan a:

- Gestionar y registrar las ventas de coches y el estado de estas.
- Asociar la gestoría a la venta de un coche para establecer una póliza de seguro correspondiente a ese coche.
- Registrar y organizar las entradas y salidas de coches en la base de datos (fotos, características del vehículo, etc.).

#### 3. Mecánico

Se trata del trabajador que se encarga de reparar y mantener los vehículos.

Sus funciones se limitan a:

- Gestionar las citas de las reparaciones solicitadas y organizarlas según su categoría técnica.
- Gestionar y registrar reparaciones con sus respectivos atributos (fecha, vehículo, categoría técnica...)
- Organizar el inventario de recambios y tener la posibilidad de realizar pedidos en caso de falta de estos.

#### 4. Administrador

Se trata del gestor principal del sistema informático.

Sus funciones son:

- Tener acceso a todo el sistema y todos los privilegios, es decir, tener acceso a todas las funciones de los demás roles.
- Gestionar los establecimientos de la empresa en la base de datos (puntos de venta y talleres).
- Administrar a los demás usuarios y, en el caso de los trabajadores, poder asignarles un establecimiento específico.

## 4. Catálogo de requisitos

### 4.1. Requisitos funcionales

**RF1 - Registro de clientes**

Como cliente,
quiero crear una cuenta desde la web con mis datos personales ,para tramitar pedidos y reparaciones desde casa.

**RF2 - Gestión de establecimientos**

Como administrador,
quiero registrar todos mis establecimientos indicando si son taller o punto de venta  para tener un sistema unificado con la información de todos los centros.

**RF3 - Alta de vehículos**

Como comercial,
quiero registrar un vehículo indicando su tipo, características, precio y establecimiento, para mantener el catálogo actualizado.

**RF4 - Galería de fotos del vehículo**

Como comercial, quiero subir varias fotos a cada vehículo,para que el cliente pueda verlo en detalle antes de comprarlo.

**RF5 -  Búsqueda de vehículos**

Como cliente,
quiero filtrar los vehículos por tipo, precio, marca y establecimiento, para encontrar rápidamente el que se ajusta a lo que busco.

**RF6 -  Registro de ventas**

Como comercial,
quiero registrar una venta indicando cliente, vehículo y  tipo de venta  para llevar un control exacto de las operaciones.

**RF7 - Registro de reparaciones**

Como mecánico,
quiero registrar cada reparación con el vehículo, tipo, avería, recambios usados y coste,
para mantener el historial técnico de cada coche.

#### 4.1.1. Requisitos de información

**RI1**
Como cliente quiero disponer de la siguiente información sobre los vehículos en venta:

- La matrícula del vehículo
- El precio del vehículo
- El modelo del vehículo
- Las fotos del vehículo subidas por el comercial
- El punto de venta donde lo puedo adquirir
- La marca del vehículo

**RI2**
Como cliente quiero disponer de la siguiente información sobre los vehículos de mi propiedad que están en reparación:

- Precio de la reparación
- Recambios usados
- Taller dónde se está haciendo la reparación:
  - Dirección del taller
- Duración estimada de la reparación
- Mecánico encargado de la reparación:
  - Nombre
  - Apellidos
  - Número de teléfono

**RI3**
Como comercial quiero disponer de la siguiente información sobre mi estado en el punto de venta donde trabajo:

- Sueldo mensual por trabajar para BLOB S.A.
- Información específica sobre el establecimiento:
  - Dirección del punto de venta
  - Horario de apertura
- Información sobre los vehículos que están en venta en el punto de venta:
  - La matrícula del vehículo
  - El modelo del vehículo
  - La marca del vehículo
  - Estado del vehículo
- Información de las gestorías que asegurarán a los vehículos:
  - Nombre de la gestoría
  - Tipo de seguro sobre el vehículo
- Información sobre clientes que hayan comprado vehículos:
  - DNI
  - Nombre
  - Apellidos
  - Correo electrónico

**RI4**
Como mecánico quiero disponer de la siguiente información sobre mi estado en el taller donde trabajo:

- Sueldo mensual por trabajar para BLOB S.A.
- Información sobre los recambios que necesito para las reparaciones:
  - Detalles sobre el pedido de cada recambio necesario
  - Nombre del recambio
  - Costes del recambio
  - Información sobre la/s pieza/s de recambio
  - Posibles compatibilidades del recambio con los vehículos del taller
- Información sobre los vehículos que están siendo reparados:
  - La matrícula del vehículo
  - El modelo del vehículo
  - La marca del vehículo
  - Estado del vehículo
- Información sobre clientes que hayan solicitado la reparación de su vehículo:
  - DNI
  - Nombre
  - Apellidos
  - Correo electrónico

#### 4.1.2. Reglas de negocio

**RN-1:** no pueden existir dos vehículos registrados con la misma matrícula o número de bastidor.

**RN-2:** para abrir una orden de reparación sobre un vehículo, este debe estar asociado a un cliente.

**RN-3:** una reparación de tipo específica sólo puede ser efectuada por un empleado( mecánico) que cumpla con dicha especialización.

**RN-4:** un usuario no puede registrarse dos veces con el mismo email.

**RN-5:** un empleado no puede estar trabajando en más de un establecimiento a la vez.

### 4.2. Mapa de historias de usuario (opcional)
<img width="1879" height="837" alt="image" src="https://github.com/user-attachments/assets/6ec44f62-d2ed-4cd3-a36c-76406fa80179" />

### 4.3. Requisitos no funcionales (opcional)

**RNF1 - Control de acceso**

Como administrador, quiero que sólo puedan acceder al sistema los empleados de mi organización, para cumplir con la Ley de Protección de Datos.

**RNF2 - Capacidad de usuarios simultáneos**

Como administrador, quiero que el sistema soporte la conexión simultánea de los clientes y empleados de todos los establecimientos sin perder velocidad, para que el crecimiento del negocio no afecte al servicio. 

**RNF3 - Compatibilidad con dispositivos**

Como cliente, quiero que la plataforma funcione correctamente en móvil, tablet y ordenador y en los navegadores más habituales, para acceder desde cualquier dispositivo. 

**RNF4 - Conservación del trabajo**

Como mecánico, quiero que los datos introducidos no se pierdan si se corta la conexión, para no tener que repetir el registro de una reparación.

-- fin entregable 1 --

## 5. Modelo conceptual

### 5.1. Diagramas de clases UML

- con restricciones.

### 5.2. Escenarios de prueba

- con descripción textual y diagrama de objetos UML.

## 6. Matrices de trazabilidad

- Matriz de trazabilidad entre los elementos del modelo conceptual y los requisitos.

|       | EntidadX   | AsociaciónX  | RestricciónX  | Entidad2 ...   | 
|:------|:-----------|:-----------|:-----------|:-----------|
| RI-1  | X          | X          | X          | X          |
| RI-2  |            | X          |            | X          |
| RF-1  |            | X          |            | X          |
| RF-2  | X          |            | X          | X          |
| RN-1  |            | X          |            |            |
| RN-2  | X          | X          | X          |            |
| ...   |            |            |            |            |

-- fin entregable 2 --

## 7. Modelo relacional en 3FN

- Relaciones obtenidas al aplicar la transformación del modelo conceptual.

### 7.1.  Justificación de la estrategia de transformación de jerarquías

- si se identificaron jerarquías en el MC.


### 8. Matriz de trazabilidad MC/SQL (opcional):

- Restricciones sobre el MC / Elementos del modelo tecnológico (SQL) (Triggers, checks, etc.)
- Incluir Reglas de negocio — Constraints/Triggers en las matrices de trazabilidad para el entregable 3

|       | EntidadX   | AsociaciónX  | RestricciónX  | Entidad2 ...   | 
|:-------|:-------|:-------|:-------|:-------|
| TABLA-1 |        |        |        |        |
| TABLA-2 |        |        |        |        |
| TABLA-3 |        |        |        |        |
| TABLA-4 |        |        |        |        |
| TRIG-1 |        |        |        |        |
| TRIG-2 | X      | X      |        | X      |
| TRIG-3 |        | X      |        | X      |
| TRIG-4 |        |        | X      |        |
| CONST-1 |        |        |        |        |
| CONST-2 | X      | X      |        | X      |
| CONST-3 |        | X      |        | X      |
| CONST-4 |        |        | X      |        |

Se consideran todo tipo de constraints declarativas (aquellas definidas durante el CREATE TABLE).
-- fin entregable 3 --

## Referencias



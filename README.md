# Título Proyecto

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

-Clientes: usuarios que compran vehículos o solicitan una reparación.
-Comercial: empleado que trabaja en el punto de venta encargado de vender los vehículos.
-Empleados: tienen permisos de administrador en el sistema. Además se diferencian en ser mecánico, que trabajan en talleres, o comercial, que está enfocado en la venta de coches y trabajan en los puntos de venta.
-Fotos: imagen de los vehículos a vender.
-Gestoría: empresa externa encargada de los seguros de los vehículos vendidos y el resto de documentación.
-Mecánico: empleados que trabajan en talleres reparando vehículos enviados para clientes.
-Punto de venta: espacio físico en donde se venden los vehículos.
-Recambios: piezas que se le cambiarán al vehículo cuando esté defectuoso durante las reparaciones, podrán ser originales o no.
-Talleres: espacios con los que cuenta el concesionario en donde se reparan vehículos.
-Usuario: toda persona que puede acceder al sistema. Son o bien clientes, que compran vehículos, o bien empleados del punto de venta, con distintos privilegios.
-Vehículo: sean motos, coches, camiones… serán arreglados en los talleres y vendidos en los puntos de venta.
-Vehículo de ocasión: vehículo de segunda mano que se vende con garantía de que funcione correctamente.

## 3. Visión general del sistema

### 3.1. Requisitos generales

### 3.2. Usuarios del sistema

## 4. Catálogo de requisitos

### 4.1. Requisitos funcionales

#### R.F.01. Título requisito funcional

Como [tipo de usuario]
quiero [servicio]
para [razón]

**Prueba de aceptación**
- Descripción de la primera comprobación a realizar
- Descripción de la segunda comprobación a realizar
- Se debe aplicar la regla de negocio R.N.XX.
- ...

#### 4.1.1. Requisitos de información

##### R.I.01. Título requisito de información

Como [tipo de usuario]
quiero [servicio]
para [razón]

**Prueba de aceptación**
- Descripción de la primera comprobación a realizar
- Descripción de la segunda comprobación a realizar
- ...

#### 4.1.2. Reglas de negocio

##### R.N.01. Título regla negocio

Descripción de la regla de negocio.

### 4.2. Mapa de historias de usuario (opcional)

### 4.3. Requisitos no funcionales (opcional)

**R.N.F. 01. Título requisito no funcional**
Como [tipo de usuario]
quiero [servicio]
para [razón]

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



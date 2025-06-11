-- Crear la base de datos
-- CREATE DATABASE rrhh_database;

-- Usar la base de datos
-- USE rrhh_database;

/* ========= 1. Dimensiones (datos maestros) ========= */

/* Tiendas / Sucursales */
CREATE TABLE Tiendas (
    ID_Tienda        INT PRIMARY KEY,
    Nombre_Tienda    VARCHAR(100),
    Ciudad           VARCHAR(80),
    Provincia        VARCHAR(80),
    Pais             VARCHAR(50),
    Fecha_Apertura   DATE,
    Metros_Cuadrados INT
);

/* Puestos de trabajo */
CREATE TABLE Puestos (
    ID_Puesto        INT PRIMARY KEY,
    Nombre_Puesto    VARCHAR(100),
    Departamento     VARCHAR(80),
    Nivel            VARCHAR(50)          -- p.ej. “Operativo”, “Mando intermedio”
);

/* Empleados */
CREATE TABLE Empleados (
    ID_Empleado      INT PRIMARY KEY,
    Nombre           VARCHAR(50),
    Apellido         VARCHAR(50),
    Genero           CHAR(1),             -- M/F/O
    Fecha_Nacimiento DATE,
    Fecha_Alta       DATE,
    Estado           VARCHAR(20),         -- Activo, Baja, Extern@, etc.
    ID_Puesto        INT,
    ID_Tienda        INT,
    Tipo_Contrato    VARCHAR(30),         -- Indefinido, Temporal, Prácticas…
    Jornada          VARCHAR(20),         -- Completa, Parcial, Fin de semana
    Salario_Base     DECIMAL(10,2),
    FOREIGN KEY (ID_Puesto) REFERENCES Puestos(ID_Puesto),
    FOREIGN KEY (ID_Tienda) REFERENCES Tiendas(ID_Tienda)
);

/* ========= 2. Hechos operativos ========= */

/* Fichajes (relojes de control horario) */
CREATE TABLE Fichajes (
    ID_Fichaje    BIGINT PRIMARY KEY,
    ID_Empleado   INT,
    Fecha_Hora    DATETIME,
    Tipo          VARCHAR(10),            -- Entrada / Salida / Pausa
    Dispositivo   VARCHAR(50),
    FOREIGN KEY (ID_Empleado) REFERENCES Empleados(ID_Empleado)
);

/* Absentismo (ausencias justificadas o no) */
CREATE TABLE Ausencias (
    ID_Ausencia     INT PRIMARY KEY,
    ID_Empleado     INT,
    Fecha_Inicio    DATE,
    Fecha_Fin       DATE,
    Tipo_Ausencia   VARCHAR(50),          -- Enfermedad, Vacaciones, Permiso, No justificada
    Comentario      VARCHAR(255),
    FOREIGN KEY (ID_Empleado) REFERENCES Empleados(ID_Empleado)
);

/* Vacantes cubiertas / Rotación */
CREATE TABLE Movimientos_Laborales (
    ID_Movimiento   INT PRIMARY KEY,
    ID_Empleado     INT,
    Fecha_Mov       DATE,
    Tipo_Mov        VARCHAR(30),          -- Alta, Baja, Cambio_Puesto, Traslado_Tienda
    Detalle         VARCHAR(255),
    FOREIGN KEY (ID_Empleado) REFERENCES Empleados(ID_Empleado)
);

/* Evaluaciones de desempeño */
CREATE TABLE Evaluaciones (
    ID_Evaluacion   INT PRIMARY KEY,
    ID_Empleado     INT,
    Fecha_Eval      DATE,
    Puntuacion      DECIMAL(3,2),         -- 0–5
    Comentarios     VARCHAR(255),
    Evaluador       VARCHAR(100),
    FOREIGN KEY (ID_Empleado) REFERENCES Empleados(ID_Empleado)
);

/* Formación / Cursos realizados */
CREATE TABLE Formaciones (
    ID_Formacion    INT PRIMARY KEY,
    ID_Empleado     INT,
    Curso           VARCHAR(100),
    Fecha_Inicio    DATE,
    Fecha_Fin       DATE,
    Horas           DECIMAL(5,2),
    Certificado     VARCHAR(100),
    FOREIGN KEY (ID_Empleado) REFERENCES Empleados(ID_Empleado)
);

/* Coste salarial mensual (snapshot) – útil para KPIs de coste por hora trabajada */
CREATE TABLE Costes_Salariales (
    ID_Coste      BIGINT PRIMARY KEY,
    ID_Empleado   INT,
    Mes           DATE,                   -- Usar el día 1 del mes como referencia
    Salario_Fijo  DECIMAL(10,2),
    Variables     DECIMAL(10,2),
    Seguridad_Social DECIMAL(10,2),
    FOREIGN KEY (ID_Empleado) REFERENCES Empleados(ID_Empleado)
);

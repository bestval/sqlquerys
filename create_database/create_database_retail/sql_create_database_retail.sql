-- Crear la base de datos
-- CREATE DATABASE fashion_retail;

-- Usar la base de datos
-- USE fashion_retail;

-- Crear las tablas

/*CREATE TABLE Categorias (
    ID_Categoria INT PRIMARY KEY,
    Nombre_Categoria VARCHAR(50),
    Descripcion VARCHAR(255)
);

CREATE TABLE Marcas (
    ID_Marca INT PRIMARY KEY,
    Nombre_Marca VARCHAR(50),
    Pais_Origen VARCHAR(50)
);

CREATE TABLE Productos (
    ID_Producto INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Descripcion VARCHAR(255),
    ID_Categoria INT,
    ID_Marca INT,
    Precio DECIMAL(10, 2),
    Costo DECIMAL(10, 2),
    Stock INT,
    Talla VARCHAR(10),
    Color VARCHAR(20),
    Genero VARCHAR(10),
    Fecha_Ingreso DATE,
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID_Categoria),
    FOREIGN KEY (ID_Marca) REFERENCES Marcas(ID_Marca)
);

CREATE TABLE Clientes (
    ID_Cliente INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Email VARCHAR(100),
    Telefono VARCHAR(20),
    Direccion VARCHAR(255),
    Fecha_Registro DATE
);

CREATE TABLE Ventas (
    ID_Venta INT PRIMARY KEY,
    ID_Cliente INT,
    Fecha_Venta DATE,
    Total_Venta DECIMAL(10, 2),
    Metodo_Pago VARCHAR(50),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);

CREATE TABLE Detalle_Ventas (
    ID_Detalle INT PRIMARY KEY,
    ID_Venta INT,
    ID_Producto INT,
    Cantidad INT,
    Precio_Unitario DECIMAL(10, 2),
    Subtotal DECIMAL(10, 2),
    FOREIGN KEY (ID_Venta) REFERENCES Ventas(ID_Venta),
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);

CREATE TABLE Proveedores (
    ID_Proveedor INT PRIMARY KEY,
    Nombre_Empresa VARCHAR(100),
    Contacto VARCHAR(100),
    Email VARCHAR(100),
    Telefono VARCHAR(20),
    Direccion VARCHAR(255)
);

CREATE TABLE Compras (
    ID_Compra INT PRIMARY KEY,
    ID_Proveedor INT,
    Fecha_Compra DATE,
    Total_Compra DECIMAL(10, 2),
    FOREIGN KEY (ID_Proveedor) REFERENCES Proveedores(ID_Proveedor)
);

CREATE TABLE Detalle_Compras (
    ID_Detalle_Compra INT PRIMARY KEY,
    ID_Compra INT,
    ID_Producto INT,
    Cantidad INT,
    Precio_Unitario DECIMAL(10, 2),
    Subtotal DECIMAL(10, 2),
    FOREIGN KEY (ID_Compra) REFERENCES Compras(ID_Compra),
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);*/

-- Crear la base de datos (Si no existe)
CREATE DATABASE IF NOT EXISTS g4s_database;
USE g4s_database;

-- 1. Tabla de Roles (Para el ambiente organizacional y permisos)
CREATE TABLE Roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) UNIQUE NOT NULL, -- Ej: 'SuperAdmin', 'Gerente', 'Cliente', 'Tecnico'
    descripcion TEXT
);

-- 2. Tabla de Usuarios (Unificada: Sirve para Empleados y Clientes que inician sesión)
CREATE TABLE Usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(150) UNIQUE NOT NULL,
    numero_celular VARCHAR(20),
    contrasena VARCHAR(255) NOT NULL, -- Contraseña 
    id_rol INT NOT NULL,
    direccion TEXT, -- Usado principalmente para clientes
    estado VARCHAR(20) DEFAULT 'Activo',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_rol) REFERENCES Roles(id_rol)
);

-- 3. Tabla de Ubicaciones (Las instalaciones o sucursales del cliente)
CREATE TABLE Ubicaciones (
    id_ubicacion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL, -- Vinculado al Cliente que es dueño de la instalación
    nombre_ubicacion VARCHAR(100) NOT NULL, -- Ej: 'Oficina Central', 'Casa de Campo'
    direccion_completa TEXT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);

-- 4. Tabla de Cámaras
CREATE TABLE Camaras (
    id_camara INT AUTO_INCREMENT PRIMARY KEY,
    id_ubicacion INT NOT NULL,
    modelo_camara VARCHAR(100),
    numero_serie VARCHAR(100) UNIQUE,
    url_transmision_en_vivo TEXT, -- URL de la transmisión para mostrar en la web
    estado VARCHAR(50) DEFAULT 'Online',
    FOREIGN KEY (id_ubicacion) REFERENCES Ubicaciones(id_ubicacion) ON DELETE CASCADE
);

-- 5. Tabla de Grabaciones
CREATE TABLE Grabaciones (
    id_grabacion INT AUTO_INCREMENT PRIMARY KEY,
    id_camara INT NOT NULL,
    fecha_hora_inicio DATETIME NOT NULL,
    fecha_hora_fin DATETIME,
    url_almacenamiento_nube TEXT NOT NULL,
    FOREIGN KEY (id_camara) REFERENCES Camaras(id_camara) ON DELETE CASCADE
);

-- 6. Tabla de Productos (Catálogo y Ventas en la Web)
CREATE TABLE Productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio_venta DECIMAL(10, 2) NOT NULL,
    cantidad_stock INT DEFAULT 0,
    url_imagen TEXT
);

-- 7. Tabla de Ventas en Línea
CREATE TABLE Ventas_Web (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL, -- El cliente que realizó la compra
    fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    monto_total DECIMAL(10, 2) NOT NULL,
    estado_pago VARCHAR(50) DEFAULT 'Completado',
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- 8. Detalle de los productos de cada venta
CREATE TABLE Detalle_Venta (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES Ventas_Web(id_venta) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- 9. Facturación de Suscripción (Cobros recurrentes por el monitoreo)
CREATE TABLE Facturas_Suscripcion (
    id_factura INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL, -- Cliente
    monto DECIMAL(10, 2) NOT NULL,
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    estado VARCHAR(20) DEFAULT 'Pendiente', -- Pendiente, Pagada, Vencida
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- ==========================================
-- DATOS INICIALES (Opcional, pero recomendado)
-- ==========================================
INSERT INTO Roles (nombre_rol, descripcion) VALUES 
('SuperAdmin', 'Acceso total al sistema y a todas las cámaras'),
('Tecnico', 'Acceso para gestionar cámaras, sin acceso a facturación'),
('Cliente', 'Acceso solo a la web, cámaras propias y tienda');

CREATE DATABASE db_eventos_peru;
USE db_eventos_peru;

-- =========================================================
-- 1. TABLA DE USUARIOS AUTENTICADOS
-- =========================================================
CREATE TABLE auth_users (
  id VARCHAR(20) PRIMARY KEY,
  email VARCHAR(150) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  enabled TINYINT(1) NOT NULL DEFAULT 1,
  nombre VARCHAR(100) NOT NULL,
  direccion VARCHAR(200),
  celular VARCHAR(20),
  rol VARCHAR(50) DEFAULT 'CLIENTE',
  calificacion_promedio DECIMAL(3,2) DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  status TINYINT(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =========================================================
-- 2. TABLAS MAESTRAS (TODAS CON user_id)
-- =========================================================

CREATE TABLE tipos_evento (
  id VARCHAR(20) PRIMARY KEY,
  user_id VARCHAR(20) NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  descripcion TEXT,
  activo TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  status TINYINT(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE categorias_servicio (
  id VARCHAR(20) PRIMARY KEY,
  user_id VARCHAR(20) NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  descripcion TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  status TINYINT(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE estados_evento (
  id VARCHAR(20) PRIMARY KEY,
  user_id VARCHAR(20) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  descripcion TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  status TINYINT(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =========================================================
-- 3. SERVICIOS Y PROVEEDORES
-- =========================================================

CREATE TABLE servicios (
  id VARCHAR(20) PRIMARY KEY,
  user_id VARCHAR(20) NOT NULL,
  nombre VARCHAR(150) NOT NULL,
  descripcion TEXT,
  precio_base DECIMAL(10,2) NOT NULL,
  categoria_id VARCHAR(20),
  disponible TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  status TINYINT(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE proveedores (
  id VARCHAR(20) PRIMARY KEY,
  user_id VARCHAR(20) NOT NULL,
  nombre VARCHAR(120) NOT NULL,
  rubro VARCHAR(100),
  contacto VARCHAR(100),
  telefono VARCHAR(20),
  email VARCHAR(150),
  calificacion_promedio DECIMAL(3,2) DEFAULT 0,
  estado VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  status TINYINT(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =========================================================
-- 4. EVENTOS (COTIZACIÓN)
-- =========================================================
CREATE TABLE cotizacion (
  id VARCHAR(20) PRIMARY KEY,
  cliente_id VARCHAR(20) NOT NULL,
  tipo_evento_id VARCHAR(20),
  nombre_evento VARCHAR(150),
  fecha_evento DATE NOT NULL,
  hora_evento TIME NOT NULL,
  numero_invitados INT NOT NULL,
  ubicacion VARCHAR(300),
  estado_actual_id VARCHAR(20) NOT NULL,
  observaciones TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  status TINYINT(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =========================================================
-- 5. DETALLE DEL EVENTO
-- =========================================================
CREATE TABLE cotizacion_detalle (
  id VARCHAR(20) PRIMARY KEY,
  evento_id VARCHAR(20) NOT NULL,
  servicio_id VARCHAR(20) NOT NULL,
  proveedor_id VARCHAR(20),
  precio_final DECIMAL(10,2) NOT NULL,
  cantidad INT DEFAULT 1,
  observaciones TEXT,
  estado VARCHAR(50) ,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  status TINYINT(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =========================================================
-- 6. VENTAS
-- =========================================================
CREATE TABLE ventas (
  id VARCHAR(20) PRIMARY KEY,
  evento_id VARCHAR(20) NOT NULL,
  subtotal DECIMAL(10,2) NOT NULL,
  impuestos DECIMAL(10,2) DEFAULT 0,
  total DECIMAL(10,2) NOT NULL,
  estado VARCHAR(50) ,
  fecha_generada TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  fecha_vencimiento DATE,
  status TINYINT(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =========================================================
-- 7. DISPONIBILIDAD PROVEEDOR
-- =========================================================
CREATE TABLE proveedor_disponibilidad (
  id VARCHAR(20) PRIMARY KEY,
  proveedor_id VARCHAR(20) NOT NULL,
  fecha DATE NOT NULL,
  disponible TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  status TINYINT(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =========================================================
-- 8. TABLAS DE CALIFICACIONES
-- =========================================================
CREATE TABLE calificacion_cliente (
  id VARCHAR(20) PRIMARY KEY,
  evento_id VARCHAR(20) NOT NULL,
  cliente_id VARCHAR(20) NOT NULL,
  evaluador_id VARCHAR(20) NOT NULL,
  calificacion INT NOT NULL,
  comentario TEXT,
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status TINYINT(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE calificacion_proveedor_evento (
  id VARCHAR(20) PRIMARY KEY,
  evento_id VARCHAR(20) NOT NULL,
  proveedor_id VARCHAR(20) NOT NULL,
  evaluador_id VARCHAR(20) NOT NULL,
  calificacion INT NOT NULL,
  comentario TEXT,
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status TINYINT(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE calificacion_servicio_cliente (
  id VARCHAR(20) PRIMARY KEY,
  evento_id VARCHAR(20) NOT NULL,
  detalle_id VARCHAR(20) NOT NULL,
  cliente_id VARCHAR(20) NOT NULL,
  servicio_id VARCHAR(20) NOT NULL,
  proveedor_id VARCHAR(20),
  calificacion INT NOT NULL,
  comentario TEXT,
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status TINYINT(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




USE db_eventos_peru;
select * from auth_users;

INSERT INTO auth_users (id, email, password_hash, nombre, direccion, celular, rol) 
VALUES 
('USER001', 'cliente@email.com', 'hash_password_123', 'Juan Pérez', 'Av. Lima 123', '987654321', 'CLIENTE'),
('USER002', 'proveedor@email.com', 'hash_password_456', 'María García', 'Av. Arequipa 456', '987654322', 'PROVEEDOR'),
('USER003', 'admin@email.com', 'hash_password_789', 'Carlos López', 'Av. Javier Prado 789', '987654323', 'ADMIN');

-- Tipos de evento
INSERT INTO tipos_evento (id, user_id, nombre, descripcion) 
VALUES 
('TIPO001', 'USER003', 'Boda', 'Eventos de matrimonio y boda'),
('TIPO002', 'USER003', 'Cumpleaños', 'Fiestas de cumpleaños'),
('TIPO003', 'USER003', 'Corporativo', 'Eventos empresariales');

-- Categorías de servicio
INSERT INTO categorias_servicio (id, user_id, nombre, descripcion) 
VALUES 
('CAT001', 'USER003', 'Catering', 'Servicios de comida y bebida'),
('CAT002', 'USER003', 'Decoración', 'Servicios de decoración de eventos'),
('CAT003', 'USER003', 'Entretenimiento', 'Música y animación');

-- Estados de evento
INSERT INTO estados_evento (id, user_id, nombre, descripcion) 
VALUES 
('EST001', 'USER003', 'COTIZACION', 'En proceso de cotización'),
('EST002', 'USER003', 'CONFIRMADO', 'Evento confirmado'),
('EST003', 'USER003', 'COMPLETADO', 'Evento finalizado');

-- Servicios
INSERT INTO servicios (id, user_id, nombre, descripcion, precio_base, categoria_id) 
VALUES 
('SERV001', 'USER002', 'Buffet Ejecutivo', 'Servicio de comida buffet para eventos', 50.00, 'CAT001'),
('SERV002', 'USER002', 'Decoración Clásica', 'Decoración elegante para eventos formales', 200.00, 'CAT002'),
('SERV003', 'USER002', 'DJ Profesional', 'Servicio de música y animación', 150.00, 'CAT003');

-- Proveedores
INSERT INTO proveedores (id, user_id, nombre, rubro, contacto, telefono, email) 
VALUES 
('PROV001', 'USER002', 'Catering Delicias', 'Catering', 'Ana Torres', '987654100', 'catering@email.com'),
('PROV002', 'USER002', 'Decoraciones Elegantes', 'Decoración', 'Luis Mendoza', '987654101', 'decoraciones@email.com'),
('PROV003', 'USER002', 'Sonido Perfecto', 'Entretenimiento', 'Roberto Díaz', '987654102', 'sonido@email.com');

INSERT INTO cotizacion (id, cliente_id, tipo_evento_id, nombre_evento, fecha_evento, hora_evento, numero_invitados, ubicacion, estado_actual_id) 
VALUES 
('EVT001', 'USER001', 'TIPO001', 'Boda Juan y María', '2024-12-15', '18:00:00', 100, 'Av. Lima 123, Miraflores', 'EST001'),
('EVT002', 'USER001', 'TIPO002', 'Cumpleaños Carlos', '2024-11-20', '16:00:00', 50, 'Jr. Union 456, Lima', 'EST002');

INSERT INTO ventas (id, evento_id, subtotal, impuestos, total, estado) 
VALUES 
('VENT001', 'EVT001', 435.00, 78.30, 513.30, 'PENDIENTE'),
('VENT002', 'EVT002', 250.00, 45.00, 295.00, 'PAGADO');

INSERT INTO proveedor_disponibilidad (id, proveedor_id, fecha, disponible) 
VALUES 
('DISP001', 'PROV001', '2024-12-15', 0), -- No disponible (ocupado)
('DISP002', 'PROV001', '2024-12-16', 1), -- Disponible
('DISP003', 'PROV002', '2024-12-15', 0); -- No disponible

-- Calificación de cliente
INSERT INTO calificacion_cliente (id, evento_id, cliente_id, evaluador_id, calificacion, comentario) 
VALUES 
('CAL_CLI001', 'EVT001', 'USER001', 'USER002', 5, 'Excelente cliente, muy puntual');

-- Calificación de proveedor
INSERT INTO calificacion_proveedor_evento (id, evento_id, proveedor_id, evaluador_id, calificacion, comentario) 
VALUES 
('CAL_PROV001', 'EVT001', 'PROV001', 'USER001', 4, 'Buen servicio de catering');

-- Calificación de servicio
INSERT INTO calificacion_servicio_cliente (id, evento_id, detalle_id, cliente_id, servicio_id, proveedor_id, calificacion, comentario) 
VALUES 
('CAL_SERV001', 'EVT001', 'DET001', 'USER001', 'SERV001', 'PROV001', 5, 'La comida estuvo excelente');


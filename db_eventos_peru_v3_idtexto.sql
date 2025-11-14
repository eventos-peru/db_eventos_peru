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
  orden INT DEFAULT 0,
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
  estado VARCHAR(50) DEFAULT 'DISPONIBLE',
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
  estado VARCHAR(50) DEFAULT 'PENDIENTE',
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
  estado VARCHAR(50) DEFAULT 'PENDIENTE',
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

-- =========================================================
-- 9. ÍNDICES
-- =========================================================

CREATE INDEX idx_evento_cliente ON cotizacion(cliente_id);
CREATE INDEX idx_evento_fecha ON cotizacion(fecha_evento);
CREATE INDEX idx_evento_estado ON cotizacion(estado_actual_id);

CREATE INDEX idx_detalle_evento ON cotizacion_detalle(evento_id);
CREATE INDEX idx_detalle_servicio ON cotizacion_detalle(servicio_id);

CREATE INDEX idx_proveedor_disponibilidad ON proveedor_disponibilidad(proveedor_id, fecha);

CREATE INDEX idx_categoria_user ON categorias_servicio(user_id);

CREATE INDEX idx_calif_cliente_evento ON calificacion_cliente(evento_id);
CREATE INDEX idx_calif_proveedor_evento ON calificacion_proveedor_evento(evento_id);
CREATE INDEX idx_calif_servicio_evento ON calificacion_servicio_cliente(evento_id);

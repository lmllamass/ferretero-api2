-- 1. Proveedor de Catálogo
CREATE TABLE proveedor (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  email_contacto VARCHAR(255),
  telefono VARCHAR(50)
);

-- 2. Catálogo
CREATE TABLE catalogo (
  id SERIAL PRIMARY KEY,
  proveedor_id INTEGER NOT NULL
    REFERENCES proveedor(id)
    ON DELETE CASCADE,
  nombre VARCHAR(255) NOT NULL,
  descripcion TEXT
);

-- 3. Categoría
CREATE TABLE categoria (
  id SERIAL PRIMARY KEY,
  catalogo_id INTEGER NOT NULL
    REFERENCES catalogo(id)
    ON DELETE CASCADE,
  padre_id INTEGER
    REFERENCES categoria(id)
    ON DELETE SET NULL,
  nombre VARCHAR(255) NOT NULL,
  nivel INTEGER NOT NULL DEFAULT 0
);

-- 4. Viñeta / Producto
CREATE TABLE vinyeta (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  imagen_url VARCHAR(2083),
  descripcion TEXT
);

-- 5. Asociación Viñeta–Categoría
CREATE TABLE vinyeta_categoria (
  vinyeta_id INTEGER NOT NULL
    REFERENCES vinyeta(id)
    ON DELETE CASCADE,
  categoria_id INTEGER NOT NULL
    REFERENCES categoria(id)
    ON DELETE CASCADE,
  PRIMARY KEY (vinyeta_id, categoria_id)
);

-- 6. Referencia
CREATE TABLE referencia (
  id SERIAL PRIMARY KEY,
  vinyeta_id INTEGER NOT NULL
    REFERENCES vinyeta(id)
    ON DELETE CASCADE,
  sku VARCHAR(100),
  precio NUMERIC(10,2) CHECK (precio >= 0)
);

-- 7. Atributo Diferenciador
CREATE TABLE atributo (
  id SERIAL PRIMARY KEY,
  referencia_id INTEGER NOT NULL
    REFERENCES referencia(id)
    ON DELETE CASCADE,
  nombre_atributo VARCHAR(100) NOT NULL,
  valor_atributo VARCHAR(255) NOT NULL
);

-- 8. Llamadas a la API
CREATE TABLE api_call (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  endpoint VARCHAR(255) NOT NULL,
  metodo_http VARCHAR(10) NOT NULL,
  descripcion TEXT
);

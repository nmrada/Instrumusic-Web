-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema instrumusic
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `instrumusic` ;

-- -----------------------------------------------------
-- Schema instrumusic
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `instrumusic` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
SHOW WARNINGS;
USE `instrumusic` ;

-- -----------------------------------------------------
-- Table `instrumusic`.`Tipo_Documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instrumusic`.`Tipo_Documento` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `instrumusic`.`Tipo_Documento` (
  `tipoDocumento` VARCHAR(40) NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  `activo` TINYINT(1) NOT NULL,
  PRIMARY KEY (`tipoDocumento`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `instrumusic`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instrumusic`.`Usuario` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `instrumusic`.`Usuario` (
  `idUsuario` VARCHAR(20) NOT NULL COMMENT 'Llave primaria del usuario',
  `contrasena` VARCHAR(45) NOT NULL COMMENT 'Contraseña del usuario',
  `rol` VARCHAR(45) NOT NULL COMMENT 'Rol del Usuario',
  `estado` VARCHAR(20) NOT NULL COMMENT 'Estado del usuario',
  `email` VARCHAR(45) NOT NULL COMMENT 'Correo Electronico del Usuario',
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `instrumusic`.`Cuenta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instrumusic`.`Cuenta` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `instrumusic`.`Cuenta` (
  `Tipo_Documento_tipoDocumento` VARCHAR(40) NOT NULL,
  `numeroDocumento` VARCHAR(45) NOT NULL COMMENT 'Llave priamria número documento cuenta',
  `primerNombre` VARCHAR(100) NOT NULL COMMENT 'Primer nombre de la persona',
  `segundoNombre` VARCHAR(45) NULL COMMENT 'Segundo nombre de la persona',
  `primerApellido` VARCHAR(100) NOT NULL COMMENT 'Primer apellido de la persona',
  `segundoApellido` VARCHAR(45) NULL COMMENT 'Segundo apellido de la persona',
  `Usuario_idUsuario` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Tipo_Documento_tipoDocumento`, `numeroDocumento`),
  CONSTRAINT `fk_Cuenta_Tipo_Documento1`
    FOREIGN KEY (`Tipo_Documento_tipoDocumento`)
    REFERENCES `instrumusic`.`Tipo_Documento` (`tipoDocumento`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Cuenta_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `instrumusic`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `instrumusic`.`Factura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instrumusic`.`Factura` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `instrumusic`.`Factura` (
  `idFactura` INT NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria de la factura',
  `fecha` DATE NOT NULL COMMENT 'Fecha y Hora de la factura',
  `total` FLOAT NOT NULL COMMENT 'Total de la factura',
  `estado` VARCHAR(45) NOT NULL,
  `Cuenta_Tipo_Documento_tipoDocumento` VARCHAR(40) NOT NULL,
  `Cuenta_numeroDocumento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFactura`),
  CONSTRAINT `fk_Factura_Cuenta1`
    FOREIGN KEY (`Cuenta_Tipo_Documento_tipoDocumento` , `Cuenta_numeroDocumento`)
    REFERENCES `instrumusic`.`Cuenta` (`Tipo_Documento_tipoDocumento` , `numeroDocumento`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `instrumusic`.`Pago`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instrumusic`.`Pago` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `instrumusic`.`Pago` (
  `Factura_idFactura` INT NOT NULL COMMENT 'Llave foranea primaria de ID Factura',
  `numTarCredito` VARCHAR(45) NOT NULL COMMENT 'Número Tarjeta del pago',
  `banco` VARCHAR(100) NOT NULL COMMENT 'Banco Tarjeta',
  `tipoCuentaTar` VARCHAR(20) NOT NULL COMMENT 'Tipo de Cuenta Tarjeta',
  `tipoTransaccion` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Factura_idFactura`),
  CONSTRAINT `fk_Pago_Factura1`
    FOREIGN KEY (`Factura_idFactura`)
    REFERENCES `instrumusic`.`Factura` (`idFactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `instrumusic`.`Pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instrumusic`.`Pedido` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `instrumusic`.`Pedido` (
  `Factura_idFactura` INT NOT NULL COMMENT 'Llave foránea primaria ID factura',
  `total` FLOAT NOT NULL COMMENT 'Precio Total del pedido',
  `subtotal` FLOAT NOT NULL COMMENT 'Subtotal del pedido',
  `impuestos` FLOAT NOT NULL COMMENT 'Impuestos del pedido',
  PRIMARY KEY (`Factura_idFactura`),
  CONSTRAINT `fk_Pedido_Factura1`
    FOREIGN KEY (`Factura_idFactura`)
    REFERENCES `instrumusic`.`Factura` (`idFactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `instrumusic`.`Categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instrumusic`.`Categoria` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `instrumusic`.`Categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria de categoria',
  `nombreCategoria` VARCHAR(100) NOT NULL COMMENT 'Nombre de la categoria',
  `activa` TINYINT(1) NOT NULL,
  `Categoria_idCategoria` INT NOT NULL,
  PRIMARY KEY (`idCategoria`),
  CONSTRAINT `fk_Categoria_Categoria1`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `instrumusic`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `instrumusic`.`Producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instrumusic`.`Producto` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `instrumusic`.`Producto` (
  `idProducto` VARCHAR(100) NOT NULL COMMENT 'Llave primaria producto',
  `nombre` VARCHAR(300) NOT NULL COMMENT 'Nombre del producto',
  `marca` VARCHAR(45) NOT NULL COMMENT 'Marca del producto',
  `referencia` VARCHAR(45) NOT NULL COMMENT 'Referencia del producto ',
  `descripcion` VARCHAR(500) NOT NULL COMMENT 'Descripcion del producto',
  `material` VARCHAR(45) NOT NULL COMMENT 'Material del producto',
  `color` VARCHAR(45) NOT NULL COMMENT 'Color del producto',
  `foto` LONGBLOB NULL COMMENT 'Foto del producto',
  `cantidad` INT NOT NULL COMMENT 'Unidades existentes del producto',
  `activo` TINYINT(1) NOT NULL COMMENT 'Estado del producto',
  `precioUnitario` FLOAT NOT NULL COMMENT 'Precio Unitario del producto',
  `descuento` FLOAT NOT NULL COMMENT 'Descuento del producto',
  `Categoria_idCategoria` INT NOT NULL,
  PRIMARY KEY (`idProducto`),
  CONSTRAINT `fk_Producto_Categoria1`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `instrumusic`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `instrumusic`.`Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instrumusic`.`Item` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `instrumusic`.`Item` (
  `Producto_idProducto` VARCHAR(100) NOT NULL COMMENT 'Llave foránea ID producto\n',
  `Pedido_Factura_idFactura` INT NOT NULL COMMENT 'Llave foránea Pedido',
  `cantidad` INT NOT NULL COMMENT 'Cantidad del producto',
  `costoUnitario` FLOAT NOT NULL COMMENT 'Costo Unitario del producto',
  `costoTotal` FLOAT NOT NULL COMMENT 'Costo Total del Item',
  PRIMARY KEY (`Producto_idProducto`, `Pedido_Factura_idFactura`),
  CONSTRAINT `fk_Item_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `instrumusic`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Item_Pedido1`
    FOREIGN KEY (`Pedido_Factura_idFactura`)
    REFERENCES `instrumusic`.`Pedido` (`Factura_idFactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `instrumusic`.`Proveedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instrumusic`.`Proveedor` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `instrumusic`.`Proveedor` (
  `Tipo_Documento_tipoDocumento` VARCHAR(40) NOT NULL,
  `numeroDocumento` VARCHAR(45) NOT NULL COMMENT 'Llave primaria compuesta de proveedor ',
  `nombre` VARCHAR(200) NOT NULL COMMENT 'Nombre del proveedor',
  `email` VARCHAR(45) NOT NULL COMMENT 'Correo electrónico del proveedor',
  PRIMARY KEY (`Tipo_Documento_tipoDocumento`, `numeroDocumento`),
  CONSTRAINT `fk_Proveedor_Tipo_Documento1`
    FOREIGN KEY (`Tipo_Documento_tipoDocumento`)
    REFERENCES `instrumusic`.`Tipo_Documento` (`tipoDocumento`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `instrumusic`.`Carrito_De_Compras`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instrumusic`.`Carrito_De_Compras` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `instrumusic`.`Carrito_De_Compras` (
  `idCarritoDeCompras` VARCHAR(255) NOT NULL COMMENT 'Llave primaria de carrito de compras ',
  `subtotal` FLOAT NOT NULL COMMENT 'Subtotasl del carrito',
  `precioTotal` FLOAT NOT NULL COMMENT 'Precio total del carrito',
  `impuestos` FLOAT NOT NULL COMMENT 'Impuestos carritos',
  PRIMARY KEY (`idCarritoDeCompras`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `instrumusic`.`Inventario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instrumusic`.`Inventario` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `instrumusic`.`Inventario` (
  `idInventario` INT NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria inventario',
  `fecha` DATE NOT NULL COMMENT 'Fecha de la compra',
  `cantidad` INT NOT NULL COMMENT 'Cantidad comprada',
  `Producto_idProducto` VARCHAR(100) NOT NULL COMMENT 'Llave foranea ID Producto',
  `Proveedor_Tipo_Documento_tipoDocumento` VARCHAR(40) NOT NULL,
  `Proveedor_numeroDocumento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idInventario`, `Producto_idProducto`, `Proveedor_Tipo_Documento_tipoDocumento`, `Proveedor_numeroDocumento`),
  CONSTRAINT `fk_Inventario_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `instrumusic`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Inventario_Proveedor1`
    FOREIGN KEY (`Proveedor_Tipo_Documento_tipoDocumento` , `Proveedor_numeroDocumento`)
    REFERENCES `instrumusic`.`Proveedor` (`Tipo_Documento_tipoDocumento` , `numeroDocumento`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `instrumusic`.`Departamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instrumusic`.`Departamento` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `instrumusic`.`Departamento` (
  `idDepartamento` INT NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria del departamento',
  `nombre` VARCHAR(45) NOT NULL COMMENT 'Nombre del departamento',
  PRIMARY KEY (`idDepartamento`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `instrumusic`.`Municipio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instrumusic`.`Municipio` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `instrumusic`.`Municipio` (
  `idMunicipio` INT NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria municipio',
  `nombre` VARCHAR(45) NOT NULL COMMENT 'Nombre del municipio',
  `Departamento_idDepartamento` INT NOT NULL,
  PRIMARY KEY (`idMunicipio`),
  CONSTRAINT `fk_Municipio_Departamento1`
    FOREIGN KEY (`Departamento_idDepartamento`)
    REFERENCES `instrumusic`.`Departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `instrumusic`.`Domicilio_Cuenta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instrumusic`.`Domicilio_Cuenta` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `instrumusic`.`Domicilio_Cuenta` (
  `Cuenta_Tipo_Documento_tipoDocumento` VARCHAR(40) NOT NULL,
  `Cuenta_numeroDocumento` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL COMMENT 'Teléfono del domicilio',
  `direccion` VARCHAR(200) NOT NULL COMMENT 'Dirección del domicilio',
  `barrio` VARCHAR(100) NOT NULL COMMENT 'Barrio del Domicilio',
  `localidad` VARCHAR(100) NULL COMMENT 'Localidad del domicilio',
  `Municipio_idMunicipio` INT NOT NULL,
  PRIMARY KEY (`Cuenta_Tipo_Documento_tipoDocumento`, `Cuenta_numeroDocumento`),
  CONSTRAINT `fk_Domicilio_Cuenta_Cuenta1`
    FOREIGN KEY (`Cuenta_Tipo_Documento_tipoDocumento` , `Cuenta_numeroDocumento`)
    REFERENCES `instrumusic`.`Cuenta` (`Tipo_Documento_tipoDocumento` , `numeroDocumento`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Domicilio_Cuenta_Municipio1`
    FOREIGN KEY (`Municipio_idMunicipio`)
    REFERENCES `instrumusic`.`Municipio` (`idMunicipio`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `instrumusic`.`Item_Carrito`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instrumusic`.`Item_Carrito` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `instrumusic`.`Item_Carrito` (
  `Producto_idProducto` VARCHAR(100) NOT NULL COMMENT 'Llave foránea ID producto',
  `Carrito_De_Compras_idCarritoDeCompras` VARCHAR(255) NOT NULL,
  `cantidad` INT NOT NULL COMMENT 'Cantidad del producto',
  `costoUnitario` FLOAT NOT NULL COMMENT 'Costo Unitario del producto',
  `costoTotal` FLOAT NOT NULL COMMENT 'Costo Total del Item',
  PRIMARY KEY (`Producto_idProducto`, `Carrito_De_Compras_idCarritoDeCompras`),
  CONSTRAINT `fk_Producto_has_CarritoDeCompras_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `instrumusic`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Item_Carrito_Carrito_De_Compras1`
    FOREIGN KEY (`Carrito_De_Compras_idCarritoDeCompras`)
    REFERENCES `instrumusic`.`Carrito_De_Compras` (`idCarritoDeCompras`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `instrumusic`.`Domicilio_Proveedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instrumusic`.`Domicilio_Proveedor` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `instrumusic`.`Domicilio_Proveedor` (
  `Proveedor_Tipo_Documento_tipoDocumento` VARCHAR(40) NOT NULL,
  `Proveedor_numeroDocumento` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL COMMENT 'Teléfono del domicilio',
  `direccion` VARCHAR(200) NOT NULL COMMENT 'Dirección del domicilio',
  `barrio` VARCHAR(100) NOT NULL COMMENT 'Barrio del Domicilio',
  `localidad` VARCHAR(100) NULL COMMENT 'Localidad del domicilio',
  `Municipio_idMunicipio` INT NOT NULL,
  PRIMARY KEY (`Proveedor_Tipo_Documento_tipoDocumento`, `Proveedor_numeroDocumento`),
  CONSTRAINT `fk_Domicilio_Proveedor_Proveedor1`
    FOREIGN KEY (`Proveedor_Tipo_Documento_tipoDocumento` , `Proveedor_numeroDocumento`)
    REFERENCES `instrumusic`.`Proveedor` (`Tipo_Documento_tipoDocumento` , `numeroDocumento`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Domicilio_Proveedor_Municipio1`
    FOREIGN KEY (`Municipio_idMunicipio`)
    REFERENCES `instrumusic`.`Municipio` (`idMunicipio`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `instrumusic`.`Logs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instrumusic`.`Logs` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `instrumusic`.`Logs` (
  `nivel` VARCHAR(10) NOT NULL,
  `fecha` DATETIME NOT NULL,
  `clase` VARCHAR(500) NOT NULL,
  `mensaje` VARCHAR(1000) NOT NULL)
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `instrumusic`.`Categoria`
-- -----------------------------------------------------
START TRANSACTION;
USE `instrumusic`;
INSERT INTO `instrumusic`.`Categoria` (`idCategoria`, `nombreCategoria`, `activa`, `Categoria_idCategoria`) VALUES (DEFAULT, 'Categorias', 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `instrumusic`.`Departamento`
-- -----------------------------------------------------
START TRANSACTION;
USE `instrumusic`;
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (1, 'AMAZONAS');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (10, 'CAUCA');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (11, 'CESAR');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (12, 'CHOCÓ');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (13, 'CÓRDOBA');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (14, 'CUNDINAMARCA');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (15, 'GUAINÍA');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (16, 'GUAVIARE');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (17, 'HUILA');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (18, 'LA GUAJIRA');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (19, 'MAGDALENA');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (2, 'ANTIOQUIA');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (20, 'META');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (21, 'NARIÑO');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (22, 'NORTE DE SANTANDER');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (23, 'PUTUMAYO');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (24, 'QUINDÍO');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (25, 'RISARALDA');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (26, 'SAN ANDRÉS Y ROVIDENCIA');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (27, 'SANTANDER');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (28, 'SUCRE');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (29, 'TOLIMA');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (3, 'ARAUCA');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (30, 'VALLE DEL CAUCA');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (31, 'VAUPÉS');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (32, 'VICHADA');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (4, 'ATLÁNTICO');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (5, 'BOLÍVAR');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (6, 'BOYACÁ');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (7, 'CALDAS');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (8, 'CAQUETÁ');
INSERT INTO `instrumusic`.`Departamento` (`idDepartamento`, `nombre`) VALUES (9, 'CASANARE');

COMMIT;


-- -----------------------------------------------------
-- Data for table `instrumusic`.`Municipio`
-- -----------------------------------------------------
START TRANSACTION;
USE `instrumusic`;
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1, 'EL ENCANTO', 1);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (2, 'LA CHORRERA', 1);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (3, 'LA PEDRERA', 1);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (4, 'LA VICTORIA', 1);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (5, 'LETICIA', 1);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (6, 'MIRITI', 1);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (7, 'PUERTO ALEGRIA', 1);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (8, 'PUERTO ARICA', 1);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (9, 'PUERTO NARIÑO', 1);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (10, 'PUERTO SANTANDER', 1);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (11, 'TURAPACA', 1);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (12, 'ABEJORRAL', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (13, 'ABRIAQUI', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (14, 'ALEJANDRIA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (15, 'AMAGA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (16, 'AMALFI', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (17, 'ANDES', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (18, 'ANGELOPOLIS', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (19, 'ANGOSTURA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (20, 'ANORI', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (21, 'ANTIOQUIA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (22, 'ANZA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (23, 'APARTADO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (24, 'ARBOLETES', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (25, 'ARGELIA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (26, 'ARMENIA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (27, 'BARBOSA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (28, 'BELLO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (29, 'BELMIRA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (30, 'BETANIA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (31, 'BETULIA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (32, 'BOLIVAR', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (33, 'BRICEÑO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (34, 'BURITICA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (35, 'CACERES', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (36, 'CAICEDO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (37, 'CALDAS', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (38, 'CAMPAMENTO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (39, 'CANASGORDAS', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (40, 'CARACOLI', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (41, 'CARAMANTA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (42, 'CAREPA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (43, 'CARMEN DE VIBORAL', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (44, 'CAROLINA DEL PRINCIPE', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (45, 'CAUCASIA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (46, 'CHIGORODO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (47, 'CISNEROS', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (48, 'COCORNA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (49, 'CONCEPCION', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (50, 'CONCORDIA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (51, 'COPACABANA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (52, 'DABEIBA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (53, 'DONMATIAS', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (54, 'EBEJICO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (55, 'EL BAGRE', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (56, 'EL PENOL', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (57, 'EL RETIRO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (58, 'ENTRERRIOS', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (59, 'ENVIGADO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (60, 'FREDONIA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (61, 'FRONTINO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (62, 'GIRALDO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (63, 'GIRARDOTA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (64, 'GOMEZ PLATA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (65, 'GRANADA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (66, 'GUADALUPE', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (67, 'GUARNE', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (68, 'GUATAQUE', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (69, 'HELICONIA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (70, 'HISPANIA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (71, 'ITAGUI', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (72, 'ITUANGO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (73, 'JARDIN', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (74, 'JERICO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (75, 'LA CEJA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (76, 'LA ESTRELLA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (77, 'LA PINTADA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (78, 'LA UNION', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (79, 'LIBORINA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (80, 'MACEO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (81, 'MARINILLA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (82, 'MEDELLIN', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (83, 'MONTEBELLO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (84, 'MURINDO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (85, 'MUTATA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (86, 'NARINO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (87, 'NECHI', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (88, 'NECOCLI', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (89, 'OLAYA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (90, 'PEQUE', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (91, 'PUEBLORRICO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (92, 'PUERTO BERRIO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (93, 'PUERTO NARE', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (94, 'PUERTO TRIUNFO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (95, 'REMEDIOS', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (96, 'RIONEGRO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (97, 'SABANALARGA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (98, 'SABANETA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (99, 'SALGAR', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (100, 'SAN ANDRES DE CUERQUIA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (101, 'SAN CARLOS', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (102, 'SAN FRANCISCO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (103, 'SAN JERONIMO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (104, 'SAN JOSE DE LA MONTAÑA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (105, 'SAN JUAN DE URABA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (106, 'SAN LUIS', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (107, 'SAN PEDRO DE LOS MILAGROS', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (108, 'SAN PEDRO DE URABA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (109, 'SAN RAFAEL', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (110, 'SAN ROQUE', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (111, 'SAN VICENTE', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (112, 'SANTA BARBARA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (113, 'SANTA ROSA DE OSOS', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (114, 'SANTO DOMINGO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (115, 'SANTUARIO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (116, 'SEGOVIA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (117, 'SONSON', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (118, 'SOPETRAN', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (119, 'TAMESIS', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (120, 'TARAZA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (121, 'TARSO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (122, 'TITIRIBI', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (123, 'TOLEDO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (124, 'TURBO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (125, 'URAMITA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (126, 'URRAO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (127, 'VALDIVIA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (128, 'VALPARAISO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (129, 'VEGACHI', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (130, 'VENECIA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (131, 'VIGIA DEL FUERTE', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (132, 'YALI', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (133, 'YARUMAL', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (134, 'YOLOMBO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (135, 'YONDO', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (136, 'ZARAGOZA', 2);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (137, 'ARAUCA', 3);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (138, 'ARAUQUITA', 3);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (139, 'CRAVO NORTE', 3);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (140, 'FORTUL', 3);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (141, 'PUERTO RONDON', 3);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (142, 'SARAVENA', 3);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (143, 'TAME', 3);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (144, 'BARANOA', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (145, 'BARRANQUILLA', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (146, 'CAMPO DE LA CRUZ', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (147, 'CANDELARIA', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (148, 'GALAPA', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (149, 'JUAN DE ACOSTA', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (150, 'LURUACO', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (151, 'MALAMBO', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (152, 'MANATI', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (153, 'PALMAR DE VARELA', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (154, 'PIOJO', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (155, 'POLO NUEVO', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (156, 'PONEDERA', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (157, 'PUERTO COLOMBIA', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (158, 'REPELON', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (159, 'SABANAGRANDE', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (160, 'SABANALARGA', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (161, 'SANTA LUCIA', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (162, 'SANTO TOMAS', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (163, 'SOLEDAD', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (164, 'SUAN', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (165, 'TUBARA', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (166, 'USIACURI', 4);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (167, 'ACHI', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (168, 'ALTOS DEL ROSARIO', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (169, 'ARENAL', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (170, 'ARJONA', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (171, 'ARROYOHONDO', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (172, 'BARRANCO DE LOBA', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (173, 'BRAZUELO DE PAPAYAL', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (174, 'CALAMAR', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (175, 'CANTAGALLO', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (176, 'CARTAGENA DE INDIAS', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (177, 'CICUCO', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (178, 'CLEMENCIA', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (179, 'CORDOBA', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (180, 'EL CARMEN DE BOLIVAR', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (181, 'EL GUAMO', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (182, 'EL PENION', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (183, 'HATILLO DE LOBA', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (184, 'MAGANGUE', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (185, 'MAHATES', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (186, 'MARGARITA', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (187, 'MARIA LA BAJA', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (188, 'MONTECRISTO', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (189, 'MORALES', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (190, 'MORALES', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (191, 'NOROSI', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (192, 'PINILLOS', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (193, 'REGIDOR', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (194, 'RIO VIEJO', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (195, 'SAN CRISTOBAL', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (196, 'SAN ESTANISLAO', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (197, 'SAN FERNANDO', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (198, 'SAN JACINTO', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (199, 'SAN JACINTO DEL CAUCA', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (200, 'SAN JUAN DE NEPOMUCENO', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (201, 'SAN MARTIN DE LOBA', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (202, 'SAN PABLO', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (203, 'SAN PABLO NORTE', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (204, 'SANTA CATALINA', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (205, 'SANTA CRUZ DE MOMPOX', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (206, 'SANTA ROSA', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (207, 'SANTA ROSA DEL SUR', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (208, 'SIMITI', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (209, 'SOPLAVIENTO', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (210, 'TALAIGUA NUEVO', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (211, 'TUQUISIO', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (212, 'TURBACO', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (213, 'TURBANA', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (214, 'VILLANUEVA', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (215, 'ZAMBRANO', 5);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (216, 'AQUITANIA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (217, 'ARCABUCO', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (218, 'BELÉN', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (219, 'BERBEO', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (220, 'BETÉITIVA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (221, 'BOAVITA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (222, 'BOYACÁ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (223, 'BRICEÑO', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (224, 'BUENAVISTA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (225, 'BUSBANZÁ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (226, 'CALDAS', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (227, 'CAMPO HERMOSO', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (228, 'CERINZA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (229, 'CHINAVITA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (230, 'CHIQUINQUIRÁ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (231, 'CHÍQUIZA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (232, 'CHISCAS', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (233, 'CHITA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (234, 'CHITARAQUE', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (235, 'CHIVATÁ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (236, 'CIÉNEGA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (237, 'CÓMBITA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (238, 'COPER', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (239, 'CORRALES', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (240, 'COVARACHÍA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (241, 'CUBARA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (242, 'CUCAITA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (243, 'CUITIVA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (244, 'DUITAMA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (245, 'EL COCUY', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (246, 'EL ESPINO', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (247, 'FIRAVITOBA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (248, 'FLORESTA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (249, 'GACHANTIVÁ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (250, 'GÁMEZA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (251, 'GARAGOA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (252, 'GUACAMAYAS', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (253, 'GÜICÁN', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (254, 'IZA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (255, 'JENESANO', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (256, 'JERICÓ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (257, 'LA UVITA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (258, 'LA VICTORIA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (259, 'LABRANZA GRANDE', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (260, 'MACANAL', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (261, 'MARIPÍ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (262, 'MIRAFLORES', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (263, 'MONGUA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (264, 'MONGUÍ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (265, 'MONIQUIRÁ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (266, 'MOTAVITA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (267, 'MUZO', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (268, 'NOBSA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (269, 'NUEVO COLÓN', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (270, 'OICATÁ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (271, 'OTANCHE', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (272, 'PACHAVITA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (273, 'PÁEZ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (274, 'PAIPA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (275, 'PAJARITO', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (276, 'PANQUEBA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (277, 'PAUNA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (278, 'PAYA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (279, 'PAZ DE RÍO', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (280, 'PESCA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (281, 'PISBA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (282, 'PUERTO BOYACA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (283, 'QUÍPAMA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (284, 'RAMIRIQUÍ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (285, 'RÁQUIRA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (286, 'RONDÓN', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (287, 'SABOYÁ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (288, 'SÁCHICA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (289, 'SAMACÁ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (290, 'SAN EDUARDO', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (291, 'SAN JOSÉ DE PARE', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (292, 'SAN LUÍS DE GACENO', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (293, 'SAN MATEO', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (294, 'SAN MIGUEL DE SEMA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (295, 'SAN PABLO DE BORBUR', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (296, 'SANTA MARÍA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (297, 'SANTA ROSA DE VITERBO', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (298, 'SANTA SOFÍA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (299, 'SANTANA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (300, 'SATIVANORTE', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (301, 'SATIVASUR', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (302, 'SIACHOQUE', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (303, 'SOATÁ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (304, 'SOCHA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (305, 'SOCOTÁ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (306, 'SOGAMOSO', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (307, 'SORA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (308, 'SORACÁ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (309, 'SOTAQUIRÁ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (310, 'SUSACÓN', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (311, 'SUTARMACHÁN', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (312, 'TASCO', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (313, 'TIBANÁ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (314, 'TIBASOSA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (315, 'TINJACÁ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (316, 'TIPACOQUE', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (317, 'TOCA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (318, 'TOGÜÍ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (319, 'TÓPAGA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (320, 'TOTA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (321, 'TUNJA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (322, 'TUNUNGUÁ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (323, 'TURMEQUÉ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (324, 'TUTA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (325, 'TUTAZÁ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (326, 'UMBITA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (327, 'VENTA QUEMADA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (328, 'VILLA DE LEYVA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (329, 'VIRACACHÁ', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (330, 'ZETAQUIRA', 6);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (331, 'AGUADAS', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (332, 'ANSERMA', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (333, 'ARANZAZU', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (334, 'BELALCAZAR', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (335, 'CHINCHINÁ', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (336, 'FILADELFIA', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (337, 'LA DORADA', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (338, 'LA MERCED', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (339, 'MANIZALES', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (340, 'MANZANARES', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (341, 'MARMATO', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (342, 'MARQUETALIA', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (343, 'MARULANDA', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (344, 'NEIRA', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (345, 'NORCASIA', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (346, 'PACORA', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (347, 'PALESTINA', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (348, 'PENSILVANIA', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (349, 'RIOSUCIO', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (350, 'RISARALDA', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (351, 'SALAMINA', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (352, 'SAMANA', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (353, 'SAN JOSE', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (354, 'SUPÍA', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (355, 'VICTORIA', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (356, 'VILLAMARÍA', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (357, 'VITERBO', 7);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (358, 'ALBANIA', 8);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (359, 'BELÉN ANDAQUIES', 8);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (360, 'CARTAGENA DEL CHAIRA', 8);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (361, 'CURILLO', 8);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (362, 'EL DONCELLO', 8);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (363, 'EL PAUJIL', 8);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (364, 'FLORENCIA', 8);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (365, 'LA MONTAÑITA', 8);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (366, 'MILÁN', 8);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (367, 'MORELIA', 8);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (368, 'PUERTO RICO', 8);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (369, 'SAN  VICENTE DEL CAGUAN', 8);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (370, 'SAN JOSÉ DE FRAGUA', 8);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (371, 'SOLANO', 8);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (372, 'SOLITA', 8);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (373, 'VALPARAÍSO', 8);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (374, 'AGUAZUL', 9);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (375, 'CHAMEZA', 9);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (376, 'HATO COROZAL', 9);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (377, 'LA SALINA', 9);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (378, 'MANÍ', 9);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (379, 'MONTERREY', 9);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (380, 'NUNCHIA', 9);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (381, 'OROCUE', 9);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (382, 'PAZ DE ARIPORO', 9);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (383, 'PORE', 9);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (384, 'RECETOR', 9);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (385, 'SABANA LARGA', 9);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (386, 'SACAMA', 9);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (387, 'SAN LUIS DE PALENQUE', 9);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (388, 'TAMARA', 9);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (389, 'TAURAMENA', 9);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (390, 'TRINIDAD', 9);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (391, 'VILLANUEVA', 9);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (392, 'YOPAL', 9);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (393, 'ALMAGUER', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (394, 'ARGELIA', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (395, 'BALBOA', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (396, 'BOLÍVAR', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (397, 'BUENOS AIRES', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (398, 'CAJIBIO', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (399, 'CALDONO', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (400, 'CALOTO', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (401, 'CORINTO', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (402, 'EL TAMBO', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (403, 'FLORENCIA', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (404, 'GUAPI', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (405, 'INZA', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (406, 'JAMBALÓ', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (407, 'LA SIERRA', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (408, 'LA VEGA', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (409, 'LÓPEZ', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (410, 'MERCADERES', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (411, 'MIRANDA', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (412, 'MORALES', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (413, 'PADILLA', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (414, 'PÁEZ', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (415, 'PATIA (EL BORDO)', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (416, 'PIAMONTE', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (417, 'PIENDAMO', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (418, 'POPAYÁN', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (419, 'PUERTO TEJADA', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (420, 'PURACE', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (421, 'ROSAS', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (422, 'SAN SEBASTIÁN', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (423, 'SANTA ROSA', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (424, 'SANTANDER DE QUILICHAO', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (425, 'SILVIA', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (426, 'SOTARA', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (427, 'SUÁREZ', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (428, 'SUCRE', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (429, 'TIMBÍO', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (430, 'TIMBIQUÍ', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (431, 'TORIBIO', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (432, 'TOTORO', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (433, 'VILLA RICA', 10);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (434, 'AGUACHICA', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (435, 'AGUSTÍN CODAZZI', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (436, 'ASTREA', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (437, 'BECERRIL', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (438, 'BOSCONIA', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (439, 'CHIMICHAGUA', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (440, 'CHIRIGUANÁ', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (441, 'CURUMANÍ', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (442, 'EL COPEY', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (443, 'EL PASO', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (444, 'GAMARRA', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (445, 'GONZÁLEZ', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (446, 'LA GLORIA', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (447, 'LA JAGUA IBIRICO', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (448, 'MANAURE BALCÓN DEL CESAR', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (449, 'PAILITAS', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (450, 'PELAYA', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (451, 'PUEBLO BELLO', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (452, 'RÍO DE ORO', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (453, 'ROBLES (LA PAZ)', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (454, 'SAN ALBERTO', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (455, 'SAN DIEGO', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (456, 'SAN MARTÍN', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (457, 'TAMALAMEQUE', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (458, 'VALLEDUPAR', 11);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (459, 'ACANDI', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (460, 'ALTO BAUDO (PIE DE PATO)', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (461, 'ATRATO', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (462, 'BAGADO', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (463, 'BAHIA SOLANO (MUTIS)', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (464, 'BAJO BAUDO (PIZARRO)', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (465, 'BOJAYA (BELLAVISTA)', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (466, 'CANTON DE SAN PABLO', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (467, 'CARMEN DEL DARIEN', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (468, 'CERTEGUI', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (469, 'CONDOTO', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (470, 'EL CARMEN', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (471, 'ISTMINA', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (472, 'JURADO', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (473, 'LITORAL DEL SAN JUAN', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (474, 'LLORO', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (475, 'MEDIO ATRATO', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (476, 'MEDIO BAUDO (BOCA DE PEPE)', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (477, 'MEDIO SAN JUAN', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (478, 'NOVITA', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (479, 'NUQUI', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (480, 'QUIBDO', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (481, 'RIO IRO', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (482, 'RIO QUITO', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (483, 'RIOSUCIO', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (484, 'SAN JOSE DEL PALMAR', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (485, 'SIPI', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (486, 'TADO', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (487, 'UNGUIA', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (488, 'UNIÓN PANAMERICANA', 12);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (489, 'AYAPEL', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (490, 'BUENAVISTA', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (491, 'CANALETE', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (492, 'CERETÉ', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (493, 'CHIMA', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (494, 'CHINÚ', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (495, 'CIENAGA DE ORO', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (496, 'COTORRA', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (497, 'LA APARTADA', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (498, 'LORICA', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (499, 'LOS CÓRDOBAS', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (500, 'MOMIL', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (501, 'MONTELÍBANO', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (502, 'MONTERÍA', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (503, 'MOÑITOS', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (504, 'PLANETA RICA', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (505, 'PUEBLO NUEVO', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (506, 'PUERTO ESCONDIDO', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (507, 'PUERTO LIBERTADOR', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (508, 'PURÍSIMA', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (509, 'SAHAGÚN', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (510, 'SAN ANDRÉS SOTAVENTO', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (511, 'SAN ANTERO', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (512, 'SAN BERNARDO VIENTO', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (513, 'SAN CARLOS', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (514, 'SAN PELAYO', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (515, 'TIERRALTA', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (516, 'VALENCIA', 13);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (517, 'AGUA DE DIOS', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (518, 'ALBAN', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (519, 'ANAPOIMA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (520, 'ANOLAIMA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (521, 'ARBELAEZ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (522, 'BELTRÁN', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (523, 'BITUIMA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (524, 'BOGOTÁ DC', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (525, 'BOJACÁ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (526, 'CABRERA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (527, 'CACHIPAY', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (528, 'CAJICÁ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (529, 'CAPARRAPÍ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (530, 'CAQUEZA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (531, 'CARMEN DE CARUPA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (532, 'CHAGUANÍ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (533, 'CHIA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (534, 'CHIPAQUE', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (535, 'CHOACHÍ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (536, 'CHOCONTÁ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (537, 'COGUA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (538, 'COTA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (539, 'CUCUNUBÁ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (540, 'EL COLEGIO', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (541, 'EL PEÑÓN', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (542, 'EL ROSAL1', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (543, 'FACATATIVA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (544, 'FÓMEQUE', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (545, 'FOSCA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (546, 'FUNZA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (547, 'FÚQUENE', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (548, 'FUSAGASUGA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (549, 'GACHALÁ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (550, 'GACHANCIPÁ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (551, 'GACHETA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (552, 'GAMA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (553, 'GIRARDOT', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (554, 'GRANADA2', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (555, 'GUACHETÁ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (556, 'GUADUAS', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (557, 'GUASCA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (558, 'GUATAQUÍ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (559, 'GUATAVITA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (560, 'GUAYABAL DE SIQUIMA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (561, 'GUAYABETAL', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (562, 'GUTIÉRREZ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (563, 'JERUSALÉN', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (564, 'JUNÍN', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (565, 'LA CALERA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (566, 'LA MESA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (567, 'LA PALMA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (568, 'LA PEÑA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (569, 'LA VEGA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (570, 'LENGUAZAQUE', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (571, 'MACHETÁ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (572, 'MADRID', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (573, 'MANTA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (574, 'MEDINA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (575, 'MOSQUERA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (576, 'NARIÑO', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (577, 'NEMOCÓN', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (578, 'NILO', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (579, 'NIMAIMA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (580, 'NOCAIMA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (581, 'OSPINA PÉREZ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (582, 'PACHO', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (583, 'PAIME', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (584, 'PANDI', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (585, 'PARATEBUENO', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (586, 'PASCA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (587, 'PUERTO SALGAR', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (588, 'PULÍ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (589, 'QUEBRADANEGRA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (590, 'QUETAME', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (591, 'QUIPILE', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (592, 'RAFAEL REYES', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (593, 'RICAURTE', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (594, 'SAN  ANTONIO DEL  TEQUENDAMA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (595, 'SAN BERNARDO', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (596, 'SAN CAYETANO', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (597, 'SAN FRANCISCO', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (598, 'SAN JUAN DE RIOSECO', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (599, 'SASAIMA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (600, 'SESQUILÉ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (601, 'SIBATÉ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (602, 'SILVANIA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (603, 'SIMIJACA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (604, 'SOACHA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (605, 'SOPO', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (606, 'SUBACHOQUE', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (607, 'SUESCA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (608, 'SUPATÁ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (609, 'SUSA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (610, 'SUTATAUSA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (611, 'TABIO', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (612, 'TAUSA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (613, 'TENA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (614, 'TENJO', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (615, 'TIBACUY', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (616, 'TIBIRITA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (617, 'TOCAIMA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (618, 'TOCANCIPÁ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (619, 'TOPAIPÍ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (620, 'UBALÁ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (621, 'UBAQUE', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (622, 'UBATÉ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (623, 'UNE', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (624, 'UTICA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (625, 'VERGARA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (626, 'VIANI', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (627, 'VILLA GOMEZ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (628, 'VILLA PINZÓN', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (629, 'VILLETA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (630, 'VIOTA', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (631, 'YACOPÍ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (632, 'ZIPACÓN', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (633, 'ZIPAQUIRÁ', 14);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (634, 'BARRANCO MINAS', 15);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (635, 'CACAHUAL', 15);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (636, 'INÍRIDA', 15);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (637, 'LA GUADALUPE', 15);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (638, 'MAPIRIPANA', 15);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (639, 'MORICHAL', 15);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (640, 'PANA PANA', 15);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (641, 'PUERTO COLOMBIA', 15);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (642, 'SAN FELIPE', 15);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (643, 'CALAMAR', 16);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (644, 'EL RETORNO', 16);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (645, 'MIRAFLOREZ', 16);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (646, 'SAN JOSÉ DEL GUAVIARE', 16);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (647, 'ACEVEDO', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (648, 'AGRADO', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (649, 'AIPE', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (650, 'ALGECIRAS', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (651, 'ALTAMIRA', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (652, 'BARAYA', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (653, 'CAMPO ALEGRE', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (654, 'COLOMBIA', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (655, 'ELIAS', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (656, 'GARZÓN', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (657, 'GIGANTE', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (658, 'GUADALUPE', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (659, 'HOBO', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (660, 'IQUIRA', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (661, 'ISNOS', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (662, 'LA ARGENTINA', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (663, 'LA PLATA', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (664, 'NATAGA', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (665, 'NEIVA', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (666, 'OPORAPA', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (667, 'PAICOL', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (668, 'PALERMO', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (669, 'PALESTINA', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (670, 'PITAL', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (671, 'PITALITO', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (672, 'RIVERA', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (673, 'SALADO BLANCO', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (674, 'SAN AGUSTÍN', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (675, 'SANTA MARIA', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (676, 'SUAZA', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (677, 'TARQUI', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (678, 'TELLO', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (679, 'TERUEL', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (680, 'TESALIA', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (681, 'TIMANA', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (682, 'VILLAVIEJA', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (683, 'YAGUARA', 17);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (684, 'ALBANIA', 18);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (685, 'BARRANCAS', 18);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (686, 'DIBULLA', 18);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (687, 'DISTRACCIÓN', 18);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (688, 'EL MOLINO', 18);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (689, 'FONSECA', 18);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (690, 'HATO NUEVO', 18);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (691, 'LA JAGUA DEL PILAR', 18);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (692, 'MAICAO', 18);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (693, 'MANAURE', 18);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (694, 'RIOHACHA', 18);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (695, 'SAN JUAN DEL CESAR', 18);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (696, 'URIBIA', 18);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (697, 'URUMITA', 18);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (698, 'VILLANUEVA', 18);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (699, 'ALGARROBO', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (700, 'ARACATACA', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (701, 'ARIGUANI', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (702, 'CERRO SAN ANTONIO', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (703, 'CHIVOLO', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (704, 'CIENAGA', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (705, 'CONCORDIA', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (706, 'EL BANCO', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (707, 'EL PIÑON', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (708, 'EL RETEN', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (709, 'FUNDACION', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (710, 'GUAMAL', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (711, 'NUEVA GRANADA', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (712, 'PEDRAZA', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (713, 'PIJIÑO DEL CARMEN', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (714, 'PIVIJAY', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (715, 'PLATO', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (716, 'PUEBLO VIEJO', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (717, 'REMOLINO', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (718, 'SABANAS DE SAN ANGEL', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (719, 'SALAMINA', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (720, 'SAN SEBASTIAN DE BUENAVISTA', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (721, 'SAN ZENON', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (722, 'SANTA ANA', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (723, 'SANTA BARBARA DE PINTO', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (724, 'SANTA MARTA', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (725, 'SITIONUEVO', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (726, 'TENERIFE', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (727, 'ZAPAYAN', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (728, 'ZONA BANANERA', 19);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (729, 'ACACIAS', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (730, 'BARRANCA DE UPIA', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (731, 'CABUYARO', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (732, 'CASTILLA LA NUEVA', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (733, 'CUBARRAL', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (734, 'CUMARAL', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (735, 'EL CALVARIO', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (736, 'EL CASTILLO', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (737, 'EL DORADO', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (738, 'FUENTE DE ORO', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (739, 'GRANADA', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (740, 'GUAMAL', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (741, 'LA MACARENA', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (742, 'LA URIBE', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (743, 'LEJANÍAS', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (744, 'MAPIRIPÁN', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (745, 'MESETAS', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (746, 'PUERTO CONCORDIA', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (747, 'PUERTO GAITÁN', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (748, 'PUERTO LLERAS', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (749, 'PUERTO LÓPEZ', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (750, 'PUERTO RICO', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (751, 'RESTREPO', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (752, 'SAN  JUAN DE ARAMA', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (753, 'SAN CARLOS GUAROA', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (754, 'SAN JUANITO', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (755, 'SAN MARTÍN', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (756, 'VILLAVICENCIO', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (757, 'VISTA HERMOSA', 20);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (758, 'ALBAN', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (759, 'ALDAÑA', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (760, 'ANCUYA', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (761, 'ARBOLEDA', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (762, 'BARBACOAS', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (763, 'BELEN', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (764, 'BUESACO', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (765, 'CHACHAGUI', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (766, 'COLON (GENOVA)', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (767, 'CONSACA', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (768, 'CONTADERO', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (769, 'CORDOBA', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (770, 'CUASPUD', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (771, 'CUMBAL', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (772, 'CUMBITARA', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (773, 'EL CHARCO', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (774, 'EL PEÑOL', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (775, 'EL ROSARIO', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (776, 'EL TABLÓN', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (777, 'EL TAMBO', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (778, 'FUNES', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (779, 'GUACHUCAL', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (780, 'GUAITARILLA', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (781, 'GUALMATAN', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (782, 'ILES', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (783, 'IMUES', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (784, 'IPIALES', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (785, 'LA CRUZ', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (786, 'LA FLORIDA', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (787, 'LA LLANADA', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (788, 'LA TOLA', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (789, 'LA UNION', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (790, 'LEIVA', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (791, 'LINARES', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (792, 'LOS ANDES', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (793, 'MAGUI', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (794, 'MALLAMA', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (795, 'MOSQUEZA', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (796, 'NARIÑO', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (797, 'OLAYA HERRERA', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (798, 'OSPINA', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (799, 'PASTO', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (800, 'PIZARRO', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (801, 'POLICARPA', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (802, 'POTOSI', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (803, 'PROVIDENCIA', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (804, 'PUERRES', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (805, 'PUPIALES', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (806, 'RICAURTE', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (807, 'ROBERTO PAYAN', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (808, 'SAMANIEGO', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (809, 'SAN BERNARDO', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (810, 'SAN LORENZO', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (811, 'SAN PABLO', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (812, 'SAN PEDRO DE CARTAGO', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (813, 'SANDONA', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (814, 'SANTA BARBARA', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (815, 'SANTACRUZ', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (816, 'SAPUYES', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (817, 'TAMINANGO', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (818, 'TANGUA', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (819, 'TUMACO', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (820, 'TUQUERRES', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (821, 'YACUANQUER', 21);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (822, 'ABREGO', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (823, 'ARBOLEDAS', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (824, 'BOCHALEMA', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (825, 'BUCARASICA', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (826, 'CÁCHIRA', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (827, 'CÁCOTA', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (828, 'CHINÁCOTA', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (829, 'CHITAGÁ', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (830, 'CONVENCIÓN', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (831, 'CÚCUTA', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (832, 'CUCUTILLA', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (833, 'DURANIA', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (834, 'EL CARMEN', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (835, 'EL TARRA', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (836, 'EL ZULIA', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (837, 'GRAMALOTE', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (838, 'HACARI', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (839, 'HERRÁN', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (840, 'LA ESPERANZA', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (841, 'LA PLAYA', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (842, 'LABATECA', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (843, 'LOS PATIOS', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (844, 'LOURDES', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (845, 'MUTISCUA', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (846, 'OCAÑA', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (847, 'PAMPLONA', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (848, 'PAMPLONITA', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (849, 'PUERTO SANTANDER', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (850, 'RAGONVALIA', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (851, 'SALAZAR', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (852, 'SAN CALIXTO', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (853, 'SAN CAYETANO', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (854, 'SANTIAGO', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (855, 'SARDINATA', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (856, 'SILOS', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (857, 'TEORAMA', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (858, 'TIBÚ', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (859, 'TOLEDO', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (860, 'VILLA CARO', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (861, 'VILLA DEL ROSARIO', 22);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (862, 'COLÓN', 23);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (863, 'MOCOA', 23);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (864, 'ORITO', 23);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (865, 'PUERTO ASÍS', 23);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (866, 'PUERTO CAYCEDO', 23);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (867, 'PUERTO GUZMÁN', 23);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (868, 'PUERTO LEGUÍZAMO', 23);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (869, 'SAN FRANCISCO', 23);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (870, 'SAN MIGUEL', 23);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (871, 'SANTIAGO', 23);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (872, 'SIBUNDOY', 23);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (873, 'VALLE DEL GUAMUEZ', 23);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (874, 'VILLAGARZÓN', 23);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (875, 'ARMENIA', 24);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (876, 'BUENAVISTA', 24);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (877, 'CALARCÁ', 24);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (878, 'CIRCASIA', 24);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (879, 'CÓRDOBA', 24);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (880, 'FILANDIA', 24);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (881, 'GÉNOVA', 24);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (882, 'LA TEBAIDA', 24);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (883, 'MONTENEGRO', 24);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (884, 'PIJAO', 24);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (885, 'QUIMBAYA', 24);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (886, 'SALENTO', 24);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (887, 'APIA', 25);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (888, 'BALBOA', 25);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (889, 'BELÉN DE UMBRÍA', 25);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (890, 'DOS QUEBRADAS', 25);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (891, 'GUATICA', 25);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (892, 'LA CELIA', 25);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (893, 'LA VIRGINIA', 25);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (894, 'MARSELLA', 25);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (895, 'MISTRATO', 25);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (896, 'PEREIRA', 25);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (897, 'PUEBLO RICO', 25);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (898, 'QUINCHÍA', 25);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (899, 'SANTA ROSA DE CABAL', 25);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (900, 'SANTUARIO', 25);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (901, 'PROVIDENCIA', 26);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (902, 'SAN ANDRES', 26);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (903, 'SANTA CATALINA', 26);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (904, 'AGUADA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (905, 'ALBANIA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (906, 'ARATOCA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (907, 'BARBOSA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (908, 'BARICHARA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (909, 'BARRANCABERMEJA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (910, 'BETULIA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (911, 'BOLÍVAR', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (912, 'BUCARAMANGA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (913, 'CABRERA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (914, 'CALIFORNIA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (915, 'CAPITANEJO', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (916, 'CARCASI', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (917, 'CEPITA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (918, 'CERRITO', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (919, 'CHARALÁ', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (920, 'CHARTA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (921, 'CHIMA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (922, 'CHIPATÁ', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (923, 'CIMITARRA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (924, 'CONCEPCIÓN', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (925, 'CONFINES', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (926, 'CONTRATACIÓN', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (927, 'COROMORO', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (928, 'CURITÍ', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (929, 'EL CARMEN', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (930, 'EL GUACAMAYO', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (931, 'EL PEÑÓN', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (932, 'EL PLAYÓN', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (933, 'ENCINO', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (934, 'ENCISO', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (935, 'FLORIÁN', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (936, 'FLORIDABLANCA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (937, 'GALÁN', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (938, 'GAMBITA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (939, 'GIRÓN', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (940, 'GUACA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (941, 'GUADALUPE', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (942, 'GUAPOTA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (943, 'GUAVATÁ', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (944, 'GUEPSA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (945, 'HATO', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (946, 'JESÚS MARIA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (947, 'JORDÁN', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (948, 'LA BELLEZA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (949, 'LA PAZ', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (950, 'LANDAZURI', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (951, 'LEBRIJA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (952, 'LOS SANTOS', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (953, 'MACARAVITA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (954, 'MÁLAGA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (955, 'MATANZA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (956, 'MOGOTES', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (957, 'MOLAGAVITA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (958, 'OCAMONTE', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (959, 'OIBA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (960, 'ONZAGA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (961, 'PALMAR', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (962, 'PALMAS DEL SOCORRO', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (963, 'PÁRAMO', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (964, 'PIEDECUESTA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (965, 'PINCHOTE', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (966, 'PUENTE NACIONAL', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (967, 'PUERTO PARRA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (968, 'PUERTO WILCHES', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (969, 'RIONEGRO', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (970, 'SABANA DE TORRES', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (971, 'SAN ANDRÉS', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (972, 'SAN BENITO', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (973, 'SAN GIL', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (974, 'SAN JOAQUÍN', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (975, 'SAN JOSÉ DE MIRANDA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (976, 'SAN MIGUEL', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (977, 'SAN VICENTE DE CHUCURÍ', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (978, 'SANTA BÁRBARA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (979, 'SANTA HELENA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (980, 'SIMACOTA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (981, 'SOCORRO', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (982, 'SUAITA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (983, 'SUCRE', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (984, 'SURATA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (985, 'TONA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (986, 'VALLE SAN JOSÉ', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (987, 'VÉLEZ', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (988, 'VETAS', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (989, 'VILLANUEVA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (990, 'ZAPATOCA', 27);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (991, 'BUENAVISTA', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (992, 'CAIMITO', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (993, 'CHALÁN', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (994, 'COLOSO', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (995, 'COROZAL', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (996, 'EL ROBLE', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (997, 'GALERAS', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (998, 'GUARANDA', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (999, 'LA UNIÓN', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1000, 'LOS PALMITOS', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1001, 'MAJAGUAL', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1002, 'MORROA', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1003, 'OVEJAS', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1004, 'PALMITO', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1005, 'SAMPUES', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1006, 'SAN BENITO ABAD', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1007, 'SAN JUAN DE BETULIA', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1008, 'SAN MARCOS', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1009, 'SAN ONOFRE', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1010, 'SAN PEDRO', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1011, 'SINCÉ', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1012, 'SINCELEJO', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1013, 'SUCRE', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1014, 'TOLÚ', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1015, 'TOLUVIEJO', 28);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1016, 'ALPUJARRA', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1017, 'ALVARADO', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1018, 'AMBALEMA', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1019, 'ANZOATEGUI', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1020, 'ARMERO (GUAYABAL)', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1021, 'ATACO', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1022, 'CAJAMARCA', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1023, 'CARMEN DE APICALÁ', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1024, 'CASABIANCA', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1025, 'CHAPARRAL', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1026, 'COELLO', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1027, 'COYAIMA', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1028, 'CUNDAY', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1029, 'DOLORES', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1030, 'ESPINAL', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1031, 'FALÁN', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1032, 'FLANDES', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1033, 'FRESNO', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1034, 'GUAMO', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1035, 'HERVEO', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1036, 'HONDA', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1037, 'IBAGUÉ', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1038, 'ICONONZO', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1039, 'LÉRIDA', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1040, 'LÍBANO', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1041, 'MARIQUITA', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1042, 'MELGAR', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1043, 'MURILLO', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1044, 'NATAGAIMA', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1045, 'ORTEGA', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1046, 'PALOCABILDO', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1047, 'PIEDRAS PLANADAS', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1048, 'PRADO', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1049, 'PURIFICACIÓN', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1050, 'RIOBLANCO', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1051, 'RONCESVALLES', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1052, 'ROVIRA', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1053, 'SALDAÑA', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1054, 'SAN ANTONIO', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1055, 'SAN LUIS', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1056, 'SANTA ISABEL', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1057, 'SUÁREZ', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1058, 'VALLE DE SAN JUAN', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1059, 'VENADILLO', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1060, 'VILLAHERMOSA', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1061, 'VILLARRICA', 29);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1062, 'ALCALÁ', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1063, 'ANDALUCÍA', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1064, 'ANSERMA NUEVO', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1065, 'ARGELIA', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1066, 'BOLÍVAR', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1067, 'BUENAVENTURA', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1068, 'BUGA', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1069, 'BUGALAGRANDE', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1070, 'CAICEDONIA', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1071, 'CALI', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1072, 'CALIMA (DARIEN)', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1073, 'CANDELARIA', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1074, 'CARTAGO', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1075, 'DAGUA', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1076, 'EL AGUILA', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1077, 'EL CAIRO', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1078, 'EL CERRITO', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1079, 'EL DOVIO', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1080, 'FLORIDA', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1081, 'GINEBRA GUACARI', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1082, 'JAMUNDÍ', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1083, 'LA CUMBRE', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1084, 'LA UNIÓN', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1085, 'LA VICTORIA', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1086, 'OBANDO', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1087, 'PALMIRA', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1088, 'PRADERA', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1089, 'RESTREPO', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1090, 'RIO FRÍO', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1091, 'ROLDANILLO', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1092, 'SAN PEDRO', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1093, 'SEVILLA', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1094, 'TORO', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1095, 'TRUJILLO', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1096, 'TULÚA', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1097, 'ULLOA', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1098, 'VERSALLES', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1099, 'VIJES', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1100, 'YOTOCO', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1101, 'YUMBO', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1102, 'ZARZAL', 30);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1103, 'CARURÚ', 31);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1104, 'MITÚ', 31);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1105, 'PACOA', 31);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1106, 'PAPUNAUA', 31);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1107, 'TARAIRA', 31);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1108, 'YAVARATÉ', 31);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1109, 'CUMARIBO', 32);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1110, 'LA PRIMAVERA', 32);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1111, 'PUERTO CARREÑO', 32);
INSERT INTO `instrumusic`.`Municipio` (`idMunicipio`, `nombre`, `Departamento_idDepartamento`) VALUES (1112, 'SANTA ROSALIA', 32);

COMMIT;


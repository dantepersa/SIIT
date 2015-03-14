# SQL Manager 2011 for MySQL 5.1.0.2
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : siit


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES latin1 */;

SET FOREIGN_KEY_CHECKS=0;

CREATE DATABASE `siit`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `siit`;

#
# Structure for the `cliente` table : 
#

CREATE TABLE `cliente` (
  `id_cliente` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `Nombres` VARCHAR(200) COLLATE latin1_swedish_ci NOT NULL,
  `Apellidos` VARCHAR(200) COLLATE latin1_swedish_ci NOT NULL,
  `TipoID` ENUM('Tarjeta de indentidad','Cedula de ciudadanía','Cedula de extranjería','Pasaporte') NOT NULL,
  `Numero_Id` VARCHAR(100) COLLATE latin1_swedish_ci NOT NULL,
  `Email` VARCHAR(200) COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_cliente`)
)ENGINE=InnoDB
AUTO_INCREMENT=3 AVG_ROW_LENGTH=8192 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `paquete` table : 
#

CREATE TABLE `paquete` (
  `id_paquete` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL,
  `Valor` INTEGER(11) NOT NULL,
  `Fecha_inicio` DATE NOT NULL COMMENT 'fecha de inicio de la promocion',
  `Fecha_fin` DATE NOT NULL,
  `Disponible` CHAR(20) COLLATE latin1_swedish_ci DEFAULT 'S' COMMENT 'S=Si esta disponible\r\nN=No esta disponible',
  `Estado` CHAR(20) COLLATE latin1_swedish_ci DEFAULT 'S' COMMENT 'S=Si esta vigente el paquete\r\nN=No esta vigente',
  PRIMARY KEY (`id_paquete`)
)ENGINE=InnoDB
AUTO_INCREMENT=2 AVG_ROW_LENGTH=16384 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `proveedor` table : 
#

CREATE TABLE `proveedor` (
  `id_proveedor` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(200) COLLATE latin1_swedish_ci NOT NULL,
  `Telefono` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL,
  `Email` VARCHAR(200) COLLATE latin1_swedish_ci NOT NULL,
  `Nit` VARCHAR(100) COLLATE latin1_swedish_ci NOT NULL,
  `Estado` CHAR(20) COLLATE latin1_swedish_ci DEFAULT 'A' COMMENT 'A=activo\r\nN=No activo',
  PRIMARY KEY (`id_proveedor`)
)ENGINE=InnoDB
AUTO_INCREMENT=7 AVG_ROW_LENGTH=5461 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `reserva` table : 
#

CREATE TABLE `reserva` (
  `Id_reserva` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `Fk_paquete` INTEGER(11) NOT NULL,
  `fk_cliente` INTEGER(11) NOT NULL,
  `valor` DOUBLE(15,3) DEFAULT NULL,
  `Fecha_pedido` DATE NOT NULL COMMENT 'El dia que tomo el servicio',
  `Fecha_reserva` DATE NOT NULL COMMENT 'para cuando estaria tomando el paquete',
  `Estado` ENUM('Cotizacion','Confirmado','No confirmado') NOT NULL COMMENT 'Aqui miramos si el cliente solo queria cotizar, si cotizo pero aun no confirma su compra y si confirma su compra del paquete',
  `Pago` CHAR(20) COLLATE latin1_swedish_ci DEFAULT 'N' COMMENT 'S= si ha pagado\r\nN= no ha pagado',
  PRIMARY KEY (`Id_reserva`),
  KEY `Fk_paquete` (`Fk_paquete`),
  KEY `fk_cliente` (`fk_cliente`),
  CONSTRAINT `reserva_fk1` FOREIGN KEY (`fk_cliente`) REFERENCES cliente (`id_cliente`),
  CONSTRAINT `reserva_fk11` FOREIGN KEY (`Fk_paquete`) REFERENCES paquete (`id_paquete`)
)ENGINE=InnoDB
AUTO_INCREMENT=2 AVG_ROW_LENGTH=16384 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `servicios` table : 
#

CREATE TABLE `servicios` (
  `id_servicios` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(200) COLLATE latin1_swedish_ci NOT NULL,
  `fk_Proveedor` INTEGER(11) NOT NULL,
  `Valor` DOUBLE(15,3) NOT NULL,
  `Estado` CHAR(20) COLLATE latin1_swedish_ci DEFAULT 'S' COMMENT 'S= si esta vigente\r\nN= no esta vigente',
  `Disponibilidad` CHAR(20) COLLATE latin1_swedish_ci DEFAULT 'S' COMMENT 'S= si esta disponible el servicio\r\nN= No esta disponible el servicio',
  PRIMARY KEY (`id_servicios`),
  KEY `fk_Proveedor` (`fk_Proveedor`),
  CONSTRAINT `servicios_fk1` FOREIGN KEY (`fk_Proveedor`) REFERENCES proveedor (`id_proveedor`)
)ENGINE=InnoDB
AUTO_INCREMENT=3 AVG_ROW_LENGTH=8192 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `servicios_paquete` table : 
#

CREATE TABLE `servicios_paquete` (
  `id_servicios_paquete` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `fk_paquete` INTEGER(11) NOT NULL,
  `fk_servicio` INTEGER(11) NOT NULL,
  `cantidad` INTEGER(11) DEFAULT NULL,
  `Valor` DOUBLE(15,3) NOT NULL,
  PRIMARY KEY (`id_servicios_paquete`),
  KEY `fk_paquete` (`fk_paquete`),
  KEY `fk_servicio` (`fk_servicio`),
  CONSTRAINT `servicios_paquete_fk1` FOREIGN KEY (`fk_paquete`) REFERENCES paquete (`id_paquete`),
  CONSTRAINT `servicios_paquete_fk2` FOREIGN KEY (`fk_servicio`) REFERENCES servicios (`id_servicios`)
)ENGINE=InnoDB
AUTO_INCREMENT=2 AVG_ROW_LENGTH=16384 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Data for the `cliente` table  (LIMIT -497,500)
#

INSERT INTO `cliente` (`id_cliente`, `Nombres`, `Apellidos`, `TipoID`, `Numero_Id`, `Email`) VALUES 
  (1,'daniel','ante','','1061714365','dantethepersa@hotmail.com'),
  (2,'hector','montero','','1061737123','hector.javier@gmail.com');
COMMIT;

#
# Data for the `paquete` table  (LIMIT -498,500)
#

INSERT INTO `paquete` (`id_paquete`, `Nombre`, `Valor`, `Fecha_inicio`, `Fecha_fin`, `Disponible`, `Estado`) VALUES 
  (1,'paquete semana santa',200000,'2015-03-29','2015-04-04','S','S');
COMMIT;

#
# Data for the `proveedor` table  (LIMIT -496,500)
#

INSERT INTO `proveedor` (`id_proveedor`, `Nombre`, `Telefono`, `Email`, `Nit`, `Estado`) VALUES 
  (1,'restaurante','8333333','restaurante@hotmail.com','123456','A'),
  (2,'hotel1','82222222','hotel@hotmail.com','1234567','A'),
  (3,'finca1','82111111','finca@hotmail.com','123456789','A');
COMMIT;

#
# Data for the `reserva` table  (LIMIT -498,500)
#

INSERT INTO `reserva` (`Id_reserva`, `Fk_paquete`, `fk_cliente`, `valor`, `Fecha_pedido`, `Fecha_reserva`, `Estado`, `Pago`) VALUES 
  (1,1,2,0.000,'2015-03-01','2015-03-10','Cotizacion','N');
COMMIT;

#
# Data for the `servicios` table  (LIMIT -497,500)
#

INSERT INTO `servicios` (`id_servicios`, `Nombre`, `fk_Proveedor`, `Valor`, `Estado`, `Disponibilidad`) VALUES 
  (1,'Empanadas de pipiam',1,200.000,'S','S'),
  (2,'Suite por noche',2,50000.000,'S','S');
COMMIT;

#
# Data for the `servicios_paquete` table  (LIMIT -498,500)
#

INSERT INTO `servicios_paquete` (`id_servicios_paquete`, `fk_paquete`, `fk_servicio`, `cantidad`, `Valor`) VALUES 
  (1,1,2,5,200000.000);
COMMIT;



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
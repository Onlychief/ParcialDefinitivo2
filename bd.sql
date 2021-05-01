-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         5.7.24 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para control_asistencia
CREATE DATABASE IF NOT EXISTS `control_asistencia` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `control_asistencia`;

-- Volcando estructura para tabla control_asistencia.administrador
CREATE TABLE IF NOT EXISTS `administrador` (
  `id` int(11) NOT NULL,
  `correo` varchar(50) NOT NULL DEFAULT '',
  `clave` varchar(100) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla control_asistencia.administrador: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `administrador` DISABLE KEYS */;
INSERT INTO `administrador` (`id`, `correo`, `clave`) VALUES
	(1, 'jhonatan@gmail.com', '123');
/*!40000 ALTER TABLE `administrador` ENABLE KEYS */;

-- Volcando estructura para tabla control_asistencia.asignacion_espacios
CREATE TABLE IF NOT EXISTS `asignacion_espacios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `espacio` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  PRIMARY KEY (`id`),
  KEY `espaciso` (`espacio`),
  CONSTRAINT `espaciso` FOREIGN KEY (`espacio`) REFERENCES `espacio_academico` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla control_asistencia.asignacion_espacios: ~11 rows (aproximadamente)
/*!40000 ALTER TABLE `asignacion_espacios` DISABLE KEYS */;
INSERT INTO `asignacion_espacios` (`id`, `espacio`, `fecha`, `hora_inicio`, `hora_fin`) VALUES
	(1, 1, '2021-03-28', '22:08:02', '23:08:13'),
	(2, 1, '2021-04-29', '19:45:00', '21:45:00'),
	(3, 1, '2021-04-30', '19:11:00', '00:20:00'),
	(4, 1, '2021-04-29', '19:23:00', '21:23:00'),
	(5, 2, '2021-04-14', '20:23:00', '21:24:00'),
	(6, 1, '2021-04-15', '05:34:00', '20:33:00'),
	(7, 1, '2021-04-02', '17:42:00', '21:40:00'),
	(8, 1, '2021-04-02', '17:42:00', '21:40:00'),
	(9, 1, '2021-04-30', '02:05:00', '04:09:00'),
	(10, 1, '2021-05-01', '07:28:00', '01:34:00'),
	(11, 1, '2021-04-07', '04:30:00', '05:30:00'),
	(12, 4, '2021-04-30', '02:17:42', '02:17:43');
/*!40000 ALTER TABLE `asignacion_espacios` ENABLE KEYS */;

-- Volcando estructura para tabla control_asistencia.asistencia
CREATE TABLE IF NOT EXISTS `asistencia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `falta` varchar(50) NOT NULL DEFAULT '0',
  `asignacion_espacios` int(11) NOT NULL DEFAULT '0',
  `estudiantes` int(11) NOT NULL DEFAULT '0',
  `hora_entradaest` time(6) NOT NULL DEFAULT '00:00:00.000000',
  `hora_salidaest` time(6) NOT NULL DEFAULT '00:00:00.000000',
  PRIMARY KEY (`id`),
  KEY `asignacion` (`asignacion_espacios`),
  KEY `estudiantes` (`estudiantes`),
  CONSTRAINT `asignacion` FOREIGN KEY (`asignacion_espacios`) REFERENCES `asignacion_espacios` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `estudiantes` FOREIGN KEY (`estudiantes`) REFERENCES `estudiantes` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla control_asistencia.asistencia: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `asistencia` DISABLE KEYS */;
INSERT INTO `asistencia` (`id`, `falta`, `asignacion_espacios`, `estudiantes`, `hora_entradaest`, `hora_salidaest`) VALUES
	(1, 'Asistió', 2, 7, '23:42:24.000000', '23:42:24.000000'),
	(2, 'Asistió', 9, 7, '00:24:14.000000', '00:24:14.000000'),
	(5, 'Asistió', 12, 1, '00:24:14.000000', '00:24:14.000000');
/*!40000 ALTER TABLE `asistencia` ENABLE KEYS */;

-- Volcando estructura para tabla control_asistencia.docente
CREATE TABLE IF NOT EXISTS `docente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Nombres` varchar(50) DEFAULT NULL,
  `Apellidos` varchar(50) DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `clave` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla control_asistencia.docente: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `docente` DISABLE KEYS */;
INSERT INTO `docente` (`id`, `Nombres`, `Apellidos`, `correo`, `clave`) VALUES
	(1, 'Jeyson', 'Calvache', 'ejemplo@hotmail.com', 'faffsfs'),
	(2, 'Ernesto', 'Monsalve', 'monsalve@gmail.com', '34324'),
	(3, 'Jhonatan', 'Jaramillo', 'jhony@gmail.com', '202cb962ac59075b964b07152d234b70');
/*!40000 ALTER TABLE `docente` ENABLE KEYS */;

-- Volcando estructura para tabla control_asistencia.espacio_academico
CREATE TABLE IF NOT EXISTS `espacio_academico` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `semestre` int(11) DEFAULT NULL,
  `docente` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `semestres` (`semestre`),
  KEY `docente` (`docente`),
  CONSTRAINT `docensfd` FOREIGN KEY (`docente`) REFERENCES `docente` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `semestres` FOREIGN KEY (`semestre`) REFERENCES `semestre` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla control_asistencia.espacio_academico: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `espacio_academico` DISABLE KEYS */;
INSERT INTO `espacio_academico` (`id`, `nombre`, `semestre`, `docente`) VALUES
	(1, 'Electiva Profesional', 1, 3),
	(2, 'Electiva Profesional 2', 1, 3),
	(3, 'Ingles VII', 2, 2),
	(4, 'Materiaprueba', 1, 3);
/*!40000 ALTER TABLE `espacio_academico` ENABLE KEYS */;

-- Volcando estructura para tabla control_asistencia.estudiantes
CREATE TABLE IF NOT EXISTS `estudiantes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Nombres` varchar(50) DEFAULT NULL,
  `Apellidos` varchar(50) DEFAULT NULL,
  `Celular` varchar(50) DEFAULT NULL,
  `Correo` varchar(50) DEFAULT NULL,
  `Clave` varchar(100) DEFAULT NULL,
  `Semestre` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `semestre` (`Semestre`),
  CONSTRAINT `semestre` FOREIGN KEY (`Semestre`) REFERENCES `semestre` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla control_asistencia.estudiantes: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `estudiantes` DISABLE KEYS */;
INSERT INTO `estudiantes` (`id`, `Nombres`, `Apellidos`, `Celular`, `Correo`, `Clave`, `Semestre`) VALUES
	(1, 'Jhonatan ', 'Jaramillo', '1111111111', 'jhonatan@gmail.com', 'fdsfad', 1),
	(2, 'Yesid ', 'Diaz', '3138030940', 'fds@@', 'fdsafsaf', 1),
	(3, 'Estudiante', 'De Prueba', '202cb962ac59075b964b07152d234b70', 'espru@hotmail.com', '202cb962ac59075b964b07152d234b70', 2),
	(4, 'Estudaints', 'Deprueba2', '202cb962ac59075b964b07152d234b70', 'se@hotmail.com', '202cb962ac59075b964b07152d234b70', 2),
	(5, 'Jaimito', 'El Cartero', '202cb962ac59075b964b07152d234b70', 'jaimito@gmail.com', '202cb962ac59075b964b07152d234b70', 2),
	(6, 'Jaimito2', 'El Cartero', '202cb962ac59075b964b07152d234b70', 'jaimito@gmail.com', '202cb962ac59075b964b07152d234b70', 2),
	(7, 'pruebas', 'fdsafa', '202cb962ac59075b964b07152d234b70', 'prueba23@hotmail.com', '202cb962ac59075b964b07152d234b70', 1);
/*!40000 ALTER TABLE `estudiantes` ENABLE KEYS */;

-- Volcando estructura para tabla control_asistencia.semestre
CREATE TABLE IF NOT EXISTS `semestre` (
  `id` int(11) NOT NULL,
  `desc_semestre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla control_asistencia.semestre: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `semestre` DISABLE KEYS */;
INSERT INTO `semestre` (`id`, `desc_semestre`) VALUES
	(1, 'X'),
	(2, 'IX');
/*!40000 ALTER TABLE `semestre` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

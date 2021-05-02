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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla control_asistencia.asignacion_espacios: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `asignacion_espacios` DISABLE KEYS */;
/*!40000 ALTER TABLE `asignacion_espacios` ENABLE KEYS */;

-- Volcando estructura para tabla control_asistencia.asistencia
CREATE TABLE IF NOT EXISTS `asistencia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `falta` varchar(50) DEFAULT NULL,
  `hora_entradaest` time DEFAULT NULL,
  `hora_salidaest` time DEFAULT NULL,
  `asignacion_espacios` int(11) DEFAULT NULL,
  `estudiantes` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `azigs` (`asignacion_espacios`),
  KEY `estuds` (`estudiantes`),
  CONSTRAINT `azigs` FOREIGN KEY (`asignacion_espacios`) REFERENCES `asignacion_espacios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `estuds` FOREIGN KEY (`estudiantes`) REFERENCES `estudiantes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla control_asistencia.asistencia: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `asistencia` DISABLE KEYS */;
INSERT INTO `asistencia` (`id`, `falta`, `hora_entradaest`, `hora_salidaest`, `asignacion_espacios`, `estudiantes`) VALUES
	(4, 'Asistió', '09:36:02', '09:36:02', NULL, NULL),
	(5, 'Asistió', '10:50:26', '10:50:26', NULL, 12);
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

-- Volcando datos para la tabla control_asistencia.docente: ~3 rows (aproximadamente)
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

-- Volcando datos para la tabla control_asistencia.espacio_academico: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `espacio_academico` DISABLE KEYS */;
INSERT INTO `espacio_academico` (`id`, `nombre`, `semestre`, `docente`) VALUES
	(1, 'Electiva Profesional', 1, 3),
	(2, 'Electiva Profesional 2', 1, 3),
	(3, 'Ingles VII', 2, 2),
	(4, 'Materiaprueba', 1, 3),
	(5, 'Proyectos', 2, 3);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla control_asistencia.estudiantes: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `estudiantes` DISABLE KEYS */;
INSERT INTO `estudiantes` (`id`, `Nombres`, `Apellidos`, `Celular`, `Correo`, `Clave`, `Semestre`) VALUES
	(11, 'Jhonatan', 'Noveno Semestre', '3138030940', 'jhon9@hotmail.com', '202cb962ac59075b964b07152d234b70', 2),
	(12, 'estudaitnecreado', 'fdsfdas', '321321312', 'prueba24@hotmail.com', '202cb962ac59075b964b07152d234b70', 1);
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

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-01-2026 a las 19:11:36
-- Versión del servidor: 11.8.2-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `faco_luz_extension`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `changelogs`
--

CREATE TABLE `changelogs` (
  `id` uuid NOT NULL,
  `changeType` int(11) NOT NULL,
  `dateTime` datetime NOT NULL,
  `userModificatorId` int(15) UNSIGNED NOT NULL,
  `userModificatedId` int(15) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `courses`
--

CREATE TABLE `courses` (
  `id` int(2) NOT NULL,
  `description` text DEFAULT NULL,
  `state` enum('Activo','Inactivo','Cancelado') DEFAULT NULL,
  `create_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enrollments`
--

CREATE TABLE `enrollments` (
  `id` uuid NOT NULL,
  `studentsId` uuid NOT NULL,
  `periodId` uuid NOT NULL,
  `dateEnrollments` datetime NOT NULL,
  `state` enum('Pagada','Deuda') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modules`
--

CREATE TABLE `modules` (
  `id` int(4) NOT NULL,
  `description` text DEFAULT NULL,
  `courseId` int(2) DEFAULT NULL,
  `create_at` datetime DEFAULT current_timestamp(),
  `state` enum('Activo','Inactivo') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `periods`
--

CREATE TABLE `periods` (
  `id` uuid NOT NULL,
  `age` int(4) NOT NULL,
  `period` uuid NOT NULL,
  `dateStart` date NOT NULL,
  `dateEnd` date DEFAULT NULL,
  `create_at` datetime DEFAULT current_timestamp(),
  `state` enum('En curso','Finalizado') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `scores`
--

CREATE TABLE `scores` (
  `studentsId` int(8) DEFAULT NULL,
  `moduleId` int(4) DEFAULT NULL,
  `score` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `students`
--

CREATE TABLE `students` (
  `id` uuid NOT NULL,
  `name` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `studentsId` int(8) NOT NULL,
  `birthDate` date NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` int(11) NOT NULL,
  `address` text NOT NULL,
  `instructionGrade` enum('Ninguno','Prescolar','Primaria','Bachillerato','Universitario','Postgrado') DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `state` enum('Activo','Desertor','Completado') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `passwordSHA256` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `identificationType` int(10) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `lastname`, `passwordSHA256`, `type`, `identificationType`, `active`) VALUES
(1, 'admin', 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 0, 0, 1),
(2, '2', '2', 'd4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35', 1, 1, 1),
(3, '3', '3', '4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce', 2, 1, 1),
(4, '4', '4', '4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a', 3, 1, 1),
(5, '5', '5', 'ef2d127de37b942baad06145e54b0c619a1f22327b2ebbcfbec78f5564afe39d', 4, 1, 1),
(6, '6', '6', 'e7f6c011776e8db7cd330b54174fd76f7d0216b612387a5ffcfb81e6f0919683', 5, 1, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_student_enrollment` (`studentsId`),
  ADD KEY `fk_period_enrollment` (`periodId`);

--
-- Indices de la tabla `modules`
--
ALTER TABLE `modules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_course` (`courseId`);

--
-- Indices de la tabla `periods`
--
ALTER TABLE `periods`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_period` (`period`);

--
-- Indices de la tabla `scores`
--
ALTER TABLE `scores`
  ADD KEY `fk_student_scores` (`studentsId`),
  ADD KEY `fk_module_scores` (`moduleId`);

--
-- Indices de la tabla `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD KEY `studentsId` (`studentsId`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(2) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `modules`
--
ALTER TABLE `modules`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `fk_period_enrollment` FOREIGN KEY (`periodId`) REFERENCES `periods` (`id`),
  ADD CONSTRAINT `fk_student_enrollment` FOREIGN KEY (`studentsId`) REFERENCES `students` (`id`);

--
-- Filtros para la tabla `modules`
--
ALTER TABLE `modules`
  ADD CONSTRAINT `fk_course` FOREIGN KEY (`courseId`) REFERENCES `courses` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `periods`
--
ALTER TABLE `periods`
  ADD CONSTRAINT `fk_period` FOREIGN KEY (`period`) REFERENCES `periods` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `scores`
--
ALTER TABLE `scores`
  ADD CONSTRAINT `fk_module_scores` FOREIGN KEY (`moduleId`) REFERENCES `modules` (`id`),
  ADD CONSTRAINT `fk_student_scores` FOREIGN KEY (`studentsId`) REFERENCES `students` (`studentsId`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

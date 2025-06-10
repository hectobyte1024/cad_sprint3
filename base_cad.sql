/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.11-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: base_cad
-- ------------------------------------------------------
-- Server version	10.11.11-MariaDB-0+deb12u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `EmergencyTypes`
--

DROP TABLE IF EXISTS `EmergencyTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `EmergencyTypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(50) NOT NULL,
  `code` varchar(10) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `priority` varchar(10) DEFAULT NULL,
  `original_sheet` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_code` (`code`),
  KEY `idx_priority` (`priority`),
  KEY `idx_category` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=347 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EmergencyTypes`
--

LOCK TABLES `EmergencyTypes` WRITE;
/*!40000 ALTER TABLE `EmergencyTypes` DISABLE KEYS */;
INSERT INTO `EmergencyTypes` VALUES
(1,'Civil Protection','20101','ACCIDENTE FERROVIARIO SIN PERSONAS LESIONADAS','Suceso en el que se ven involucrados locomotoras o vehículos que circulan en las vías del tren, sin que resulten personas lesionadas.','MEDIA','Protección civil'),
(2,'Civil Protection','20102','ALMACENAMIENTO ILÍCITO DE SUSTANCIAS PELIGROSAS','Conjunto de recintos y recipientes no autorizados en los cuales se resguardan productos químicos, que puedan producir un riesgo no controlado para las personas, su patrimonio o el medio ambiente.','ALTA','Protección civil'),
(3,'Civil Protection','20103','ANIMAL PELIGROSO','Animales que, con independencia de su agresividad, su especie o raza tienen capacidad de causar muerte o lesiones a personas o animales y/o daños a las cosas.','ALTA','Protección civil'),
(4,'Civil Protection','20104','ANIMAL SUELTO','Animal fuera de su hábitat o que debiera estar resguardado, o animales sueltos en vía pública que entorpecen la vida cotidiana.','MEDIA','Protección civil'),
(5,'Civil Protection','20105','FUGAS Y DERRAMES EN ESCUELA','Rupturas de recipientes o tuberías con sustancias que pueden causar daños en infraestructura o personas dentro o alrededor de un centro escolar.','ALTA','Protección civil'),
(6,'Civil Protection','20106','DESBORDAMIENTO DE CUERPO DE AGUA','Ocupación inhabitual de un espacio con agua debido al rebase de la capacidad normal de un cuerpo de agua. Incluye encharcamientos.','ALTA','Protección civil'),
(7,'Civil Protection','20107','EXPLOSIÓN','Liberación de gran cantidad de energía en corto tiempo por impacto o reacción química.','ALTA','Protección civil'),
(8,'Civil Protection','20108','FUGAS Y DERRAMES DE SUSTANCIAS QUÍMICAS','Fugas debidas a presión o rupturas en recipientes o tuberías que contienen sustancias químicas.','ALTA','Protección civil'),
(9,'Civil Protection','20109','HUNDIMIENTOS / AGRIETAMIENTOS / INESTABILIDAD DEL TERRENO','Provocados por actividades antrópicas que alteran cauces naturales (extracción de agua, relleno, excavaciones, minas, etc.).','ALTA','Protección civil'),
(10,'Civil Protection','20110','GASES TÓXICOS','Presencia de contaminantes del aire a través de sustancias químicas.','MEDIA','Protección civil'),
(11,'Civil Protection','20111','OLORES FÉTIDOS','Contaminación ambiental por olores intensos, malolientes, nauseabundos o pútridos.','MEDIA','Protección civil'),
(12,'Civil Protection','20112','MATERIALES PELIGROSOS O RADIOACTIVOS (EXPOSICIÓN)','Materiales que no cumplen especificaciones de calidad. Residuos peligrosos en forma sólida, líquida o gaseosa.','ALTA','Protección civil'),
(13,'Civil Protection','20113','CAÍDA O INCLINACIÓN PELIGROSA DE ANUNCIO O ESPECTACULAR','Inclinación o caída de anuncio de gran tamaño, que puede causar daños a vía pública o patrimonio.','MEDIA','Protección civil'),
(14,'Civil Protection','20114','TRANSPORTE NEGLIGENTE O CLANDESTINO DE SUSTANCIAS PELIGROSAS','Transporte inseguro de sustancias peligrosas que representa peligro para transportistas o poblaciones, incumpliendo normas.','ALTA','Protección civil'),
(15,'Civil Protection','20115','FUGA DE GAS','Escape de gas en tanques portátiles, estacionarios, casas, negocios o tuberías subterráneas.','ALTA','Protección civil'),
(16,'Civil Protection','20201','CONTAMINACIÓN DE SUELO, AIRE Y AGUA','Emisión de contaminantes que afectan recursos naturales, flora, fauna, ecosistemas o el ambiente.','ALTA','Protección civil'),
(17,'Civil Protection','20202','DERRUMBES Y DESLAVES','Pérdida de capacidad del terreno para sustentarse, con colapsos por fenómenos naturales o antrópicos.','ALTA','Protección civil'),
(18,'Civil Protection','20203','ENJAMBRE DE ABEJAS','Conjunto de abejas que representan peligro potencial para personas.','MEDIA','Protección civil'),
(19,'Civil Protection','20204','ERUPCIÓN O EMISIONES VOLCÁNICAS','Emisión de lava, ceniza, rocas, lodo o derrumbes por actividad volcánica.','ALTA','Protección civil'),
(20,'Civil Protection','20205','FRENTES FRÍOS, BAJAS TEMPERATURAS, NEVADAS Y HELADAS','Fenómenos meteorológicos que afectan personas, flora y fauna. Incluye nevadas, heladas y bajas temperaturas.','ALTA','Protección civil'),
(21,'Civil Protection','20206','HURACANES','Ciclón tropical con vientos fuertes y lluvias intensas.','ALTA','Protección civil'),
(22,'Civil Protection','20207','INUNDACIONES','Presencia anormal de agua en un espacio, que puede entorpecer la vida cotidiana o dañar la salud y patrimonio.','ALTA','Protección civil'),
(23,'Civil Protection','20208','PLAGAS','Grandes cantidades de animales portadores de enfermedades transmisibles al ser humano.','MEDIA','Protección civil'),
(24,'Civil Protection','20209','SISMO','Rompimiento repentino de la corteza terrestre que causa vibraciones percibidas como sacudidas.','ALTA','Protección civil'),
(25,'Civil Protection','20210','ÁRBOL CAÍDO O POR CAER','Desprendimiento o riesgo de caída de un árbol.','ALTA','Protección civil'),
(26,'Civil Protection','20211','TORMENTAS DE GRANIZO / DE NIEVE','Precipitación en forma de piedras de hielo o nieve durante tormentas severas.','ALTA','Protección civil'),
(27,'Civil Protection','20212','TORNADOS','Remolino violento de viento por inestabilidad atmosférica.','ALTA','Protección civil'),
(28,'Civil Protection','20213','TSUNAMI','Ondas destructivas causadas por terremotos en cuerpos de agua.','MEDIA','Protección civil'),
(29,'Civil Protection','20214','TORMENTA DE ARENA O POLVO','Movimiento horizontal del aire que transporta partículas como arena o polvo.','MEDIA','Protección civil'),
(30,'Civil Protection','20301','INCENDIO DE CASA HABITACIÓN',NULL,'ALTA','Protección civil'),
(31,'Civil Protection','20302','INCENDIO EN ESCUELA',NULL,'ALTA','Protección civil'),
(32,'Civil Protection','20303','INCENDIO DE VEHÍCULO',NULL,'ALTA','Protección civil'),
(33,'Civil Protection','20304','INCENDIO DE COMERCIO',NULL,'ALTA','Protección civil'),
(34,'Civil Protection','20305','INCENDIO DE EDIFICIO',NULL,'ALTA','Protección civil'),
(35,'Civil Protection','20306','INCENDIO A BORDO DE EMBARCACIÓN',NULL,'ALTA','Protección civil'),
(36,'Civil Protection','20307','INCENDIO FORESTAL',NULL,'ALTA','Protección civil'),
(37,'Civil Protection','20308','QUEMA URBANA',NULL,'ALTA','Protección civil'),
(38,'Civil Protection','20309','QUEMA AGROPECUARIA',NULL,'ALTA','Protección civil'),
(39,'Civil Protection','20310','INCENDIO DE FÁBRICA O INDUSTRIA',NULL,'ALTA','Protección civil'),
(40,'Civil Protection','20311','OTROS INCENDIOS',NULL,'ALTA','Protección civil'),
(41,'Medical','10101','Accidente acuático con persona(s) lesionada(s)','Acontecimiento relacionado con el medio acuático; es decir, suscitado en mar, piscina/alberca, lago, río y/o presas donde haya personas lesionadas.','ALTA','Medico'),
(42,'Medical','10102','Accidente de aeronave con personas lesionadas','Todo suceso donde una o más personas a bordo de una aeronave, resultan lesionadas.','ALTA','Medico'),
(43,'Medical','10103','Accidente de motocicleta con persona(s) lesionada(s)','Todo suceso relacionado con un vehículo (de dos, tres ruedas o cuatrimoto) impulsado por un motor y en donde resulta una o más personas con lesiones.','ALTA','Medico'),
(44,'Medical','10104','Accidente de vehículo automotor con persona(s) lesionada(s)','Hecho de tránsito de vehículo automotor en donde resultan personas lesionadas, incluye choques, volcaduras, impacto contra semovientes (animales) o impacto contra objeto fijo.','ALTA','Medico'),
(45,'Medical','10105','Accidente ferroviario con personas lesionadas','Hecho de tránsito en el que se ven involucrados los vehículos que circulan en las vías del sistema ferroviario, ya sea de servicio de carga o de pasajeros, y en el cual resultan personas lesionadas.','ALTA','Medico'),
(46,'Medical','10106','Accidente ferroviario con persona(s) fallecida(s)','Suceso en el que se ven involucrados los vehículos que circulan en las vías del sistema ferroviario, en servicio de carga o pasajeros, y en el cual resultan personas fallecidas.','ALTA','Medico'),
(47,'Medical','10107','Accidente múltiple con persona(s) lesionada(s)','Hecho de tránsito que ocurre sobre la vía pública... en el cual resultan personas lesionadas.','ALTA','Medico'),
(48,'Medical','10108','Accidente múltiple con persona(s) fallecida(s)','Hecho de tránsito que ocurre sobre la vía pública... en el cual resultan personas fallecidas.','ALTA','Medico'),
(49,'Medical','10109','Accidente de transporte de pasajeros con persona(s) lesionada(s)','Hecho de tránsito en el que se ve involucrado vehículo designado para el transporte de pasajeros y en el cual se presentan una o más personas lesionadas.','ALTA','Medico'),
(50,'Medical','10110','Accidente de transporte de pasajeros con persona(s) fallecida(s)','Acontecimiento que comprende la colisión de uno o más vehículos, uno de los cuales es designado para el transporte de pasajeros, en el cual se presentan una o más personas fallecidas.','ALTA','Medico'),
(51,'Medical','10111','Accidente de motocicleta con persona(s) fallecida(s)','Todo suceso relacionado con un vehículo... en donde resultan una o más personas fallecidas.','ALTA','Medico'),
(52,'Medical','10112','Accidente de vehículo automotor con persona(s) fallecida(s)','Hecho de tránsito de vehículo automotor en donde resultan personas fallecidas...','ALTA','Medico'),
(53,'Medical','10113','Accidente de aeronave con persona(s) fallecida(s)','Todo suceso donde una o más personas a bordo de una aeronave, resultan fallecidas.','ALTA','Medico'),
(54,'Medical','10114','Accidente de embarcaciones con persona(s) lesionada(s)','Acontecimiento relacionado con el medio acuático; que ocurre a bordo de una embarcación o entre embarcaciones y del cual resultan una o más personas lesionadas.','ALTA','Medico'),
(55,'Medical','10115','Accidente de embarcaciones con persona(s) fallecida(s)','Acontecimiento relacionado con el medio acuático; que ocurre a bordo de una embarcación y del cual resultan una o más personas fallecidas.','ALTA','Medico'),
(56,'Medical','10116','Atropellamiento con persona(s) lesionada(s)','Hecho de tránsito en que ocurre un impacto entre un vehículo... provocando lesiones al peatón y/o ciclista.','ALTA','Medico'),
(57,'Medical','10117','Accidente acuático con persona fallecida','Acontecimiento relacionado con el medio acuático... donde haya personas fallecidas.','ALTA','Medico'),
(58,'Medical','10118','Accidentes con materiales peligrosos','Eventos de liberación accidental, fuga, derrame, explosión y/o incendio con materiales peligrosos que afectan la vida, salud o medio ambiente.','ALTA','Medico'),
(59,'Medical','10119','Accidentes con materiales radiactivos','Emisión accidental de materiales radiactivos susceptible de perjudicar la salud pública o el medio ambiente.','ALTA','Medico'),
(60,'Medical','10120','Accidentes con riesgo biológico infecto-contagioso','Incidente con exposición a microorganismos... que puedan provocar enfermedades.','ALTA','Medico'),
(61,'Medical','10121','Otros accidentes con personas lesionadas','Referencia a otros accidentes diversos con una o más personas lesionadas.','ALTA','Medico'),
(62,'Medical','10122','Accidente de autotransporte de carga con personas lesionadas','Hecho de tránsito en servicios de carga... con personas lesionadas.','ALTA','Medico'),
(63,'Medical','10123','Accidente de autotransporte de carga con personas fallecidas','Hecho de tránsito en servicios de carga... con personas fallecidas.','ALTA','Medico'),
(64,'Medical','10124','Atropellamiento con personas fallecidas','Hecho de tránsito... provocando la muerte del peatón y/o ciclista.','ALTA','Medico'),
(65,'Medical','10125','Personas fallecidas por electrocución','Daño por corriente eléctrica que provoca la muerte... puede ser por rayo o accidente eléctrico.','ALTA','Medico'),
(66,'Medical','10126','Personas fallecidas por quemaduras','Lesiones en piel y tejidos causadas por calor, frío, radiación, químicos... que provocan la muerte.','ALTA','Medico'),
(67,'Medical','10127','Accidente de vehículos de tracción humana con lesionados','Accidente con bicicletas, triciclos, scooters, etc. con personas lesionadas.','ALTA','Medico'),
(68,'Medical','10201','Ahogamiento','Sofocación por sumersión/inmersión en líquido. Puede causar pérdida de conciencia o muerte.','ALTA','Medico'),
(69,'Medical','10202','Amputación','Separación total o parcial de una extremidad por evento traumático.','ALTA','Medico'),
(70,'Medical','10203','Asfixia','Fallo en la respiración por falta de oxígeno o vías obstruidas.','ALTA','Medico'),
(71,'Medical','10204','Persona lesionada por caída','Pérdida de equilibrio involuntaria que causa lesión.','ALTA','Medico'),
(72,'Medical','10205','Persona lesionada por corriente eléctrica','Daño al cuerpo por contacto con corriente eléctrica.','ALTA','Medico'),
(73,'Medical','10206','Fractura/traumatismo en extremidades','Pérdida de continuidad del hueso o lesión como esguince o torcedura.','ALTA','Medico'),
(74,'Medical','10207','Hemorragia','Pérdida de sangre interna o externa por ruptura de vasos.','ALTA','Medico'),
(75,'Medical','10208','Persona lesionada por arma blanca','Traumatismo por objeto cortante o punzante.','ALTA','Medico'),
(76,'Medical','10209','Persona lesionada por proyectil de arma de fuego','Lesión por impacto de proyectiles de armas.','ALTA','Medico'),
(77,'Medical','10210','Mordedura de animal','Lesión por mordedura de animal, doméstico o salvaje.','ALTA','Medico'),
(78,'Medical','10211','Persona lesionada por quemaduras','Lesión en piel por calor, frío, radiación, químicos, etc.','ALTA','Medico'),
(79,'Medical','10213','Traumatismo de cráneo','Lesión estructural o funcional del cráneo por fuerza externa.','ALTA','Medico'),
(80,'Medical','10214','Traumatismo de tórax','Lesiones en el pecho o espalda por fuerzas externas.','ALTA','Medico'),
(81,'Medical','10215','Traumatismo abdominal','Lesión en órganos abdominales por fuerza externa.','ALTA','Medico'),
(82,'Medical','10216','Traumatismo genital y/o urinario','Lesión en órganos del aparato genitourinario.','ALTA','Medico'),
(83,'Medical','10217','Congelamiento/condiciones ambientales','Lesiones por exposición prolongada al frío extremo.','ALTA','Medico'),
(84,'Medical','10218','Hipotermia','Disminución peligrosa de la temperatura corporal bajo 35°C.','ALTA','Medico'),
(85,'Medical','10219','Persona fallecida de causa traumática','Muerte atribuible a incidentes traumáticos no clasificados.','MEDIA','Medico'),
(86,'Medical','10220','Otros incidentes médicos traumáticos','Lesiones múltiples causadas por eventos traumáticos no clasificados.','ALTA','Medico'),
(87,'Medical','10221','Atragantamiento','Obstrucción de vías respiratorias por alimentos u objetos.','ALTA','Medico'),
(88,'Medical','10222','Persona lesionada por objeto contundente','Traumatismo por palos, piedras, tubos, etc.','ALTA','Medico'),
(89,'Medical','10223','Persona fallecida por asfixia','Muerte por trastorno respiratorio (hipoxia/anoxia).','ALTA','Medico'),
(90,'Medical','10224','Deshidratación','Pérdida peligrosa de líquidos por enfermedad o calor.','MEDIA','Medico'),
(91,'Medical','10225','Persona lesionada por riña/alteración del orden público','Lesión durante disturbios o riñas con o sin armas.','ALTA','Medico'),
(92,'Medical','10226','Persona fallecida por proyectil de arma de fuego','Muerte por proyectiles de armamento civil o militar.','ALTA','Medico'),
(93,'Medical','10227','Persona fallecida por arma blanca','Muerte por traumatismo por objeto cortante o punzante.','ALTA','Medico'),
(94,'Medical','10228','Persona fallecida por ahogamiento','Muerte por sumersión/inmersión en líquido.','ALTA','Medico'),
(95,'Medical','10229','Persona con golpe de calor','Trastorno por exceso de calor en el cuerpo.','ALTA','Medico'),
(96,'Medical','10301','TRABAJO DE PARTO',NULL,'ALTA','Medico'),
(97,'Medical','10302','AMENAZA DE ABORTO',NULL,'ALTA','Medico'),
(98,'Medical','10303','URGENCIA EN PACIENTE EMBARAZADA',NULL,'ALTA','Medico'),
(99,'Medical','10304','INFARTO CEREBRAL',NULL,'ALTA','Medico'),
(100,'Medical','10305','DIFICULTAD RESPIRATORIA/URGENCIA RESPIRATORIA',NULL,'ALTA','Medico'),
(101,'Medical','10306','INTOXICACIÓN ETÍLICA',NULL,'ALTA','Medico'),
(102,'Medical','10307','CONVULSIONES',NULL,'ALTA','Medico'),
(103,'Medical','10308','PERSONA INCONSCIENTE/URGENCIA NEUROLÓGICA',NULL,'ALTA','Medico'),
(104,'Medical','10309','ENVENENAMIENTO POR ANIMAL DE PONZOÑA',NULL,'ALTA','Medico'),
(105,'Medical','10310','URGENCIA POR ENFERMEDAD GENERAL',NULL,'ALTA','Medico'),
(106,'Medical','10311','DOLOR ABDOMINAL/URGENCIA ABDOMINAL',NULL,'ALTA','Medico'),
(107,'Medical','10312','DESCOMPENSACIÓN DE LA DIABETES/DESHIDRATACIÓN',NULL,'ALTA','Medico'),
(108,'Medical','10313','PARO CARDIORRESPIRATORIO',NULL,'ALTA','Medico'),
(109,'Medical','10314','INFARTO/URGENCIA CARDIOLÓGICA',NULL,'ALTA','Medico'),
(110,'Medical','10315','INTOXICACIÓN/SOBREDOSIS/ENVENENAMIENTO POR SUSTANCIAS',NULL,'ALTA','Medico'),
(111,'Medical','10316','OTROS INCIDENTES MÉDICOS CLÍNICOS',NULL,'ALTA','Medico'),
(112,'Medical','10317','FALLECIDO DE CAUSA NATURAL',NULL,'BAJA','Medico'),
(113,'Medical','10318','PERSONA EN CRISIS POR TRASTORNO MENTAL',NULL,'MEDIA','Medico'),
(114,'Medical','10319','EPIDEMIAS',NULL,'ALTA','Medico'),
(115,'Assistance','50101','CONCENTRACIÓN PACÍFICA DE PERSONAS','Concentración de un grupo de personas sin desarrollar conductas de violencia.','BAJA','Asistencia'),
(116,'Assistance','50102','TENTATIVA DE ROBO','Acción cometida, pero no consumada, por una o más personas, con el fin de apoderarse de bienes muebles.','MEDIA','Asistencia'),
(117,'Assistance','50103','EXTRAVÍO DE PLACA','Reporte que realiza una persona para informar de la pérdida de una placa que identifica un vehículo.','BAJA','Asistencia'),
(118,'Assistance','50104','FRAUDE','Obtener ilícitamente una cosa o alcanzar un lucro indebido para sí o para otro, engañando a la víctima o aprovechándose del error o la ignorancia.','BAJA','Asistencia'),
(119,'Assistance','50105','RUIDO EXCESIVO','Actos en los que se turba la tranquilidad de los vecinos con ruidos, gritos, aparatos musicales o electrónicos de sonido u otros semejantes.','BAJA','Asistencia'),
(120,'Assistance','50106','USURPACIÓN DE IDENTIDAD/FUNCIONES','Cuando un individuo suplanta o se apropia de la identidad o funciones de otra persona con fines ilícitos.','BAJA','Asistencia'),
(121,'Assistance','50107','ABUSO DE CONFIANZA','Disposición indebida para sí o para otro de una cosa ajena mueble, cuya tenencia fue cedida pero no el dominio.','BAJA','Asistencia'),
(122,'Assistance','50108','ABUSO DE AUTORIDAD','Empleo ilegal de la fuerza pública, violencia, vejación, humillación o insulto por agentes de autoridad.','MEDIA','Asistencia'),
(123,'Assistance','50109','INGRESO A HOSPITAL','Reporte del ingreso de una persona a un hospital por parte del personal médico, solicitando la presencia de la autoridad.','MEDIA','Asistencia'),
(124,'Assistance','50110','INTENTO DE FRAUDE','Intento de obtener ilícitamente una cosa o lucro indebido, mediante engaño o aprovechamiento del error o ignorancia de la víctima.','MEDIA','Asistencia'),
(125,'Assistance','50201','HALLAZGO DE CADÁVER / RESTOS HUMANOS','Reclasificado al Tipo Seguridad, Subtipo Notificación de Hallazgo, número 31201.','BAJA','Asistencia'),
(126,'Assistance','50202','HALLAZGO DE ARMA','Reclasificado al Tipo Seguridad, Subtipo Notificación de Hallazgo, número 31202.','BAJA','Asistencia'),
(127,'Assistance','50203','HALLAZGO DE VEHÍCULO ROBADO','Reclasificado al Tipo Seguridad, Subtipo Notificación de Hallazgo, número 31203.','BAJA','Asistencia'),
(128,'Assistance','50301','APOYO A LA POBLACIÓN','Intervención de personal de seguridad pública, protección civil u otras corporaciones para atender una solicitud ciudadana.','BAJA','Asistencia'),
(129,'Assistance','50302','PERSONA LOCALIZADA','Notificación de que se tiene información sobre una persona con reporte de extravío o no localizada.','BAJA','Asistencia'),
(130,'Assistance','50303','MALTRATO DE ANIMALES','Hechos que causan dolor, sufrimiento o daño a la salud del animal, o lo sobreexplotan.','MEDIA','Asistencia'),
(131,'Assistance','50304','PERSONA EN SITUACIÓN DE CALLE','Persona que tiene como habitación la vía pública.','BAJA','Asistencia'),
(132,'Assistance','50305','SOLICITUD DE RONDÍN','Solicitud de presencia de personal de seguridad pública en un espacio específico.','BAJA','Asistencia'),
(133,'Assistance','50306','QUEJA CONTRA SERVIDORES PÚBLICOS','Reporte de inconformidad hacia la atención de un servidor público, no asociado al Servicio de Emergencia 9-1-1.','BAJA','Asistencia'),
(134,'Public Services','40101','BARDA CAÍDA O POR CAER','Cuando una barda cae o está por caerse por su propio peso o por una fuerza externa y representa un riesgo para la población.','MEDIA','Servicios publicos'),
(135,'Public Services','40102','POSTE CAÍDO O POR CAER','Cuando un poste cae por la acción de su propio peso, o por fuerza externa; o bien se encuentra por caer debido al deterioro del mismo.','MEDIA','Servicios publicos'),
(136,'Public Services','40103','FALLA DE ALUMBRADO PÚBLICO','Defecto en la iluminación de vías públicas o parques, que puede ocasionar accidentes o delitos por la falta de luz.','MEDIA','Servicios publicos'),
(137,'Public Services','40104','FALLAS DE SEMÁFORO','Interrupción del mecanismo electrónico de un semáforo que dificulta la circulación continua.','MEDIA','Servicios publicos'),
(138,'Public Services','40105','ALCANTARILLA SIN TAPA','Abertura sin tapa en sistema de drenaje, que representa un riesgo de accidentes.','MEDIA','Servicios publicos'),
(139,'Public Services','40106','CABLES COLGANDO O CAÍDOS','Cables suspendidos o caídos que pueden causar accidentes o heridas.','MEDIA','Servicios publicos'),
(140,'Public Services','40107','CORTO CIRCUITO','Fenómeno eléctrico por contacto entre dos puntos con diferencia de potencial, que produce corrientes peligrosas.','MEDIA','Servicios publicos'),
(141,'Public Services','40108','GRAVA SUELTA O MATERIAL ESPARCIDO','Material suelto en caminos que puede causar accidentes a vehículos, peatones o ciclistas.','MEDIA','Servicios publicos'),
(142,'Public Services','40109','AFECTACIÓN DE LOS SERVICIOS BÁSICOS O INFRAESTRUCTURA ESTRATÉGICA','Fallas en servicios esenciales como agua, drenaje o infraestructura crítica cuya pérdida afecta gravemente a la población.','ALTA','Servicios publicos'),
(143,'Public Services','40110','VIALIDAD EN MAL ESTADO','Vías públicas deterioradas que dificultan el tránsito seguro.','MEDIA','Servicios publicos'),
(144,'Public Services','40111','FUGA DE AGUA','Pérdida de agua desde un sistema de conducción o almacenamiento de forma descontrolada.','ALTA','Servicios publicos'),
(145,'Public Services','40112','CAÍDA DE TECHO, CASA, EDIFICIO O CONSTRUCCIÓN','Colapso de estructuras que representan riesgo para las personas.','MEDIA','Servicios publicos'),
(146,'Public Services','40113','DAÑO ESTRUCTURAL Y/O AGRIETAMIENTOS DE EDIFICACIONES','Deterioro físico o estructural de edificios que pone en riesgo a los ocupantes.','MEDIA','Servicios publicos'),
(147,'Public Services','40114','ALCANTARILLA OBSTRUIDA','Drenajes taponados que pueden provocar accidentes o problemas viales.','ALTA','Servicios publicos'),
(148,'Public Services','40115','ANIMAL MUERTO EN VÍA PÚBLICA','Presencia de un animal muerto en la vía que puede causar accidentes o molestias.','MEDIA','Servicios publicos'),
(149,'Security','30101','VEHÍCULO ABANDONADO','Acto de dejar de lado o descuidar cualquier vehículo.','MEDIA','Seguridad'),
(150,'Security','30102','OBJETO SOSPECHOSO O PELIGROSO','Objeto dejado en la vía pública que puede causar un daño a la población, los inmuebles, el transporte o las vías de comunicación.','MEDIA','Seguridad'),
(151,'Security','30103','PERSONA TIRADA EN VÍA PÚBLICA','Persona inmóvil que yace en vía pública y de la cual se desconoce su estado de salud o si está con vida y no tiene huellas de violencia.','MEDIA','Seguridad'),
(152,'Security','30201','DETONACIÓN DE EXPLOSIVOS','Activación de sustancias explosivas que liberan energía súbitamente, causando sobrepresión, llama y ruido.','ALTA','Seguridad'),
(153,'Security','30202','DETONACIÓN POR ARMA DE FUEGO','Presenciar, ver o escuchar la detonación de un arma de fuego sin personas lesionadas identificadas.','ALTA','Seguridad'),
(154,'Security','30203','PERSONA ARMADA EN ESCUELA','Persona con arma en una comunidad escolar, poniendo en riesgo la seguridad.','ALTA','Seguridad'),
(155,'Security','30204','PORTACIÓN DE ARMAS DE FUEGO O CARTUCHOS','Individuo con armas de fuego o cartuchos sin demostrar permiso legal.','MEDIA','Seguridad'),
(156,'Security','30205','DETONACIÓN DE COHETES O FUEGOS ARTIFICIALES','Explosión de fuegos artificiales con propiedades sonoras, luminosas o caloríficas.','MEDIA','Seguridad'),
(157,'Security','30206','DETONACIÓN DE ARMA DE FUEGO EN ESCUELA','Detonación de arma de fuego en un centro escolar.','ALTA','Seguridad'),
(158,'Security','30207','TRÁFICO DE ARMAS O EXPLOSIVOS','Trasiego o intercambio de armas o explosivos prohibidos o de uso exclusivo del ejército.','ALTA','Seguridad'),
(159,'Security','30208','ACCIDENTE CON COHETES O FUEGOS ARTIFICIALES','Explosión accidental de fuegos artificiales, sin personas lesionadas.','ALTA','Seguridad'),
(160,'Security','30209','PORTACIÓN DE ARMA BLANCA','Persona portando arma blanca que representa un peligro para la población.','ALTA','Seguridad'),
(161,'Security','30301','AERONAVE SOSPECHOSA','Vuelo sospechoso en condiciones anormales o zonas no autorizadas.','MEDIA','Seguridad'),
(162,'Security','30302','ARRANCONES O CARRERAS DE VEHÍCULOS','Competencia o exhibición de vehículos en la vía pública.','MEDIA','Seguridad'),
(163,'Security','30303','BLOQUEO O CORTE DE VÍAS DE COMUNICACIÓN','Hechos que interrumpen o alteran el funcionamiento de vías de transporte.','MEDIA','Seguridad'),
(164,'Security','30304','CIRCULAR EN SENTIDO CONTRARIO','Transitar en sentido contrario, poniendo en riesgo a otros.',NULL,'Seguridad'),
(165,'Security','30305','VEHÍCULO A EXCESO DE VELOCIDAD','Conducción de un vehículo automotor por encima de los límites de velocidad establecidos.','MEDIA','Seguridad'),
(166,'Security','30306','VEHÍCULO EN HUIDA','Vehículo que se da a la fuga tras cometer un acto ilícito o infracción, poniendo en riesgo a otros.','MEDIA','Seguridad'),
(167,'Security','30307','VEHÍCULO SOSPECHOSO','Vehículo posiblemente relacionado con la comisión de un delito.','MEDIA','Seguridad'),
(168,'Security','30308','VEHÍCULO DESCOMPUESTO','Vehículo detenido aparentemente por falla mecánica.','MEDIA','Seguridad'),
(169,'Security','30309','ACCIDENTE DE TRÁNSITO SIN PERSONAS LESIONADAS','Hecho de tránsito en vía pública sin lesionados, causado por factores humanos, mecánicos, ambientales o de infraestructura.','ALTA','Seguridad'),
(170,'Security','30310','OTRAS FALTAS AL REGLAMENTO DE TRÁNSITO','Faltas al reglamento de tránsito que representan riesgo para personas o bienes.','BAJA','Seguridad'),
(171,'Security','30311','JUGADORES EN VÍA PÚBLICA','Personas jugando deportes en la vía pública, obstruyéndola.','MEDIA','Seguridad'),
(172,'Security','30312','ACCIDENTE DE MOTOCICLETA SIN PERSONAS LESIONADAS','Suceso relacionado con motocicleta o cuatrimoto sin personas lesionadas.','MEDIA','Seguridad'),
(173,'Security','30313','ACCIDENTE DE AERONAVE SIN PERSONAS LESIONADAS','Suceso con daños materiales en aeronave sin personas lesionadas.','ALTA','Seguridad'),
(174,'Security','30314','ACCIDENTE DE AUTOTRANSPORTE DE CARGA SIN PERSONAS LESIONADAS','Hecho de tránsito en transporte de carga sin personas lesionadas.','MEDIA','Seguridad'),
(175,'Security','30315','ACCIDENTE DE AUTOTRANSPORTE DE PASAJEROS SIN PERSONAS LESIONADAS','Hecho de tránsito con vehículo de transporte de pasajeros sin lesionados.','ALTA','Seguridad'),
(176,'Security','30316','ROBO U OBSTRUCCIÓN CASETA DE PEAJE','Robo de cuotas o impedimento de paso en caseta de peaje ajeno al personal.','ALTA','Seguridad'),
(177,'Security','30401','OTRAS ALARMAS DE EMERGENCIAS ACTIVADAS','Alarma activada ante la posible comisión de delito o incidente en casa o comercio.','ALTA','Seguridad'),
(178,'Security','30402','BOTÓN DE ALERTA / ALARMA DE EMERGENCIA ACTIVADO','Botón activado ante la posible comisión de delito o incidente.','ALTA','Seguridad'),
(179,'Security','30403','CRISTALAZO O ROBO AL INTERIOR DE VEHÍCULO','Daño a cristales o cerraduras de vehículo para robar bienes del interior.','ALTA','Seguridad'),
(180,'Security','30404','DAÑOS A PROPIEDAD AJENA','Disminución patrimonial por daño a bienes muebles o inmuebles.','MEDIA','Seguridad'),
(181,'Security','30405','DESPOJO','Usurpación o ocupación ilegítima de inmueble que corresponde a otra persona.','MEDIA','Seguridad'),
(182,'Security','30406','EXTORSIÓN O INTENTO DE EXTORSIÓN (NO TELEFÓNICA)','Obligación ilícita de dar, hacer o tolerar algo, con fines de lucro o daño patrimonial.','MEDIA','Seguridad'),
(183,'Security','30407','EXTORSIÓN TELEFÓNICA','Llamada anónima con amenazas o manipulación para obtener beneficio económico.','MEDIA','Seguridad'),
(184,'Security','30408','ACTIVACIÓN DE ALARMA EN ESCUELA','Alarma activada ante delito o incidente en centro escolar.','MEDIA','Seguridad'),
(185,'Security','30409','ROBO DE COMBUSTIBLE','Apoderamiento ilegal de combustible.','ALTA','Seguridad'),
(186,'Security','30410','ROBO A CAJERO AUTOMÁTICO','Robo total o parcial de cajero automático o su contenido.','MEDIA','Seguridad'),
(187,'Security','30411','ROBO DE AUTOPARTES O ACCESORIOS','Apoderamiento de partes o accesorios de un vehículo automotor.','MEDIA','Seguridad'),
(188,'Security','30412','Robo de ganado o productos agropecuarios','El que se apodere, ilegítimamente, total o parcialmente de ganado vacuno, ovino, equino, caprino, porcino o auquénido o productos agropecuarios.','MEDIA','Seguridad'),
(189,'Security','30413','Robo a casa habitación con violencia','Acción que comete una o más personas al apoderarse de bienes muebles, invadiendo propiedades privadas con una forma de acción violenta.','ALTA','Seguridad'),
(190,'Security','30414','Robo a casa habitación sin violencia','Acción que comete una persona al apoderarse de pertenencias ajenas, invadiendo propiedades privadas con una forma de acción no violenta.','ALTA','Seguridad'),
(191,'Security','30415','Robo a escuela con violencia','Es el apoderamiento en un plantel escolar de una cosa ajena mueble, sin derecho y sin consentimiento de quien pueda disponer legalmente de la cosa, haciendo uso de la violencia.','ALTA','Seguridad'),
(192,'Security','30416','Robo a escuela sin violencia','Es el apoderamiento en un plantel escolar de una cosa ajena mueble, sin derecho y sin consentimiento de quien pueda disponer legalmente de la cosa, sin hacer uso de la violencia.','MEDIA','Seguridad'),
(193,'Security','30417','Robo a gasolinera con violencia','Acción cometida por una o más personas con el fin de apoderarse de bienes muebles ajenos, en específico contra una estación gasolinera, con una forma de acción violenta.','ALTA','Seguridad'),
(194,'Security','30418','Robo a gasolinera sin violencia','Acción cometida por una o más personas con el fin de apoderarse de pertenencias ajenas, en específico contra una estación gasolinera con una forma de acción no violenta.','MEDIA','Seguridad'),
(195,'Security','30419','Robo a negocio con violencia','Acción cometida por una o más personas con el fin de apoderarse de pertenencias ajenas, contra un negocio o comercio establecido con una forma de acción violenta.','ALTA','Seguridad'),
(196,'Security','30420','Robo a negocio sin violencia','Acción cometida por una o más personas con el fin de apoderarse de pertenencias ajenas, contra un negocio o comercio establecido con una forma de acción no violenta.','MEDIA','Seguridad'),
(197,'Security','30421','Robo a transeúnte con violencia','Acción cometida por una o más personas con el fin de apoderarse de un bien mueble propiedad de una persona que se encuentra en la vía pública o espacio abierto, con una forma de acción violenta.','ALTA','Seguridad'),
(198,'Security','30422','Robo a transeúnte sin violencia','Acción cometida por una o más personas con el fin de apoderarse de un bien mueble propiedad de una persona que se encuentra en la vía pública o espacio abierto, con una forma de acción no violenta.','MEDIA','Seguridad'),
(199,'Security','30423','Robo en transporte colectivo público o privado con violencia','Apoderarse de un bien mueble, sin el consentimiento de quien legítimamente pueda otorgarlo, con uso de la violencia, encontrándose la víctima en un transporte colectivo público o privado.','ALTA','Seguridad'),
(200,'Security','30424','Robo en transporte colectivo público o privado sin violencia','Apoderarse de un bien mueble, sin el consentimiento de quien legítimamente pueda otorgarlo, sin uso de la violencia, encontrándose la víctima en un transporte colectivo público o privado.','MEDIA','Seguridad'),
(201,'Security','30425','Robo en transporte público individual con violencia','Apoderarse de un bien mediante una forma de acción violenta sin el permiso de quien podría legalmente otorgarlo, encontrándose la víctima en un vehículo o transporte público individual de personas o cosas, cuando este servicio se preste o con motivo del mismo.','ALTA','Seguridad'),
(202,'Security','30426','Robo en transporte público individual sin violencia','Apoderarse de un bien mediante una forma de acción no violenta sin el permiso de quien podría legalmente otorgarlo, encontrándose la víctima en un vehículo o transporte público individual de personas o cosas, cuando este servicio se preste o con motivo del mismo.','MEDIA','Seguridad'),
(203,'Security','30427','Robo a transportista o vehículo comercial con violencia','Acción cometida por una o más personas con el fin de apoderarse de bienes ajenos, en específico del hurto a los servicios de autotransporte, sea de servicio de carga, paquetería y mensajería, transporte privado con fines de cobro, que se cometa violentamente.','ALTA','Seguridad'),
(204,'Security','30428','Robo a transportista o vehículo comercial sin violencia','Acción cometida por una o más personas con el fin de apoderarse de bienes ajenos, en específico del hurto a los servicios de autotransporte, sea de servicio de carga, paquetería y mensajería, transporte privado con fines de cobro, que se cometa de forma no violenta.','MEDIA','Seguridad'),
(205,'Security','30429','Robo de vehículo particular con violencia','Cuando el artículo hurtado sea un medio de transporte automotor terrestre particular, que sea objeto de registro conforme a la ley en la materia, con una forma de acción violenta.','ALTA','Seguridad'),
(206,'Security','30430','Robo de vehículo particular sin violencia','Cuando el artículo hurtado sea un medio de transporte automotor terrestre particular, que sea objeto de registro conforme a la ley en la materia, sin violencia.','MEDIA','Seguridad'),
(207,'Security','30431','Robo en carretera con violencia','Hecho cometido en vías de comunicación como carreteras o autopistas, por una o más personas, con el fin de apoderarse de pertenencias ajenas mediante una forma violenta.','ALTA','Seguridad'),
(208,'Security','30432','Robo en carretera sin violencia','Hecho cometido en vías de comunicación como carreteras o autopistas, por una o más personas, con el fin de apoderarse de pertenencias ajenas mediante una forma no violenta.','MEDIA','Seguridad'),
(209,'Security','30433','Robo a banco con violencia','Acción cometida por una o más personas con el fin de apoderarse de bienes muebles, contra una institución financiera o banco de forma violenta.','ALTA','Seguridad'),
(210,'Security','30434','Robo a banco sin violencia','Acción cometida por una o más personas con el fin de apoderarse de bienes muebles, contra una institución financiera o banco de forma no violenta.','MEDIA','Seguridad'),
(211,'Security','30435','Robo a casa de cambio con violencia','Acción cometida por una o más personas con el fin de apoderarse de bienes muebles, contra una casa de cambio de forma violenta.','ALTA','Seguridad'),
(212,'Security','30436','Robo a casa de cambio sin violencia','Acción cometida por una o más personas con el fin de apoderarse de bienes muebles, contra una casa de cambio de forma no violenta.','MEDIA','Seguridad'),
(213,'Security','30437','Robo a empresa de traslado de valores con violencia','Acción cometida por una o más personas con el fin de apoderarse de bienes muebles, contra empresas especialistas en el manejo, custodia y traslado de bienes, documentos y dinero en efectivo de forma violenta.','ALTA','Seguridad'),
(214,'Security','30438','Robo a empresa de traslado de valores sin violencia','Acción cometida por una o más personas con el fin de apoderarse de bienes muebles, contra empresas especialistas en el manejo, custodia y traslado de bienes, documentos y dinero en efectivo de forma no violenta.','MEDIA','Seguridad'),
(215,'Security','30439','Robo a ferrocarril','Hecho de quitar o modificar sin la debida autorización uno o más elementos del sistema ferroviario o de la mercancía transportada.','ALTA','Seguridad'),
(216,'Security','30440','Robo de placa','Apoderamiento con ánimo de dominio y sin consentimiento de quien legalmente pueda otorgarlo de placas de circulación.','MEDIA','Seguridad'),
(217,'Security','30441','Robo a transporte escolar con violencia','Acción cometida por una o más personas con el fin de apoderarse de bienes muebles, contra un transporte escolar de forma violenta.','ALTA','Seguridad'),
(218,'Security','30442','Robo a transporte escolar sin violencia','Acción cometida por una o más personas con el fin de apoderarse de bienes muebles, contra un transporte escolar de forma no violenta.','MEDIA','Seguridad'),
(219,'Security','30443','Robo a embarcaciones y piratería','Acción cometida por una o más personas con el fin de apoderarse de bienes muebles, contra un vehículo marítimo o fluvial.','MEDIA','Seguridad'),
(220,'Security','30444','Transporte ilegal de combustible','Trasiego sin autorización de sustancias combustibles.','ALTA','Seguridad'),
(221,'Security','30445','Robo a templo religioso sin violencia','Acción cometida por una o más personas con el fin de apoderarse de bienes muebles de naturaleza asociada con algún culto religioso.','MEDIA','Seguridad'),
(222,'Security','30446','Otros actos relacionados con el patrimonio','Apropiación de bienes abandonados, ocultación de artículos robados, administración fraudulenta, operación con recursos de procedencia ilícita, etc.','MEDIA','Seguridad'),
(223,'Security','30447','Robo a templo religioso con violencia','Apoderamiento con violencia de bienes muebles relacionados con cultos religiosos.','ALTA','Seguridad'),
(224,'Security','30448','Secuestro virtual','Modalidad de extorsión telefónica que aísla a la víctima y extorsiona a sus familiares por un supuesto rescate.','ALTA','Seguridad'),
(225,'Security','30449','Toma clandestina de ductos (huachicoleo)','Apoderamiento de combustible mediante la perforación ilegal de ductos.','ALTA','Seguridad'),
(226,'Security','30450','Dinero falso','Reporte por haber recibido un pago con dinero falso.','MEDIA','Seguridad'),
(227,'Security','30451','Persona negándose a pagar','Solicitud de apoyo por negarse una persona a pagar por un servicio recibido.','MEDIA','Seguridad'),
(228,'Security','30452','Robo con violencia a conductor de vehículo particular','Robo violento a conductor o pasajero de un vehículo particular.','ALTA','Seguridad'),
(229,'Security','30453','Robo sin violencia a conductor de vehículo particular','Robo no violento a conductor o pasajero de un vehículo particular.','ALTA','Seguridad'),
(230,'Security','30454','Robo de material peligroso o radiactivo','Robo de contenedores u objetos con material peligroso o radiactivo.','ALTA','Seguridad'),
(231,'Security','30455','Bloqueo de entrada/salida de domicilio','Ocupación de un espacio que impide el acceso o salida de una vivienda.','MEDIA','Seguridad'),
(232,'Security','30456','Alarma de banco','Activación de alarma ante posible delito o siniestro en banco (incluye cajeros).','ALTA','Seguridad'),
(233,'Security','30457','Daños a dispositivos de monitoreo y alertamiento','Daño a cámaras, postes, botones de pánico u otros sistemas de seguridad pública.','ALTA','Seguridad'),
(234,'Security','30458','Robo a cuentahabiente y/o tarjetahabiente','Robo de bienes a persona que acudía o salía de una sucursal bancaria.','ALTA','Seguridad'),
(235,'Security','30459','Robo de animales','Robo de mascotas o animales de granja.','ALTA','Seguridad'),
(236,'Security','30460','Robo a repartidor con violencia','Robo violento a repartidor de productos para empresas o comercios.','ALTA','Seguridad'),
(237,'Security','30461','Robo a repartidor sin violencia','Robo no violento a repartidor.','ALTA','Seguridad'),
(238,'Security','30462','Robo de motocicleta con violencia','Robo de motocicleta utilizando violencia.','ALTA','Seguridad'),
(239,'Security','30463','Robo de motocicleta sin violencia','Robo de motocicleta sin violencia o sin que el propietario se percate.','MEDIA','Seguridad'),
(240,'Security','30464','Robo o extracción ilícita de material mineral','Extracción ilegal de minerales con potencial daño ambiental o humano.','ALTA','Seguridad'),
(241,'Security','30465','Detección de placa sobrepuesta','Vehículo con placas registradas para otro auto.','MEDIA','Seguridad'),
(242,'Security','30466','Detección de vehículo con reporte de robo','Identificación de vehículo robado.','ALTA','Seguridad'),
(243,'Security','30501','Abandono de persona','Dejar sin cuidado a un menor, enfermo o adulto mayor, con riesgo para su integridad.','ALTA','Seguridad'),
(244,'Security','30502','Violencia de pareja','Maltrato físico, sexual o emocional ejercido por la pareja o expareja.','ALTA','Seguridad'),
(245,'Security','30503','Violencia familiar','Maltrato físico, psicológico o abandono entre miembros de una familia.','ALTA','Seguridad'),
(246,'Security','30504','Otros actos relacionados con la familia','Cualquier otro acto que atente contra la familia no clasificado previamente.','ALTA','Seguridad'),
(247,'Security','30505','Maltrato de niñas, niños y adolescentes','Agresiones físicas o actos que causan dolor a menores.','ALTA','Seguridad'),
(248,'Security','30506','Maltrato de personas adultas mayores','Agresiones físicas a personas adultas mayores.','ALTA','Seguridad'),
(249,'Security','30601','NIÑA, NIÑO O ADOLESCENTE EXTRAVIADO','Niñas, niños o adolescentes que han desaparecido bajo circunstancias desconocidas. Incluye personas desorientadas, con enfermedades, discapacidades o condiciones que les impidan recordar dónde viven, quiénes son o cómo comunicarse con sus familias.','ALTA','Seguridad'),
(250,'Security','30602','PERSONA NO LOCALIZADA O DESAPARECIDA','Persona cuyo paradero es desconocido para sus allegados, y cuya ausencia puede estar o no relacionada con un delito.','ALTA','Seguridad'),
(251,'Security','30603','PRIVACIÓN DE LA LIBERTAD','Acción de limitar a alguien de su libertad ambulatoria en contra de su voluntad.','ALTA','Seguridad'),
(252,'Security','30604','REHENES','Persona capturada para obligar a otro individuo, organización o nación a cumplir ciertas condiciones.','ALTA','Seguridad'),
(253,'Security','30605','ROBO DE NIÑAS, NIÑOS O ADOLESCENTES','Sustracción u ocultamiento de un menor sin relación de parentesco ni consentimiento de quien ejerce derechos de custodia.','ALTA','Seguridad'),
(254,'Security','30606','PERSONA DETENIDA','Persona limitada en su libertad por la presunta comisión de un hecho ilícito.','ALTA','Seguridad'),
(255,'Security','30607','SUSTRACCIÓN, RETENCIÓN U OCULTAMIENTO DE NIÑAS, NIÑOS, ADOLESCENTES O PERSONAS INCAPACES','Separación unilateral e injustificada de un menor o persona incapaz por parte de quien tenga patria potestad, custodia o sea familiar.','ALTA','Seguridad'),
(256,'Security','30608','TRÁFICO DE NIÑAS, NIÑOS Y ADOLESCENTES','Traslado o entrega ilícita de menores para obtener un beneficio económico, incluso por quien tenga su custodia.','ALTA','Seguridad'),
(257,'Security','30609','OTROS ACTOS RELACIONADOS CON LA LIBERTAD PERSONAL','Conductas de privación ilegal de la libertad no clasificadas previamente, incluyendo fines sexuales.','ALTA','Seguridad'),
(258,'Security','30610','TENTATIVA DE PRIVACIÓN DE LA LIBERTAD','Intento no consumado de limitar la libertad ambulatoria de una persona.','MEDIA','Seguridad'),
(259,'Security','30611','NOTIFICACIÓN DE CIBER INCIDENTE','Actos digitales que afectan sistemas, redes o datos (ransomware, phishing, hacking, cracking), sin encuadrar en conductas previas.','MEDIA','Seguridad'),
(260,'Security','30612','NOTICIAS FALSAS','Difusión de información no autorizada para manipular, generar confusión o provocar el envío de corporaciones.','MEDIA','Seguridad'),
(261,'Security','30613','FRAUDE ELECTRÓNICO','Prácticas fraudulentas a través de medios electrónicos (tarjetas, compras en línea, estafas digitales).','ALTA','Seguridad'),
(262,'Security','30614','SEXTORSIÓN','Extorsión mediante obtención y uso de material sexual de la víctima como medio de presión para lograr un beneficio.','ALTA','Seguridad'),
(263,'Security','30615','ACOSO CIBERNÉTICO','Uso de tecnología (plataformas en línea y redes sociales) para acosar, intimidar, amenazar o difamar a una persona, mediante comportamientos hostiles y repetitivos.','MEDIA','Seguridad'),
(264,'Security','30616','PERSONA DESORIENTADA','Persona (adulto o menor) que no puede identificar tiempo y espacio, pero aún no ha sido reportada como extraviada.','MEDIA','Seguridad'),
(265,'Security','30701','ABUSO SEXUAL','Prácticas sexuales sin cópula (tocamientos, exhibición de actos sexuales, masturbación, etc.) realizadas sin consentimiento.','ALTA','Seguridad'),
(266,'Security','30702','ACOSO U HOSTIGAMIENTO SEXUAL','Conducta sexual no deseada que busca intimidar, humillar o asediar a una persona, con o sin relación jerárquica.','MEDIA','Seguridad'),
(267,'Security','30703','AFECTACIÓN A LA INTIMIDAD SEXUAL','Fabricación, publicación o difusión sin consentimiento de contenido audiovisual que atente contra la libertad sexual.','MEDIA','Seguridad'),
(268,'Security','30705','EXPLOTACIÓN DE NIÑAS, NIÑOS Y ADOLESCENTES','Comercialización o explotación sexual de menores, afectando su desarrollo psicosexual.','ALTA','Seguridad'),
(269,'Security','30706','TRATA DE NIÑAS, NIÑOS Y ADOLESCENTES','Captación o traslado de menores para explotación sexual (pornografía, turismo sexual, relaciones sexuales remuneradas).','ALTA','Seguridad'),
(270,'Security','30707','VIOLACIÓN','Penetración sexual no consentida, incluyendo por pareja íntima, bajo violencia o incapacidad para otorgar consentimiento.','ALTA','Seguridad'),
(271,'Security','30708','OTROS ACTOS RELACIONADOS CON LA LIBERTAD Y LA SEGURIDAD SEXUAL','Conductas que atentan contra la seguridad sexual no clasificadas anteriormente (pornografía, lenocinio, etc.).','ALTA','Seguridad'),
(272,'Security','30709','TRATA DE PERSONAS','Captación o traslado de personas con fines de explotación (sexual, laboral, tráfico de órganos, mendicidad forzada, etc.).','ALTA','Seguridad'),
(273,'Security','30710','TRÁFICO DE PERSONAS/INDOCUMENTADAS','Traslado de personas a otro país sin documentación, con el fin de obtener un lucro.','ALTA','Seguridad'),
(274,'Security','30711','CORRUPCIÓN DE PERSONAS MENORES DE EDAD O INCAPACES','Violencia para inducir a menores a actos delictivos o perjudiciales (alcohol, drogas, delitos, exhibicionismo, etc.).','ALTA','Seguridad'),
(275,'Security','30712','VIOLENCIA DIGITAL O MEDIÁTICA','Difusión de contenido íntimo sin consentimiento o promoción de violencia/estereotipos por medios digitales.','MEDIA','Seguridad'),
(276,'Security','30713','PORNOGRAFÍA INFANTIL','Fabricación o publicación de contenido audiovisual con menores de edad que atente contra la moral pública.','ALTA','Seguridad'),
(277,'Security','30714','EXPLOTACIÓN DE PERSONAS INCAPACITADAS O DISCAPACITADAS','Explotación sexual de personas con discapacidad intelectual o incapacidad de comprender el significado de los hechos.','ALTA','Seguridad'),
(278,'Security','30801','ACTOS DE COMERCIALIZACIÓN ILEGAL DE SANGRE, ÓRGANOS Y TEJIDOS HUMANOS','Obtención, uso o comercialización ilegal de órganos, sangre, tejidos, fetos o cadáveres humanos.','ALTA','Seguridad'),
(279,'Security','30802','ASOCIACIÓN DELICTUOSA O PANDILLERISMO','Agrupación con fines delictivos que altera la percepción de seguridad en espacios públicos o privados.','MEDIA','Seguridad'),
(280,'Security','30803','ENFRENTAMIENTO DE GRUPOS ARMADOS','Conflictos armados entre civiles o grupos insurrectos en el territorio nacional.','ALTA','Seguridad'),
(281,'Security','30804','TERRORISMO O ATENTADO','Actos violentos con intención de causar terror o presionar a autoridades/personas.','ALTA','Seguridad'),
(282,'Security','30805','AMENAZA DE BOMBA','Amenaza de daño por explosivos realizada por cualquier medio.','ALTA','Seguridad'),
(283,'Security','30806','OTROS ACTOS RELACIONADOS CON LA SEGURIDAD COLECTIVA','Conductas contra la sociedad no contempladas en otras categorías.','ALTA','Seguridad'),
(284,'Security','30807','MOTÍN','Concentración violenta de personas que perturban el orden público.','ALTA','Seguridad'),
(285,'Security','30808','VENTA CLANDESTINA DE PIROTECNIA, COHETES O FUEGOS ARTIFICIALES','Venta ilegal de productos detonantes o pirotécnicos sin autorización.','MEDIA','Seguridad'),
(286,'Security','30809','VENTA ILEGAL DE COMBUSTIBLE','Comercialización de combustibles sin permiso legal.','ALTA','Seguridad'),
(287,'Security','30810','AMENAZA DE BOMBA EN ESCUELA','Amenaza de explosivos específicamente en instalaciones escolares.','ALTA','Seguridad'),
(288,'Security','30811','AMENAZA A CIVILES, LOCALIDADES, CORPORACIONES O PERSONAS SERVIDORAS PÚBLICAS (PINTA O NARCOMANTA)','Amenaza manifestada públicamente mediante pintas o narcomantas contra personas o instituciones.','MEDIA','Seguridad'),
(289,'Security','30901','OTROS ACTOS RELACIONADOS CON LA VIDA Y LA INTEGRIDAD PERSONAL','Conductas delictivas relacionadas con privación ilegal de libertad no clasificadas previamente.','ALTA','Seguridad'),
(290,'Security','30903','VIOLENCIA CONTRA LAS MUJERES','Acción u omisión basada en género que causa daño físico, sexual, emocional, económico, patrimonial o la muerte. Incluye violencia económica y patrimonial.','ALTA','Seguridad'),
(291,'Security','30904','PERSONA SOSPECHOSA','Individuo que genera sospechas de realizar una mala acción.','MEDIA','Seguridad'),
(292,'Security','30905','AMENAZA DE SUICIDIO','Manifestación verbal o escrita de intención de suicidarse.','ALTA','Seguridad'),
(293,'Security','30906','HOMICIDIO','Privación de la vida de una persona.','ALTA','Seguridad'),
(294,'Security','30907','PERSONA AGRESIVA','Persona que intenta causar daño físico o emocional a otra mediante violencia verbal o física.','ALTA','Seguridad'),
(295,'Security','30908','SUICIDIO','Acto intencional de quitarse la vida.','ALTA','Seguridad'),
(296,'Security','30909','AGRESIÓN FÍSICA','Daño corporal intencionado por medio físico.','ALTA','Seguridad'),
(297,'Security','30910','ACOSO ESCOLAR (BULLYING)','Violencia repetida e intencionada contra un alumno, física o psicológica.','MEDIA','Seguridad'),
(298,'Security','30911','ACTOS RELACIONADOS CON MIGRANTES','Conductas que atentan contra la vida e integridad de personas migrantes.','ALTA','Seguridad'),
(299,'Security','30912','RESCATE DE MIGRANTES (EXTRANJEROS INDOCUMENTADOS)','Acciones para proteger la vida e integridad de migrantes indocumentados.','ALTA','Seguridad'),
(300,'Security','31001','ALLANAMIENTO DE MORADA','Ingreso a domicilio sin derecho ni consentimiento válido.','MEDIA','Seguridad'),
(301,'Security','31002','AMENAZA','Intimidación con daño a persona, bienes u honor propio o de allegados.','MEDIA','Seguridad'),
(302,'Security','31003','ROBO O DAÑO A BIENES PÚBLICOS, INSTITUCIONES, MONUMENTOS, ENTRE OTROS','Apoderamiento o destrucción de bienes públicos como cables, monumentos, etc.','MEDIA','Seguridad'),
(303,'Security','31004','DESCARGA DE DESECHOS SIN PERMISOS','Vertido ilegal de aguas residuales, químicos o desechos sin autorización.','ALTA','Seguridad'),
(304,'Security','31005','INCIDENTES ELECTORALES','Acciones que alteran el funcionamiento del proceso electoral.','MEDIA','Seguridad'),
(305,'Security','31006','FUGA DE REOS','Persona privada de la libertad que escapa de un centro de detención bajo condena o prisión preventiva.','ALTA','Seguridad'),
(306,'Security','31007','NARCOMENUDEO','Venta, compra, traslado o distribución de narcóticos en pequeñas cantidades.','ALTA','Seguridad'),
(307,'Security','31008','TOMA DE EDIFICIO PÚBLICO','Ocupación de instalaciones gubernamentales sin autorización.','ALTA','Seguridad'),
(308,'Security','31009','TOMA DE INSTALACIONES EDUCATIVAS CON VIOLENCIA','Ocupación violenta de un centro escolar sin autorización.','ALTA','Seguridad'),
(309,'Security','31010','TALA ILEGAL','Daño a bosques sin autorización o fuera de regulación legal.','ALTA','Seguridad'),
(310,'Security','31011','TRÁFICO DE MADERA','Transporte, compra, venta o procesamiento de madera fuera del marco legal.','ALTA','Seguridad'),
(311,'Security','31012','TRÁFICO Y/O VENTA ILEGAL DE ANIMALES','Comercialización de animales sin permiso conforme a la ley aplicable.','ALTA','Seguridad'),
(312,'Security','31013','TRÁFICO DE DROGAS Y ESTUPEFACIENTES EN LA MAR','Producción, transporte o suministro ilegal de narcóticos por vía marítima.','ALTA','Seguridad'),
(313,'Security','31014','TRÁFICO DE DROGAS Y ESTUPEFACIENTES EN VÍA PÚBLICA','Producción, transporte o suministro ilegal de narcóticos en vía pública.','ALTA','Seguridad'),
(314,'Security','31015','OTROS ACTOS RELACIONADOS CON OTROS BIENES JURÍDICOS','Hechos que atentan contra bienes jurídicos protegidos por el Estado no clasificados antes.','MEDIA','Seguridad'),
(315,'Security','31016','CAZA ILEGAL','Caza fuera de temporadas, sin permiso o de especies protegidas o en peligro de extinción.','ALTA','Seguridad'),
(316,'Security','31017','INCIDENTE EN DUCTOS DE HIDROCARBUROS','Robo, fuga, daños u otro evento en ductos que transporte hidrocarburos.','ALTA','Seguridad'),
(317,'Improcedente','70101','LLAMADA DE BROMA POR NIÑOS',NULL,'BAJA','Improcedentes'),
(318,'Improcedente','70102','LLAMADA DE PRUEBA',NULL,'BAJA','Improcedentes'),
(319,'Improcedente','70103','LLAMADA INCOMPLETA',NULL,'BAJA','Improcedentes'),
(320,'Improcedente','70104','LLAMADA MUDA',NULL,'BAJA','Improcedentes'),
(321,'Improcedente','70105','TRANSFERENCIA DE LLAMADA',NULL,'BAJA','Improcedentes'),
(322,'Improcedente','70106','INSULTOS POR ADULTOS/LLAMADA OBSCENA',NULL,'BAJA','Improcedentes'),
(323,'Improcedente','70107','JÓVENES/ADULTOS JUGANDO',NULL,'BAJA','Improcedentes'),
(324,'Improcedente','70108','OTRAS LLAMADAS IMPROCEDENTES',NULL,'BAJA','Improcedentes'),
(325,'Otro','60101','Reclasificado','Se cambia al Tipo Servicios Públicos, Subtipo Infraestructura con número 40114 (Alcantarilla Obstruida).','BAJA','Otros'),
(326,'Otro','60102','Reclasificado','Se cambia al Tipo Servicios Públicos, Subtipo Infraestructura con número 40115 (Animal muerto en vía pública).','BAJA','Otros'),
(327,'Otro','60103','SOLICITUD DE OTROS SERVICIOS PÚBLICOS','Cualquier otro servicio público que se encuentre averiado y que pueda ocasionar accidentes.','BAJA','Otros'),
(328,'Otro','60201','LLAMADA DE PRUEBA','Llamada realizada generalmente por supervisión o personal público para evaluar el funcionamiento del 9-1-1.','BAJA','Otros'),
(329,'Otro','60202','LLAMADA INCOMPLETA','Llamada que se interrumpe o no proporciona los datos mínimos para su atención.','BAJA','Otros'),
(330,'Otro','60203','TRANSFERENCIA DE LLAMADA','Llamada que es canalizada a otro departamento o CALLE para su atención.','BAJA','Otros'),
(331,'Otro','60204','SOLICITUD DE INFORMACIÓN','Llamada donde se solicita información no asociada a una emergencia.','BAJA','Otros'),
(332,'Otro','60205','INFORMACIÓN DE INCIDENTE YA REPORTADO','Llamadas repetidas sobre un mismo incidente ya atendido o reincidencia del apoyo.','BAJA','Otros'),
(333,'Otro','60206','LLAMADA DE FELICITACIÓN','Llamada de una persona para felicitar al servicio de emergencias 9-1-1.','BAJA','Otros'),
(334,'Otro','60207','LLAMADA DE SEGUIMIENTO','Llamada para dar seguimiento a un incidente ya reportado.','BAJA','Otros'),
(335,'Otro','60208','LLAMADA DE QUEJA','Llamada para presentar quejas respecto al servicio de emergencias 9-1-1.','BAJA','Otros'),
(336,'Otro','60209','APOYO A OTRO ESTADO/CALLE','Intercambio de información entre CALLEs estatales sobre incidentes como personas no localizadas o robo de vehículo.','BAJA','Otros'),
(337,'Otro','60210','SIMULACRO','Llamada asociada a la programación o reporte de un simulacro, ya sea por autoridades o sector privado.','BAJA','Otros'),
(338,'Mal uso del servicio','70101','LLAMADA DE BROMA POR MENORES DE EDAD','Llamadas con risas, titubeos o contradicciones hechas por menores; no se consideran emergencias y no se activan servicios.','BAJA','Mal uso del servicio'),
(339,'Mal uso del servicio','70102','Reclasificado','Se cambia al Tipo Otros Servicios, Subtipo Gestión del servicio con número 60201 (Llamada de prueba).','BAJA','Mal uso del servicio'),
(340,'Mal uso del servicio','70103','Reclasificado','Se cambia al Tipo Otros Servicios, Subtipo Gestión del servicio con número 60202 (Llamada incompleta).','BAJA','Mal uso del servicio'),
(341,'Mal uso del servicio','70104','LLAMADA MUDA','No se recibe ninguna solicitud de auxilio, ni sonidos que indiquen emergencia; se da por concluida.','BAJA','Mal uso del servicio'),
(342,'Mal uso del servicio','70105','Reclasificado','Se cambia al Tipo Otros Servicios, Subtipo Gestión del servicio con número 60203 (Transferencia de llamada).','BAJA','Mal uso del servicio'),
(343,'Mal uso del servicio','70106','LLAMADA CON PALABRAS OBSCENAS Y/O INSULTOS','Llamada donde se insulta al operador(a), sin que se solicite auxilio, usando palabras obscenas o soeces.','BAJA','Mal uso del servicio'),
(344,'Mal uso del servicio','70107','LLAMADA DE BROMA POR ADULTOS / JÓVENES','Llamadas de adultos o jóvenes con señales de broma como risas o contradicciones; no se consideran emergencias.','BAJA','Mal uso del servicio'),
(345,'Mal uso del servicio','70108','Reclasificado','Se cambia al Tipo Otros Servicios, Subtipo Gestión del servicio con número 60204 (Solicitud de información).','BAJA','Mal uso del servicio'),
(346,'Mal uso del servicio','70109','LLAMADAS COLGADAS','Llamadas cortadas inmediatamente después del protocolo, comúnmente por error en el dispositivo.','BAJA','Mal uso del servicio');
/*!40000 ALTER TABLE `EmergencyTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asignaciones_unidades`
--

DROP TABLE IF EXISTS `asignaciones_unidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `asignaciones_unidades` (
  `id_asignacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_incidente` int(11) NOT NULL,
  `id_unidad` int(11) NOT NULL,
  `fecha_asignacion` datetime DEFAULT current_timestamp(),
  `id_usuario_asignador` int(11) DEFAULT NULL,
  `comentarios` text DEFAULT NULL,
  PRIMARY KEY (`id_asignacion`),
  KEY `id_incidente` (`id_incidente`),
  KEY `id_unidad` (`id_unidad`),
  KEY `id_usuario_asignador` (`id_usuario_asignador`),
  CONSTRAINT `asignaciones_unidades_ibfk_1` FOREIGN KEY (`id_incidente`) REFERENCES `incidentes` (`folio_incidente`) ON DELETE CASCADE,
  CONSTRAINT `asignaciones_unidades_ibfk_2` FOREIGN KEY (`id_unidad`) REFERENCES `unidades` (`id_unidad`),
  CONSTRAINT `asignaciones_unidades_ibfk_3` FOREIGN KEY (`id_usuario_asignador`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asignaciones_unidades`
--

LOCK TABLES `asignaciones_unidades` WRITE;
/*!40000 ALTER TABLE `asignaciones_unidades` DISABLE KEYS */;
INSERT INTO `asignaciones_unidades` VALUES
(1,1,1,'2025-04-22 13:29:30',2,'jajjajajja'),
(3,1,1,'2025-05-18 22:45:31',3,''),
(4,1,1,'2025-05-19 00:13:13',3,'aiuda'),
(5,252,2,'2025-05-19 01:14:45',3,'ambulancia #1'),
(6,254,3,'2025-05-19 01:19:13',3,'Enviar una camilla y unas pastillas para el dolor de espalda'),
(7,254,6,'2025-05-19 18:29:25',3,'Localizar el panal de abejas'),
(8,258,4,'2025-05-19 18:36:52',3,'Enviar unas pastillas'),
(9,259,7,'2025-05-19 19:03:44',4,'(Llevar pastillas para el dolor de espalda)'),
(10,259,10,'2025-05-19 19:13:32',4,''),
(11,259,8,'2025-05-19 19:13:45',4,''),
(12,264,9,'2025-05-21 19:36:29',2,'asignar un poca');
/*!40000 ALTER TABLE `asignaciones_unidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_participants`
--

DROP TABLE IF EXISTS `chat_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_participants` (
  `id_participant` int(11) NOT NULL AUTO_INCREMENT,
  `id_chat` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `joined_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_participant`),
  KEY `id_chat` (`id_chat`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `chat_participants_ibfk_1` FOREIGN KEY (`id_chat`) REFERENCES `chats` (`id_chat`) ON DELETE CASCADE,
  CONSTRAINT `chat_participants_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_participants`
--

LOCK TABLES `chat_participants` WRITE;
/*!40000 ALTER TABLE `chat_participants` DISABLE KEYS */;
INSERT INTO `chat_participants` VALUES
(1,1,3,'2025-05-19 05:34:20'),
(2,1,1,'2025-05-19 05:34:20'),
(3,1,2,'2025-05-19 05:34:20'),
(4,2,3,'2025-05-19 05:34:53'),
(5,2,2,'2025-05-19 05:34:53'),
(6,2,7,'2025-05-19 05:34:53'),
(7,3,3,'2025-05-20 00:37:45'),
(8,3,5,'2025-05-20 00:37:45'),
(9,4,2,'2025-05-20 01:00:58'),
(10,4,5,'2025-05-20 01:00:58'),
(11,5,2,'2025-05-22 01:41:25'),
(12,5,6,'2025-05-22 01:41:25');
/*!40000 ALTER TABLE `chat_participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chats`
--

DROP TABLE IF EXISTS `chats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `chats` (
  `id_chat` int(11) NOT NULL AUTO_INCREMENT,
  `chat_name` varchar(100) DEFAULT NULL,
  `is_group` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_chat`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chats`
--

LOCK TABLES `chats` WRITE;
/*!40000 ALTER TABLE `chats` DISABLE KEYS */;
INSERT INTO `chats` VALUES
(1,'',1,'2025-05-19 05:34:31'),
(2,'Equipo 1',1,'2025-05-19 05:35:22'),
(3,'',0,'2025-05-20 00:38:04'),
(4,'',0,'2025-05-20 01:00:58'),
(5,'',0,'2025-05-22 01:41:44');
/*!40000 ALTER TABLE `chats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gestion_personal`
--

DROP TABLE IF EXISTS `gestion_personal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gestion_personal` (
  `id_personal` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_completo` varchar(50) NOT NULL,
  `id_horario` int(11) DEFAULT NULL,
  `estado` enum('Activo','Inactivo') DEFAULT 'Activo',
  PRIMARY KEY (`id_personal`),
  KEY `fk_gestion_horario` (`id_horario`),
  CONSTRAINT `fk_gestion_horario` FOREIGN KEY (`id_horario`) REFERENCES `horarios` (`id_horario`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gestion_personal`
--

LOCK TABLES `gestion_personal` WRITE;
/*!40000 ALTER TABLE `gestion_personal` DISABLE KEYS */;
INSERT INTO `gestion_personal` VALUES
(1,'Eliza Juarez',2,'Activo'),
(2,'Juan Perez',3,'Activo'),
(3,'Sara Juarez',1,'Activo'),
(4,'Lia Vallarta',4,'Activo'),
(5,'Mila Rojas',1,'Activo'),
(6,'Leon Casas',2,'Activo'),
(7,'Luna Villareal',2,'Activo');
/*!40000 ALTER TABLE `gestion_personal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horarios`
--

DROP TABLE IF EXISTS `horarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `horarios` (
  `id_horario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_horario` varchar(50) NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `dias_semana` varchar(50) NOT NULL,
  `activo` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id_horario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horarios`
--

LOCK TABLES `horarios` WRITE;
/*!40000 ALTER TABLE `horarios` DISABLE KEYS */;
INSERT INTO `horarios` VALUES
(1,'Matutino','08:00:00','16:00:00','Lunes-Martes-Miércoles-Jueves-Viernes',1),
(2,'Vespertino','16:00:00','00:00:00','Lunes-Martes-Miércoles-Jueves-Viernes',1),
(3,'Nocturno','00:00:00','08:00:00','Lunes-Martes-Miércoles-Jueves-Viernes',1),
(4,'Fin de Semana','08:00:00','20:00:00','Sábado-Domingo',1);
/*!40000 ALTER TABLE `horarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incidentes`
--

DROP TABLE IF EXISTS `incidentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidentes` (
  `folio_incidente` int(11) NOT NULL AUTO_INCREMENT,
  `quepaso` varchar(255) NOT NULL,
  `tipo_auxilio` varchar(50) NOT NULL,
  `hora_incidente` time NOT NULL,
  `fecha_incidente` datetime NOT NULL,
  `fecha_actualizacion` datetime DEFAULT NULL,
  `num_personas` int(11) NOT NULL,
  `latitud` decimal(10,8) DEFAULT NULL,
  `longitud` decimal(11,8) DEFAULT NULL,
  `telefono` varchar(20) NOT NULL,
  `id_usuario_reporta` int(11) DEFAULT NULL,
  `clasificacion` varchar(20) DEFAULT NULL,
  `prioridad` enum('Alta','Media','Baja') DEFAULT 'Media',
  `id_unidad_asignada` int(11) DEFAULT NULL,
  `colonia` varchar(255) DEFAULT NULL,
  `localidad` varchar(255) DEFAULT NULL,
  `municipio` varchar(255) DEFAULT NULL,
  `id_emergency_type` varchar(10) DEFAULT NULL,
  `id_llamada` int(11) DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `hora_edicion` time DEFAULT NULL,
  `nombre_completo` varchar(30) DEFAULT NULL,
  `detalle` text DEFAULT NULL,
  `objetos_involucrados` varchar(40) DEFAULT NULL,
  `tipo_telefono` enum('Local','Celular','Publico') DEFAULT NULL,
  `referencia_lugar` text DEFAULT NULL,
  PRIMARY KEY (`folio_incidente`),
  KEY `id_usuario_reporta` (`id_usuario_reporta`),
  KEY `id_unidad_asignada` (`id_unidad_asignada`),
  KEY `id_emergency_type` (`id_emergency_type`),
  KEY `fk_incidente_llamada` (`id_llamada`),
  CONSTRAINT `fk_incidente_llamada` FOREIGN KEY (`id_llamada`) REFERENCES `llamadas` (`id_llamada`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `incidentes_ibfk_1` FOREIGN KEY (`id_usuario_reporta`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL,
  CONSTRAINT `incidentes_ibfk_2` FOREIGN KEY (`id_unidad_asignada`) REFERENCES `unidades` (`id_unidad`) ON DELETE SET NULL,
  CONSTRAINT `incidentes_ibfk_3` FOREIGN KEY (`id_emergency_type`) REFERENCES `EmergencyTypes` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidentes`
--

LOCK TABLES `incidentes` WRITE;
/*!40000 ALTER TABLE `incidentes` DISABLE KEYS */;
INSERT INTO `incidentes` VALUES
(1,'Accidente en la calle Venus','Medico','00:00:00','2025-04-22 19:23:14',NULL,5,NULL,NULL,'555678978',2,'TTY','Media',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(2,'Gatito atrapado en un arbol','Proteccion Civil','12:30:54','2025-04-22 22:30:54',NULL,1,NULL,NULL,'5567890656',7,'Emergencia Real','Alta',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(54,'lklkfjsldfsd','Proteccion Civil','19:38:35','2025-05-02 19:38:35','2025-05-02 19:38:35',5,19.44694300,-99.13444500,'5523456789',2,'Emergencia Real','Media',NULL,'Morelos','Mexico City','Mexico City',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(55,'lklkfjsldfsd','Proteccion Civil','19:44:49','2025-05-02 19:44:49','2025-05-02 19:44:49',5,19.44694300,-99.13444500,'5523456789',2,'Emergencia Real','Media',NULL,'Morelos','Mexico City','Mexico City',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(56,'lñdlksñdfsdf','Proteccion Civil','19:45:22','2025-05-02 19:45:22','2025-05-02 19:45:22',5,19.43625900,-99.14337200,'5521036756',2,'Emergencia Real','Baja',NULL,'Barrio Chino','Mexico City','Mexico City',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(57,'lñdlksñdfsdf','Proteccion Civil','19:50:54','2025-05-02 19:50:54','2025-05-02 19:50:54',5,19.43625900,-99.14337200,'5521036756',2,'Emergencia Real','Baja',NULL,'Barrio Chino','Mexico City','Mexico City',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(65,'Llamada simulada 25','Medico','20:39:40','2025-05-04 20:39:40','2025-05-04 20:41:33',2,19.42259800,-99.04677700,'5551234567',2,'TTY','Baja',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(66,'Llamada simulada 25','Proteccion Civil','20:41:59','2025-05-04 20:41:59','2025-05-04 20:41:59',2,19.42296800,-99.04672600,'5551234567',2,'TTY','Baja',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(92,'Llamada simulada 12','Proteccion Civil','20:54:19','2025-05-04 20:54:19','2025-05-05 12:23:32',4,19.42814900,-99.07616600,'5551234567',2,'Emergencia Real','Alta',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(94,'Llamada simulada 47','Proteccion Civil','20:54:33','2025-05-04 20:54:33','2025-05-04 20:54:56',3,19.44816900,-99.01650800,'5551234567',2,'Emergencia Real','Media',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(95,'Llamada simulada 47','Proteccion Civil','20:55:31','2025-05-04 20:55:31','2025-05-04 20:55:31',3,19.51740500,-98.90510600,'5551234567',2,'Emergencia Real','Media',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(104,'Llamada simulada 43','Seguridad','20:57:44','2025-05-04 20:57:44','2025-05-04 20:58:16',2,19.41536000,-99.05462400,'5551234567',2,'Emergencia Real','Alta',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(105,'Llamada simulada 43','Proteccion Civil','20:58:41','2025-05-04 20:58:41','2025-05-04 20:58:41',2,19.41531900,-99.05453700,'5551234567',2,'Broma','Media',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(108,'Llamada simulada 4','Proteccion Civil','21:26:03','2025-05-04 21:26:03','2025-05-04 23:15:29',4,19.40429800,-99.09603500,'5551234567',2,'TTY','Media',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(110,'Llamada simulada 4','Proteccion Civil','23:15:54','2025-05-04 23:15:54','2025-05-04 23:15:54',4,19.40439000,-99.09603600,'5551234567',2,'TTY','Media',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(117,'Llamada simulada 12','Proteccion Civil','12:23:44','2025-05-05 12:23:44','2025-05-05 12:23:44',4,19.42762300,-99.07569400,'5551234567',2,'Emergencia Real','Alta',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(118,'se cayó un árbol','Proteccion Civil','12:26:52','2025-05-05 12:26:52','2025-05-05 12:26:52',4,19.46044200,-99.09256000,'5528576890',7,'Emergencia Real','Media',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(132,'Todo suceso relacionado con un vehículo (de dos, tres ruedas o cuatrimoto) impulsado por un motor y en donde resulta una o más personas con lesiones.','Medico','12:28:31','2025-05-05 12:28:31','2025-05-07 23:14:59',1,19.40679300,-99.09110100,'5551234567',7,'Emergencia Real','Alta',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(150,'Hecho de tránsito de vehículo automotor en donde resultan personas lesionadas, incluye choques, volcaduras, impacto contra semovientes (animales) o impacto contra objeto fijo.','Medico','22:53:21','2025-05-07 22:53:21','2025-05-07 22:53:21',1,19.42106200,-99.12002600,'5528576890',2,'Emergencia Real','Alta',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(151,'Hecho de tránsito de vehículo automotor en donde resultan personas lesionadas, incluye choques, volcaduras, impacto contra semovientes (animales) o impacto contra objeto fijo.','Medico','23:12:20','2025-05-07 23:12:20','2025-05-07 23:12:20',1,19.42106200,-99.12002600,'5528576890',2,'Emergencia Real','Alta',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(165,'Suceso en el que se ven involucrados locomotoras o vehículos que circulan en las vías del tren, sin que resulten personas lesionadas.','Proteccion Civil','21:00:37','2025-05-10 21:00:37','2025-05-10 21:06:53',1,19.40948000,-99.09264600,'5551234567',2,'Broma','Media',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(192,'Suceso en el que se ven involucrados locomotoras o vehículos que circulan en las vías del tren, sin que resulten personas lesionadas.','','16:19:14','2025-05-11 16:19:14','2025-05-11 16:19:14',1,19.41134400,-99.15744800,'',2,'Emergencia Real','Media',NULL,'Roma Norte','Ciudad de México','Ciudad de México','20101',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(193,'Suceso en el que se ven involucrados locomotoras o vehículos que circulan en las vías del tren, sin que resulten personas lesionadas.','','16:25:52','2025-05-11 16:25:52','2025-05-11 16:25:52',1,19.41134400,-99.15744800,'',2,'Emergencia Real','Media',NULL,'Roma Norte','Ciudad de México','Ciudad de México','20101',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(194,'Suceso en el que se ven involucrados locomotoras o vehículos que circulan en las vías del tren, sin que resulten personas lesionadas.','','16:26:47','2025-05-11 16:26:47','2025-05-11 16:26:47',1,19.41134400,-99.15744800,'',2,'Emergencia Real','Media',NULL,'Roma Norte','Ciudad de México','Ciudad de México','20101',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(195,'Suceso en el que se ven involucrados locomotoras o vehículos que circulan en las vías del tren, sin que resulten personas lesionadas.','','16:28:51','2025-05-11 16:28:51','2025-05-11 16:28:51',1,19.41134400,-99.15744800,'',2,'Emergencia Real','Media',NULL,'Roma Norte','Ciudad de México','Ciudad de México','20101',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(196,'Acontecimiento relacionado con el medio acuático; es decir, suscitado en mar, piscina/alberca, lago, río y/o presas donde haya personas lesionadas.','','16:29:09','2025-05-11 16:29:09','2025-05-11 16:29:09',4,19.42711800,-99.12963900,'',2,'Emergencia Real','Media',NULL,'Centro','Mexico City','Mexico City','10101',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(197,'Acontecimiento relacionado con el medio acuático; es decir, suscitado en mar, piscina/alberca, lago, río y/o presas donde haya personas lesionadas.','','16:31:04','2025-05-11 16:31:04','2025-05-11 16:31:04',4,19.42711800,-99.12963900,'',2,'Emergencia Real','Media',NULL,'Centro','Mexico City','Mexico City','10101',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(198,'Hecho de tránsito de vehículo automotor en donde resultan personas lesionadas, incluye choques, volcaduras, impacto contra semovientes (animales) o impacto contra objeto fijo.','','16:31:31','2025-05-11 16:31:31','2025-05-11 16:31:31',4,19.44243800,-99.12757900,'',2,'Emergencia Real','Media',NULL,'Morelos','Mexico City','Mexico City','10104',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(199,'Suceso en el que se ven involucrados los vehículos que circulan en las vías del sistema ferroviario, en servicio de carga o pasajeros, y en el cual resultan personas fallecidas.','','16:33:07','2025-05-11 16:33:07','2025-05-11 16:33:07',1,19.43746800,-99.12826500,'',2,'Emergencia Real','Media',NULL,'Centro','Mexico City','Mexico City','10106',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(203,'Conjunto de recintos y recipientes no autorizados en los cuales se resguardan productos químicos, que puedan producir un riesgo no controlado para las personas, su patrimonio o el medio ambiente.','Civil Protection','17:52:55','2025-05-11 17:52:55','2025-05-11 17:52:55',1,19.44893400,-99.16946400,'',2,'Emergencia Real','Alta',NULL,'Colonia Un hogar para nosotros','Mexico City','Mexico City','20102',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(210,'Concentración de un grupo de personas sin desarrollar conductas de violencia.','','18:07:36','2025-05-11 18:07:36',NULL,1,19.40193600,-99.09281700,'5631697228',2,'Emergencia Real','Media',NULL,'Colonia Mario Moreno','Mexico City','Mexico City','50101',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(221,'Acción cometida, pero no consumada, por una o más personas, con el fin de apoderarse de bienes muebles.','','18:17:31','2025-05-11 18:17:31',NULL,3,19.40120700,-99.09509200,'5548729488',2,'Emergencia Real','Alta',NULL,'','','','50102',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(225,'Suceso en el que se ven involucrados locomotoras o vehículos que circulan en las vías del tren, sin que resulten personas lesionadas.','','18:17:37','2025-05-11 18:17:37',NULL,1,19.40489100,-99.09822500,'5647021704',2,'Broma','Alta',NULL,'Colonia Granjas México','Mexico City','Mexico City','20101',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(228,'Animales que, con independencia de su agresividad, su especie o raza tienen capacidad de causar muerte o lesiones a personas o animales y/o daños a las cosas.','','18:17:41','2025-05-11 18:17:41',NULL,1,19.40647000,-99.09676600,'5544502553',2,'Emergencia Real','Media',NULL,'Colonia Mario Moreno','Mexico City','Mexico City','20103',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(249,'Acontecimiento relacionado con el medio acuático; que ocurre a bordo de una embarcación o entre embarcaciones y del cual resultan una o más personas lesionadas.','Medical','14:44:00','2025-05-17 14:44:00',NULL,1,19.45080000,-99.01700000,'5627882801',2,NULL,'Alta',NULL,'','','Estado de México','10114',176,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(250,'Acontecimiento relacionado con el medio acuático; es decir, suscitado en mar, piscina/alberca, lago, río y/o presas donde haya personas lesionadas.','Medical','14:44:19','2025-05-17 14:44:19',NULL,1,19.46670000,-99.03170000,'5524705739',2,NULL,'Alta',NULL,'Colonia Canal de Sales','Nezahualcóyotl','Estado de México','10101',172,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(251,'Acción cometida, pero no consumada, por una o más personas, con el fin de apoderarse de bienes muebles.','Assistance','11:22:03','2025-05-18 11:22:03',NULL,1,19.47160000,-99.07140000,'5535817657',2,NULL,'Media',NULL,'Colonia San Juan de Aragón 7a. Sección','Ciudad de México','Ciudad de México','50102',188,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(252,'Acción que comete una o más personas al apoderarse de bienes muebles, invadiendo propiedades privadas con una forma de acción violenta.','Security','20:59:52','2025-05-18 20:59:52',NULL,1,19.46660000,-99.03940000,'5693444735',2,NULL,'Alta',NULL,'Colonia U.H. RDCIAL Prados de Aragón','Nezahualcóyotl','Estado de México','30413',201,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(253,'Acción que comete una persona al apoderarse de pertenencias ajenas, invadiendo propiedades privadas con una forma de acción no violenta.','Security','21:23:13','2025-05-18 21:23:13',NULL,7,19.45770000,-99.16650000,'5547338847',2,NULL,'Alta',NULL,'Unidad Habitacional Tlatilco','Ciudad de México','Ciudad de México','30414',213,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(254,'Daño a cristales o cerraduras de vehículo para robar bienes del interior.','Security','01:16:10','2025-05-19 01:16:10',NULL,3,19.33690000,-99.07890000,'5662094057',3,NULL,'Alta',NULL,'Unidad Habitacional FOVISSSTE San Juan','Ciudad de México','Ciudad de México','30403',219,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(255,'Competencia o exhibición de vehículos en la vía pública.','Security','13:26:33','2025-05-19 13:26:33',NULL,4,19.34230000,-99.07320000,'5570633410',2,NULL,'Media',NULL,'Colonia Paraje San Juan','Ciudad de México','Ciudad de México','30302',231,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(256,'Acción cometida, pero no consumada, por una o más personas, con el fin de apoderarse de bienes muebles.','Assistance','14:11:26','2025-05-19 14:11:26',NULL,1,19.43280000,-99.13300000,'5554444444',2,NULL,'Media',NULL,'Centro','Ciudad de México','Ciudad de México','50102',235,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(257,'Acción cometida, pero no consumada, por una o más personas, con el fin de apoderarse de bienes muebles.','Assistance','14:11:39','2025-05-19 14:11:39',NULL,1,19.43250000,-99.13330000,'5553333333',2,NULL,'Media',NULL,'Centro','Ciudad de México','Ciudad de México','50102',234,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(258,'Acción cometida, pero no consumada, por una o más personas, con el fin de apoderarse de bienes muebles.','Assistance','18:34:34','2025-05-19 18:34:34',NULL,1,19.32580000,-99.10960000,'5545860595',3,NULL,'Media',NULL,'Unidad Obrero CTM Culhuacán Sección 7','Ciudad de México','Ciudad de México','50102',250,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(259,'Hecho de tránsito en que ocurre un impacto entre un vehículo... provocando lesiones al peatón y/o ciclista. (Dolor de espalda)','Medical','18:47:24','2025-05-19 18:47:24',NULL,1,19.34000000,-99.14530000,'5583253233',2,NULL,'Alta',NULL,'Colonia Atlántida','Ciudad de México','Ciudad de México','10116',280,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(260,'Acción cometida por una o más personas con el fin de apoderarse de bienes muebles, contra una casa de cambio de forma violenta.','Security','13:45:40','2025-05-20 13:45:40',NULL,1,19.33580000,-99.07010000,'5641788092',3,NULL,'Alta',NULL,'Colonia San Lorenzo Tezonco','Ciudad de México','Ciudad de México','30435',277,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(261,'Reclasificado al Tipo Seguridad, Subtipo Notificación de Hallazgo, número 31203.','Assistance','22:35:00','2025-05-20 16:35:42',NULL,1,19.40370000,-99.02920000,'5660259927',5,NULL,'Baja',NULL,'','Nezahualcóyotl','Estado de México','50203',275,'22:35:00',NULL,NULL,NULL,NULL,NULL,NULL),
(262,'Daño a cristales o cerraduras de vehículo para robar bienes del interior, vehículo marca Honda CRV 2022 color azul','Security','16:45:00','2025-05-20 16:51:13',NULL,4,19.43032020,-99.14144039,'5510101010',2,NULL,'Alta',NULL,'Barrio Chino','Ciudad de México','Ciudad de México','30403',NULL,'16:45:00',NULL,NULL,NULL,NULL,NULL,NULL),
(263,'Identificación de vehículo robado.','Security','22:57:00','2025-05-20 16:57:56','2025-05-20 17:02:02',12,19.36340000,-99.06820000,'5680250225',2,NULL,'Alta',NULL,'Colonia Leyes de Reforma 1a. Sección','Ciudad de México','Ciudad de México','30466',286,'21:08:00','17:02:02',NULL,NULL,NULL,NULL,NULL),
(264,'Hecho de tránsito con vehículo de transporte de pasajeros sin lesionados.','Security','01:23:00','2025-05-21 19:34:39',NULL,4,19.35590000,-99.06990000,'5550503165',2,NULL,'Alta',NULL,'Colonia Albarrada','Ciudad de México','Ciudad de México','30315',303,'01:23:00',NULL,NULL,NULL,NULL,NULL,NULL),
(265,'Acontecimiento relacionado con el medio acuático... donde haya personas fallecidas.','Medical','20:41:00','2025-05-22 14:43:04',NULL,1,19.34680000,-99.10660000,'5623179690',2,NULL,'Baja',NULL,'Zona Urbana Los Reyes Culhuacán','Ciudad de México','Ciudad de México','10117',300,'20:41:00',NULL,'Juan Lopez Perez',NULL,'Vehículos','Celular','al lado de tienda coca');
/*!40000 ALTER TABLE `incidentes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER prevent_dual_classification
BEFORE INSERT ON incidentes
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM prank_calls WHERE id_llamada = NEW.id_llamada) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'This call is already classified as a prank call';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `incidentes_change_log`
--

DROP TABLE IF EXISTS `incidentes_change_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidentes_change_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `folio_incidente` int(11) NOT NULL,
  `changed_field` varchar(50) NOT NULL,
  `old_value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  `change_timestamp` datetime DEFAULT current_timestamp(),
  `changed_by` int(11) NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `folio_incidente` (`folio_incidente`),
  KEY `changed_by` (`changed_by`),
  CONSTRAINT `incidentes_change_log_ibfk_1` FOREIGN KEY (`folio_incidente`) REFERENCES `incidentes` (`folio_incidente`),
  CONSTRAINT `incidentes_change_log_ibfk_2` FOREIGN KEY (`changed_by`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidentes_change_log`
--

LOCK TABLES `incidentes_change_log` WRITE;
/*!40000 ALTER TABLE `incidentes_change_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `incidentes_change_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `llamadas`
--

DROP TABLE IF EXISTS `llamadas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `llamadas` (
  `id_llamada` int(11) NOT NULL AUTO_INCREMENT,
  `id_operador` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `duracion` int(11) DEFAULT NULL COMMENT 'Duración en segundos',
  `estatus` enum('En curso','Finalizada','Atender','Clasificada') DEFAULT 'Atender',
  `telefono` bigint(20) DEFAULT NULL,
  `latitud` float DEFAULT NULL,
  `longitud` float DEFAULT NULL,
  PRIMARY KEY (`id_llamada`),
  KEY `id_operador` (`id_operador`),
  CONSTRAINT `llamadas_ibfk_1` FOREIGN KEY (`id_operador`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=314 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `llamadas`
--

LOCK TABLES `llamadas` WRITE;
/*!40000 ALTER TABLE `llamadas` DISABLE KEYS */;
INSERT INTO `llamadas` VALUES
(1,2,'2025-04-22 08:15:00',235,'Finalizada',NULL,NULL,NULL),
(2,7,'2025-04-22 16:33:50',500,'En curso',NULL,NULL,NULL),
(3,3,'2025-05-04 20:39:34',NULL,'Atender',NULL,NULL,NULL),
(4,3,'2025-05-04 20:39:36',NULL,'Atender',NULL,NULL,NULL),
(5,3,'2025-05-04 20:39:37',NULL,'Atender',NULL,NULL,NULL),
(6,3,'2025-05-04 20:39:39',NULL,'Atender',NULL,NULL,NULL),
(7,2,'2025-05-04 20:39:40',NULL,'En curso',NULL,NULL,NULL),
(8,2,'2025-05-04 20:49:07',NULL,'Atender',NULL,NULL,NULL),
(9,3,'2025-05-04 20:49:09',NULL,'Atender',NULL,NULL,NULL),
(10,2,'2025-05-04 20:49:10',NULL,'Atender',NULL,NULL,NULL),
(11,1,'2025-05-04 20:49:11',NULL,'Atender',NULL,NULL,NULL),
(12,3,'2025-05-04 20:49:13',NULL,'Atender',NULL,NULL,NULL),
(13,3,'2025-05-04 20:49:14',NULL,'Atender',NULL,NULL,NULL),
(14,3,'2025-05-04 20:49:16',NULL,'En curso',NULL,NULL,NULL),
(15,3,'2025-05-04 20:53:13',NULL,'Atender',NULL,NULL,NULL),
(16,3,'2025-05-04 20:53:14',NULL,'Atender',NULL,NULL,NULL),
(17,3,'2025-05-04 20:53:16',NULL,'Atender',NULL,NULL,NULL),
(18,3,'2025-05-04 20:53:17',NULL,'Atender',NULL,NULL,NULL),
(19,3,'2025-05-04 20:53:19',NULL,'Atender',NULL,NULL,NULL),
(20,1,'2025-05-04 20:53:20',NULL,'Atender',NULL,NULL,NULL),
(21,3,'2025-05-04 20:53:22',NULL,'Atender',NULL,NULL,NULL),
(22,1,'2025-05-04 20:53:23',NULL,'Atender',NULL,NULL,NULL),
(23,1,'2025-05-04 20:53:25',NULL,'Atender',NULL,NULL,NULL),
(24,1,'2025-05-04 20:53:26',NULL,'En curso',NULL,NULL,NULL),
(25,2,'2025-05-04 20:54:07',NULL,'Atender',NULL,NULL,NULL),
(26,1,'2025-05-04 20:54:08',NULL,'Atender',NULL,NULL,NULL),
(27,2,'2025-05-04 20:54:10',NULL,'Atender',NULL,NULL,NULL),
(28,1,'2025-05-04 20:54:11',NULL,'Atender',NULL,NULL,NULL),
(29,1,'2025-05-04 20:54:13',NULL,'Atender',NULL,NULL,NULL),
(30,1,'2025-05-04 20:54:14',NULL,'Atender',NULL,NULL,NULL),
(31,1,'2025-05-04 20:54:16',NULL,'Atender',NULL,NULL,NULL),
(32,3,'2025-05-04 20:54:17',NULL,'Atender',NULL,NULL,NULL),
(33,2,'2025-05-04 20:54:19',NULL,'En curso',NULL,NULL,NULL),
(34,2,'2025-05-04 20:54:20',NULL,'Atender',NULL,NULL,NULL),
(35,3,'2025-05-04 20:54:33',NULL,'En curso',NULL,NULL,NULL),
(36,3,'2025-05-04 20:57:32',NULL,'Atender',NULL,NULL,NULL),
(37,1,'2025-05-04 20:57:33',NULL,'Atender',NULL,NULL,NULL),
(38,2,'2025-05-04 20:57:35',NULL,'Atender',NULL,NULL,NULL),
(39,1,'2025-05-04 20:57:36',NULL,'Atender',NULL,NULL,NULL),
(40,1,'2025-05-04 20:57:38',NULL,'Atender',NULL,NULL,NULL),
(41,3,'2025-05-04 20:57:39',NULL,'Atender',NULL,NULL,NULL),
(42,2,'2025-05-04 20:57:41',NULL,'Atender',NULL,NULL,NULL),
(43,2,'2025-05-04 20:57:42',NULL,'Atender',NULL,NULL,NULL),
(44,3,'2025-05-04 20:57:44',NULL,'En curso',NULL,NULL,NULL),
(45,3,'2025-05-04 21:26:00',NULL,'En curso',NULL,NULL,NULL),
(46,1,'2025-05-04 21:26:02',NULL,'Atender',NULL,NULL,NULL),
(47,1,'2025-05-04 21:26:03',NULL,'En curso',NULL,NULL,NULL),
(48,2,'2025-05-04 21:26:05',NULL,'En curso',NULL,NULL,NULL),
(49,3,'2025-05-05 12:12:58',NULL,'Atender',NULL,NULL,NULL),
(50,1,'2025-05-05 12:13:00',NULL,'Atender',NULL,NULL,NULL),
(51,1,'2025-05-05 12:13:01',NULL,'En curso',NULL,NULL,NULL),
(52,2,'2025-05-05 12:13:03',NULL,'Atender',NULL,NULL,NULL),
(53,3,'2025-05-05 12:13:04',NULL,'En curso',NULL,NULL,NULL),
(54,2,'2025-05-05 12:13:06',NULL,'En curso',NULL,NULL,NULL),
(55,2,'2025-05-05 12:28:00',NULL,'Atender',NULL,NULL,NULL),
(56,1,'2025-05-05 12:28:09',NULL,'Atender',NULL,NULL,NULL),
(57,3,'2025-05-05 12:28:10',NULL,'Atender',NULL,NULL,NULL),
(58,2,'2025-05-05 12:28:12',NULL,'Atender',NULL,NULL,NULL),
(59,3,'2025-05-05 12:28:18',NULL,'Atender',NULL,NULL,NULL),
(60,3,'2025-05-05 12:28:19',NULL,'Atender',NULL,NULL,NULL),
(61,1,'2025-05-05 12:28:21',NULL,'Atender',NULL,NULL,NULL),
(62,1,'2025-05-05 12:28:22',NULL,'Atender',NULL,NULL,NULL),
(63,2,'2025-05-05 12:28:24',NULL,'Atender',NULL,NULL,NULL),
(64,1,'2025-05-05 12:28:25',NULL,'Atender',NULL,NULL,NULL),
(65,1,'2025-05-05 12:28:27',NULL,'Atender',NULL,NULL,NULL),
(66,2,'2025-05-05 12:28:28',NULL,'Atender',NULL,NULL,NULL),
(67,1,'2025-05-05 12:28:30',NULL,'Atender',NULL,NULL,NULL),
(68,2,'2025-05-05 12:28:31',NULL,'En curso',NULL,NULL,NULL),
(69,2,'2025-05-05 12:28:33',NULL,'Atender',NULL,NULL,NULL),
(70,1,'2025-05-05 12:28:34',NULL,'Atender',NULL,NULL,NULL),
(71,3,'2025-05-05 12:28:36',NULL,'Atender',NULL,NULL,NULL),
(72,3,'2025-05-05 12:28:37',NULL,'Atender',NULL,NULL,NULL),
(73,2,'2025-05-05 12:28:39',NULL,'Atender',NULL,NULL,NULL),
(74,1,'2025-05-05 12:28:40',NULL,'En curso',NULL,NULL,NULL),
(75,3,'2025-05-05 12:28:42',NULL,'Atender',NULL,NULL,NULL),
(76,1,'2025-05-05 12:28:43',NULL,'Atender',NULL,NULL,NULL),
(77,3,'2025-05-05 12:28:45',NULL,'En curso',NULL,NULL,NULL),
(78,2,'2025-05-05 12:28:46',NULL,'Atender',NULL,NULL,NULL),
(79,1,'2025-05-05 12:28:48',NULL,'En curso',NULL,NULL,NULL),
(80,3,'2025-05-05 12:28:49',NULL,'En curso',NULL,NULL,NULL),
(81,2,'2025-05-05 12:30:07',NULL,'En curso',NULL,NULL,NULL),
(82,2,'2025-05-07 14:50:28',NULL,'Atender',NULL,NULL,NULL),
(83,2,'2025-05-07 14:50:30',NULL,'Atender',NULL,NULL,NULL),
(84,1,'2025-05-07 14:50:31',NULL,'Atender',NULL,NULL,NULL),
(85,2,'2025-05-07 14:50:33',NULL,'Atender',NULL,NULL,NULL),
(86,1,'2025-05-08 20:03:05',NULL,'Atender',NULL,NULL,NULL),
(87,2,'2025-05-08 20:03:07',NULL,'Atender',NULL,NULL,NULL),
(88,1,'2025-05-08 20:03:08',NULL,'En curso',NULL,NULL,NULL),
(89,3,'2025-05-10 21:00:22',NULL,'Atender',NULL,NULL,NULL),
(90,1,'2025-05-10 21:00:24',NULL,'Atender',NULL,NULL,NULL),
(91,1,'2025-05-10 21:00:25',NULL,'Atender',NULL,NULL,NULL),
(92,1,'2025-05-10 21:00:27',NULL,'Atender',NULL,NULL,NULL),
(93,1,'2025-05-10 21:00:28',NULL,'Atender',NULL,NULL,NULL),
(94,1,'2025-05-10 21:00:30',NULL,'Atender',NULL,NULL,NULL),
(95,1,'2025-05-10 21:00:32',NULL,'Atender',NULL,NULL,NULL),
(96,1,'2025-05-10 21:00:33',NULL,'Atender',NULL,NULL,NULL),
(97,1,'2025-05-10 21:00:35',NULL,'Atender',NULL,NULL,NULL),
(98,3,'2025-05-10 21:00:36',NULL,'Atender',NULL,NULL,NULL),
(99,3,'2025-05-10 21:00:37',NULL,'En curso',NULL,NULL,NULL),
(100,1,'2025-05-10 21:26:03',NULL,'Atender',NULL,NULL,NULL),
(101,3,'2025-05-10 21:26:05',NULL,'Atender',NULL,NULL,NULL),
(102,2,'2025-05-10 21:26:06',NULL,'Atender',NULL,NULL,NULL),
(103,3,'2025-05-10 21:26:08',NULL,'Atender',NULL,NULL,NULL),
(104,3,'2025-05-10 21:26:14',NULL,'Atender',NULL,NULL,NULL),
(105,3,'2025-05-10 21:26:15',NULL,'Atender',NULL,NULL,NULL),
(106,2,'2025-05-10 21:26:17',NULL,'Atender',NULL,NULL,NULL),
(107,2,'2025-05-10 21:27:44',NULL,'Atender',NULL,NULL,NULL),
(108,2,'2025-05-10 21:27:46',NULL,'Atender',NULL,NULL,NULL),
(109,1,'2025-05-10 21:27:48',NULL,'Atender',NULL,NULL,NULL),
(110,2,'2025-05-10 21:27:49',NULL,'Atender',NULL,NULL,NULL),
(111,1,'2025-05-10 21:27:50',NULL,'Atender',NULL,NULL,NULL),
(112,2,'2025-05-10 21:27:52',NULL,'Atender',NULL,NULL,NULL),
(113,3,'2025-05-10 21:27:54',NULL,'Atender',NULL,NULL,NULL),
(114,2,'2025-05-10 21:27:55',NULL,'Atender',NULL,NULL,NULL),
(115,3,'2025-05-10 21:27:57',NULL,'Atender',NULL,NULL,NULL),
(116,3,'2025-05-10 21:27:58',NULL,'Atender',NULL,NULL,NULL),
(117,3,'2025-05-10 21:27:59',NULL,'Atender',NULL,NULL,NULL),
(118,2,'2025-05-10 21:28:01',NULL,'Atender',NULL,NULL,NULL),
(119,2,'2025-05-10 21:28:02',NULL,'Atender',NULL,NULL,NULL),
(120,1,'2025-05-10 21:28:04',NULL,'Atender',NULL,NULL,NULL),
(121,1,'2025-05-11 15:18:41',NULL,'Atender',NULL,NULL,NULL),
(122,2,'2025-05-11 15:18:43',NULL,'Atender',NULL,NULL,NULL),
(123,1,'2025-05-11 15:18:45',NULL,'Atender',NULL,NULL,NULL),
(124,2,'2025-05-11 15:18:46',NULL,'Atender',NULL,NULL,NULL),
(125,2,'2025-05-11 15:18:47',NULL,'Atender',NULL,NULL,NULL),
(126,2,'2025-05-11 18:07:27',NULL,'Atender',NULL,NULL,NULL),
(127,3,'2025-05-11 18:07:28',NULL,'Atender',NULL,NULL,NULL),
(128,3,'2025-05-11 18:07:30',NULL,'Atender',NULL,NULL,NULL),
(129,3,'2025-05-11 18:07:31',NULL,'En curso',NULL,NULL,NULL),
(130,3,'2025-05-11 18:07:33',NULL,'Atender',NULL,NULL,NULL),
(131,1,'2025-05-11 18:07:34',NULL,'Atender',NULL,NULL,NULL),
(132,1,'2025-05-11 18:07:36',NULL,'En curso',NULL,NULL,NULL),
(133,1,'2025-05-11 18:17:16',NULL,'Atender',NULL,NULL,NULL),
(134,2,'2025-05-11 18:17:17',NULL,'Atender',NULL,NULL,NULL),
(135,1,'2025-05-11 18:17:19',NULL,'Atender',NULL,NULL,NULL),
(136,3,'2025-05-11 18:17:20',NULL,'Atender',NULL,NULL,NULL),
(137,3,'2025-05-11 18:17:22',NULL,'Atender',NULL,NULL,NULL),
(138,2,'2025-05-11 18:17:23',NULL,'Atender',NULL,NULL,NULL),
(139,2,'2025-05-11 18:17:25',NULL,'Atender',NULL,NULL,NULL),
(140,1,'2025-05-11 18:17:26',NULL,'Atender',NULL,NULL,NULL),
(141,2,'2025-05-11 18:17:28',NULL,'Atender',NULL,NULL,NULL),
(142,1,'2025-05-11 18:17:29',NULL,'Atender',NULL,NULL,NULL),
(143,3,'2025-05-11 18:17:31',NULL,'Finalizada',NULL,NULL,NULL),
(144,3,'2025-05-11 18:17:32',NULL,'En curso',NULL,NULL,NULL),
(145,3,'2025-05-11 18:17:34',NULL,'En curso',NULL,NULL,NULL),
(146,1,'2025-05-11 18:17:35',NULL,'Atender',NULL,NULL,NULL),
(147,2,'2025-05-11 18:17:37',NULL,'Finalizada',NULL,NULL,NULL),
(148,3,'2025-05-11 18:17:38',NULL,'Atender',NULL,NULL,NULL),
(149,2,'2025-05-11 18:17:40',NULL,'En curso',NULL,NULL,NULL),
(150,2,'2025-05-11 18:17:41',NULL,'En curso',NULL,NULL,NULL),
(151,2,'2025-05-12 18:45:02',NULL,'Atender',NULL,NULL,NULL),
(152,3,'2025-05-12 18:45:04',NULL,'Atender',NULL,NULL,NULL),
(153,2,'2025-05-12 18:45:05',NULL,'Atender',NULL,NULL,NULL),
(154,1,'2025-05-12 18:45:07',NULL,'En curso',NULL,NULL,NULL),
(155,3,'2025-05-12 18:45:08',NULL,'En curso',NULL,NULL,NULL),
(156,1,'2025-05-12 18:45:10',NULL,'Atender',NULL,NULL,NULL),
(157,2,'2025-05-12 18:45:11',NULL,'Atender',NULL,NULL,NULL),
(158,2,'2025-05-12 18:45:13',NULL,'Atender',NULL,NULL,NULL),
(159,3,'2025-05-12 18:45:14',NULL,'Atender',NULL,NULL,NULL),
(160,2,'2025-05-12 18:45:16',NULL,'Atender',NULL,NULL,NULL),
(161,3,'2025-05-12 18:45:17',NULL,'Atender',NULL,NULL,NULL),
(162,2,'2025-05-16 20:25:49',5,'Atender',5532267105,19.4144,-99.0262),
(163,2,'2025-05-16 20:25:50',3,'Atender',5542024576,19.4826,-99.0632),
(164,2,'2025-05-16 20:25:52',4,'Atender',5544535432,19.4285,-99.0582),
(165,2,'2025-05-16 20:25:53',4,'Finalizada',5546784790,19.4783,-99.0089),
(166,2,'2025-05-16 20:25:55',5,'En curso',5589273396,19.4429,-99.0583),
(167,2,'2025-05-16 20:33:44',3,'En curso',5668739284,19.458,-99.0038),
(168,2,'2025-05-17 12:21:47',3,'Atender',5620375801,19.449,-99.0199),
(169,2,'2025-05-17 12:21:49',4,'Atender',5654436229,19.4482,-99.0534),
(170,2,'2025-05-17 12:21:50',7,'Atender',5569984956,19.4692,-99.0373),
(171,2,'2025-05-17 12:21:52',4,'Atender',5580269031,19.408,-99.0444),
(172,2,'2025-05-17 12:21:53',6,'Finalizada',5524705739,19.4667,-99.0317),
(173,2,'2025-05-17 12:21:55',5,'En curso',5556590928,19.4772,-99.0974),
(174,2,'2025-05-17 12:21:56',5,'En curso',5617136437,19.4226,-99.0615),
(175,2,'2025-05-17 12:21:58',5,'En curso',5591670713,19.4467,-99.0527),
(176,2,'2025-05-17 12:21:59',6,'Finalizada',5627882801,19.4508,-99.017),
(177,2,'2025-05-17 12:22:01',7,'Finalizada',5535648456,19.4884,-99.0375),
(178,2,'2025-05-17 12:22:02',3,'En curso',5589611356,19.4003,-99.0841),
(179,2,'2025-05-18 11:12:38',7,'Atender',5642724673,19.404,-99.0257),
(180,2,'2025-05-18 11:12:40',5,'Atender',5574114819,19.4557,-99.0239),
(181,2,'2025-05-18 11:12:42',3,'En curso',5616693344,19.4024,-99.0197),
(182,2,'2025-05-18 11:12:43',6,'En curso',5597225065,19.4067,-99.0399),
(183,2,'2025-05-18 11:21:21',6,'Atender',5586155395,19.4974,-99.0327),
(184,2,'2025-05-18 11:21:23',4,'Atender',5555456112,19.4562,-99.056),
(185,2,'2025-05-18 11:21:24',6,'Atender',5684004372,19.4295,-99.0528),
(186,2,'2025-05-18 11:21:26',6,'Atender',5541748202,19.453,-99.0259),
(187,2,'2025-05-18 11:21:27',4,'Atender',5574839045,19.4231,-99.0477),
(188,2,'2025-05-18 11:21:29',7,'Finalizada',5535817657,19.4716,-99.0714),
(189,2,'2025-05-18 20:43:16',5,'Atender',5525794942,19.4027,-99.0987),
(190,2,'2025-05-18 20:43:17',7,'Atender',5646051663,19.4007,-99.0915),
(191,2,'2025-05-18 20:43:19',5,'Atender',5617626818,19.4042,-99.0916),
(192,2,'2025-05-18 20:43:20',5,'Atender',5591128748,19.4075,-99.096),
(193,2,'2025-05-18 20:43:22',5,'Atender',5649976189,19.4089,-99.0953),
(194,2,'2025-05-18 20:43:24',5,'Atender',5697737897,19.4041,-99.0995),
(195,2,'2025-05-18 20:43:25',6,'Atender',5586781527,19.4064,-99.0931),
(196,2,'2025-05-18 20:43:27',5,'Atender',5577231204,19.41,-99.0948),
(197,2,'2025-05-18 20:43:28',5,'Atender',5532354559,19.4072,-99.0983),
(198,2,'2025-05-18 20:58:46',5,'Atender',5542780155,19.3407,-99.1714),
(199,2,'2025-05-18 20:58:48',5,'Atender',5512331240,19.4633,-99.105),
(200,2,'2025-05-18 20:58:49',4,'Atender',5680443871,19.4298,-99.074),
(201,2,'2025-05-18 20:58:50',5,'Finalizada',5693444735,19.4666,-99.0394),
(202,2,'2025-05-18 21:21:45',7,'Atender',5528638867,19.4294,-99.0555),
(203,2,'2025-05-18 21:21:46',4,'Atender',5564706416,19.41,-99.1478),
(204,2,'2025-05-18 21:21:48',7,'Atender',5510041565,19.4371,-99.0852),
(205,2,'2025-05-18 21:21:49',6,'Atender',5577847782,19.3641,-99.0535),
(206,2,'2025-05-18 21:21:51',7,'Atender',5553433851,19.3675,-99.1064),
(207,2,'2025-05-18 21:21:52',6,'Atender',5511512165,19.4108,-99.1266),
(208,2,'2025-05-18 21:21:54',5,'Atender',5642749294,19.3861,-99.116),
(209,2,'2025-05-18 21:21:55',3,'Atender',5519626739,19.3359,-99.0878),
(210,2,'2025-05-18 21:21:57',6,'Atender',5669087975,19.4632,-99.0747),
(211,2,'2025-05-18 21:21:58',7,'Atender',5699034118,19.4601,-99.1664),
(212,2,'2025-05-18 21:22:00',5,'Atender',5537510741,19.3641,-99.1271),
(213,2,'2025-05-18 21:22:01',6,'Finalizada',5547338847,19.4577,-99.1665),
(214,3,'2025-05-19 01:15:11',7,'Atender',5629902913,19.4336,-99.0869),
(215,3,'2025-05-19 01:15:13',7,'Atender',5611155245,19.4375,-99.0234),
(216,3,'2025-05-19 01:15:14',7,'Atender',5680237069,19.3807,-99.0362),
(217,3,'2025-05-19 01:15:16',7,'Finalizada',5523957599,19.4335,-99.1174),
(218,3,'2025-05-19 01:15:17',6,'En curso',5562709805,19.4159,-99.1225),
(219,3,'2025-05-19 01:15:19',7,'Finalizada',5662094057,19.3369,-99.0789),
(220,3,'2025-05-19 01:22:11',6,'En curso',5662399776,19.3494,-99.1684),
(221,2,'2025-05-19 10:42:38',7,'Atender',5516310790,19.4393,-99.1302),
(222,2,'2025-05-19 10:42:40',6,'Atender',5617960542,19.4138,-99.1267),
(223,2,'2025-05-19 10:42:41',5,'Atender',5566037755,19.4527,-99.1666),
(224,2,'2025-05-19 10:42:43',5,'Atender',5691411157,19.4331,-99.0558),
(225,2,'2025-05-19 10:42:45',6,'Atender',5689770672,19.4635,-99.0525),
(226,2,'2025-05-19 10:42:46',6,'Atender',5585086883,19.3509,-99.0206),
(227,2,'2025-05-19 10:42:48',4,'Finalizada',5610952670,19.4389,-99.0495),
(228,2,'2025-05-19 13:22:43',5,'Atender',5632209881,19.3822,-99.0164),
(229,2,'2025-05-19 13:22:44',4,'Atender',5694545487,19.3705,-99.1063),
(230,2,'2025-05-19 13:22:46',6,'Atender',5574008649,19.447,-99.1194),
(231,2,'2025-05-19 13:22:47',6,'Finalizada',5570633410,19.3423,-99.0732),
(232,1,'2025-05-19 13:25:43',180,'Atender',5551111111,19.4326,-99.1332),
(233,1,'2025-05-19 13:28:43',120,'Atender',5552222222,19.4327,-99.1331),
(234,1,'2025-05-19 13:30:43',150,'Finalizada',5553333333,19.4325,-99.1333),
(235,1,'2025-05-19 13:32:43',90,'Finalizada',5554444444,19.4328,-99.133),
(236,1,'2025-05-19 13:35:45',60,'Finalizada',5555555555,19.4326,-99.1332),
(237,1,'2025-05-19 13:38:13',120,'Atender',5551111111,19.4326,-99.1332),
(238,1,'2025-05-19 13:41:13',90,'Atender',5551111112,19.4327,-99.1331),
(239,1,'2025-05-19 13:43:13',60,'Atender',5551111113,19.4325,-99.1333),
(240,1,'2025-05-19 13:53:13',180,'Atender',5552222221,19.44,-99.14),
(241,1,'2025-05-19 13:55:13',120,'Atender',5552222222,19.4401,-99.1401),
(242,1,'2025-05-19 13:56:13',150,'Atender',5552222223,19.4399,-99.1399),
(243,1,'2025-05-19 13:58:13',90,'Atender',5552222224,19.4402,-99.1402),
(244,1,'2025-05-19 14:08:13',180,'Atender',5553333331,19.45,-99.15),
(245,1,'2025-05-19 14:11:13',120,'Finalizada',5553333332,19.4501,-99.1501),
(246,1,'2025-05-19 14:13:13',150,'Atender',5553333333,19.4499,-99.1499),
(247,1,'2025-05-19 14:18:15',60,'En curso',5550000000,19.5,-99.2),
(248,3,'2025-05-19 18:34:06',3,'Atender',5539534664,19.4444,-99.0634),
(249,3,'2025-05-19 18:34:07',3,'Atender',5530647627,19.4826,-99.0829),
(250,3,'2025-05-19 18:34:09',7,'Finalizada',5545860595,19.3258,-99.1096),
(251,2,'2025-05-19 18:45:02',4,'Atender',5640067425,19.4649,-99.0775),
(252,2,'2025-05-19 18:45:03',5,'Atender',5667054018,19.3613,-99.1648),
(253,2,'2025-05-19 18:45:05',5,'Atender',5552725552,19.3896,-99.0079),
(254,2,'2025-05-19 18:45:06',5,'Atender',5595760765,19.4447,-99.1591),
(255,2,'2025-05-19 18:45:08',5,'Atender',5654575766,19.4036,-99.1715),
(256,2,'2025-05-19 18:45:09',7,'Atender',5581000427,19.4431,-99.1178),
(257,2,'2025-05-19 18:45:11',5,'Atender',5681618404,19.4687,-99.1099),
(258,2,'2025-05-19 18:45:12',7,'Atender',5539016706,19.4195,-99.1711),
(259,2,'2025-05-19 18:45:14',4,'Atender',5563764948,19.4488,-99.0382),
(260,2,'2025-05-19 18:45:15',4,'Atender',5569188222,19.4376,-99.1761),
(261,2,'2025-05-19 18:45:17',5,'Atender',5693637264,19.4678,-99.0826),
(262,2,'2025-05-19 18:45:18',7,'En curso',5551762831,19.4201,-99.0491),
(263,2,'2025-05-19 18:45:20',4,'Atender',5589771336,19.3789,-99.1098),
(264,2,'2025-05-19 18:45:21',6,'Atender',5581840527,19.4426,-99.1689),
(265,2,'2025-05-19 18:45:23',4,'Atender',5650972832,19.4015,-99.1002),
(266,2,'2025-05-19 18:45:24',6,'Atender',5544513136,19.4363,-99.0171),
(267,2,'2025-05-19 18:45:26',4,'Atender',5639224548,19.4316,-99.0123),
(268,2,'2025-05-19 18:45:27',3,'Atender',5650601122,19.3732,-99.0286),
(269,2,'2025-05-19 18:45:29',3,'Atender',5583790385,19.4689,-99.0586),
(270,2,'2025-05-19 18:45:30',7,'Atender',5690996778,19.4745,-99.1421),
(271,2,'2025-05-19 18:45:32',4,'Atender',5683827543,19.4116,-99.1462),
(272,2,'2025-05-19 18:45:33',5,'Atender',5692432680,19.4075,-99.0657),
(273,2,'2025-05-19 18:45:35',5,'Atender',5581062428,19.3757,-99.1681),
(274,2,'2025-05-19 18:45:36',3,'Atender',5692425156,19.3919,-99.1309),
(275,2,'2025-05-19 18:45:38',7,'En curso',5660259927,19.4037,-99.0292),
(276,2,'2025-05-19 18:45:39',7,'En curso',5614276423,19.379,-99.1383),
(277,2,'2025-05-19 18:45:41',4,'Finalizada',5641788092,19.3358,-99.0701),
(278,2,'2025-05-19 18:45:43',4,'En curso',5583459374,19.3192,-99.0941),
(279,2,'2025-05-19 18:45:44',4,'En curso',5541095620,19.3817,-99.008),
(280,2,'2025-05-19 18:45:46',3,'En curso',5583253233,19.34,-99.1453),
(281,2,'2025-05-20 16:46:17',5,'En curso',5593400213,19.3739,-99.0613),
(282,2,'2025-05-20 16:57:33',6,'Atender',5671850242,19.3404,-99.0863),
(283,2,'2025-05-20 16:57:35',6,'Atender',5599542043,19.4794,-99.1274),
(284,2,'2025-05-20 16:57:36',4,'Atender',5630530126,19.3887,-99.0868),
(285,2,'2025-05-20 16:57:38',4,'En curso',5654228264,19.3803,-99.1055),
(286,2,'2025-05-20 16:57:39',7,'En curso',5680250225,19.3634,-99.0682),
(287,2,'2025-05-21 19:15:43',3,'Atender',5527769831,19.4436,-99.1423),
(288,2,'2025-05-21 19:15:44',7,'Atender',5537447229,19.3776,-99.0433),
(289,2,'2025-05-21 19:15:46',3,'Atender',5527330270,19.3315,-99.0807),
(290,2,'2025-05-21 19:15:47',4,'Atender',5698787473,19.3363,-99.0518),
(291,2,'2025-05-21 19:15:49',5,'Atender',5670312775,19.4715,-99.1187),
(292,2,'2025-05-21 19:15:50',3,'Atender',5515822739,19.4249,-99.089),
(293,2,'2025-05-21 19:15:52',5,'Atender',5642829108,19.3974,-99.1037),
(294,2,'2025-05-21 19:15:53',7,'Atender',5524948911,19.4383,-99.1668),
(295,2,'2025-05-21 19:15:55',5,'Atender',5540610984,19.3935,-99.0588),
(296,2,'2025-05-21 19:15:56',3,'Atender',5642529506,19.332,-99.1011),
(297,2,'2025-05-21 19:15:58',7,'Atender',5571444628,19.3752,-99.136),
(298,2,'2025-05-21 19:15:59',6,'Atender',5565269401,19.3993,-99.0892),
(299,2,'2025-05-21 19:16:01',5,'Atender',5516708050,19.4672,-99.066),
(300,2,'2025-05-21 19:16:02',4,'Finalizada',5623179690,19.3468,-99.1066),
(301,2,'2025-05-21 19:16:04',3,'Atender',5622182987,19.3951,-99.1275),
(302,2,'2025-05-21 19:16:05',5,'En curso',5651391085,19.438,-99.1328),
(303,2,'2025-05-21 19:16:07',4,'Finalizada',5550503165,19.3559,-99.0699),
(304,2,'2025-05-22 14:51:32',6,'Atender',5524716162,19.3819,-99.1483),
(305,2,'2025-05-22 14:51:34',4,'Atender',5536685686,19.3639,-99.1634),
(306,2,'2025-05-22 14:51:35',3,'Atender',5567556491,19.3681,-99.0641),
(307,2,'2025-05-22 18:44:34',6,'Atender',5681874503,19.3392,-99.0496),
(308,2,'2025-05-22 18:44:36',5,'Atender',5621577805,19.4346,-99.0989),
(309,2,'2025-05-22 18:44:37',3,'Atender',5535616560,19.4497,-99.1166),
(310,2,'2025-05-22 18:44:39',3,'Atender',5694994584,19.3934,-99.0988),
(311,2,'2025-05-22 18:44:40',7,'Atender',5566139986,19.413,-99.0108),
(312,2,'2025-05-22 18:44:42',6,'Atender',5690199982,19.4407,-99.1705),
(313,2,'2025-05-22 18:44:43',3,'En curso',5546547616,19.4512,-99.0955);
/*!40000 ALTER TABLE `llamadas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `id_location` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `direccion` text DEFAULT NULL,
  `latitud` decimal(10,8) NOT NULL,
  `longitud` decimal(11,8) NOT NULL,
  PRIMARY KEY (`id_location`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES
(1,'SSC Comando Central','Av. Tlaxcala 148, Roma Sur',19.41360000,-99.16330000),
(2,'Policía Cibernética','Av. Río Churubusco 1431',19.39780000,-99.13350000),
(3,'Hospital General de México','Dr. Balmis 148, Doctores',19.42040000,-99.15580000),
(4,'C5 Comando de Emergencias','Av. Chapultepec 544, Roma',19.41970000,-99.17140000),
(5,'SSC Cuauhtémoc Sector Centro','República de GUatemala 94',19.43250000,-99.13330000),
(6,'Policía TUrística Zona Rosa','Londres 102, Juárez',19.42640000,-99.16780000),
(7,'Policía Bancaria e Industrial Centro','Av. Juárez 68, Col. Centro',19.43390000,-99.14080000),
(8,'Policía Bancaria e Industrial Centro','Av. Juárez 68, Col. Centro',19.43390000,-99.14080000),
(9,'Hospital General La Villa','Av. San Juan de Aragón No 28, Col. Granjas Modernas. Delegación Gustavo A. Madero C.P. 07460.',19.48077400,-99.10337100),
(10,'Hospital General Dr. Rubén Leñero','Plan de San Luis y Díaz Mirón, Col. Casco de Santo Tomás Delegación Miguel Hidalgo C.P. 11340.',19.45098700,-99.16918900),
(11,'Hospital General Iztapalapa C.E.E.','Avenida Ermita Iztapalapa no. 3018, Col. Citlali; Delegación Iztapalapa, CP 09660',19.34345100,-99.02786300),
(12,'Hospital Pediátrico Iztapalapa','Calzada Ermita Iztapalapa No. 780, Col. Granjas San Antonio, Delegación Iztapalapa C.P. 09070.',19.35654800,-99.10768900),
(13,'Hospital Pediátrico Moctezuma','Oriente 158 No. 189, Col. Moctezuma 2da. Sección, Delegación Venustiano Carranza C.P. 15530.',19.43285200,-99.09835800),
(14,'Hospital Pediátrico Coyoacán','Moctezuma No. 18, Col. Del Carmen Coyoacán, Delegación Coyoacán C.P. 0400.',19.34573700,-99.16772500),
(15,'Hospital Pediátrico San Juan de Aragón','Av. 506 entre calle 517 y 521, Col. San Juan de Aragón 1a. Sección Del. Gustavo A. Madero C.P. 07969.',19.45730600,-99.09281200),
(16,'Hospital Pediátrico Villa','Avenida Cantera, Esq. Hidalgo S/n, Col. Estanzuela Delegación Gustavo A. Madero C.P. 07050.',19.48755100,-99.11387600),
(17,'Hospital Pediátrico Iztacalco','Avenida Coyuya y Terraplén de Río Frío S/n, Col. La Cruz, Delegación Iztacalco C.P. 08310.',19.40237600,-99.11794300),
(18,'Hospital Pediátrico Peralvillo','Tolnahuac No. 14, Col. San Simón Delegación Cuauhtémoc C.P. 06920.',19.46025100,-99.14102200),
(19,'Hospital General Xoco','Av. México Coyoacán s/n, Esq. Bruno Traven, Col. General Anaya, Delegación Benito Juárez C.P. 30340.',19.36005000,-99.16316200),
(20,'Hospital Pediátrico Tacubaya','Calle Carlos Lazo No.25, Esq. Gaviota, Col. Tacubaya Delegación Miguel Hidalgo C.P. 11870.',19.40247500,-99.19084200),
(21,'Hospital Materno Infantil Topilejo','Calzada Santa Cruz No. 1, Col.San Miguel Topilejo, Delegación Tlalpan C.P. 14500.',19.19930800,-99.14023600),
(22,'Hospital General Balbuena','Cecilio Robelo y sur No.103, Col. Aeronáutica Militar, Delegación Venustiano Carranza C.P. 15900.',19.42490600,-99.11530300),
(23,'Hospital Materno Infantil Cuautepec','Emiliano Zapata No 17, Col. Cuautepec Barrio Bajo Delegación Gustavo A. Madero C.P. 07200.',19.53980300,-99.14078500),
(24,'Hospital Pediátrico Legaria','Calzada Legaria 371, Col. México Nuevo, Delegación Miguel Hidalgo C. P. 11260.',19.45073300,-99.20293400),
(25,'Hospital General Dr. Enrique Cabrera','Av. Centenario, esquina Prolongación 5 de mayo, Col. Exhacienda de Tarango, Delegación Álvaro Obregón',19.36196100,-99.22467800),
(26,'Hospital de Especialidades Dr. Belisario Domínguez','Av. Tlahuac No. 4866, Esq. Zacatlan, Col. San Lorenzo Tezonco, Delegación Iztapalapa C.P. 09790.',19.30676800,-99.06546000),
(27,'Hospital General Dr. Gregorio Salas Flores','Carmen No. 41, Col. Centro Delegación Cuauhtemoc C.P 06020.',19.43764300,-99.12935600),
(28,'Hospital Pediátrico Azcapotzalco','Los Reyes, Azcapotzalco, Ciudad de México, DF',19.48449100,-99.18560800),
(29,'Hospital Materno Infantil Cuajimalpa','Av. 16 de Septiembre s/n, Col. Contadero, Delegación Cuajimalpa de Morelos C.P.06500.',19.34743300,-99.30111700),
(30,'Hospital Materno Infantil Dr. Nicolás M. Cedillo','Gustavo J. S/n, Esq. Víctor Hernández Covarrubias, Col. Unidad Francisco Villa Delegación Azcapotzalco C.P. 02400.',19.49825100,-99.20330000),
(31,'Hospital Materno Infantil Tláhuac','Av. Tláhuac Chalco No. 231, Col. La Habana, Delegación Tláhuac C.P. 13050.',19.26550500,-98.99792500),
(32,'C2 Centro','Cuauhtémoc',19.43177000,-99.14669000),
(33,'C2 Sur','Benito Juárez',19.37073000,-99.16020000),
(34,'C2 Norte','Gustavo A. Madero',19.48315400,-99.11701600),
(35,'C2 Centro','Cuauhtémoc',19.43177000,-99.14669000),
(36,'C2 Sur','Benito Juárez',19.37073000,-99.16020000),
(37,'C2 Norte','Gustavo A. Madero',19.48315400,-99.11701600),
(38,'C2 Poniente','Miguel Hidalgo',19.39094000,-99.19933000),
(39,'C2 Oriente','Iztapalapa',19.31301000,-99.06510000),
(40,'C5','Venustiano Carranza',19.42523000,-99.11805000);
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id_mensaje` int(11) NOT NULL AUTO_INCREMENT,
  `id_chat` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `mensaje` text NOT NULL,
  `fecha_envio` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_mensaje`),
  KEY `id_chat` (`id_chat`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`id_chat`) REFERENCES `chats` (`id_chat`) ON DELETE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES
(1,1,3,'hola','2025-05-19 05:34:31'),
(2,2,3,'chat de operadores','2025-05-19 05:35:03'),
(3,2,3,'nadie mande mensajes que son de otro departamento por favor','2025-05-19 05:35:22'),
(4,3,3,'Hola a todos','2025-05-20 00:38:04'),
(5,5,2,'Hola Leon Casas','2025-05-22 01:41:35'),
(6,5,2,'Buenas tardes','2025-05-22 01:41:44');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prank_calls`
--

DROP TABLE IF EXISTS `prank_calls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `prank_calls` (
  `folio_prank_call` int(11) NOT NULL AUTO_INCREMENT,
  `id_llamada` int(11) DEFAULT NULL,
  `motivo` varchar(255) NOT NULL COMMENT 'Descripción de la llamada falsa',
  `tipo_broma` varchar(50) NOT NULL COMMENT 'Categoría de la broma',
  `hora_prank_call` time NOT NULL DEFAULT current_timestamp(),
  `fecha_prank_call` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` datetime DEFAULT NULL,
  `id_operador` int(11) NOT NULL COMMENT 'Operador que clasificó la llamada',
  `telefono_origen` varchar(20) NOT NULL,
  `clasificacion` enum('Inocente','Molesta','Peligrosa') NOT NULL DEFAULT 'Inocente',
  `acciones_tomadas` text DEFAULT NULL COMMENT 'Medidas aplicadas al número',
  `bloqueo_numero` tinyint(1) DEFAULT 0 COMMENT 'Si se bloqueó el número',
  `colonia` varchar(255) DEFAULT NULL,
  `localidad` varchar(255) DEFAULT NULL,
  `municipio` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`folio_prank_call`),
  KEY `id_llamada` (`id_llamada`),
  CONSTRAINT `prank_calls_ibfk_1` FOREIGN KEY (`id_llamada`) REFERENCES `llamadas` (`id_llamada`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prank_calls`
--

LOCK TABLES `prank_calls` WRITE;
/*!40000 ALTER TABLE `prank_calls` DISABLE KEYS */;
INSERT INTO `prank_calls` VALUES
(1,1,'Niños jugando con el teléfono','Llamada de broma por menores','15:30:00','2025-05-12 00:00:00',NULL,2,'5551234567','Inocente','Advertencia a los padres',0,'Centro','Ciudad de México','CDMX'),
(2,2,'Llamada muda','Llamada muda','22:45:00','2025-05-11 00:00:00',NULL,3,'5559876543','Molesta','Registro en sistema',0,'Del Valle','Ciudad de México','CDMX'),
(3,3,'Lenguaje obsceno','Llamada con palabras obscenas','20:15:00','2025-05-10 00:00:00',NULL,1,'5554567890','Peligrosa','Bloqueo temporal',1,'Roma Norte','Ciudad de México','CDMX'),
(4,NULL,'Reporte falso de incendio','Simulación de emergencia','11:20:00','2025-05-09 00:00:00',NULL,4,'5557890123','Peligrosa','Investigación en curso',1,'Polanco','Ciudad de México','CDMX'),
(5,NULL,'Llamada de prueba','Llamada de prueba','09:05:00','2025-05-08 00:00:00',NULL,2,'5552345678','Inocente','Verificación de sistema',0,'Nápoles','Ciudad de México','CDMX'),
(6,NULL,'Llamadas repetidas del mismo número','Acoso telefónico','19:30:00','2025-05-07 00:00:00',NULL,3,'5558765432','Peligrosa','Bloqueo permanente',1,'Condesa','Ciudad de México','CDMX'),
(7,NULL,'Amenaza de bomba falsa','Amenaza falsa','14:50:00','2025-05-06 00:00:00',NULL,1,'5553456789','Peligrosa','Reporte a autoridades',1,'Santa Fe','Ciudad de México','CDMX'),
(8,NULL,'Niños jugando con el servicio de emergencia','Llamada de broma por menores','16:20:00','2025-05-05 00:00:00',NULL,4,'5556543210','Inocente','Educación a padres',0,'Coyoacán','Ciudad de México','CDMX'),
(9,NULL,'Adulto imitando sonidos de emergencia','Llamada de broma por adultos','21:10:00','2025-05-04 00:00:00',NULL,2,'5554321098','Molesta','Advertencia formal',0,'San Ángel','Ciudad de México','CDMX'),
(10,NULL,'Reporte falso de ataque cardíaco','Simulación de emergencia médica','10:45:00','2025-05-03 00:00:00',NULL,3,'5553210987','Peligrosa','Investigación en curso',1,'Tlalpan','Ciudad de México','CDMX'),
(11,NULL,'Risas y bromas en el fondo','Llamada de broma por jóvenes','17:30:00','2025-05-02 00:00:00',NULL,1,'5552109876','Inocente','Registro en sistema',0,'Xochimilco','Ciudad de México','CDMX'),
(12,NULL,'Reporte falso de robo a mano armada','Simulación de delito','23:15:00','2025-05-01 00:00:00',NULL,4,'5551098765','Peligrosa','Reporte a autoridades',1,'Iztapalapa','Ciudad de México','CDMX'),
(13,217,'Llamada de broma','Llamada de broma por adultos','10:42:30','2025-05-19 10:42:30',NULL,2,'5523957599','Inocente','Se registró la llamada como falsa en el sistema',0,NULL,NULL,NULL),
(14,227,'Llamada de broma','Llamada de broma por adultos','10:43:35','2025-05-19 10:43:35',NULL,2,'5610952670','Inocente','Se registró la llamada como falsa en el sistema',0,NULL,NULL,NULL),
(15,245,'Llamada de broma','Llamada de broma por adultos','18:34:51','2025-05-19 18:34:51',NULL,3,'5553333332','Inocente','Se registró la llamada como falsa en el sistema',0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `prank_calls` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER prevent_dual_classification_prank
BEFORE INSERT ON prank_calls
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM incidentes WHERE id_llamada = NEW.id_llamada) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'This call is already classified as an incident';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `recursos`
--

DROP TABLE IF EXISTS `recursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `recursos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `insumos` varchar(255) NOT NULL,
  `vehiculos` varchar(50) NOT NULL,
  `personal` int(11) NOT NULL,
  `estatus` varchar(50) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_registro` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recursos`
--

LOCK TABLES `recursos` WRITE;
/*!40000 ALTER TABLE `recursos` DISABLE KEYS */;
/*!40000 ALTER TABLE `recursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_rol` enum('Administrador','Operador','Despachador','Supervisor_Op','Supervisor_Desp') NOT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nombre_rol` (`nombre_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES
(1,'Administrador'),
(2,'Operador'),
(3,'Despachador'),
(4,'Supervisor_Op'),
(5,'Supervisor_Desp');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_unidad`
--

DROP TABLE IF EXISTS `tipos_unidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_unidad` (
  `id_tipo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_tipo` varchar(50) NOT NULL,
  PRIMARY KEY (`id_tipo`),
  UNIQUE KEY `nombre_tipo` (`nombre_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_unidad`
--

LOCK TABLES `tipos_unidad` WRITE;
/*!40000 ALTER TABLE `tipos_unidad` DISABLE KEYS */;
INSERT INTO `tipos_unidad` VALUES
(1,'Ambulancia'),
(5,'Policía'),
(3,'Protección_civil');
/*!40000 ALTER TABLE `tipos_unidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidades`
--

DROP TABLE IF EXISTS `unidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `unidades` (
  `id_unidad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_unidad` varchar(50) NOT NULL,
  `id_tipo_unidad` int(11) NOT NULL,
  `estado` enum('Disponible','En_servicio','Mantenimiento','Inactiva') DEFAULT 'Disponible',
  `ubicacion_actual` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_unidad`),
  KEY `id_tipo_unidad` (`id_tipo_unidad`),
  CONSTRAINT `unidades_ibfk_1` FOREIGN KEY (`id_tipo_unidad`) REFERENCES `tipos_unidad` (`id_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidades`
--

LOCK TABLES `unidades` WRITE;
/*!40000 ALTER TABLE `unidades` DISABLE KEYS */;
INSERT INTO `unidades` VALUES
(1,'Ambulancia',1,'En_servicio','2345678909876543234567890'),
(2,'Ambulancia',1,'En_servicio','2345678909876543234567890'),
(3,'Ambulancia',1,'En_servicio','2345678909876543234567890'),
(4,'Ambulancia',1,'En_servicio','2345678909876543234567890'),
(6,'Policía',5,'En_servicio','2345678909876543234567890'),
(7,'Policía',5,'En_servicio','2345678909876543234567890'),
(8,'Policía',5,'En_servicio','2345678909876543234567890'),
(9,'Policía',5,'En_servicio','2345678909876543234567890'),
(10,'Ambulancia',1,'En_servicio','2345678909876543234567890'),
(11,'Ambulancia',1,'Disponible','2345678909876543234567890'),
(12,'Ambulancia',1,'Disponible','2345678909876543234567890'),
(13,'Ambulancia',1,'Disponible','2345678909876543234567890');
/*!40000 ALTER TABLE `unidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `id_personal` int(11) DEFAULT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `id_horario` int(11) DEFAULT NULL,
  `rol_id` int(11) NOT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  `activo` tinyint(1) DEFAULT 1,
  `calificacion` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `correo` (`correo`),
  KEY `id_personal` (`id_personal`),
  KEY `id_horario` (`id_horario`),
  KEY `rol_id` (`rol_id`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_personal`) REFERENCES `gestion_personal` (`id_personal`) ON DELETE SET NULL,
  CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`id_horario`) REFERENCES `horarios` (`id_horario`) ON DELETE SET NULL,
  CONSTRAINT `usuarios_ibfk_3` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES
(1,1,'Eliza','Juarez','elidejoji@ejemplo.com','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',2,1,'2025-04-20 13:02:23',1,NULL),
(2,2,'juan','perez','juan@gmail.com','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',3,2,'2025-04-20 13:10:29',1,NULL),
(3,3,'Sara','Juarez','sara@gmail.com','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',1,3,'2025-04-20 13:21:51',1,NULL),
(4,4,'Lia','Vallarta','lia@hotmail.com','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',4,3,'2025-04-22 13:19:19',1,NULL),
(5,5,'Mila','Rojas','mila@gmail.com','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',3,4,'2025-04-22 13:34:04',1,NULL),
(6,6,'Leon','Casas','leon@gmail.com','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',1,5,'2025-04-22 13:37:58',1,NULL),
(7,7,'Luna','Villareal','luna@hotmail.com','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',2,2,'2025-04-22 14:23:59',1,NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-22 22:08:35

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asignaciones_unidades`
--

LOCK TABLES `asignaciones_unidades` WRITE;
/*!40000 ALTER TABLE `asignaciones_unidades` DISABLE KEYS */;
INSERT INTO `asignaciones_unidades` VALUES
(1,1,1,'2025-04-22 13:29:30',2,'jajjajajja');
/*!40000 ALTER TABLE `asignaciones_unidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_mensajes`
--

DROP TABLE IF EXISTS `chat_mensajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_mensajes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `mensaje` text NOT NULL,
  `fecha_envio` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `chat_mensajes_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_mensajes`
--

LOCK TABLES `chat_mensajes` WRITE;
/*!40000 ALTER TABLE `chat_mensajes` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_mensajes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_participants`
--

DROP TABLE IF EXISTS `chat_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_participants` (
  `id_participant` int(11) NOT NULL AUTO_INCREMENT,
  `id_chat` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `joined_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_participant`),
  KEY `id_chat` (`id_chat`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `chat_participants_ibfk_1` FOREIGN KEY (`id_chat`) REFERENCES `chats` (`id_chat`) ON DELETE CASCADE,
  CONSTRAINT `chat_participants_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_participants`
--

LOCK TABLES `chat_participants` WRITE;
/*!40000 ALTER TABLE `chat_participants` DISABLE KEYS */;
INSERT INTO `chat_participants` VALUES
(1,1,2,'2025-05-07 21:37:16'),
(2,1,1,'2025-05-07 21:37:16'),
(3,2,2,'2025-05-07 21:47:03'),
(4,2,4,'2025-05-07 21:47:03'),
(5,2,3,'2025-05-07 21:47:03'),
(6,3,2,'2025-05-07 21:48:17'),
(7,3,4,'2025-05-07 21:48:17'),
(8,3,3,'2025-05-07 21:48:17'),
(9,4,2,'2025-05-07 21:49:36'),
(10,4,4,'2025-05-07 21:49:36'),
(11,4,3,'2025-05-07 21:49:36');
/*!40000 ALTER TABLE `chat_participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_rooms`
--

DROP TABLE IF EXISTS `chat_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_rooms` (
  `id_portario` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `is_private` tinyint(1) DEFAULT 0,
  `roll_id` int(11) NOT NULL,
  `from_register` datetime DEFAULT current_timestamp(),
  `active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id_portario`),
  KEY `roll_id` (`roll_id`),
  CONSTRAINT `chat_rooms_ibfk_1` FOREIGN KEY (`roll_id`) REFERENCES `roles` (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_rooms`
--

LOCK TABLES `chat_rooms` WRITE;
/*!40000 ALTER TABLE `chat_rooms` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_rooms` ENABLE KEYS */;
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
  `is_group` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_chat`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chats`
--

LOCK TABLES `chats` WRITE;
/*!40000 ALTER TABLE `chats` DISABLE KEYS */;
INSERT INTO `chats` VALUES
(1,'Asunto muy importante',1,'2025-05-07 21:37:16'),
(2,'',1,'2025-05-07 21:47:03'),
(3,'Despachadores',1,'2025-05-07 21:48:17'),
(4,'',1,'2025-05-07 21:49:36');
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
  PRIMARY KEY (`folio_incidente`),
  KEY `id_usuario_reporta` (`id_usuario_reporta`),
  KEY `id_unidad_asignada` (`id_unidad_asignada`),
  KEY `id_emergency_type` (`id_emergency_type`),
  KEY `fk_incidente_llamada` (`id_llamada`),
  CONSTRAINT `fk_incidente_llamada` FOREIGN KEY (`id_llamada`) REFERENCES `llamadas` (`id_llamada`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `incidentes_ibfk_1` FOREIGN KEY (`id_usuario_reporta`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL,
  CONSTRAINT `incidentes_ibfk_2` FOREIGN KEY (`id_unidad_asignada`) REFERENCES `unidades` (`id_unidad`) ON DELETE SET NULL,
  CONSTRAINT `incidentes_ibfk_3` FOREIGN KEY (`id_emergency_type`) REFERENCES `EmergencyTypes` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidentes`
--

LOCK TABLES `incidentes` WRITE;
/*!40000 ALTER TABLE `incidentes` DISABLE KEYS */;
INSERT INTO `incidentes` VALUES
(1,'Accidente en la calle Venus','Medico','00:00:00','2025-04-22 19:23:14',NULL,5,NULL,NULL,'555678978',2,'TTY','Media',1,NULL,NULL,NULL,NULL,NULL),
(2,'Gatito atrapado en un arbol','Proteccion Civil','12:30:54','2025-04-22 22:30:54',NULL,1,NULL,NULL,'5567890656',7,'Emergencia Real','Alta',1,NULL,NULL,NULL,NULL,NULL),
(3,'un evento','0','20:35:54','2025-04-27 20:35:54',NULL,15,19.42511056,-99.14508820,'23420938409234',2,'Broma','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(4,'un evento','0','20:41:51','2025-04-27 20:41:51',NULL,15,19.42511056,-99.14508820,'23420938409234',2,'Broma','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(5,'deslavamiento','0','20:42:59','2025-04-27 20:42:59',NULL,30,19.45262900,-99.08441900,'5521036756',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(6,'se cayó un árbol','0','01:18:38','2025-04-28 01:18:38',NULL,5,19.44214000,-99.13038500,'5527564922',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(7,'Se cayó un perrito','0','19:24:46','2025-04-28 19:24:46',NULL,4,19.43825500,-99.13415800,'5521036756',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(8,'Llamada simulada 8','0','06:23:06','2025-04-29 06:23:06',NULL,2,19.48181700,-99.01711000,'5551234567',2,'TTY','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(9,'Llamada simulada 2','0','06:23:08','2025-04-29 06:23:08',NULL,5,19.46403700,-99.02334700,'5551234567',2,'TTY','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(10,'Llamada simulada 54','0','06:23:09','2025-04-29 06:23:09',NULL,2,19.42094000,-99.04500700,'5551234567',2,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(11,'Llamada simulada 43','0','06:23:11','2025-04-29 06:23:11',NULL,2,19.41115100,-99.03531900,'5551234567',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(12,'Llamada simulada 27','0','06:23:12','2025-04-29 06:23:12',NULL,2,19.41781000,-99.05569000,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(13,'Llamada simulada 48','0','06:23:14','2025-04-29 06:23:14',NULL,1,19.40632000,-99.04137700,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(14,'Llamada simulada 78','0','06:23:16','2025-04-29 06:23:16',NULL,3,19.46568300,-99.03149500,'5551234567',2,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(15,'Llamada simulada 59','0','06:23:17','2025-04-29 06:23:17',NULL,2,19.49887100,-99.02238600,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(16,'Llamada simulada 3','0','16:16:59','2025-04-29 16:16:59',NULL,4,19.43903600,-99.05198100,'5551234567',2,'TTY','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(17,'Llamada simulada 38','0','16:17:01','2025-04-29 16:17:01',NULL,1,19.47214100,-99.02823700,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(18,'Llamada simulada 23','0','16:17:02','2025-04-29 16:17:02',NULL,2,19.49807000,-99.04867500,'5551234567',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(19,'Llamada simulada 94','0','16:17:04','2025-04-29 16:17:04',NULL,2,19.49961500,-99.09412100,'5551234567',2,'Broma','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(20,'Llamada simulada 69','0','16:17:05','2025-04-29 16:17:05',NULL,2,19.41622800,-99.03763500,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(21,'Llamada simulada 3','0','16:17:07','2025-04-29 16:17:07',NULL,2,19.48932400,-99.09086900,'5551234567',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(22,'Llamada simulada 71','0','16:17:08','2025-04-29 16:17:08',NULL,3,19.40543800,-99.09668000,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(23,'Llamada simulada 91','0','16:17:10','2025-04-29 16:17:10',NULL,2,19.40433400,-99.01845700,'5551234567',2,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(24,'Llamada simulada 59','0','16:17:31','2025-04-29 16:17:31',NULL,3,19.43300700,-99.03408100,'5551234567',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(25,'Llamada simulada 83','0','16:17:32','2025-04-29 16:17:32',NULL,5,19.46151300,-99.02572700,'5551234567',2,'Broma','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(26,'Llamada simulada 84','0','16:17:34','2025-04-29 16:17:34',NULL,1,19.45999600,-99.06367600,'5551234567',2,'Broma','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(27,'Llamada simulada 97','0','16:17:35','2025-04-29 16:17:35',NULL,1,19.45289700,-99.03548400,'5551234567',2,'TTY','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(28,'Llamada simulada 17','0','16:17:37','2025-04-29 16:17:37',NULL,1,19.42199000,-99.02069900,'5551234567',2,'TTY','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(29,'Llamada simulada 73','0','16:17:38','2025-04-29 16:17:38',NULL,2,19.42006200,-99.09841500,'5551234567',2,'TTY','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(30,'Llamada simulada 80','0','16:52:37','2025-04-29 16:52:37',NULL,1,19.46246200,-99.09773400,'5551234567',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(31,'Llamada simulada 89','0','16:52:38','2025-04-29 16:52:38',NULL,1,19.46115900,-99.02871400,'5551234567',2,'TTY','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(32,'Llamada simulada 84','0','16:52:40','2025-04-29 16:52:40',NULL,3,19.48367000,-99.08320600,'5551234567',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(33,'Llamada simulada 61','0','16:52:41','2025-04-29 16:52:41',NULL,2,19.43159000,-99.09645400,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(34,'Llamada simulada 37','0','16:52:43','2025-04-29 16:52:43',NULL,2,19.41741200,-99.01769600,'5551234567',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(35,'Llamada simulada 76','0','16:52:44','2025-04-29 16:52:44',NULL,5,19.49739600,-99.00580800,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(36,'Llamada simulada 54','0','16:52:46','2025-04-29 16:52:46',NULL,2,19.45346500,-99.02323900,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(37,'Llamada simulada 44','0','16:52:47','2025-04-29 16:52:47',NULL,4,19.48052600,-99.00908000,'5551234567',2,'TTY','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(38,'Llamada simulada 8','0','16:52:49','2025-04-29 16:52:49',NULL,4,19.42850400,-99.01441000,'5551234567',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(39,'Llamada simulada 35','0','16:52:50','2025-04-29 16:52:50',NULL,2,19.41259700,-99.03617300,'5551234567',2,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(40,'Llamada simulada 64','0','16:52:52','2025-04-29 16:52:52',NULL,5,19.47372900,-99.06553100,'5551234567',2,'TTY','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(41,'Llamada simulada 75','0','16:52:53','2025-04-29 16:52:53',NULL,4,19.47357200,-99.04098500,'5551234567',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(42,'Llamada simulada 40','0','16:52:55','2025-04-29 16:52:55',NULL,2,19.43676600,-99.08818200,'5551234567',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(43,'Llamada simulada 2','0','16:52:56','2025-04-29 16:52:56',NULL,1,19.44783900,-99.05554100,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(44,'Llamada simulada 75','0','16:53:05','2025-04-29 16:53:05',NULL,3,19.47415700,-99.09480700,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(45,'Llamada simulada 80','0','16:53:06','2025-04-29 16:53:06',NULL,5,19.41032700,-99.03744400,'5551234567',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(46,'Llamada simulada 90','0','17:27:09','2025-04-29 17:27:09',NULL,2,19.45292800,-99.02318400,'5551234567',2,'Broma','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(47,'Llamada simulada 58','0','17:27:10','2025-04-29 17:27:10',NULL,4,19.48019100,-99.00620600,'5551234567',2,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(48,'Llamada simulada 55','0','17:27:12','2025-04-29 17:27:12',NULL,2,19.46146200,-99.08684200,'5551234567',2,'TTY','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(49,'Llamada simulada 37','0','17:28:41','2025-04-29 17:28:41',NULL,5,19.49685300,-99.09151300,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(50,'Llamada simulada 5','0','17:28:43','2025-04-29 17:28:43',NULL,2,19.40253600,-99.09161600,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(51,'Llamada simulada 1','0','17:28:44','2025-04-29 17:28:44',NULL,5,19.42903600,-99.08794500,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(52,'Llamada simulada 82','0','17:28:46','2025-04-29 17:28:46',NULL,1,19.48928800,-99.01224300,'5551234567',2,'Broma','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(53,'Llamada simulada 32','0','22:02:23','2025-04-30 22:02:23',NULL,4,19.43720600,-99.04509300,'5551234567',2,'Broma','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(54,'lklkfjsldfsd','Proteccion Civil','19:38:35','2025-05-02 19:38:35','2025-05-02 19:38:35',5,19.44694300,-99.13444500,'5523456789',2,'Emergencia Real','Media',NULL,'Morelos','Mexico City','Mexico City',NULL,NULL),
(55,'lklkfjsldfsd','Proteccion Civil','19:44:49','2025-05-02 19:44:49','2025-05-02 19:44:49',5,19.44694300,-99.13444500,'5523456789',2,'Emergencia Real','Media',NULL,'Morelos','Mexico City','Mexico City',NULL,NULL),
(56,'lñdlksñdfsdf','Proteccion Civil','19:45:22','2025-05-02 19:45:22','2025-05-02 19:45:22',5,19.43625900,-99.14337200,'5521036756',2,'Emergencia Real','Baja',NULL,'Barrio Chino','Mexico City','Mexico City',NULL,NULL),
(57,'lñdlksñdfsdf','Proteccion Civil','19:50:54','2025-05-02 19:50:54','2025-05-02 19:50:54',5,19.43625900,-99.14337200,'5521036756',2,'Emergencia Real','Baja',NULL,'Barrio Chino','Mexico City','Mexico City',NULL,NULL),
(58,'Llamada simulada 63','0','17:27:10','2025-05-04 17:27:10',NULL,1,19.46176000,-99.00377600,'5551234567',2,'TTY','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(59,'Llamada simulada 82','0','17:27:11','2025-05-04 17:27:11',NULL,5,19.40655300,-99.09465100,'5551234567',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(60,'Llamada simulada 71','0','17:27:13','2025-05-04 17:27:13',NULL,1,19.47672300,-99.06132500,'5551234567',2,'Broma','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(61,'Llamada simulada 47','0','20:39:34','2025-05-04 20:39:34',NULL,5,19.48136300,-99.04225400,'5551234567',2,'Broma','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(62,'Llamada simulada 89','0','20:39:36','2025-05-04 20:39:36',NULL,2,19.48692200,-99.03876000,'5551234567',2,'Broma','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(63,'Llamada simulada 84','0','20:39:37','2025-05-04 20:39:37',NULL,5,19.47913700,-99.07551500,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(64,'Llamada simulada 35','0','20:39:39','2025-05-04 20:39:39',NULL,1,19.43122600,-99.07135200,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(65,'Llamada simulada 25','Medico','20:39:40','2025-05-04 20:39:40','2025-05-04 20:41:33',2,19.42259800,-99.04677700,'5551234567',2,'TTY','Baja',NULL,'','','',NULL,NULL),
(66,'Llamada simulada 25','Proteccion Civil','20:41:59','2025-05-04 20:41:59','2025-05-04 20:41:59',2,19.42296800,-99.04672600,'5551234567',2,'TTY','Baja',NULL,'','','',NULL,NULL),
(67,'Llamada simulada 62','0','20:49:07','2025-05-04 20:49:07',NULL,4,19.44652700,-99.02228200,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(68,'Llamada simulada 21','0','20:49:09','2025-05-04 20:49:09',NULL,2,19.41435800,-99.08784900,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(69,'Llamada simulada 94','0','20:49:10','2025-05-04 20:49:10',NULL,3,19.44658700,-99.08891300,'5551234567',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(70,'Llamada simulada 11','0','20:49:11','2025-05-04 20:49:11',NULL,1,19.44712400,-99.08594200,'5551234567',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(71,'Llamada simulada 46','0','20:49:13','2025-05-04 20:49:13',NULL,5,19.47442600,-99.04335500,'5551234567',2,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(72,'Llamada simulada 18','0','20:49:14','2025-05-04 20:49:14',NULL,5,19.47598100,-99.08838400,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(73,'Llamada simulada 85','0','20:49:16','2025-05-04 20:49:16',NULL,2,19.48121500,-99.09139200,'5551234567',2,'Broma','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(74,'Llamada simulada 85','0','20:53:13','2025-05-04 20:53:13',NULL,5,19.48786600,-99.03176000,'5551234567',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(75,'Llamada simulada 43','0','20:53:14','2025-05-04 20:53:14',NULL,4,19.40897500,-99.06589200,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(76,'Llamada simulada 72','0','20:53:16','2025-05-04 20:53:16',NULL,1,19.46234000,-99.08709700,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(77,'Llamada simulada 65','0','20:53:17','2025-05-04 20:53:17',NULL,3,19.41551700,-99.07413400,'5551234567',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(78,'Llamada simulada 83','0','20:53:19','2025-05-04 20:53:19',NULL,4,19.46639000,-99.00944500,'5551234567',2,'Broma','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(79,'Llamada simulada 7','0','20:53:20','2025-05-04 20:53:20',NULL,2,19.43281000,-99.00323600,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(80,'Llamada simulada 19','0','20:53:22','2025-05-04 20:53:22',NULL,2,19.48757100,-99.02833600,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(81,'Llamada simulada 30','0','20:53:23','2025-05-04 20:53:23',NULL,1,19.41419100,-99.06231300,'5551234567',2,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(82,'Llamada simulada 5','0','20:53:25','2025-05-04 20:53:25',NULL,5,19.47565300,-99.06929800,'5551234567',2,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(83,'Llamada simulada 71','0','20:53:26','2025-05-04 20:53:26',NULL,4,19.46454800,-99.07441300,'5551234567',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(84,'Llamada simulada 10','0','20:54:07','2025-05-04 20:54:07',NULL,5,19.42038300,-99.02290800,'5551234567',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(85,'Llamada simulada 79','0','20:54:08','2025-05-04 20:54:08',NULL,5,19.48543100,-99.05429000,'5551234567',2,'Broma','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(86,'Llamada simulada 11','0','20:54:10','2025-05-04 20:54:10',NULL,1,19.47478700,-99.08436400,'5551234567',2,'TTY','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(87,'Llamada simulada 6','0','20:54:11','2025-05-04 20:54:11',NULL,3,19.41010300,-99.03927900,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(88,'Llamada simulada 95','0','20:54:13','2025-05-04 20:54:13',NULL,4,19.41356500,-99.05967800,'5551234567',2,'TTY','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(89,'Llamada simulada 65','0','20:54:14','2025-05-04 20:54:14',NULL,3,19.48416400,-99.06137100,'5551234567',2,'TTY','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(90,'Llamada simulada 71','0','20:54:16','2025-05-04 20:54:16',NULL,4,19.49333100,-99.05013400,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(91,'Llamada simulada 87','0','20:54:17','2025-05-04 20:54:17',NULL,2,19.43672400,-99.09475000,'5551234567',2,'TTY','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(92,'Llamada simulada 12','Proteccion Civil','20:54:19','2025-05-04 20:54:19','2025-05-05 12:23:32',4,19.42814900,-99.07616600,'5551234567',2,'Emergencia Real','Alta',NULL,'','','',NULL,NULL),
(93,'Llamada simulada 100','0','20:54:20','2025-05-04 20:54:20',NULL,2,19.45117000,-99.02311700,'5551234567',2,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(94,'Llamada simulada 47','Proteccion Civil','20:54:33','2025-05-04 20:54:33','2025-05-04 20:54:56',3,19.44816900,-99.01650800,'5551234567',2,'Emergencia Real','Media',NULL,'','','',NULL,NULL),
(95,'Llamada simulada 47','Proteccion Civil','20:55:31','2025-05-04 20:55:31','2025-05-04 20:55:31',3,19.51740500,-98.90510600,'5551234567',2,'Emergencia Real','Media',NULL,'','','',NULL,NULL),
(96,'Llamada simulada 26','0','20:57:32','2025-05-04 20:57:32',NULL,5,19.48231000,-99.03392600,'5551234567',2,'Broma','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(97,'Llamada simulada 83','0','20:57:33','2025-05-04 20:57:33',NULL,3,19.43706400,-99.09631300,'5551234567',2,'Broma','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(98,'Llamada simulada 22','0','20:57:35','2025-05-04 20:57:35',NULL,2,19.41747400,-99.08533400,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(99,'Llamada simulada 60','0','20:57:36','2025-05-04 20:57:36',NULL,1,19.43395800,-99.03173100,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(100,'Llamada simulada 14','0','20:57:38','2025-05-04 20:57:38',NULL,3,19.44169400,-99.02599200,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(101,'Llamada simulada 97','0','20:57:39','2025-05-04 20:57:39',NULL,4,19.41648900,-99.08304600,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(102,'Llamada simulada 92','0','20:57:41','2025-05-04 20:57:41',NULL,2,19.43654800,-99.09934100,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(103,'Llamada simulada 88','0','20:57:42','2025-05-04 20:57:42',NULL,4,19.41862300,-99.08030000,'5551234567',2,'TTY','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(104,'Llamada simulada 43','Seguridad','20:57:44','2025-05-04 20:57:44','2025-05-04 20:58:16',2,19.41536000,-99.05462400,'5551234567',2,'Emergencia Real','Alta',NULL,'','','',NULL,NULL),
(105,'Llamada simulada 43','Proteccion Civil','20:58:41','2025-05-04 20:58:41','2025-05-04 20:58:41',2,19.41531900,-99.05453700,'5551234567',2,'Broma','Media',NULL,'','','',NULL,NULL),
(106,'Llamada simulada 46','0','21:26:00','2025-05-04 21:26:00',NULL,5,19.40482800,-99.09968700,'5551234567',2,'TTY','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(107,'Llamada simulada 89','0','21:26:02','2025-05-04 21:26:02',NULL,2,19.40435000,-99.09017900,'5551234567',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(108,'Llamada simulada 4','Proteccion Civil','21:26:03','2025-05-04 21:26:03','2025-05-04 23:15:29',4,19.40429800,-99.09603500,'5551234567',2,'TTY','Media',NULL,'','','',NULL,NULL),
(109,'Llamada simulada 4','0','21:26:05','2025-05-04 21:26:05',NULL,4,19.40723700,-99.09725300,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(110,'Llamada simulada 4','Proteccion Civil','23:15:54','2025-05-04 23:15:54','2025-05-04 23:15:54',4,19.40439000,-99.09603600,'5551234567',2,'TTY','Media',NULL,'','','',NULL,NULL),
(111,'Llamada simulada 99','0','12:12:58','2025-05-05 12:12:58',NULL,2,19.40217900,-99.09522400,'5551234567',2,'TTY','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(112,'Llamada simulada 46','0','12:13:00','2025-05-05 12:13:00',NULL,2,19.40202900,-99.09018000,'5551234567',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(113,'Llamada simulada 71','0','12:13:01','2025-05-05 12:13:01',NULL,4,19.40937700,-99.09324400,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(114,'Llamada simulada 29','0','12:13:03','2025-05-05 12:13:03',NULL,2,19.40121500,-99.09864400,'5551234567',2,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(115,'Llamada simulada 98','0','12:13:04','2025-05-05 12:13:04',NULL,2,19.40875600,-99.09375000,'5551234567',2,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(116,'Llamada simulada 31','0','12:13:06','2025-05-05 12:13:06',NULL,2,19.40190700,-99.09595200,'5551234567',2,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(117,'Llamada simulada 12','Proteccion Civil','12:23:44','2025-05-05 12:23:44','2025-05-05 12:23:44',4,19.42762300,-99.07569400,'5551234567',2,'Emergencia Real','Alta',NULL,'','','',NULL,NULL),
(118,'se cayó un árbol','Proteccion Civil','12:26:52','2025-05-05 12:26:52','2025-05-05 12:26:52',4,19.46044200,-99.09256000,'5528576890',7,'Emergencia Real','Media',NULL,'','','',NULL,NULL),
(119,'Llamada simulada 5','0','12:28:00','2025-05-05 12:28:00',NULL,3,19.40440400,-99.09279700,'5551234567',7,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(120,'Llamada simulada 99','0','12:28:09','2025-05-05 12:28:09',NULL,1,19.40446800,-99.09773100,'5551234567',7,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(121,'Llamada simulada 93','0','12:28:10','2025-05-05 12:28:10',NULL,3,19.40994600,-99.09156300,'5551234567',7,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(122,'Llamada simulada 43','0','12:28:12','2025-05-05 12:28:12',NULL,2,19.40190700,-99.09740700,'5551234567',7,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(123,'Llamada simulada 96','0','12:28:18','2025-05-05 12:28:18',NULL,4,19.40253800,-99.09090000,'5551234567',7,'Broma','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(124,'Llamada simulada 88','0','12:28:19','2025-05-05 12:28:19',NULL,1,19.40655800,-99.09078400,'5551234567',7,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(125,'Llamada simulada 100','0','12:28:21','2025-05-05 12:28:21',NULL,1,19.40127900,-99.09687700,'5551234567',7,'TTY','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(126,'Llamada simulada 89','0','12:28:22','2025-05-05 12:28:22',NULL,4,19.40699600,-99.09250500,'5551234567',7,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(127,'Llamada simulada 26','0','12:28:24','2025-05-05 12:28:24',NULL,1,19.40984100,-99.09574400,'5551234567',7,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(128,'Llamada simulada 78','0','12:28:25','2025-05-05 12:28:25',NULL,3,19.40198600,-99.09716100,'5551234567',7,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(129,'Llamada simulada 43','0','12:28:27','2025-05-05 12:28:27',NULL,1,19.40604500,-99.09665200,'5551234567',7,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(130,'Llamada simulada 17','0','12:28:28','2025-05-05 12:28:28',NULL,3,19.40430400,-99.09644300,'5551234567',7,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(131,'Llamada simulada 71','0','12:28:30','2025-05-05 12:28:30',NULL,4,19.40828600,-99.09626600,'5551234567',7,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(132,'Todo suceso relacionado con un vehículo (de dos, tres ruedas o cuatrimoto) impulsado por un motor y en donde resulta una o más personas con lesiones.','Medico','12:28:31','2025-05-05 12:28:31','2025-05-07 23:14:59',1,19.40679300,-99.09110100,'5551234567',7,'Emergencia Real','Alta',NULL,'','','',NULL,NULL),
(133,'Llamada simulada 70','0','12:28:33','2025-05-05 12:28:33',NULL,1,19.40182900,-99.09150500,'5551234567',7,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(134,'Llamada simulada 63','0','12:28:34','2025-05-05 12:28:34',NULL,1,19.40887000,-99.09366000,'5551234567',7,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(135,'Llamada simulada 25','0','12:28:36','2025-05-05 12:28:36',NULL,2,19.40796300,-99.09530300,'5551234567',7,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(136,'Llamada simulada 4','0','12:28:37','2025-05-05 12:28:37',NULL,4,19.40212500,-99.09714400,'5551234567',7,'TTY','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(137,'Llamada simulada 35','0','12:28:39','2025-05-05 12:28:39',NULL,3,19.40122200,-99.09385800,'5551234567',7,'Broma','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(138,'Llamada simulada 84','0','12:28:40','2025-05-05 12:28:40',NULL,2,19.40018800,-99.09413400,'5551234567',7,'Broma','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(139,'Llamada simulada 33','0','12:28:42','2025-05-05 12:28:42',NULL,4,19.40132500,-99.09546300,'5551234567',7,'TTY','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(140,'Llamada simulada 75','0','12:28:43','2025-05-05 12:28:43',NULL,2,19.40750400,-99.09300700,'5551234567',7,'TTY','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(141,'Llamada simulada 9','0','12:28:45','2025-05-05 12:28:45',NULL,3,19.40542400,-99.09038400,'5551234567',7,'TTY','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(142,'Llamada simulada 94','0','12:28:46','2025-05-05 12:28:46',NULL,5,19.40999100,-99.09389600,'5551234567',7,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(143,'Llamada simulada 49','0','12:28:48','2025-05-05 12:28:48',NULL,2,19.40264700,-99.09880300,'5551234567',7,'TTY','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(144,'Llamada simulada 84','0','12:28:49','2025-05-05 12:28:49',NULL,4,19.40352100,-99.09409000,'5551234567',7,'TTY','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(145,'Llamada simulada 72','0','12:30:07','2025-05-05 12:30:07',NULL,5,19.40740900,-99.09265300,'5551234567',7,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(146,'Llamada simulada 61','0','14:50:28','2025-05-07 14:50:28',NULL,1,19.40477800,-99.09047100,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(147,'Llamada simulada 4','0','14:50:30','2025-05-07 14:50:30',NULL,4,19.40481400,-99.09281100,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(148,'Llamada simulada 65','0','14:50:31','2025-05-07 14:50:31',NULL,1,19.40014700,-99.09949000,'5551234567',2,'TTY','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(149,'Llamada simulada 73','0','14:50:33','2025-05-07 14:50:33',NULL,2,19.40379900,-99.09740300,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(150,'Hecho de tránsito de vehículo automotor en donde resultan personas lesionadas, incluye choques, volcaduras, impacto contra semovientes (animales) o impacto contra objeto fijo.','Medico','22:53:21','2025-05-07 22:53:21','2025-05-07 22:53:21',1,19.42106200,-99.12002600,'5528576890',2,'Emergencia Real','Alta',NULL,'','','',NULL,NULL),
(151,'Hecho de tránsito de vehículo automotor en donde resultan personas lesionadas, incluye choques, volcaduras, impacto contra semovientes (animales) o impacto contra objeto fijo.','Medico','23:12:20','2025-05-07 23:12:20','2025-05-07 23:12:20',1,19.42106200,-99.12002600,'5528576890',2,'Emergencia Real','Alta',NULL,'','','',NULL,NULL),
(152,'Llamada simulada 55','0','20:03:05','2025-05-08 20:03:05',NULL,5,19.40961900,-99.09450200,'5551234567',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(153,'Llamada simulada 40','0','20:03:07','2025-05-08 20:03:07',NULL,4,19.40915900,-99.09954900,'5551234567',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(154,'Llamada simulada 24','0','20:03:08','2025-05-08 20:03:08',NULL,2,19.40838700,-99.09606000,'5551234567',2,'Broma','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(155,'Llamada simulada 91','0','21:00:22','2025-05-10 21:00:22',NULL,3,19.40345500,-99.09738000,'5551234567',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(156,'Llamada simulada 19','0','21:00:24','2025-05-10 21:00:24',NULL,1,19.40804400,-99.09100700,'5551234567',2,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(157,'Llamada simulada 90','0','21:00:25','2025-05-10 21:00:25',NULL,3,19.40917200,-99.09836900,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(158,'Llamada simulada 48','0','21:00:27','2025-05-10 21:00:27',NULL,5,19.40350100,-99.09344400,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(159,'Llamada simulada 14','0','21:00:28','2025-05-10 21:00:28',NULL,2,19.40195000,-99.09123300,'5551234567',2,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(160,'Llamada simulada 33','0','21:00:30','2025-05-10 21:00:30',NULL,4,19.40036300,-99.09076700,'5551234567',2,'Broma','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(161,'Llamada simulada 79','0','21:00:32','2025-05-10 21:00:32',NULL,4,19.40799600,-99.09641400,'5551234567',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(162,'Llamada simulada 90','0','21:00:33','2025-05-10 21:00:33',NULL,5,19.40150500,-99.09548300,'5551234567',2,'Broma','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(163,'Llamada simulada 29','0','21:00:35','2025-05-10 21:00:35',NULL,3,19.40118700,-99.09642400,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(164,'Llamada simulada 14','0','21:00:36','2025-05-10 21:00:36',NULL,5,19.40699000,-99.09336800,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(165,'Suceso en el que se ven involucrados locomotoras o vehículos que circulan en las vías del tren, sin que resulten personas lesionadas.','Proteccion Civil','21:00:37','2025-05-10 21:00:37','2025-05-10 21:06:53',1,19.40948000,-99.09264600,'5551234567',2,'Broma','Media',NULL,'','','',NULL,NULL),
(166,'Llamada simulada 53','0','21:26:03','2025-05-10 21:26:03',NULL,5,19.40549400,-99.09763300,'5551234567',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(167,'Llamada simulada 44','0','21:26:05','2025-05-10 21:26:05',NULL,1,19.40039400,-99.09413900,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(168,'Llamada simulada 81','0','21:26:06','2025-05-10 21:26:06',NULL,5,19.40620400,-99.09104600,'5551234567',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(169,'Llamada simulada 28','0','21:26:08','2025-05-10 21:26:08',NULL,5,19.40994500,-99.09969700,'5551234567',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(170,'Llamada simulada 62','0','21:26:14','2025-05-10 21:26:14',NULL,2,19.40056200,-99.09702900,'5551234567',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(171,'Llamada simulada 6','0','21:26:15','2025-05-10 21:26:15',NULL,1,19.40475000,-99.09385300,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(172,'Llamada simulada 28','0','21:26:17','2025-05-10 21:26:17',NULL,2,19.40601800,-99.09505200,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(173,'Llamada simulada 94','0','21:27:44','2025-05-10 21:27:44',NULL,3,19.40536100,-99.09423300,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(174,'Llamada simulada 69','0','21:27:46','2025-05-10 21:27:46',NULL,2,19.40518300,-99.09508900,'5551234567',2,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(175,'Llamada simulada 54','0','21:27:48','2025-05-10 21:27:48',NULL,5,19.40852200,-99.09853900,'5551234567',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(176,'Llamada simulada 49','0','21:27:49','2025-05-10 21:27:49',NULL,4,19.40526300,-99.09658200,'5551234567',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(177,'Llamada simulada 40','0','21:27:50','2025-05-10 21:27:50',NULL,2,19.40117500,-99.09230500,'5551234567',2,'TTY','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(178,'Llamada simulada 74','0','21:27:52','2025-05-10 21:27:52',NULL,2,19.40699200,-99.09774900,'5551234567',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(179,'Llamada simulada 45','0','21:27:54','2025-05-10 21:27:54',NULL,3,19.40144200,-99.09693400,'5551234567',2,'TTY','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(180,'Llamada simulada 69','0','21:27:55','2025-05-10 21:27:55',NULL,1,19.40257900,-99.09732900,'5551234567',2,'Broma','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(181,'Llamada simulada 22','0','21:27:57','2025-05-10 21:27:57',NULL,2,19.40838900,-99.09555800,'5551234567',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(182,'Llamada simulada 33','0','21:27:58','2025-05-10 21:27:58',NULL,3,19.40788700,-99.09423200,'5551234567',2,'TTY','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(183,'Llamada simulada 38','0','21:27:59','2025-05-10 21:27:59',NULL,2,19.40562100,-99.09644600,'5551234567',2,'Broma','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(184,'Llamada simulada 26','0','21:28:01','2025-05-10 21:28:01',NULL,1,19.40053700,-99.09130300,'5551234567',2,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(185,'Llamada simulada 34','0','21:28:02','2025-05-10 21:28:02',NULL,3,19.40047100,-99.09619400,'5551234567',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(186,'Llamada simulada 2','0','21:28:04','2025-05-10 21:28:04',NULL,5,19.40877400,-99.09235000,'5551234567',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(187,'Llamada simulada 99','0','15:18:41','2025-05-11 15:18:41',NULL,1,19.40246000,-99.09091300,'5551234567',2,'Broma','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(188,'Llamada simulada 16','0','15:18:43','2025-05-11 15:18:43',NULL,5,19.40205100,-99.09743000,'5551234567',2,'TTY','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(189,'Llamada simulada 21','0','15:18:45','2025-05-11 15:18:45',NULL,3,19.40913600,-99.09185400,'5551234567',2,'TTY','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(190,'Llamada simulada 76','0','15:18:46','2025-05-11 15:18:46',NULL,4,19.40665100,-99.09590300,'5551234567',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(191,'Llamada simulada 91','0','15:18:47','2025-05-11 15:18:47',NULL,4,19.40128800,-99.09389400,'5551234567',2,'Broma','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(192,'Suceso en el que se ven involucrados locomotoras o vehículos que circulan en las vías del tren, sin que resulten personas lesionadas.','','16:19:14','2025-05-11 16:19:14','2025-05-11 16:19:14',1,19.41134400,-99.15744800,'',2,'Emergencia Real','Media',NULL,'Roma Norte','Ciudad de México','Ciudad de México','20101',NULL),
(193,'Suceso en el que se ven involucrados locomotoras o vehículos que circulan en las vías del tren, sin que resulten personas lesionadas.','','16:25:52','2025-05-11 16:25:52','2025-05-11 16:25:52',1,19.41134400,-99.15744800,'',2,'Emergencia Real','Media',NULL,'Roma Norte','Ciudad de México','Ciudad de México','20101',NULL),
(194,'Suceso en el que se ven involucrados locomotoras o vehículos que circulan en las vías del tren, sin que resulten personas lesionadas.','','16:26:47','2025-05-11 16:26:47','2025-05-11 16:26:47',1,19.41134400,-99.15744800,'',2,'Emergencia Real','Media',NULL,'Roma Norte','Ciudad de México','Ciudad de México','20101',NULL),
(195,'Suceso en el que se ven involucrados locomotoras o vehículos que circulan en las vías del tren, sin que resulten personas lesionadas.','','16:28:51','2025-05-11 16:28:51','2025-05-11 16:28:51',1,19.41134400,-99.15744800,'',2,'Emergencia Real','Media',NULL,'Roma Norte','Ciudad de México','Ciudad de México','20101',NULL),
(196,'Acontecimiento relacionado con el medio acuático; es decir, suscitado en mar, piscina/alberca, lago, río y/o presas donde haya personas lesionadas.','','16:29:09','2025-05-11 16:29:09','2025-05-11 16:29:09',4,19.42711800,-99.12963900,'',2,'Emergencia Real','Media',NULL,'Centro','Mexico City','Mexico City','10101',NULL),
(197,'Acontecimiento relacionado con el medio acuático; es decir, suscitado en mar, piscina/alberca, lago, río y/o presas donde haya personas lesionadas.','','16:31:04','2025-05-11 16:31:04','2025-05-11 16:31:04',4,19.42711800,-99.12963900,'',2,'Emergencia Real','Media',NULL,'Centro','Mexico City','Mexico City','10101',NULL),
(198,'Hecho de tránsito de vehículo automotor en donde resultan personas lesionadas, incluye choques, volcaduras, impacto contra semovientes (animales) o impacto contra objeto fijo.','','16:31:31','2025-05-11 16:31:31','2025-05-11 16:31:31',4,19.44243800,-99.12757900,'',2,'Emergencia Real','Media',NULL,'Morelos','Mexico City','Mexico City','10104',NULL),
(199,'Suceso en el que se ven involucrados los vehículos que circulan en las vías del sistema ferroviario, en servicio de carga o pasajeros, y en el cual resultan personas fallecidas.','','16:33:07','2025-05-11 16:33:07','2025-05-11 16:33:07',1,19.43746800,-99.12826500,'',2,'Emergencia Real','Media',NULL,'Centro','Mexico City','Mexico City','10106',NULL),
(203,'Conjunto de recintos y recipientes no autorizados en los cuales se resguardan productos químicos, que puedan producir un riesgo no controlado para las personas, su patrimonio o el medio ambiente.','Civil Protection','17:52:55','2025-05-11 17:52:55','2025-05-11 17:52:55',1,19.44893400,-99.16946400,'',2,'Emergencia Real','Alta',NULL,'Colonia Un hogar para nosotros','Mexico City','Mexico City','20102',NULL),
(204,'Llamada simulada 40','0','18:07:27','2025-05-11 18:07:27',NULL,4,19.40655600,-99.09356000,'5648988299',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(205,'Llamada simulada 50','0','18:07:28','2025-05-11 18:07:28',NULL,3,19.40263500,-99.09861000,'5527962883',2,'TTY','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(206,'Llamada simulada 43','0','18:07:30','2025-05-11 18:07:30',NULL,3,19.40912100,-99.09182300,'5640235729',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(207,'Llamada simulada 89','0','18:07:31','2025-05-11 18:07:31',NULL,4,19.40013900,-99.09775000,'5686040635',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(208,'Llamada simulada 1','0','18:07:33','2025-05-11 18:07:33',NULL,1,19.40453500,-99.09988300,'5579397949',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(209,'Llamada simulada 16','0','18:07:34','2025-05-11 18:07:34',NULL,2,19.40112500,-99.09414800,'5569295968',2,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(210,'Concentración de un grupo de personas sin desarrollar conductas de violencia.','','18:07:36','2025-05-11 18:07:36',NULL,1,19.40193600,-99.09281700,'5631697228',2,'Emergencia Real','Media',NULL,'Colonia Mario Moreno','Mexico City','Mexico City','50101',NULL),
(211,'Llamada simulada 73','0','18:17:16','2025-05-11 18:17:16',NULL,3,19.40621400,-99.09797700,'5520755213',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(212,'Llamada simulada 75','0','18:17:17','2025-05-11 18:17:17',NULL,3,19.40966000,-99.09183400,'5585784671',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(213,'Llamada simulada 47','0','18:17:19','2025-05-11 18:17:19',NULL,1,19.40238300,-99.09816200,'5659639465',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(214,'Llamada simulada 91','0','18:17:20','2025-05-11 18:17:20',NULL,1,19.40617200,-99.09005700,'5667269368',2,'Broma','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(215,'Llamada simulada 51','0','18:17:22','2025-05-11 18:17:22',NULL,3,19.40644100,-99.09025800,'5647420670',2,'TTY','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(216,'Llamada simulada 66','0','18:17:23','2025-05-11 18:17:23',NULL,5,19.40632000,-99.09174000,'5515461039',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(217,'Llamada simulada 59','0','18:17:25','2025-05-11 18:17:25',NULL,4,19.40884900,-99.09692000,'5547283012',2,'Broma','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(218,'Llamada simulada 25','0','18:17:26','2025-05-11 18:17:26',NULL,2,19.40588700,-99.09314300,'5657388489',2,'TTY','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(219,'Llamada simulada 21','0','18:17:28','2025-05-11 18:17:28',NULL,3,19.40697800,-99.09685200,'5655630634',2,'TTY','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(220,'Llamada simulada 32','0','18:17:29','2025-05-11 18:17:29',NULL,5,19.40990000,-99.09344100,'5654672994',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(221,'Acción cometida, pero no consumada, por una o más personas, con el fin de apoderarse de bienes muebles.','','18:17:31','2025-05-11 18:17:31',NULL,3,19.40120700,-99.09509200,'5548729488',2,'Emergencia Real','Alta',NULL,'','','','50102',NULL),
(222,'Llamada simulada 83','0','18:17:32','2025-05-11 18:17:32',NULL,5,19.40810400,-99.09347700,'5664832834',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(223,'Llamada simulada 56','0','18:17:34','2025-05-11 18:17:34',NULL,1,19.40931600,-99.09370500,'5539336940',2,'Emergencia Real','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(224,'Llamada simulada 45','0','18:17:35','2025-05-11 18:17:35',NULL,1,19.40674900,-99.09451600,'5543233505',2,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(225,'Suceso en el que se ven involucrados locomotoras o vehículos que circulan en las vías del tren, sin que resulten personas lesionadas.','','18:17:37','2025-05-11 18:17:37',NULL,1,19.40489100,-99.09822500,'5647021704',2,'Broma','Alta',NULL,'Colonia Granjas México','Mexico City','Mexico City','20101',NULL),
(226,'Llamada simulada 30','0','18:17:38','2025-05-11 18:17:38',NULL,2,19.40993200,-99.09407800,'5656122181',2,'TTY','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(227,'Llamada simulada 86','0','18:17:40','2025-05-11 18:17:40',NULL,1,19.40155800,-99.09938100,'5678068192',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(228,'Animales que, con independencia de su agresividad, su especie o raza tienen capacidad de causar muerte o lesiones a personas o animales y/o daños a las cosas.','','18:17:41','2025-05-11 18:17:41',NULL,1,19.40647000,-99.09676600,'5544502553',2,'Emergencia Real','Media',NULL,'Colonia Mario Moreno','Mexico City','Mexico City','20103',NULL),
(229,'Llamada simulada 23','0','18:45:02','2025-05-12 18:45:02',NULL,4,19.40501400,-99.09088700,'5621635931',2,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(230,'Llamada simulada 36','0','18:45:04','2025-05-12 18:45:04',NULL,2,19.40766400,-99.09254400,'5694483186',2,'Emergencia Real','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(231,'Llamada simulada 47','0','18:45:05','2025-05-12 18:45:05',NULL,4,19.40316700,-99.09231400,'5642920739',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(232,'Llamada simulada 79','0','18:45:07','2025-05-12 18:45:07',NULL,2,19.40077000,-99.09177200,'5639627294',2,'Broma','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(233,'Llamada simulada 58','0','18:45:08','2025-05-12 18:45:08',NULL,4,19.40208400,-99.09089000,'5519764376',2,'Broma','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(234,'Llamada simulada 52','0','18:45:10','2025-05-12 18:45:10',NULL,1,19.40238400,-99.09802100,'5589249702',2,'Broma','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(235,'Llamada simulada 71','0','18:45:11','2025-05-12 18:45:11',NULL,1,19.40618400,-99.09821600,'5698717919',2,'TTY','Media',NULL,NULL,NULL,NULL,NULL,NULL),
(236,'Llamada simulada 33','0','18:45:13','2025-05-12 18:45:13',NULL,4,19.40922000,-99.09669200,'5664587706',2,'TTY','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(237,'Llamada simulada 49','0','18:45:14','2025-05-12 18:45:14',NULL,1,19.40008000,-99.09276500,'5574583071',2,'Broma','Alta',NULL,NULL,NULL,NULL,NULL,NULL),
(238,'Llamada simulada 23','0','18:45:16','2025-05-12 18:45:16',NULL,4,19.40287100,-99.09615200,'5668088769',2,'TTY','Baja',NULL,NULL,NULL,NULL,NULL,NULL),
(239,'Llamada simulada 24','0','18:45:17','2025-05-12 18:45:17',NULL,5,19.40172600,-99.09526300,'5548196520',2,'Emergencia Real','Alta',NULL,NULL,NULL,NULL,NULL,NULL);
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
  PRIMARY KEY (`id_llamada`),
  KEY `id_operador` (`id_operador`),
  CONSTRAINT `llamadas_ibfk_1` FOREIGN KEY (`id_operador`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `llamadas`
--

LOCK TABLES `llamadas` WRITE;
/*!40000 ALTER TABLE `llamadas` DISABLE KEYS */;
INSERT INTO `llamadas` VALUES
(1,2,'2025-04-22 08:15:00',235,'Finalizada'),
(2,7,'2025-04-22 16:33:50',500,'En curso'),
(3,3,'2025-05-04 20:39:34',NULL,'Atender'),
(4,3,'2025-05-04 20:39:36',NULL,'Atender'),
(5,3,'2025-05-04 20:39:37',NULL,'Atender'),
(6,3,'2025-05-04 20:39:39',NULL,'Atender'),
(7,2,'2025-05-04 20:39:40',NULL,'En curso'),
(8,2,'2025-05-04 20:49:07',NULL,'Atender'),
(9,3,'2025-05-04 20:49:09',NULL,'Atender'),
(10,2,'2025-05-04 20:49:10',NULL,'Atender'),
(11,1,'2025-05-04 20:49:11',NULL,'Atender'),
(12,3,'2025-05-04 20:49:13',NULL,'Atender'),
(13,3,'2025-05-04 20:49:14',NULL,'Atender'),
(14,3,'2025-05-04 20:49:16',NULL,'En curso'),
(15,3,'2025-05-04 20:53:13',NULL,'Atender'),
(16,3,'2025-05-04 20:53:14',NULL,'Atender'),
(17,3,'2025-05-04 20:53:16',NULL,'Atender'),
(18,3,'2025-05-04 20:53:17',NULL,'Atender'),
(19,3,'2025-05-04 20:53:19',NULL,'Atender'),
(20,1,'2025-05-04 20:53:20',NULL,'Atender'),
(21,3,'2025-05-04 20:53:22',NULL,'Atender'),
(22,1,'2025-05-04 20:53:23',NULL,'Atender'),
(23,1,'2025-05-04 20:53:25',NULL,'Atender'),
(24,1,'2025-05-04 20:53:26',NULL,'En curso'),
(25,2,'2025-05-04 20:54:07',NULL,'Atender'),
(26,1,'2025-05-04 20:54:08',NULL,'Atender'),
(27,2,'2025-05-04 20:54:10',NULL,'Atender'),
(28,1,'2025-05-04 20:54:11',NULL,'Atender'),
(29,1,'2025-05-04 20:54:13',NULL,'Atender'),
(30,1,'2025-05-04 20:54:14',NULL,'Atender'),
(31,1,'2025-05-04 20:54:16',NULL,'Atender'),
(32,3,'2025-05-04 20:54:17',NULL,'Atender'),
(33,2,'2025-05-04 20:54:19',NULL,'En curso'),
(34,2,'2025-05-04 20:54:20',NULL,'Atender'),
(35,3,'2025-05-04 20:54:33',NULL,'En curso'),
(36,3,'2025-05-04 20:57:32',NULL,'Atender'),
(37,1,'2025-05-04 20:57:33',NULL,'Atender'),
(38,2,'2025-05-04 20:57:35',NULL,'Atender'),
(39,1,'2025-05-04 20:57:36',NULL,'Atender'),
(40,1,'2025-05-04 20:57:38',NULL,'Atender'),
(41,3,'2025-05-04 20:57:39',NULL,'Atender'),
(42,2,'2025-05-04 20:57:41',NULL,'Atender'),
(43,2,'2025-05-04 20:57:42',NULL,'Atender'),
(44,3,'2025-05-04 20:57:44',NULL,'En curso'),
(45,3,'2025-05-04 21:26:00',NULL,'En curso'),
(46,1,'2025-05-04 21:26:02',NULL,'Atender'),
(47,1,'2025-05-04 21:26:03',NULL,'En curso'),
(48,2,'2025-05-04 21:26:05',NULL,'En curso'),
(49,3,'2025-05-05 12:12:58',NULL,'Atender'),
(50,1,'2025-05-05 12:13:00',NULL,'Atender'),
(51,1,'2025-05-05 12:13:01',NULL,'En curso'),
(52,2,'2025-05-05 12:13:03',NULL,'Atender'),
(53,3,'2025-05-05 12:13:04',NULL,'En curso'),
(54,2,'2025-05-05 12:13:06',NULL,'En curso'),
(55,2,'2025-05-05 12:28:00',NULL,'Atender'),
(56,1,'2025-05-05 12:28:09',NULL,'Atender'),
(57,3,'2025-05-05 12:28:10',NULL,'Atender'),
(58,2,'2025-05-05 12:28:12',NULL,'Atender'),
(59,3,'2025-05-05 12:28:18',NULL,'Atender'),
(60,3,'2025-05-05 12:28:19',NULL,'Atender'),
(61,1,'2025-05-05 12:28:21',NULL,'Atender'),
(62,1,'2025-05-05 12:28:22',NULL,'Atender'),
(63,2,'2025-05-05 12:28:24',NULL,'Atender'),
(64,1,'2025-05-05 12:28:25',NULL,'Atender'),
(65,1,'2025-05-05 12:28:27',NULL,'Atender'),
(66,2,'2025-05-05 12:28:28',NULL,'Atender'),
(67,1,'2025-05-05 12:28:30',NULL,'Atender'),
(68,2,'2025-05-05 12:28:31',NULL,'En curso'),
(69,2,'2025-05-05 12:28:33',NULL,'Atender'),
(70,1,'2025-05-05 12:28:34',NULL,'Atender'),
(71,3,'2025-05-05 12:28:36',NULL,'Atender'),
(72,3,'2025-05-05 12:28:37',NULL,'Atender'),
(73,2,'2025-05-05 12:28:39',NULL,'Atender'),
(74,1,'2025-05-05 12:28:40',NULL,'En curso'),
(75,3,'2025-05-05 12:28:42',NULL,'Atender'),
(76,1,'2025-05-05 12:28:43',NULL,'Atender'),
(77,3,'2025-05-05 12:28:45',NULL,'En curso'),
(78,2,'2025-05-05 12:28:46',NULL,'Atender'),
(79,1,'2025-05-05 12:28:48',NULL,'En curso'),
(80,3,'2025-05-05 12:28:49',NULL,'En curso'),
(81,2,'2025-05-05 12:30:07',NULL,'En curso'),
(82,2,'2025-05-07 14:50:28',NULL,'Atender'),
(83,2,'2025-05-07 14:50:30',NULL,'Atender'),
(84,1,'2025-05-07 14:50:31',NULL,'Atender'),
(85,2,'2025-05-07 14:50:33',NULL,'Atender'),
(86,1,'2025-05-08 20:03:05',NULL,'Atender'),
(87,2,'2025-05-08 20:03:07',NULL,'Atender'),
(88,1,'2025-05-08 20:03:08',NULL,'En curso'),
(89,3,'2025-05-10 21:00:22',NULL,'Atender'),
(90,1,'2025-05-10 21:00:24',NULL,'Atender'),
(91,1,'2025-05-10 21:00:25',NULL,'Atender'),
(92,1,'2025-05-10 21:00:27',NULL,'Atender'),
(93,1,'2025-05-10 21:00:28',NULL,'Atender'),
(94,1,'2025-05-10 21:00:30',NULL,'Atender'),
(95,1,'2025-05-10 21:00:32',NULL,'Atender'),
(96,1,'2025-05-10 21:00:33',NULL,'Atender'),
(97,1,'2025-05-10 21:00:35',NULL,'Atender'),
(98,3,'2025-05-10 21:00:36',NULL,'Atender'),
(99,3,'2025-05-10 21:00:37',NULL,'En curso'),
(100,1,'2025-05-10 21:26:03',NULL,'Atender'),
(101,3,'2025-05-10 21:26:05',NULL,'Atender'),
(102,2,'2025-05-10 21:26:06',NULL,'Atender'),
(103,3,'2025-05-10 21:26:08',NULL,'Atender'),
(104,3,'2025-05-10 21:26:14',NULL,'Atender'),
(105,3,'2025-05-10 21:26:15',NULL,'Atender'),
(106,2,'2025-05-10 21:26:17',NULL,'Atender'),
(107,2,'2025-05-10 21:27:44',NULL,'Atender'),
(108,2,'2025-05-10 21:27:46',NULL,'Atender'),
(109,1,'2025-05-10 21:27:48',NULL,'Atender'),
(110,2,'2025-05-10 21:27:49',NULL,'Atender'),
(111,1,'2025-05-10 21:27:50',NULL,'Atender'),
(112,2,'2025-05-10 21:27:52',NULL,'Atender'),
(113,3,'2025-05-10 21:27:54',NULL,'Atender'),
(114,2,'2025-05-10 21:27:55',NULL,'Atender'),
(115,3,'2025-05-10 21:27:57',NULL,'Atender'),
(116,3,'2025-05-10 21:27:58',NULL,'Atender'),
(117,3,'2025-05-10 21:27:59',NULL,'Atender'),
(118,2,'2025-05-10 21:28:01',NULL,'Atender'),
(119,2,'2025-05-10 21:28:02',NULL,'Atender'),
(120,1,'2025-05-10 21:28:04',NULL,'Atender'),
(121,1,'2025-05-11 15:18:41',NULL,'Atender'),
(122,2,'2025-05-11 15:18:43',NULL,'Atender'),
(123,1,'2025-05-11 15:18:45',NULL,'Atender'),
(124,2,'2025-05-11 15:18:46',NULL,'Atender'),
(125,2,'2025-05-11 15:18:47',NULL,'Atender'),
(126,2,'2025-05-11 18:07:27',NULL,'Atender'),
(127,3,'2025-05-11 18:07:28',NULL,'Atender'),
(128,3,'2025-05-11 18:07:30',NULL,'Atender'),
(129,3,'2025-05-11 18:07:31',NULL,'En curso'),
(130,3,'2025-05-11 18:07:33',NULL,'Atender'),
(131,1,'2025-05-11 18:07:34',NULL,'Atender'),
(132,1,'2025-05-11 18:07:36',NULL,'En curso'),
(133,1,'2025-05-11 18:17:16',NULL,'Atender'),
(134,2,'2025-05-11 18:17:17',NULL,'Atender'),
(135,1,'2025-05-11 18:17:19',NULL,'Atender'),
(136,3,'2025-05-11 18:17:20',NULL,'Atender'),
(137,3,'2025-05-11 18:17:22',NULL,'Atender'),
(138,2,'2025-05-11 18:17:23',NULL,'Atender'),
(139,2,'2025-05-11 18:17:25',NULL,'Atender'),
(140,1,'2025-05-11 18:17:26',NULL,'Atender'),
(141,2,'2025-05-11 18:17:28',NULL,'Atender'),
(142,1,'2025-05-11 18:17:29',NULL,'Atender'),
(143,3,'2025-05-11 18:17:31',NULL,'Finalizada'),
(144,3,'2025-05-11 18:17:32',NULL,'En curso'),
(145,3,'2025-05-11 18:17:34',NULL,'En curso'),
(146,1,'2025-05-11 18:17:35',NULL,'Atender'),
(147,2,'2025-05-11 18:17:37',NULL,'Finalizada'),
(148,3,'2025-05-11 18:17:38',NULL,'Atender'),
(149,2,'2025-05-11 18:17:40',NULL,'En curso'),
(150,2,'2025-05-11 18:17:41',NULL,'En curso'),
(151,2,'2025-05-12 18:45:02',NULL,'Atender'),
(152,3,'2025-05-12 18:45:04',NULL,'Atender'),
(153,2,'2025-05-12 18:45:05',NULL,'Atender'),
(154,1,'2025-05-12 18:45:07',NULL,'En curso'),
(155,3,'2025-05-12 18:45:08',NULL,'En curso'),
(156,1,'2025-05-12 18:45:10',NULL,'Atender'),
(157,2,'2025-05-12 18:45:11',NULL,'Atender'),
(158,2,'2025-05-12 18:45:13',NULL,'Atender'),
(159,3,'2025-05-12 18:45:14',NULL,'Atender'),
(160,2,'2025-05-12 18:45:16',NULL,'Atender'),
(161,3,'2025-05-12 18:45:17',NULL,'Atender');
/*!40000 ALTER TABLE `llamadas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id_mensaje` int(11) NOT NULL AUTO_INCREMENT,
  `id_chat` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `mensaje` text DEFAULT NULL,
  `fecha_envio` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_mensaje`),
  KEY `id_chat` (`id_chat`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`id_chat`) REFERENCES `chats` (`id_chat`) ON DELETE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES
(1,1,2,'Hola, buenas tardes directora, le envío un mensaje para un asunto muy importante','2025-05-07 21:37:46'),
(2,1,2,'Hola directora, necesito comunicarme inmediatamente con usted','2025-05-07 21:50:04');
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
  `hora_prank_call` time NOT NULL,
  `fecha_prank_call` datetime NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
(12,NULL,'Reporte falso de robo a mano armada','Simulación de delito','23:15:00','2025-05-01 00:00:00',NULL,4,'5551098765','Peligrosa','Reporte a autoridades',1,'Iztapalapa','Ciudad de México','CDMX');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_unidad`
--

LOCK TABLES `tipos_unidad` WRITE;
/*!40000 ALTER TABLE `tipos_unidad` DISABLE KEYS */;
INSERT INTO `tipos_unidad` VALUES
(1,'Ambulancia'),
(2,'Patrulla');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidades`
--

LOCK TABLES `unidades` WRITE;
/*!40000 ALTER TABLE `unidades` DISABLE KEYS */;
INSERT INTO `unidades` VALUES
(1,'Ambulancia',1,'Disponible','2345678909876543234567890');
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

-- Dump completed on 2025-05-16 14:52:01

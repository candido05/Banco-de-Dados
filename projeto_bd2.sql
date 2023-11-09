-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: banco_de_dados
-- ------------------------------------------------------
-- Server version	8.0.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `CPF` varchar(11) DEFAULT NULL,
  `numero_enderecos` int DEFAULT '0',
  `numero_cartao` bigint DEFAULT NULL,
  `bandeira_cartao` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (127890,'Jose','12345678901',4,55567890,'MasterCard'),(4891862,'Marcelo Iuri','8521473652',1,4561857436250022,'Visa'),(8458453,'Barbara','98723456712',2,8908765456786500,'MasterCard'),(10046210,'Carlos','10498002694',4,5502097049800269,'MasterCard'),(13231277,'Cândido Leandro','08424591461',6,4561200370500124,'MasterCard'),(14287985,'Daniel','54243197206',0,7412568914750232,'Visa'),(27454603,'Pedro','12345678900',2,1234432109877890,'Visa'),(53287328,'Gab','98765432105',3,7894321536520147,'MasterCard'),(53408938,'Sebastião','54685214795',1,7895654525360012,'Elo'),(65886553,'paulo','07402596456',1,1020748596361421,'elo'),(75396210,'Luis','12345678901',2,55567890,'MasterCard'),(76684262,'vitu','78451236984',0,4512968532017402,'visa'),(99999999,'Paulo','10498002694',2,5502097049800269,'MasterCard'),(1234567890,'Candido','12345678901',2,1234567890,'MasterCard');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra`
--

DROP TABLE IF EXISTS `compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compra` (
  `id_compra` int NOT NULL,
  `id_cliente` int DEFAULT NULL,
  PRIMARY KEY (`id_compra`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  CONSTRAINT `fk_compra_id_compra` FOREIGN KEY (`id_compra`) REFERENCES `dadoscompra` (`id_compra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
INSERT INTO `compra` VALUES (27442243,8458453),(32106422,8458453),(50993718,8458453),(59185493,8458453),(66129423,8458453),(4731714,13231277),(19161231,13231277),(24544186,13231277),(24965248,13231277),(30504199,13231277),(52361032,13231277),(57025337,13231277),(59507919,13231277),(64168059,13231277),(89544105,13231277),(97692962,13231277),(45694506,27454603),(20003400,53287328),(25437221,53287328),(82940154,53287328),(19714388,53408938);
/*!40000 ALTER TABLE `compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `comprasclientenoano`
--

DROP TABLE IF EXISTS `comprasclientenoano`;
/*!50001 DROP VIEW IF EXISTS `comprasclientenoano`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `comprasclientenoano` AS SELECT 
 1 AS `id_cliente`,
 1 AS `nome`,
 1 AS `SUM(DC.quantidade_por_livro)`,
 1 AS `SUM(V.valor_total)`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `dadoscompra`
--

DROP TABLE IF EXISTS `dadoscompra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dadoscompra` (
  `id_dados` float NOT NULL,
  `id_compra` int DEFAULT NULL,
  `id_livro` int DEFAULT NULL,
  `quantidade_por_livro` int DEFAULT NULL,
  `data_compra` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_dados`),
  KEY `fk_dadoscompra_id_compra` (`id_compra`),
  KEY `fk_livro_id_livro` (`id_livro`),
  CONSTRAINT `dadoscompra_ibfk_2` FOREIGN KEY (`id_livro`) REFERENCES `livraria` (`livro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dadoscompra`
--

LOCK TABLES `dadoscompra` WRITE;
/*!40000 ALTER TABLE `dadoscompra` DISABLE KEYS */;
INSERT INTO `dadoscompra` VALUES (45193100,19161231,2010045,2,'2023-11-03 21:44:19'),(107455000,755422,630096,2,'2023-11-03 18:14:36'),(1032450000,30504199,630096,6,'2023-11-06 13:35:29'),(1898130000,82940154,630096,2,'2023-11-03 22:56:21'),(2130560000,4731714,630096,1,'2023-11-03 22:31:29'),(2415740000,64168059,7900012,2,'2023-11-03 18:26:22'),(2578180000,59507919,2010045,4,'2023-11-06 01:51:43'),(2624190000,20003400,2780045,1,'2023-11-03 21:49:43'),(2831350000,97692962,2780045,2,'2023-11-03 22:32:13'),(2854930000,27442243,630096,1,'2023-11-05 21:49:42'),(3154830000,45694506,7330096,2,'2023-11-06 00:25:27'),(3526140000,19161231,1450096,1,'2023-11-03 21:44:19'),(3637740000,24544186,2010045,4,'2023-11-06 01:50:50'),(3911530000,20003400,630096,3,'2023-11-03 21:49:43'),(4250000000,755422,630096,2,'2023-11-03 18:22:42'),(4321690000,64168059,7330096,1,'2023-11-03 18:26:22'),(4863620000,19714388,2250045,2,'2023-11-06 10:49:38'),(5548970000,27442243,1450096,2,'2023-11-05 21:49:42'),(5805860000,89544105,2010045,1,'2023-11-06 10:28:25'),(5923710000,50993718,7330096,5,'2023-11-06 01:27:14'),(6164750000,32106422,7900012,2,'2023-11-06 01:30:29'),(7133680000,66129423,1450096,3,'2023-11-06 01:38:38'),(7183870000,25437221,8410045,2,'2023-11-03 22:59:03'),(7535540000,45694506,7900012,2,'2023-11-06 00:25:27'),(7795510000,24965248,7900012,1,'2023-11-06 13:15:10'),(8017550000,59185493,2250045,3,'2023-11-06 01:41:02'),(9081540000,57025337,7900012,2,'2023-11-03 22:50:48'),(9245010000,52361032,630096,1,'2023-11-03 22:19:43'),(9399010000,82940154,7330096,1,'2023-11-03 22:56:21');
/*!40000 ALTER TABLE `dadoscompra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encomendas`
--

DROP TABLE IF EXISTS `encomendas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encomendas` (
  `id_encomenda` int NOT NULL,
  `id_fornecedor` int DEFAULT NULL,
  `quantidade_pedido` int DEFAULT NULL,
  `valor_total` float DEFAULT NULL,
  PRIMARY KEY (`id_encomenda`),
  KEY `id_fornecedor` (`id_fornecedor`),
  CONSTRAINT `encomendas_ibfk_1` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedor` (`id_fornecedor`),
  CONSTRAINT `encomendas_ibfk_2` FOREIGN KEY (`id_encomenda`) REFERENCES `registros` (`id_encomenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encomendas`
--

LOCK TABLES `encomendas` WRITE;
/*!40000 ALTER TABLE `encomendas` DISABLE KEYS */;
/*!40000 ALTER TABLE `encomendas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enderecos`
--

DROP TABLE IF EXISTS `enderecos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enderecos` (
  `id_enderecos` int NOT NULL,
  `id_cliente` int DEFAULT NULL,
  PRIMARY KEY (`id_enderecos`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `enderecos_ibfk_1` FOREIGN KEY (`id_enderecos`) REFERENCES `enderecoscliente` (`id_enderecos`),
  CONSTRAINT `enderecos_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enderecos`
--

LOCK TABLES `enderecos` WRITE;
/*!40000 ALTER TABLE `enderecos` DISABLE KEYS */;
INSERT INTO `enderecos` VALUES (77216712,4891862),(23468685,8458453),(34234929,8458453),(13222467,13231277),(19905476,13231277),(59469493,13231277),(78078419,13231277),(97351355,13231277),(39046484,27454603),(47234601,27454603),(28338266,53287328),(55788737,53287328),(67600733,53287328),(31652085,53408938),(56726628,65886553);
/*!40000 ALTER TABLE `enderecos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enderecoscliente`
--

DROP TABLE IF EXISTS `enderecoscliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enderecoscliente` (
  `id_enderecos` int NOT NULL,
  `CEP` int DEFAULT NULL,
  `rua` varchar(255) DEFAULT NULL,
  `bairro` varchar(255) DEFAULT NULL,
  `cidade` varchar(255) DEFAULT NULL,
  `numero` int DEFAULT NULL,
  `Estado` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`id_enderecos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enderecoscliente`
--

LOCK TABLES `enderecoscliente` WRITE;
/*!40000 ALTER TABLE `enderecoscliente` DISABLE KEYS */;
INSERT INTO `enderecoscliente` VALUES (10224230,789120001,'Rua dos Jatobas','Prata','Campina Grande',451,NULL),(13222467,96312500,'Rua Oliveiro Gomes','Aquarios','São Jose dos Campos',42,'São Paulo'),(19905476,330001,'Rua Max Verstappen','Red Bull','Sousa',33,'Paraíba'),(23468685,12345600,'Rua das ortelarias','Intermares','Cabedelo',12,'Paraiba'),(28338266,654430100,'Avenida das Oliveiras','Palacios','São Bernado',96,'São Paulo'),(31652085,74125000,'Rua 12 de Maio','Dom Pedro','Sousa',78,'Paraíba'),(33287798,1425200,'Rua dos Bancos','Lagoa','Sousa',421,NULL),(34234929,7895500,'Rua dos Alfaiates','Torre','Sousa',56,'Praiba'),(35304952,7840010,'Rua do Hospicio','Santo Amaro','Recife',85001,NULL),(39046484,34567890,'Avenida Moscow','Leme','Fortaleza',45,'Ceara'),(47234601,1234567,'Rua das Flores','Castelo','Sousa',12,'Praiba'),(51955760,85032100,'Rua 27 de Maio','Centro','Sao Jose',684,NULL),(53922252,987400120,'Avenida dos Afogados','Mangabeira','João Pessoa',74123520,NULL),(55788737,2002550,'Rua das Flores','Jardins','Sousa',52,'Paraíba'),(56726628,45500200,'Avenida dos Jatobas','Explanada','Brasilia',45,'Distrito Federal'),(59469493,4125800,'Rua Novembro Verde','Orquideas','Santa Clara ',186,'Minas Gerais'),(67600733,74120025,'Rua 8 de Julho','Manaira','João Pessoa',85,'Paraiba'),(77216712,1245365200,'Rua 6 de Novembro','Bairro dos Estados','João Pessoa',74,'Paraiba'),(78078419,123455678,'Rua Nova','Tocantins','São Gusmão',98,'Ceara'),(97351355,96100052,'Rua das Flores','Lagoa Nova','Anapolis',41,'Goias');
/*!40000 ALTER TABLE `enderecoscliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornecedor`
--

DROP TABLE IF EXISTS `fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornecedor` (
  `id_fornecedor` int NOT NULL,
  `nome_fornecedor` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_fornecedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedor`
--

LOCK TABLES `fornecedor` WRITE;
/*!40000 ALTER TABLE `fornecedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `fornecedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historicodecompras`
--

DROP TABLE IF EXISTS `historicodecompras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historicodecompras` (
  `id_cliente` int NOT NULL,
  `quantidade_total` int DEFAULT NULL,
  `valor_total` float DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  CONSTRAINT `historicodecompras_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historicodecompras`
--

LOCK TABLES `historicodecompras` WRITE;
/*!40000 ALTER TABLE `historicodecompras` DISABLE KEYS */;
INSERT INTO `historicodecompras` VALUES (8458453,11,456.604),(13231277,29,1053.54),(53287328,9,293.13),(53408938,2,96);
/*!40000 ALTER TABLE `historicodecompras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historicodevendas`
--

DROP TABLE IF EXISTS `historicodevendas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historicodevendas` (
  `id_livro` int NOT NULL,
  `quantidade_vend_total` int DEFAULT NULL,
  `vendas_total` float DEFAULT NULL,
  PRIMARY KEY (`id_livro`),
  CONSTRAINT `historicodevendas_ibfk_1` FOREIGN KEY (`id_livro`) REFERENCES `livraria` (`livro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historicodevendas`
--

LOCK TABLES `historicodevendas` WRITE;
/*!40000 ALTER TABLE `historicodevendas` DISABLE KEYS */;
/*!40000 ALTER TABLE `historicodevendas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livraria`
--

DROP TABLE IF EXISTS `livraria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `livraria` (
  `livro_id` int NOT NULL,
  `livro_nome` varchar(120) DEFAULT NULL,
  `escritor` varchar(200) DEFAULT NULL,
  `ano_edição` int DEFAULT NULL,
  `editora` varchar(50) DEFAULT NULL,
  `genero` varchar(50) DEFAULT NULL,
  `valor` decimal(5,2) DEFAULT NULL,
  `estoque_atual` int DEFAULT NULL,
  `lote` int DEFAULT NULL,
  `data_cadastro` datetime DEFAULT NULL,
  PRIMARY KEY (`livro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livraria`
--

LOCK TABLES `livraria` WRITE;
/*!40000 ALTER TABLE `livraria` DISABLE KEYS */;
INSERT INTO `livraria` VALUES (520142,'Teoria Geral dos Bancos de Dados','Marcelo Iury',2024,'O\'Reilly','Tecnologia',85.35,60,40230,'2023-10-04 19:17:22'),(630096,'A República','Platão',2017,'Editora Lafonte','Filosofia',30.98,30,520096,'2023-09-17 19:46:17'),(1220021,'Crime e castigo','Fiódor Dostoiévski',2016,'Editora 34','Literatura Russa',124.00,86,1865,'2023-09-17 19:46:17'),(1450096,'Meditações','Marco Aurélio',2019,'Edipro','Filosofia',35.25,49,520096,'2023-09-17 19:46:17'),(1670012,'Frankenstein','Mary Shelley',2017,'Darkside','Terro',53.20,48,460971,'2023-09-17 20:14:01'),(1940020,'Admirável mundo novo','Aldous Leonard Huxley',2014,'Biblioteca Azul','Ficção científica',42.10,63,532072,'2023-09-17 20:00:34'),(2010045,'Os Sertões','Euclides da Cunha',2020,'Principis','Literatura Brasileira',30.00,37,1530025,'2023-09-20 16:23:31'),(2070096,'A Arte de ter Razão','Arthur Schopenhauer',2019,'Edipro','Filosofia',30.00,52,809630,'2023-09-17 20:00:34'),(2250045,'Vidas secas','Graciliano Ramos',2019,'Record','Literatura Brasileira',48.00,54,2750354,'2023-09-17 20:31:45'),(2780045,'Dom Casmurro','Machado de Assis',2019,'Principis','Literatura Brasileira',29.80,68,2750354,'2023-09-17 20:31:45'),(3240036,'Meditações','Santo Agostinho de Hipona',2021,'Edições livre','Teologia',50.00,53,750056,'2023-09-17 20:00:34'),(3520096,'Confissões','Santo Agostinho de Hipona',2018,'Penguin-Companhia','Filosofia',32.50,49,52300,'2023-09-17 19:46:17'),(3780045,'Vidas Secas','João Guimarães Rosa',2019,'Record','Literatura Brasileira',42.00,46,790041,'2023-09-18 20:07:12'),(4080045,'Grande sertão: veredas','João Guimarães Rosa',2019,'Companhia das Letras','Literatura Brasileira',72.45,56,790041,'2023-09-18 13:40:40'),(4220036,'Sobre o Livre-arbítrio','Santo Agostinho de Hipona',2019,'Ecclesiae','Teologia',45.25,42,750056,'2023-09-17 20:00:34'),(5020021,'Os irmãos Karamázov','Fiódor Dostoiévski',2013,'Martin Claret','Literatura Russa',98.85,62,1865,'2023-09-17 19:46:17'),(6740045,'Memórias póstumas de Brás Cubas','Machado de Assis',2019,'Principis','Literatura Brasileira',30.25,62,2750354,'2023-09-17 20:31:45'),(7300045,'Triste fim de Policarpo Quaresma','Lima Barreto',2018,'Via Leitura','Literatura Brasileira',36.15,48,2750354,'2023-09-17 20:31:45'),(7330096,'Clara dos Anjos','Lima Barreto',2012,'Penguin-Companhia','Literatura Brasileira',48.73,59,2750354,'2023-09-17 20:31:45'),(7900012,'Drácula','Bram Stoker',2018,'Darkside','Terro',78.55,27,460971,'2023-09-17 20:14:01'),(8010021,'Anna Kariênina','Liev Tolstói',2017,'Companhia das Letras','Literatura Russa',72.40,57,1865,'2023-09-17 20:14:01'),(8410045,'Capitães da Area','Jorge Amado',2009,'Companhia do Bolso','Literatura Brasileira',29.85,54,1530025,'2023-09-20 16:25:36'),(9010045,'O cortiço','Aluísio Azevedo',2019,'Principis','Literatura Brasileira',27.00,52,2750354,'2023-09-17 20:31:45'),(9020021,'A morte de Ivan Ilitch','Lev Tolstói',2009,'Editora 34','Literatura Russa',54.35,54,1865,'2023-09-17 20:14:01');
/*!40000 ALTER TABLE `livraria` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trig_atualiza_data_cadastro` BEFORE INSERT ON `livraria` FOR EACH ROW BEGIN
    SET NEW.data_cadastro = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `registros`
--

DROP TABLE IF EXISTS `registros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registros` (
  `id_encomenda` int NOT NULL,
  `id_livro` int DEFAULT NULL,
  `quantidade_livro` int DEFAULT NULL,
  `data_encomenda` datetime DEFAULT CURRENT_TIMESTAMP,
  `lote` int DEFAULT NULL,
  PRIMARY KEY (`id_encomenda`),
  KEY `id_livro` (`id_livro`),
  CONSTRAINT `registros_ibfk_1` FOREIGN KEY (`id_livro`) REFERENCES `livraria` (`livro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registros`
--

LOCK TABLES `registros` WRITE;
/*!40000 ALTER TABLE `registros` DISABLE KEYS */;
/*!40000 ALTER TABLE `registros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendas`
--

DROP TABLE IF EXISTS `vendas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendas` (
  `id_compra` int NOT NULL,
  `quantidade_total` int DEFAULT NULL,
  `valor_total` float DEFAULT NULL,
  PRIMARY KEY (`id_compra`),
  CONSTRAINT `fk_vendas_id_compra` FOREIGN KEY (`id_compra`) REFERENCES `dadoscompra` (`id_compra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendas`
--

LOCK TABLES `vendas` WRITE;
/*!40000 ALTER TABLE `vendas` DISABLE KEYS */;
INSERT INTO `vendas` VALUES (4731714,1,7.17549),(19161231,3,22.0615),(19714388,2,81.6),(20003400,4,122.74),(24544186,4,86.7),(24965248,1,66.7675),(25437221,2,59.7),(27442243,3,52.9732),(30504199,6,157.998),(32106422,2,96.479),(45694506,4,216.376),(50993718,5,127.187),(52361032,1,7.17549),(57025337,2,36.387),(59185493,3,122.4),(59507919,4,86.7),(64168059,3,47.6737),(66129423,3,76.4044),(82940154,3,110.69),(89544105,1,25.5),(97692962,2,13.8044);
/*!40000 ALTER TABLE `vendas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'banco_de_dados'
--

--
-- Dumping routines for database 'banco_de_dados'
--
/*!50003 DROP PROCEDURE IF EXISTS `CalcularDescontoSousa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CalcularDescontoSousa`(IN cliente_CPF VARCHAR(11))
BEGIN
    DECLARE cliente_id INT;
    DECLARE total_compras DECIMAL(10, 2);
    DECLARE desconto DECIMAL(10, 2);

    -- Encontre o ID do cliente com base no CPF
    SELECT id_cliente INTO cliente_id
    FROM Cliente
    WHERE CPF = cliente_CPF;

    -- Verifique se o cliente existe e mora em 'Sousa'
    IF cliente_id IS NOT NULL THEN
        -- Calcula o total de compras do cliente
        SELECT SUM(DC.valor_total) INTO total_compras
        FROM DadosCompra DC
        JOIN Compra Co ON DC.id_compra = Co.id_compra
        WHERE Co.id_cliente = cliente_id;

        -- Aplica o desconto de 15% se o total de compras for maior que 0
        IF total_compras > 0 THEN
            SET desconto = total_compras * 0.15;
            -- Atualiza o histórico de compras com o desconto
            UPDATE HistoricoCompra SET valor_total = valor_total - desconto WHERE id_cliente = cliente_id;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CD`(IN clienteCPF VARCHAR(11))
BEGIN
    DECLARE clienteID INT;
        -- Variáveis para armazenar os valores de quantidade_total e valor_total
    DECLARE quantidadeTotal INT;
    DECLARE valorTotal DECIMAL(10, 2);
    
    -- Obter o ID do cliente com base no CPF
    SELECT id_cliente INTO clienteID FROM Cliente WHERE CPF = clienteCPF;
	IF clienteID IS NOT NULL THEN
		UPDATE Vendas
		SET valor_total = valor_total * 0.85  -- Aplicar desconto de 15%
		WHERE id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID);

		-- Obter a quantidade total e valor total
		SELECT COUNT(*), SUM(valor_total)
		INTO quantidadeTotal, valorTotal
		FROM Vendas
		WHERE id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID);

		-- Inserir um novo registro em HistoricoCompra
		INSERT INTO HistoricoCompra (id_cliente, quantidade_total, valor_total)
		VALUES (clienteID, quantidadeTotal, valorTotal);
		
			SELECT 'Desconto atualizado com sucesso.' AS Resultado;
		ELSE
			SELECT 'Cliente não encontrado.' AS Resultado;
		END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CD1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CD1`(IN clienteCPF VARCHAR(11))
BEGIN
    DECLARE clienteID INT;
        -- Variáveis para armazenar os valores de quantidade_total e valor_total
    DECLARE quantidadeTotal INT;
    DECLARE valorTotal DECIMAL(10, 2);
    
    -- Obter o ID do cliente com base no CPF
    SELECT id_cliente INTO clienteID FROM Cliente WHERE CPF = clienteCPF;
	IF clienteID IS NOT NULL THEN
		UPDATE Vendas
		SET valor_total = valor_total * 0.85  -- Aplicar desconto de 15%
		WHERE id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID);

		-- Obter a quantidade total e valor total
		SELECT COUNT(*), SUM(valor_total)
		INTO quantidadeTotal, valorTotal
		FROM Vendas
		WHERE id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID);

		-- Inserir um novo registro em HistoricoCompra
		INSERT INTO historicodecompras (id_cliente, quantidade_total, valor_total)
		VALUES (clienteID, quantidadeTotal, valorTotal);
		
			SELECT 'Desconto atualizado com sucesso.' AS Resultado;
		ELSE
			SELECT 'Cliente não encontrado.' AS Resultado;
		END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CD2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CD2`(IN clienteCPF VARCHAR(11))
BEGIN
    DECLARE clienteID INT;
        -- Variáveis para armazenar os valores de quantidade_total e valor_total
    DECLARE quantidadeTotal INT;
    DECLARE valorTotal DECIMAL(10, 2);
    
    -- Obter o ID do cliente com base no CPF
    SELECT id_cliente INTO clienteID FROM Cliente WHERE CPF = clienteCPF;
	IF clienteID IS NOT NULL THEN
		UPDATE Vendas
		SET valor_total = valor_total * 0.85  -- Aplicar desconto de 15%
		WHERE id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID);

		-- Obter a quantidade total e valor total
		SELECT COUNT(*), SUM(valor_total)
		INTO quantidadeTotal, valorTotal
		FROM Vendas
		WHERE id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID);

		-- Inserir um novo registro em HistoricoCompra
        -- Atualizar o desconto em HistoricoCompra
        UPDATE HistoricoCompra
        SET valor_total = valor_total * 0.85  -- Aplicar desconto de 15%
        WHERE id_cliente = clienteID;
		
			SELECT 'Desconto atualizado com sucesso.' AS Resultado;
		ELSE
			SELECT 'Cliente não encontrado.' AS Resultado;
		END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CD3` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CD3`(IN clienteCPF VARCHAR(11))
BEGIN
    DECLARE clienteID INT;
        -- Variáveis para armazenar os valores de quantidade_total e valor_total
    DECLARE quantidadeTotal INT;
    DECLARE valorTotal DECIMAL(10, 2);
    
    -- Obter o ID do cliente com base no CPF
    SELECT id_cliente INTO clienteID FROM Cliente WHERE CPF = clienteCPF;
	IF clienteID IS NOT NULL THEN
		UPDATE Vendas
		SET valor_total = valor_total * 0.85  -- Aplicar desconto de 15%
		WHERE id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID);

		-- Obter a quantidade total e valor total
		SELECT COUNT(*), SUM(valor_total)
		INTO quantidadeTotal, valorTotal
		FROM Vendas
		WHERE id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID);

		-- Inserir um novo registro em HistoricoCompra
        -- Atualizar o desconto em HistoricoCompra
        UPDATE historicodecompras
        SET valor_total = valor_total * 0.85  -- Aplicar desconto de 15%
        WHERE id_cliente = clienteID;
		
			SELECT 'Desconto atualizado com sucesso.' AS Resultado;
		ELSE
			SELECT 'Cliente não encontrado.' AS Resultado;
		END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CD4` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CD4`(IN clienteCPF VARCHAR(11))
BEGIN
    DECLARE clienteID INT;
        -- Variáveis para armazenar os valores de quantidade_total e valor_total
    DECLARE quantidadeTotal INT;
    DECLARE valorTotal DECIMAL(10, 2);
    
    -- Obter o ID do cliente com base no CPF
    SELECT id_cliente INTO clienteID FROM Cliente WHERE CPF = clienteCPF;
	IF clienteID IS NOT NULL THEN
		UPDATE Vendas
		SET valor_total = valor_total * 0.85  -- Aplicar desconto de 15%
		WHERE id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID);

		-- Obter a quantidade total e valor total
		SELECT COUNT(*), SUM(valor_total)
		INTO quantidadeTotal, valorTotal
		FROM Vendas
		WHERE id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID);

		-- Inserir um novo registro em HistoricoCompra
        -- Atualizar o desconto em HistoricoCompra
        UPDATE historicodecompras
        SET valor_total = valor_total   
        WHERE id_cliente = clienteID;
		
			SELECT 'Desconto atualizado com sucesso.' AS Resultado;
		ELSE
			SELECT 'Cliente não encontrado.' AS Resultado;
		END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ClienteDesconto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ClienteDesconto`(IN clienteCPF VARCHAR(11))
BEGIN
    DECLARE clienteID INT;
    
    -- Obter o ID do cliente com base no CPF
    SELECT id_cliente INTO clienteID FROM Cliente WHERE CPF = clienteCPF;
    
    IF clienteID IS NOT NULL THEN
        -- Atualizar o desconto em Vendas
        UPDATE Vendas
        SET valor_total = valor_total * 0.85  -- Aplicar desconto de 15%
        WHERE id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID);
        
        -- Inserir um novo registro em HistoricoCompra
        INSERT INTO historicodecompras (id_cliente, quantidade_total, valor_total)
        SELECT id_cliente, COUNT(*), SUM(valor_total)
        FROM Vendas
        WHERE id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID)
        GROUP BY id_cliente;
        
        SELECT 'Desconto atualizado com sucesso.' AS Resultado;
    ELSE
        SELECT 'Cliente não encontrado.' AS Resultado;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DescontoClienteSousa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DescontoClienteSousa`(IN clienteCPF VARCHAR(11))
BEGIN
    DECLARE clienteID INT;
    
    -- Obter o ID do cliente com base no CPF
    SELECT id_cliente INTO clienteID FROM Cliente WHERE CPF = clienteCPF;
    
    IF clienteID IS NOT NULL THEN
        -- Atualizar o desconto em Vendas
        UPDATE Vendas
        SET valor_total = valor_total * 0.85  -- Aplicar desconto de 15%
        WHERE id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID);

        -- Atualizar o desconto em DadosCompra
        UPDATE DadosCompra
        SET valor_total = valor_total * 0.85  -- Aplicar desconto de 15%
        WHERE id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID);
        
        -- Atualizar o desconto em HistoricoCompra
        UPDATE HistoricoCompra hc
        SET valor_total = (
            SELECT SUM(valor_total)
            FROM Vendas v
            WHERE v.id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID)
        )
        WHERE hc.id_cliente = clienteID;
        
        SELECT 'Desconto atualizado com sucesso.' AS Resultado;
    ELSE
        SELECT 'Cliente não encontrado.' AS Resultado;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Desconto_ClienteSousa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Desconto_ClienteSousa`(IN clienteCPF VARCHAR(11))
BEGIN
    DECLARE clienteID INT;
    
    -- Obter o ID do cliente com base no CPF
    SELECT id_cliente INTO clienteID FROM Cliente WHERE CPF = clienteCPF;
    
    IF clienteID IS NOT NULL THEN
        -- Atualizar o desconto em Vendas
        UPDATE Vendas
        SET valor_total = valor_total * 0.85  -- Aplicar desconto de 15%
        WHERE id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID);
        
        -- Atualizar o desconto em HistoricoCompra
        UPDATE historicodecompras hc
        SET valor_total = (
            SELECT SUM(valor_total)
            FROM Vendas v
            WHERE v.id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID)
        )
        WHERE hc.id_cliente = clienteID;
        
        SELECT 'Desconto atualizado com sucesso.' AS Resultado;
    ELSE
        SELECT 'Cliente não encontrado.' AS Resultado;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Desconto_Cliente_Sousa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Desconto_Cliente_Sousa`(IN clienteCPF VARCHAR(11))
BEGIN
    DECLARE clienteID INT;
    
    -- Obter o ID do cliente com base no CPF
    SELECT id_cliente INTO clienteID FROM Cliente WHERE CPF = clienteCPF;
    
    IF clienteID IS NOT NULL THEN
        -- Atualizar o desconto em Vendas
        UPDATE Vendas
        SET valor_total = valor_total * 0.85  -- Aplicar desconto de 15%
        WHERE id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID);
        
        -- Atualizar o desconto em HistoricoCompra
        UPDATE HistoricoCompra hc
        SET valor_total = (
            SELECT SUM(valor_total)
            FROM Vendas v
            WHERE v.id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID)
        )
        WHERE hc.id_cliente = clienteID;
        
        SELECT 'Desconto atualizado com sucesso.' AS Resultado;
    ELSE
        SELECT 'Cliente não encontrado.' AS Resultado;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Desconto_Sousa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Desconto_Sousa`(IN clienteCPF VARCHAR(11))
BEGIN
    DECLARE clienteID INT;
    
    -- Obter o ID do cliente com base no CPF
    SELECT id_cliente INTO clienteID FROM Cliente WHERE CPF = clienteCPF;
    
    IF clienteID IS NOT NULL THEN
        -- Atualizar o desconto em Vendas
        UPDATE Vendas
        SET valor_total = valor_total * 0.85  -- Aplicar desconto de 15%
        WHERE id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID);
        
        -- Inserir um novo registro em HistoricoCompra
        INSERT INTO HistoricoCompra (id_cliente, quantidade_total, valor_total)
        SELECT id_cliente, COUNT(*), SUM(valor_total)
        FROM Vendas
        WHERE id_compra IN (SELECT id_compra FROM Compra WHERE id_cliente = clienteID)
        GROUP BY id_cliente;
        
        SELECT 'Desconto atualizado com sucesso.' AS Resultado;
    ELSE
        SELECT 'Cliente não encontrado.' AS Resultado;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `comprasclientenoano`
--

/*!50001 DROP VIEW IF EXISTS `comprasclientenoano`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `comprasclientenoano` AS select `c`.`id_cliente` AS `id_cliente`,`c`.`nome` AS `nome`,sum(`dc`.`quantidade_por_livro`) AS `SUM(DC.quantidade_por_livro)`,sum(`v`.`valor_total`) AS `SUM(V.valor_total)` from (((`cliente` `c` join `compra` `co` on((`c`.`id_cliente` = `co`.`id_cliente`))) join `dadoscompra` `dc` on((`co`.`id_compra` = `dc`.`id_compra`))) join `vendas` `v` on((`dc`.`id_compra` = `v`.`id_compra`))) where (year(`dc`.`data_compra`) = 2023) group by `c`.`id_cliente` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-06 10:41:45

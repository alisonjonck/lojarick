# ************************************************************
# Sequel Pro SQL dump
# Version 4004
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.5.28)
# Database: lojarick
# Generation Time: 2013-06-19 12:35:18 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table auth_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table auth_group_permissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_bda51c3c` (`group_id`),
  KEY `auth_group_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `group_id_refs_id_3cea63fe` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_a7792de1` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table auth_permission
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_e4470c6e` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_728de91f` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`)
VALUES
	(1,'Can add permission',1,'add_permission'),
	(2,'Can change permission',1,'change_permission'),
	(3,'Can delete permission',1,'delete_permission'),
	(4,'Can add group',2,'add_group'),
	(5,'Can change group',2,'change_group'),
	(6,'Can delete group',2,'delete_group'),
	(7,'Can add user',3,'add_user'),
	(8,'Can change user',3,'change_user'),
	(9,'Can delete user',3,'delete_user'),
	(10,'Can add content type',4,'add_contenttype'),
	(11,'Can change content type',4,'change_contenttype'),
	(12,'Can delete content type',4,'delete_contenttype'),
	(13,'Can add session',5,'add_session'),
	(14,'Can change session',5,'change_session'),
	(15,'Can delete session',5,'delete_session'),
	(16,'Can add site',6,'add_site'),
	(17,'Can change site',6,'change_site'),
	(18,'Can delete site',6,'delete_site'),
	(19,'Can add log entry',7,'add_logentry'),
	(20,'Can change log entry',7,'change_logentry'),
	(21,'Can delete log entry',7,'delete_logentry'),
	(22,'Can add tipo',8,'add_tipo'),
	(23,'Can change tipo',8,'change_tipo'),
	(24,'Can delete tipo',8,'delete_tipo'),
	(25,'Can add fabricante',9,'add_fabricante'),
	(26,'Can change fabricante',9,'change_fabricante'),
	(27,'Can delete fabricante',9,'delete_fabricante'),
	(28,'Can add instrumento',10,'add_instrumento'),
	(29,'Can change instrumento',10,'change_instrumento'),
	(30,'Can delete instrumento',10,'delete_instrumento'),
	(31,'Can add tipo campo',11,'add_tipocampo'),
	(32,'Can change tipo campo',11,'change_tipocampo'),
	(33,'Can delete tipo campo',11,'delete_tipocampo'),
	(34,'Can add tipo caracteristica',12,'add_tipocaracteristica'),
	(35,'Can change tipo caracteristica',12,'change_tipocaracteristica'),
	(36,'Can delete tipo caracteristica',12,'delete_tipocaracteristica'),
	(37,'Can add instrumento caracteristica',13,'add_instrumentocaracteristica'),
	(38,'Can change instrumento caracteristica',13,'change_instrumentocaracteristica'),
	(39,'Can delete instrumento caracteristica',13,'delete_instrumentocaracteristica'),
	(40,'Can add parceiro',14,'add_parceiro'),
	(41,'Can change parceiro',14,'change_parceiro'),
	(42,'Can delete parceiro',14,'delete_parceiro');

/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table auth_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;

INSERT INTO `auth_user` (`id`, `username`, `first_name`, `last_name`, `email`, `password`, `is_staff`, `is_active`, `is_superuser`, `last_login`, `date_joined`)
VALUES
	(1,'alison','','','alison@alison.com','pbkdf2_sha256$10000$H5dfoBuQqb9z$EAM6RWzwuWrQb0T576575hkibhKv/PC288NgWAldvrc=',1,1,1,'2013-06-07 14:02:58','2013-06-07 14:02:26');

/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table auth_user_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_fbfc09f1` (`user_id`),
  KEY `auth_user_groups_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_f0ee9890` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_831107f1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table auth_user_user_permissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_fbfc09f1` (`user_id`),
  KEY `auth_user_user_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `permission_id_refs_id_67e79cb` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_id_refs_id_f2045483` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table cores
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cores`;

CREATE TABLE `cores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `cores` WRITE;
/*!40000 ALTER TABLE `cores` DISABLE KEYS */;

INSERT INTO `cores` (`id`, `nome`)
VALUES
	(2,'Amarelo'),
	(5,'Azul'),
	(3,'Branco'),
	(6,'Marrom'),
	(4,'Preto'),
	(7,'Roza'),
	(1,'Vermelho');

/*!40000 ALTER TABLE `cores` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table django_admin_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_fbfc09f1` (`user_id`),
  KEY `django_admin_log_e4470c6e` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_288599e6` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_c8665aa` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;

INSERT INTO `django_admin_log` (`id`, `action_time`, `user_id`, `content_type_id`, `object_id`, `object_repr`, `action_flag`, `change_message`)
VALUES
	(1,'2013-06-07 14:03:09',1,8,'1','Guitarra',1,''),
	(2,'2013-06-07 14:03:12',1,8,'2','Bateria',1,''),
	(3,'2013-06-07 14:03:31',1,9,'1','Fender',1,''),
	(4,'2013-06-07 14:03:51',1,10,'1','Guitarra A',1,''),
	(5,'2013-06-07 14:04:01',1,9,'2','King',1,''),
	(6,'2013-06-07 14:04:07',1,10,'2','Guitarra B',1,''),
	(7,'2013-06-07 14:04:27',1,9,'3','Tong',1,''),
	(8,'2013-06-07 14:04:33',1,10,'3','Bateria A',1,''),
	(9,'2013-06-07 14:04:45',1,9,'4','Kyoge',1,''),
	(10,'2013-06-07 14:04:52',1,10,'4','Bateria B',1,''),
	(11,'2013-06-07 14:05:43',1,11,'1','Sem máscara',1,''),
	(12,'2013-06-07 14:06:04',1,12,'1','Cor guitarra',1,''),
	(13,'2013-06-07 14:06:23',1,12,'2','Tipo da Madeira',1,''),
	(14,'2013-06-07 14:06:39',1,11,'2','Inteiro',1,''),
	(15,'2013-06-07 14:06:42',1,12,'3','Quantidade de pratos',1,''),
	(16,'2013-06-07 14:08:04',1,11,'3','Booleano',1,''),
	(17,'2013-06-07 14:08:19',1,12,'4','Bateria eletrônica',1,''),
	(18,'2013-06-07 14:08:37',1,13,'1','Vermelha',1,''),
	(19,'2013-06-07 14:08:48',1,13,'2','Madeira A',1,''),
	(20,'2013-06-07 14:09:00',1,13,'3','Amarela',1,''),
	(21,'2013-06-07 14:09:11',1,13,'4','Madeira B',1,''),
	(22,'2013-06-07 14:09:21',1,13,'5','Sim',1,''),
	(23,'2013-06-07 14:09:30',1,13,'6','4',1,''),
	(24,'2013-06-07 14:09:41',1,13,'7','Madeira B',1,''),
	(25,'2013-06-07 14:09:56',1,13,'8','Não',1,''),
	(26,'2013-06-08 17:47:57',1,8,'3','Bandolim',1,''),
	(27,'2013-06-08 17:48:01',1,8,'4','Saxofone',1,''),
	(28,'2013-06-08 17:48:05',1,8,'5','Teclado',1,''),
	(29,'2013-06-08 17:48:10',1,8,'6','Violão',1,''),
	(30,'2013-06-08 17:48:13',1,8,'7','Flauta',1,''),
	(31,'2013-06-08 17:48:19',1,8,'8','Violino',1,''),
	(32,'2013-06-08 18:15:59',1,14,'2','Fender Guitar',1,''),
	(33,'2013-06-08 18:16:42',1,14,'3','King Guitar',1,''),
	(34,'2013-06-08 18:17:13',1,14,'4','Sonor',1,''),
	(35,'2013-06-08 18:17:50',1,14,'5','Mapex Drums',1,''),
	(36,'2013-06-08 18:18:58',1,14,'6','Gibson',1,''),
	(37,'2013-06-12 13:43:52',1,10,'5','Guitarra do nicolas',1,''),
	(38,'2013-06-12 13:44:36',1,13,'9','Vermelha',1,''),
	(39,'2013-06-14 12:57:11',1,8,'9','Harpa',1,''),
	(40,'2013-06-14 12:57:25',1,10,'6','Harpa da Joice',1,''),
	(41,'2013-06-14 12:58:07',1,12,'5','Cor do instrumento',1,''),
	(42,'2013-06-14 12:58:22',1,12,'6','Quantidade de cordas',1,''),
	(43,'2013-06-14 16:28:36',1,12,'7','Quantidade de cordas',1,''),
	(44,'2013-06-14 16:29:10',1,12,'8','Categoria',1,''),
	(45,'2013-06-14 16:29:25',1,12,'9','Sub-categoria',1,''),
	(46,'2013-06-14 16:29:52',1,12,'10','Modelo',1,''),
	(47,'2013-06-14 16:51:29',1,12,'11','Modelo',1,''),
	(48,'2013-06-14 16:52:17',1,12,'1','Cor guitarra',2,'Modificado tabela_relacionamento.'),
	(49,'2013-06-14 16:52:52',1,12,'5','Cor do instrumento',2,'Modificado tabela_relacionamento.'),
	(50,'2013-06-14 19:38:06',1,12,'2','Tipo da Madeira',2,'Modificado possui_relacionamento e tabela_relacionamento.'),
	(51,'2013-06-15 14:44:39',1,10,'7','GUITARRA IGOR 4V',1,''),
	(52,'2013-06-15 14:45:40',1,8,'10','Violoncelo',1,''),
	(53,'2013-06-15 14:46:19',1,12,'12','Quantidade de cordas',1,''),
	(54,'2013-06-15 14:47:00',1,12,'13','Cor do instrumento',1,''),
	(55,'2013-06-15 14:47:23',1,12,'14','Tipo da madeira',1,''),
	(56,'2013-06-17 14:05:55',1,12,'15','Tipo da madeira',1,''),
	(57,'2013-06-17 15:24:08',1,11,'2','Inteiro não negativo',2,'Modificado nome e mascara.'),
	(58,'2013-06-17 15:24:59',1,11,'3','Booleano',2,'Modificado mascara.'),
	(59,'2013-06-17 15:25:12',1,11,'1','Sem máscara',2,'Modificado mascara.'),
	(60,'2013-06-17 15:28:30',1,12,'16','Guitarra elétrica',1,''),
	(61,'2013-06-17 15:30:52',1,12,'16','Guitarra elétrica',3,''),
	(62,'2013-06-18 12:14:09',1,10,'1','Guitarra A',2,'Modificado foto.'),
	(63,'2013-06-19 12:02:08',1,12,'1','Cor da guitarra',2,'Modificado nome.');

/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table django_content_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;

INSERT INTO `django_content_type` (`id`, `name`, `app_label`, `model`)
VALUES
	(1,'permission','auth','permission'),
	(2,'group','auth','group'),
	(3,'user','auth','user'),
	(4,'content type','contenttypes','contenttype'),
	(5,'session','sessions','session'),
	(6,'site','sites','site'),
	(7,'log entry','admin','logentry'),
	(8,'tipo','loja','tipo'),
	(9,'fabricante','loja','fabricante'),
	(10,'instrumento','loja','instrumento'),
	(11,'tipo campo','loja','tipocampo'),
	(12,'tipo caracteristica','loja','tipocaracteristica'),
	(13,'instrumento caracteristica','loja','instrumentocaracteristica'),
	(14,'parceiro','loja','parceiro');

/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table django_session
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_c25c2c28` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`)
VALUES
	('860dbdfed3789bac6cbc84ba1aa9ad23','YzZiYTRlNTBiMDdkMzJjMjIzZGRmMzFlMzgxNGU0ZGIwZjEyOTFjNjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2013-06-21 14:02:58');

/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table django_site
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_site`;

CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;

INSERT INTO `django_site` (`id`, `domain`, `name`)
VALUES
	(1,'example.com','example.com');

/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table loja_fabricante
# ------------------------------------------------------------

DROP TABLE IF EXISTS `loja_fabricante`;

CREATE TABLE `loja_fabricante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `loja_fabricante` WRITE;
/*!40000 ALTER TABLE `loja_fabricante` DISABLE KEYS */;

INSERT INTO `loja_fabricante` (`id`, `nome`)
VALUES
	(1,'Fender'),
	(2,'King'),
	(3,'Tong'),
	(4,'Kyoge');

/*!40000 ALTER TABLE `loja_fabricante` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table loja_instrumento
# ------------------------------------------------------------

DROP TABLE IF EXISTS `loja_instrumento`;

CREATE TABLE `loja_instrumento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `tipo_id` int(11) NOT NULL,
  `fabricante_id` int(11) NOT NULL,
  `preco` decimal(11,2) NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loja_instrumento_d81b0b6e` (`tipo_id`),
  KEY `loja_instrumento_a878eb37` (`fabricante_id`),
  CONSTRAINT `fabricante_id_refs_id_32c9e82b` FOREIGN KEY (`fabricante_id`) REFERENCES `loja_fabricante` (`id`),
  CONSTRAINT `tipo_id_refs_id_8d7862f0` FOREIGN KEY (`tipo_id`) REFERENCES `loja_tipo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `loja_instrumento` WRITE;
/*!40000 ALTER TABLE `loja_instrumento` DISABLE KEYS */;

INSERT INTO `loja_instrumento` (`id`, `nome`, `tipo_id`, `fabricante_id`, `preco`, `foto`)
VALUES
	(1,'Guitarra A',1,1,400.00,'img/guitar.jpeg'),
	(2,'Guitarra B',1,2,315.00,NULL),
	(3,'Bateria A',2,3,690.00,NULL),
	(4,'Bateria B',2,4,1050.00,NULL),
	(5,'Guitarra do nicolas',1,1,100.00,NULL),
	(6,'Harpa da Joice',9,4,100.00,NULL),
	(7,'GUITARRA IGOR 4V',1,1,1199.50,NULL);

/*!40000 ALTER TABLE `loja_instrumento` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table loja_instrumentocaracteristica
# ------------------------------------------------------------

DROP TABLE IF EXISTS `loja_instrumentocaracteristica`;

CREATE TABLE `loja_instrumentocaracteristica` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `valor` varchar(100) NOT NULL,
  `instrumento_id` int(11) NOT NULL,
  `tipo_caracteristica_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `loja_instrumentocaracteristica_81992d1b` (`instrumento_id`),
  KEY `loja_instrumentocaracteristica_4c0d406c` (`tipo_caracteristica_id`),
  CONSTRAINT `instrumento_id_refs_id_78aa8c63` FOREIGN KEY (`instrumento_id`) REFERENCES `loja_instrumento` (`id`),
  CONSTRAINT `tipo_caracteristica_id_refs_id_fa162ed4` FOREIGN KEY (`tipo_caracteristica_id`) REFERENCES `loja_tipocaracteristica` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `loja_instrumentocaracteristica` WRITE;
/*!40000 ALTER TABLE `loja_instrumentocaracteristica` DISABLE KEYS */;

INSERT INTO `loja_instrumentocaracteristica` (`id`, `valor`, `instrumento_id`, `tipo_caracteristica_id`)
VALUES
	(1,'Vermelha',1,1),
	(2,'Madeira A',1,2),
	(3,'Amarela',2,1),
	(4,'Madeira B',2,2),
	(5,'Sim',3,4),
	(6,'4',3,3),
	(7,'Madeira B',4,2),
	(8,'Não',4,4),
	(9,'Vermelha',5,1);

/*!40000 ALTER TABLE `loja_instrumentocaracteristica` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table loja_parceiro
# ------------------------------------------------------------

DROP TABLE IF EXISTS `loja_parceiro`;

CREATE TABLE `loja_parceiro` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `site` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `loja_parceiro` WRITE;
/*!40000 ALTER TABLE `loja_parceiro` DISABLE KEYS */;

INSERT INTO `loja_parceiro` (`id`, `nome`, `site`)
VALUES
	(2,'Fender Guitar','www.fender.com/'),
	(3,'King Guitar','www.kingguitar.com/'),
	(4,'Sonor','www.sonor.com/'),
	(5,'Mapex Drums','www.mapexdrums.com/'),
	(6,'Gibson','www.gibson.com/');

/*!40000 ALTER TABLE `loja_parceiro` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table loja_tipo
# ------------------------------------------------------------

DROP TABLE IF EXISTS `loja_tipo`;

CREATE TABLE `loja_tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `loja_tipo` WRITE;
/*!40000 ALTER TABLE `loja_tipo` DISABLE KEYS */;

INSERT INTO `loja_tipo` (`id`, `nome`)
VALUES
	(1,'Guitarra'),
	(2,'Bateria'),
	(3,'Bandolim'),
	(4,'Saxofone'),
	(5,'Teclado'),
	(6,'Violão'),
	(7,'Flauta'),
	(8,'Violino'),
	(9,'Harpa'),
	(10,'Violoncelo');

/*!40000 ALTER TABLE `loja_tipo` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table loja_tipocampo
# ------------------------------------------------------------

DROP TABLE IF EXISTS `loja_tipocampo`;

CREATE TABLE `loja_tipocampo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `mascara` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `loja_tipocampo` WRITE;
/*!40000 ALTER TABLE `loja_tipocampo` DISABLE KEYS */;

INSERT INTO `loja_tipocampo` (`id`, `nome`, `mascara`)
VALUES
	(1,'Sem máscara','type=\"text\"'),
	(2,'Inteiro não negativo','type=\"number\" min=\"0\"'),
	(3,'Booleano','type=\"checkbox\"');

/*!40000 ALTER TABLE `loja_tipocampo` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table loja_tipocaracteristica
# ------------------------------------------------------------

DROP TABLE IF EXISTS `loja_tipocaracteristica`;

CREATE TABLE `loja_tipocaracteristica` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `tipo_campo_id` int(11) NOT NULL,
  `tipo_id` int(11) NOT NULL,
  `possui_relacionamento` tinyint(1) NOT NULL,
  `tabela_relacionamento` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `loja_tipocaracteristica_b24d6175` (`tipo_campo_id`),
  KEY `loja_tipocaracteristica_d81b0b6e` (`tipo_id`),
  CONSTRAINT `tipo_campo_id_refs_id_95764b8e` FOREIGN KEY (`tipo_campo_id`) REFERENCES `loja_tipocampo` (`id`),
  CONSTRAINT `tipo_id_refs_id_ac2d2237` FOREIGN KEY (`tipo_id`) REFERENCES `loja_tipo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `loja_tipocaracteristica` WRITE;
/*!40000 ALTER TABLE `loja_tipocaracteristica` DISABLE KEYS */;

INSERT INTO `loja_tipocaracteristica` (`id`, `nome`, `tipo_campo_id`, `tipo_id`, `possui_relacionamento`, `tabela_relacionamento`)
VALUES
	(1,'Cor da guitarra',1,1,1,'cores'),
	(2,'Tipo da Madeira',1,1,1,'tipos_madeira'),
	(3,'Quantidade de pratos',2,2,0,''),
	(4,'Bateria eletrônica',3,2,0,''),
	(5,'Cor do instrumento',1,9,1,'cores'),
	(6,'Quantidade de cordas',2,9,0,''),
	(7,'Quantidade de cordas',2,1,0,''),
	(8,'Categoria',1,1,0,''),
	(9,'Sub-categoria',1,1,0,''),
	(10,'Modelo',1,1,0,''),
	(11,'Modelo',1,4,0,''),
	(12,'Quantidade de cordas',2,10,0,''),
	(13,'Cor do instrumento',1,10,1,'cores'),
	(14,'Tipo da madeira',1,10,1,'tipos_madeira'),
	(15,'Tipo da madeira',1,8,1,'tipos_madeira');

/*!40000 ALTER TABLE `loja_tipocaracteristica` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tipos_madeira
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tipos_madeira`;

CREATE TABLE `tipos_madeira` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `tipos_madeira` WRITE;
/*!40000 ALTER TABLE `tipos_madeira` DISABLE KEYS */;

INSERT INTO `tipos_madeira` (`id`, `nome`)
VALUES
	(1,'Acácia'),
	(2,'Cedro Australiano'),
	(3,'Cedro Rosado'),
	(4,'Cumaru'),
	(5,'Freijó'),
	(6,'Guanandi'),
	(7,'Jatobá'),
	(8,'Mogno Africano'),
	(9,'Mogno brasileiro'),
	(10,'Paricá'),
	(11,'Pinheiro'),
	(12,'Pinus');

/*!40000 ALTER TABLE `tipos_madeira` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

CREATE TABLE `tcmcconfiguration` (
`id` bigint(20) NOT NULL AUTO_INCREMENT,
`version` bigint(20) NOT NULL,
`duration` int(11) NOT NULL,
`name` varchar(50) NOT NULL,
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `virtual_waiting_room` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
   `version` bigint(20) NOT NULL,
   `created_date_time` datetime DEFAULT NULL,
    `deactivate_date_time` datetime DEFAULT NULL,
    `is_active` bit(1) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `booking_state` (
`id` bigint(20) NOT NULL AUTO_INCREMENT,
`version` bigint(20) NOT NULL,
`state_name` varchar(50) NOT NULL,
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `source_type` (
`id` bigint(20) NOT NULL AUTO_INCREMENT,
`version` bigint(20) NOT NULL,
`source_name` varchar(50) NOT NULL,
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `risk_assessment_question` (
`id` bigint(20) NOT NULL AUTO_INCREMENT,
`version` bigint(20) NOT NULL,
`created_by` bigint(20) DEFAULT NULL,
`created_date_time` datetime DEFAULT NULL,
`is_deleted` bit(1) NOT NULL,
`question` varchar(500) NOT NULL,
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `doctor` (
`id` bigint(20) NOT NULL AUTO_INCREMENT,
`version` bigint(20) NOT NULL,
`booking_assigned` bit(1) DEFAULT NULL,
`doctor_id` bigint(20) NOT NULL,
`is_available` bit(1) DEFAULT NULL,
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `audit_log` (
`id` bigint(20) NOT NULL AUTO_INCREMENT,
`version` bigint(20) NOT NULL,
`created_date_time` datetime NOT NULL,
`description` varchar(5000) DEFAULT NULL,
`source_id` bigint(20) NOT NULL,
`source_type_id` bigint(20) NOT NULL,
PRIMARY KEY (`id`),
KEY `FK_105xtiow32geobac4cd4pwj60` (`source_type_id`),
CONSTRAINT `FK_105xtiow32geobac4cd4pwj60` FOREIGN KEY
(`source_type_id`) REFERENCES `source_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `booking` (
`booking_id` bigint(20) NOT NULL,
`version` bigint(20) NOT NULL,
`ahpra_number` varchar(45) DEFAULT NULL,
`booking_end_time` datetime DEFAULT NULL,
`booking_start_time` datetime NOT NULL,
`booking_state_id` bigint(20) NOT NULL,
`booking_type` varchar(50) DEFAULT NULL,
`consultation_end_time` datetime DEFAULT NULL,
`consultation_start_time` datetime DEFAULT NULL,
`created_date_time` datetime NOT NULL,
`doctor_email` varchar(255) DEFAULT NULL,
`doctor_gender` varchar(1) DEFAULT NULL,
`doctor_id` bigint(20) DEFAULT NULL,
`doctor_name` varchar(255) DEFAULT NULL,
`doctor_surname` varchar(255) DEFAULT NULL,
`image_link` varchar(255) DEFAULT NULL,
`last_modified_time` datetime DEFAULT NULL,
`patient_address_line1` varchar(255) DEFAULT NULL,
`patient_address_line2` varchar(255) DEFAULT NULL,
`patient_birth_date` datetime DEFAULT NULL,
`patient_city` varchar(255) DEFAULT NULL,
`patient_country` varchar(9) DEFAULT NULL,
`patient_email` varchar(255) DEFAULT NULL,
`patient_gender` varchar(1) DEFAULT NULL,
`patient_id` bigint(20) NOT NULL,
`patient_mobile` varchar(255) DEFAULT NULL,
`patient_name` varchar(255) DEFAULT NULL,
`patient_state` varchar(18) DEFAULT NULL,
`patient_surname` varchar(255) DEFAULT NULL,
`practice_name` varchar(255) DEFAULT NULL,
`service_name` varchar(255) DEFAULT NULL,
`signature_link` varchar(255) DEFAULT NULL,
`tok_session_id` varchar(100) DEFAULT NULL,
`virtual_waiting_room_id` bigint(20) NOT NULL,
PRIMARY KEY (`booking_id`),
KEY `FK_99lueg42vbrq2wpcoptmwb6tq` (`booking_state_id`),
KEY `FK_53iskgpkfu56qgj0u8o6df1qt`
(`virtual_waiting_room_id`),
 CONSTRAINT `FK_53iskgpkfu56qgj0u8o6df1qt` FOREIGN KEY
(`virtual_waiting_room_id`) REFERENCES `virtual_waiting_room`
(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `diagnostic_note` (
 `id` bigint(20) NOT NULL AUTO_INCREMENT,
 `version` bigint(20) NOT NULL,
 `booking_id` bigint(20) NOT NULL,
 `created_date_time` datetime NOT NULL,
 `description` varchar(5000) NOT NULL,
 `is_active` bit(1) NOT NULL,
 `title` varchar(100) DEFAULT NULL,
 PRIMARY KEY (`id`),
 KEY `FK_215liv112w06pa0r5vh6ads5r` (`booking_id`),
 CONSTRAINT `FK_215liv112w06pa0r5vh6ads5r` FOREIGN KEY
 (`booking_id`) REFERENCES `booking` (`booking_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `medical_certificate` (
 `id` bigint(20) NOT NULL AUTO_INCREMENT,
 `version` bigint(20) NOT NULL,
 `booking_id` bigint(20) NOT NULL,
 `from_date` datetime DEFAULT NULL,
 `is_active` bit(1) NOT NULL,
 `issued_date` datetime NOT NULL,
 `mc_unique_id` varchar(45) NOT NULL,
 `reason` varchar(500) DEFAULT NULL,
 `sick_duration` int(11) NOT NULL,
 `work_address` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_cpngvl43j36u6t45vqsgo3jgt` (`mc_unique_id`),
  KEY `FK_2aflncx4hj0mq6y1pln0j4lyf` (`booking_id`),
  CONSTRAINT `FK_2aflncx4hj0mq6y1pln0j4lyf` FOREIGN KEY
 (`booking_id`) REFERENCES `booking` (`booking_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `patient_blocking` (
 `id` bigint(20) NOT NULL AUTO_INCREMENT,
 `version` bigint(20) NOT NULL,
 `booking_id` bigint(20) DEFAULT NULL,
 `created_date_time` datetime DEFAULT NULL,
 `is_blocked` bit(1) NOT NULL,
 `patient_id` bigint(20) NOT NULL,
 `reason` varchar(500) DEFAULT NULL,
 `user_id` bigint(20) NOT NULL,
 `user_type` varchar(45) DEFAULT NULL,
 PRIMARY KEY (`id`),
 KEY `FK_ckqk856c0hn5ntxc2vd9e4fxe` (`booking_id`),
 CONSTRAINT `FK_ckqk856c0hn5ntxc2vd9e4fxe` FOREIGN KEY
 (`booking_id`) REFERENCES `booking` (`booking_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `risk_assessment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `answer` varchar(500) NOT NULL,
  `created_date_time` datetime NOT NULL,
  `patient_id` bigint(20) NOT NULL,
  `risk_assessment_question_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bvkqv7os8ex66pw4aenhd8mn6`
  (`risk_assessment_question_id`),
    CONSTRAINT `FK_bvkqv7os8ex66pw4aenhd8mn6` FOREIGN KEY
  (`risk_assessment_question_id`) REFERENCES
  `risk_assessment_question` (`id`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `state_transition` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `booking_id` bigint(20) NOT NULL,
  `booking_state_id` bigint(20) NOT NULL,
  `created_date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_b09n8odb7iahvsk76pc3girxp` (`booking_id`),
  KEY `FK_2c213i80kj7hhbqgqa1saj6me` (`booking_state_id`),
  CONSTRAINT `FK_2c213i80kj7hhbqgqa1saj6me` FOREIGN KEY
 (`booking_state_id`) REFERENCES `booking_state` (`id`),
  CONSTRAINT `FK_b09n8odb7iahvsk76pc3girxp` FOREIGN KEY
  (`booking_id`) REFERENCES `booking` (`booking_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `virtual_waiting_room_filter` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `source_id` bigint(20) DEFAULT NULL,
  `source_type_id` bigint(20) NOT NULL,
  `virtual_waiting_room_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_qxqeqpd9wdljprkimtey4kc5u` (`source_type_id`),
  KEY `FK_ta34jbma9aafvgley93sw3134`
 (`virtual_waiting_room_id`),
  CONSTRAINT `FK_qxqeqpd9wdljprkimtey4kc5u` FOREIGN KEY
 (`source_type_id`) REFERENCES `source_type` (`id`),
   CONSTRAINT `FK_ta34jbma9aafvgley93sw3134` FOREIGN KEY
 (`virtual_waiting_room_id`) REFERENCES `virtual_waiting_room`
 (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 
CREATE TABLE `virtual_waiting_room_user` (
 `id` bigint(20) NOT NULL AUTO_INCREMENT,
 `version` bigint(20) NOT NULL,
 `created_date_time` datetime NOT NULL,
 `is_available` bit(1) DEFAULT NULL,
 `user_id` bigint(20) DEFAULT NULL,
 `user_type` varchar(45) DEFAULT NULL,
 `virtual_waiting_room_id` bigint(20) NOT NULL,
 PRIMARY KEY (`id`),
 KEY `FK_ac5pygj9ut92w1v8evto5f6f2`
(`virtual_waiting_room_id`),
 CONSTRAINT `FK_ac5pygj9ut92w1v8evto5f6f2` FOREIGN KEY
(`virtual_waiting_room_id`) REFERENCES `virtual_waiting_room`
(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `virtual_waiting_room` VALUES (2,0,'2018-03-02 04:46:32',NULL,''),(3,0,'2018-03-02 04:47:25',NULL,''),(9,0,'2018-03-05 08:50:47',NULL,'');
INSERT INTO `source_type` VALUES (1,1,'Practice'),(2,1,'PracticeGroup');
INSERT INTO `virtual_waiting_room_filter` VALUES (1,0,12,1,9),(2,0,13,1,9),(3,0,14,1,9),(4,0,896,2,9),(5,0,546,2,9),(6,0,549,2,9),(7,0,12,1,3);
INSERT INTO `booking` VALUES (101,0,'548554','2017-05-04 18:40:00','2017-05-04 18:30:00',1,'Advanced',NULL,NULL,'2018-03-02 04:46:32','df@gmail.com','M',555,'Dr sdf','sdfs','http://doctorimage','2018-03-02 04:46:32','sydney','test','1993-08-20 00:00:00','test','Australia','jhon@gmail.com','M',565,'8587458754','Jhon','test','ff','cdsfsd','dentist','http://singaturelink',NULL,2),(102,0,'548554','2017-05-04 18:40:00','2017-05-04 18:30:00',1,'Advanced',NULL,NULL,'2018-03-02 04:47:25','df@gmail.com','M',555,'Dr sdf','sdfs','http://doctorimage','2018-03-02 04:47:25','sydney','test','1993-08-20 00:00:00','test','Australia','test333@gmail.com','M',111,'5654645645','test_patient','test','ff','cdsfsd','dentist','http://singaturelink',NULL,3),(544,1,'45324',NULL,'2018-03-05 09:54:38',15,'Ondemand',NULL,NULL,'2018-03-05 09:26:27','testDoctor@g.com','M',105,'Doctor1','ST',NULL,'2018-03-05 09:54:38','fdgd','dfgfg','1993-02-02 00:00:00','sdf','sdfasdf','test@g.com','M',64,'85548465','test','sfs','df','dsfas','Cardiologist',NULL,NULL,3);

INSERT INTO `medical_certificate` VALUES (1,0,101,'2017-05-04 00:00:00','','2018-03-02 04:48:04','PrYQOZ1bb2rk','reason for sick',3,'Lake Street, Varsity Lakes'),(2,0,102,'2017-05-04 00:00:00','\0','2018-03-02 04:49:00','ZYWFFuKrATCZ','fever',4,'Lake Street, Varsity Lakes'),(3,0,102,'2020-11-03 00:00:00','','2018-03-05 10:32:18','I60Mdo9vCtvg','reason for sick',3,'Lake Street, Varsity Lakes');
INSERT INTO `diagnostic_note` VALUES (1,0,101,'2018-03-02 04:50:15','viral fever','','note 1'),(2,0,101,'2018-03-02 04:50:38','test note2','','note 2');

INSERT INTO `virtual_waiting_room_user` VALUES (1,0,'2018-03-05 08:55:45','',123,'Doctor',9),(2,0,'2018-03-05 08:55:45','',105,'Doctor',3),(3,0,'2018-03-05 10:00:42','',159,'Doctor',2),(4,0,'2018-03-05 10:00:59','',159,'Doctor',2),(5,0,'2018-03-05 10:01:00','',159,'Doctor',9),(6,0,'2018-03-05 10:01:27','',159,'Doctor',2),(7,0,'2018-03-05 10:01:27','',159,'Doctor',9),(8,0,'2018-03-05 10:02:09','',105,'Doctor',2),(9,0,'2018-03-05 10:02:10','',105,'Doctor',9);
INSERT INTO `patient_blocking` VALUES (1,0,NULL,'2018-03-01 02:45:18','',111,'patient blocked',101,'Doctor'),(2,0,NULL,'2018-03-01 02:46:58','\0',112,'patient blocked',101,'Doctor'),(3,0,101,'2018-03-02 04:49:21','\0',565,'patient blocked',555,'Doctor');

INSERT INTO `risk_assessment_question` VALUES (1,0,255,'2018-03-02 04:51:16','\0','age'),(2,0,255,'2018-03-02 04:51:24','\0','height');
INSERT INTO `risk_assessment` VALUES (1,0,'gfhgfhgf','2018-03-02 04:52:12',12568,1),(2,0,'160cm','2018-03-02 04:52:12',12568,2);

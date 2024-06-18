CREATE TABLE IF NOT EXISTS `academic_year` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `active` TINYINT(1) DEFAULT 1,
  `start_month` VARCHAR(5) NOT NULL, 
  `end_month` VARCHAR(5) NOT NULL,
  `start_year` YEAR NOT NULL, 
  `end_year` YEAR NOT NULL,
  `name` VARCHAR(15) GENERATED ALWAYS AS (CONCAT(`start_year`, '-', `end_year`)),
  `archived` TINYINT(1) DEFAULT 0,
  PRIMARY KEY (`id`)
);
CREATE INDEX academic_year_active_idx1 ON `academic_year` (`active`);
CREATE INDEX academic_year_start_month_idx1 ON `academic_year` (`start_month`);
CREATE INDEX academic_year_end_month_idx1 ON `academic_year` (`end_month`);
CREATE INDEX academic_year_start_year_idx1 ON `academic_year` (`start_year`);
CREATE INDEX academic_year_end_year_idx1 ON `academic_year` (`end_year`);
CREATE INDEX academic_year_name_idx1 ON `academic_year` (`name`);
CREATE INDEX academic_year_archived_idx1 ON `academic_year` (`archived`);
INSERT INTO `academic_year` (`start_month`, `start_year`, `end_month`, `end_year`) VALUES ('Sep', '2023', 'Jun', '2024');

CREATE TABLE IF NOT EXISTS `department` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `archived` TINYINT(1) DEFAULT 0,
  PRIMARY KEY (`id`)
);
CREATE INDEX department_archived_idx1 ON `department` (`archived`);
INSERT INTO `department`(`name`) VALUES ('ICT'), ('MARINE'), ('NAUTICAL'), ('ELECTRICAL'), ('TRANSPORT');

CREATE TABLE `programs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_type` int(11),
  `fk_department` int(11),
  `name` varchar(255) NOT NULL,
  `merit` varchar(255) DEFAULT NULL,
  `regulation` varchar(50) DEFAULT NULL,
  `category` varchar(25) DEFAULT 'DEGREE',
  `code` varchar(20) DEFAULT NULL,
  `index_code` varchar(5) DEFAULT NULL,
  `faculty` varchar(255) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `dur_format` varchar(50) DEFAULT NULL,
  `num_of_semesters` int(11) DEFAULT '8',
  `regular` tinyint(1) DEFAULT '1',
  `weekend` tinyint(4) DEFAULT '0',
  `group` char(1) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `archived` TINYINT(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `fk_prog_form_type` (`fk_type`),
  KEY `fk_program_department` (`fk_department`),
  CONSTRAINT `fk_program_department` FOREIGN KEY (`fk_department`) REFERENCES `department` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX programs_name_idx1 ON `programs` (`name`);
CREATE INDEX programs_merit_idx1 ON `programs` (`merit`);
CREATE INDEX programs_department_idx1 ON `programs` (`department`);
CREATE INDEX programs_regulation_idx1 ON `programs` (`regulation`);
CREATE INDEX programs_category_idx1 ON `programs` (`category`);
CREATE INDEX programs_code_idx1 ON `programs` (`code`);
CREATE INDEX programs_index_code_idx1 ON `programs` (`index_code`);
CREATE INDEX programs_faculty_idx1 ON `programs` (`faculty`);
CREATE INDEX programs_duration_idx1 ON `programs` (`duration`);
CREATE INDEX programs_dur_format_idx1 ON `programs` (`dur_format`);
CREATE INDEX programs_num_of_semesters_idx1 ON `programs` (`num_of_semesters`);
CREATE INDEX programs_type_idx1 ON `programs` (`type`);
CREATE INDEX programs_regular_idx1 ON `programs` (`regular`);
CREATE INDEX programs_weekend_idx1 ON `programs` (`weekend`);
CREATE INDEX programs_updated_at_idx1 ON `programs` (`updated_at`);
CREATE INDEX programs_archived_idx1 ON `programs` (`archived`);

CREATE TABLE `programs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_type` int(11),
  `fk_department` int(11),
  `name` varchar(255) NOT NULL,
  `merit` varchar(255) DEFAULT NULL,
  `regulation` varchar(50) DEFAULT NULL,
  `category` varchar(25) DEFAULT 'DEGREE',
  `code` varchar(20) DEFAULT NULL,
  `index_code` varchar(5) DEFAULT NULL,
  `faculty` varchar(255) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `dur_format` varchar(50) DEFAULT NULL,
  `num_of_semesters` int(11) DEFAULT '8',
  `regular` tinyint(1) DEFAULT '1',
  `weekend` tinyint(4) DEFAULT '0',
  `group` char(1) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `archived` TINYINT(1) DEFAULT 0,
  PRIMARY KEY (`id`)
)ENGINE=INNODB COMMENT='mysql://root:@host:3306/rmu_admissions_test/programs';
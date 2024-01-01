-- -----------------------------------------------------
-- Schema rmu_student_mgt_db // youtube.com: wordoftruthministry, brian bolt
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `rmu_student_mgt_db` DEFAULT CHARACTER SET utf8 ;
USE `rmu_student_mgt_db` ;

-- -----------------------------------------------------
-- Table `academic_year`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academic_year` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `start_year` YEAR NOT NULL, 
  `end_year` YEAR NOT NULL,
  `archived` TINYINT(1) DEFAULT 0,
  `name` VARCHAR(15) GENERATED ALWAYS AS (CONCAT(`start_year`, '-', `end_year`)) VIRTUAL,
  PRIMARY KEY (`id`)
);
CREATE INDEX IF NOT EXISTS academic_year_name_idx1 ON `academic_year` (`name`);
CREATE INDEX IF NOT EXISTS academic_year_start_year_idx1 ON `academic_year` (`start_year`);
CREATE INDEX IF NOT EXISTS academic_year_end_year_idx1 ON `academic_year` (`end_year`);
CREATE INDEX IF NOT EXISTS academic_year_archived_idx1 ON `academic_year` (`archived`);
INSERT INTO `academic_year` (`name`, `start_year`, `end_year`) VALUES ('2023 - 2024', '2023', '2024');

-- -----------------------------------------------------
-- Table `semester`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `semester` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL UNIQUE,
  `archived` TINYINT(1) DEFAULT 0,
  PRIMARY KEY (`id`)
);
CREATE INDEX IF NOT EXISTS semester_name_idx1 ON `semester` (`name`);
CREATE INDEX IF NOT EXISTS semester_archived_idx1 ON `semester` (`archived`);
INSERT INTO `semester` (`name`) VALUES ('SEMESTER 1'), ('SEMESTER 2');

-- -----------------------------------------------------
-- Table `department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `department` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL UNIQUE,
  `archived` TINYINT(1) DEFAULT 0,
  PRIMARY KEY (`id`)
);
CREATE INDEX IF NOT EXISTS department_name_idx1 ON `department` (`name`);
CREATE INDEX IF NOT EXISTS department_archived_idx1 ON `department` (`archived`);

-- -----------------------------------------------------
-- Table `program`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `program` (
  `code` VARCHAR(10) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `duration` INT DEFAULT 0,
  `dur_format` VARCHAR(25) DEFAULT 'YEAR',
  `archived` TINYINT(1) DEFAULT 0,
  `fk_department` INT NOT NULL,
  PRIMARY KEY (`code`),
  CONSTRAINT `fk_program_department1` FOREIGN KEY (`fk_department`) REFERENCES `department` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX IF NOT EXISTS program_name_idx1 ON `program` (`name`);
CREATE INDEX IF NOT EXISTS program_duration_idx1 ON `program` (`duration`); 
CREATE INDEX IF NOT EXISTS program_dur_format_idx1 ON `program` (`dur_format`);
CREATE INDEX IF NOT EXISTS program_archived_idx1 ON `program` (`archived`);

-- -----------------------------------------------------
-- Table `course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `course` (
  `code` VARCHAR(10) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `credit_hours` INT DEFAULT 0,
  `archived` TINYINT(1) DEFAULT 0,
  `fk_department` INT NOT NULL,
  PRIMARY KEY (`code`),
  CONSTRAINT `fk_course_department1` FOREIGN KEY (`fk_department`) REFERENCES `department` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX IF NOT EXISTS course_name_idx1 ON `course` (`name`);
CREATE INDEX IF NOT EXISTS course_credit_hours_idx1 ON `course` (`credit_hours`);
CREATE INDEX IF NOT EXISTS course_archived_idx1 ON `course` (`archived`);

-- -----------------------------------------------------
-- Table `room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `room` (
  `number` VARCHAR(10) NOT NULL,
  `capacity`INT NOT NULL,
  `location` VARCHAR(255),
  `archived` TINYINT(1) DEFAULT 0,
  `fk_department` INT NOT NULL,
  PRIMARY KEY (`number`),
  CONSTRAINT `fk_room_department1` FOREIGN KEY (`fk_department`) REFERENCES `department` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX IF NOT EXISTS room_code_idx1 ON `room` (`capacity`);
CREATE INDEX IF NOT EXISTS room_name_idx1 ON `room` (`location`);
CREATE INDEX IF NOT EXISTS room_archived_idx1 ON `room` (`archived`);

-- -----------------------------------------------------
-- Table `class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `class` (
  `code` VARCHAR(10) NOT NULL,
  `archived` TINYINT(1) DEFAULT 0,
  `fk_program` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`code`),
  CONSTRAINT `fk_class_program1`FOREIGN KEY (`fk_program`) REFERENCES `program` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX IF NOT EXISTS class_archived_idx1 ON `class` (`archived`);

-- -----------------------------------------------------
-- Table `student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `student` (
  `index_number` VARCHAR(10) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `app_number` VARCHAR(10) NOT NULL UNIQUE,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `phone_number` VARCHAR(15) NOT NULL UNIQUE,
  `first_name` VARCHAR(255) NOT NULL,
  `middle_name` VARCHAR(255),
  `last_name` VARCHAR(255) NOT NULL,
  `suffix` VARCHAR(10),
  `gender` VARCHAR(1) DEFAULT 'F',
  `dob` DATE NOT NULL,
  `nationality` VARCHAR(25) NOT NULL,
  `photo` VARCHAR(25) NOT NULL,
  `date_admitted` DATE DEFAULT CURRENT_DATE(),
  `term_admitted` VARCHAR(15) NOT NULL,
  `stream_admitted` VARCHAR(15) NOT NULL,
  `archived` TINYINT(1) DEFAULT 0,
  `fk_department` INT NOT NULL,
  `fk_class` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`index_number`),
  CONSTRAINT `fk_student_department1` FOREIGN KEY (`fk_department`) REFERENCES `department` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_class1` FOREIGN KEY (`fk_class`) REFERENCES `class` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX IF NOT EXISTS student_app_number_idx1 ON `student` (`app_number`);
CREATE INDEX IF NOT EXISTS student_email_idx1 ON `student` (`email`);
CREATE INDEX IF NOT EXISTS student_first_name_idx1 ON `student` (`first_name`);
CREATE INDEX IF NOT EXISTS student_last_name_idx1 ON `student` (`last_name`);
CREATE INDEX IF NOT EXISTS student_gender_idx1 ON `student` (`gender`);
CREATE INDEX IF NOT EXISTS student_dob_idx1 ON `student` (`dob`);
CREATE INDEX IF NOT EXISTS student_nationality_idx1 ON `student` (`nationality`);
CREATE INDEX IF NOT EXISTS student_date_admitted_idx1 ON `student` (`date_admitted`);
CREATE INDEX IF NOT EXISTS student_term_admitted_idx1 ON `student` (`term_admitted`);
CREATE INDEX IF NOT EXISTS student_stream_admitted_idx1 ON `student` (`stream_admitted`);
CREATE INDEX IF NOT EXISTS student_archived_idx1 ON `student` (`archived`);

-- -----------------------------------------------------
-- Table `section`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `section` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `archived` TINYINT(1) DEFAULT 0,
  `fk_course` VARCHAR(10) NOT NULL,
  `fk_class` VARCHAR(10) NOT NULL,
  `fk_academic_year` INT NOT NULL,
  `fk_semester` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_section_course1` FOREIGN KEY (`fk_course`) REFERENCES `course` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_class1` FOREIGN KEY (`fk_class`) REFERENCES `class` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_academic_year1` FOREIGN KEY (`fk_academic_year`) REFERENCES `academic_year` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_semester1` FOREIGN KEY (`fk_semester`) REFERENCES `semester` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX IF NOT EXISTS section_archived_idx1 ON `section` (`archived`);

-- -----------------------------------------------------
-- Table `schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `schedule` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `day_of_week` VARCHAR(10) NOT NULL,
  `course_crdt_hrs` INT DEFAULT 0,
  `start_time` TIME NOT NULL,
  `end_time` TIME GENERATED ALWAYS AS (`start_time` + (`course_crdt_hrs` * MINUTE(50))),
  `archived` TINYINT(1) DEFAULT 0,
  `fk_course` VARCHAR(10) NOT NULL,
  `fk_room` VARCHAR(10) NOT NULL,
  `fk_academic_year` INT NOT NULL,
  `fk_semester` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_schedule_course1` FOREIGN KEY (`fk_course`) REFERENCES `course` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_schedule_room1` FOREIGN KEY (`fk_room`) REFERENCES `room` (`number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_schedule_academic_year1` FOREIGN KEY (`fk_academic_year`) REFERENCES `academic_year` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_schedule_semester1` FOREIGN KEY (`fk_semester`) REFERENCES `semester` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX IF NOT EXISTS schedule_day_of_week_idx1 ON `schedule` (`day_of_week`);
CREATE INDEX IF NOT EXISTS schedule_course_crdt_hrs_idx1 ON `schedule` (`course_crdt_hrs`);
CREATE INDEX IF NOT EXISTS schedule_start_time_idx1 ON `schedule` (`start_time`);
CREATE INDEX IF NOT EXISTS schedule_end_time_idx1 ON `schedule` (`end_time`);
CREATE INDEX IF NOT EXISTS schedule_archived_idx1 ON `schedule` (`archived`);

-- -----------------------------------------------------
-- Table `registration`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registration` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `archived` TINYINT(1) DEFAULT 0,
  `fk_course` VARCHAR(10) NOT NULL,
  `fk_student` VARCHAR(10) NOT NULL,
  `fk_academic_year` INT NOT NULL,
  `fk_semester` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_registration_course1` FOREIGN KEY (`fk_course`) REFERENCES `course` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_registration_student1` FOREIGN KEY (`fk_student`) REFERENCES `student` (`index_number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_registration_academic_year1` FOREIGN KEY (`fk_academic_year`) REFERENCES `academic_year` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_registration_semester1` FOREIGN KEY (`fk_semester`) REFERENCES `semester` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX IF NOT EXISTS registration_archived_idx1 ON `registration` (`archived`);

-- -----------------------------------------------------
-- Table `staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `staff` (
  `number` VARCHAR(10) NOT NULL,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `first_name` VARCHAR(255) NOT NULL,
  `middle_name` VARCHAR(255),
  `last_name` VARCHAR(255) NOT NULL,
  `suffix` VARCHAR(10),
  `gender` VARCHAR(1) DEFAULT 'F',
  `role` VARCHAR(15) NOT NULL,
  `archived` TINYINT(1) DEFAULT 0,
  `fk_department` INT NOT NULL,
  PRIMARY KEY (`number`),
  CONSTRAINT `fk_staff_department1` FOREIGN KEY (`fk_department`) REFERENCES `department` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX IF NOT EXISTS staff_email_idx1 ON `staff` (`email`);
CREATE INDEX IF NOT EXISTS staff_first_name_idx1 ON `staff` (`first_name`);
CREATE INDEX IF NOT EXISTS staff_last_name_idx1 ON `staff` (`last_name`);
CREATE INDEX IF NOT EXISTS staff_suffix_idx1 ON `staff` (`suffix`);
CREATE INDEX IF NOT EXISTS staff_gender_idx1 ON `staff` (`gender`);
CREATE INDEX IF NOT EXISTS staff_role_idx1 ON `staff` (`role`);
CREATE INDEX IF NOT EXISTS staff_archived_idx1 ON `staff` (`archived`);

-- -----------------------------------------------------
-- Table `lecture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lecture` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `archived` TINYINT(1) DEFAULT 0,
  `fk_staff` VARCHAR(20) NOT NULL,
  `fk_course` VARCHAR(10) NOT NULL,
  `fk_academic_year` INT NOT NULL,
  `fk_semester` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_lecture_staff1` FOREIGN KEY (`fk_staff`) REFERENCES `staff` (`number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_lecture_course1` FOREIGN KEY (`fk_course`) REFERENCES `course` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `lecture_academic_year1` FOREIGN KEY (`fk_academic_year`) REFERENCES `academic_year` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `lecture_semester1` FOREIGN KEY (`fk_semester`) REFERENCES `semester` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX IF NOT EXISTS lecture_archived_idx1 ON `lecture` (`archived`);

-- -----------------------------------------------------
-- Table `quizz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quizz` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `total_mark` DECIMAL(4,1) NOT NULL,
  `pass_mark` DECIMAL(4,1) NOT NULL,
  `start_date` DATETIME NOT NULL,
  `start_time` DATETIME NOT NULL,
  `duration` INT NOT NULL,
  `archived` TINYINT(1) DEFAULT 0,
  `fk_course` VARCHAR(10) NOT NULL,
  `fk_staff` VARCHAR(10) NOT NULL,
  `fk_academic_year` INT NOT NULL,
  `fk_semester` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_quizz_course1` FOREIGN KEY (`fk_course`) REFERENCES `course` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_quizz_staff1` FOREIGN KEY (`fk_staff`) REFERENCES `staff` (`number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_quizz_academic_year1` FOREIGN KEY (`fk_academic_year`) REFERENCES `academic_year` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_quizz_semester1` FOREIGN KEY (`fk_semester`) REFERENCES `semester` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX IF NOT EXISTS quizz_title_idx1 ON `quizz` (`title`);
CREATE INDEX IF NOT EXISTS quizz_total_mark_idx1 ON `quizz` (`total_mark`);
CREATE INDEX IF NOT EXISTS quizz_pass_mark_idx1 ON `quizz` (`pass_mark`);
CREATE INDEX IF NOT EXISTS quizz_start_date_idx1 ON `quizz` (`start_date`);
CREATE INDEX IF NOT EXISTS quizz_start_time_idx1 ON `quizz` (`start_time`);
CREATE INDEX IF NOT EXISTS quizz_duration_idx1 ON `quizz` (`duration`);
CREATE INDEX IF NOT EXISTS quizz_archived_idx1 ON `quizz` (`archived`);

-- -----------------------------------------------------
-- Table `question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `question` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(25) NOT NULL,
  `question` LONGTEXT NOT NULL,
  `marks` INT NOT NULL,
  `archived` TINYINT(1) DEFAULT 0,
  `fk_course` VARCHAR(10) NOT NULL,
  `fk_staff` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_question_course1` FOREIGN KEY (`fk_course`) REFERENCES `course` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_question_staff1` FOREIGN KEY (`fk_staff`) REFERENCES `staff` (`number`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX IF NOT EXISTS question_type_idx1 ON `question` (`type`);
CREATE INDEX IF NOT EXISTS question_question_idx1 ON `question` (`question`);
CREATE INDEX IF NOT EXISTS question_marks_idx1 ON `question` (`marks`);
CREATE INDEX IF NOT EXISTS question_archived_idx1 ON `question` (`archived`);

-- -----------------------------------------------------
-- Table `answer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `answer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `option` TEXT(500) NOT NULL,
  `right_answer` VARCHAR(255) NULL,
  `archived` TINYINT(1) DEFAULT 0,
  `fk_question` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_answer_question1` FOREIGN KEY (`fk_question`) REFERENCES `question` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX IF NOT EXISTS answer_option_idx1 ON `answer` (`option`);
CREATE INDEX IF NOT EXISTS answer_right_answer_idx1 ON `answer` (`right_answer`);
CREATE INDEX IF NOT EXISTS answer_archived_idx1 ON `answer` (`archived`);

-- -----------------------------------------------------
-- Table `quizz_question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quizz_question` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `archived` TINYINT(1) DEFAULT 0,
  `fk_quizz` INT NOT NULL,
  `fk_question` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_quizz_question_quizz1` FOREIGN KEY (`fk_quizz`) REFERENCES `quizz` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_quizz_question_question1` FOREIGN KEY (`fk_question`) REFERENCES `question` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX IF NOT EXISTS quizz_question_archived_idx1 ON `quizz_question` (`archived`);

-- -----------------------------------------------------
-- Table `student_quizz_response`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `student_quizz_response` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `archived` TINYINT(1) DEFAULT 0,
  `fk_quizz` INT NOT NULL,
  `fk_question` INT NOT NULL,
  `fk_answer` INT NOT NULL,
  `fk_student` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_student_quizz_response_quizz1` FOREIGN KEY (`fk_quizz`) REFERENCES `quizz` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_quizz_response_question1` FOREIGN KEY (`fk_question`) REFERENCES `question` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_quizz_response_answer1` FOREIGN KEY (`fk_answer`) REFERENCES `answer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_quizz_response_student1` FOREIGN KEY (`fk_student`) REFERENCES `student` (`index_number`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX IF NOT EXISTS student_quizz_response_archived_idx1 ON `student_quizz_response` (`archived`);

-- -----------------------------------------------------
-- Table `student_quizz_stat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `student_quizz_stat` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `total_mark` DECIMAL(4,1) NOT NULL,
  `pass_mark` DECIMAL(4,1) NOT NULL,
  `score_obtained` DECIMAL(4,1) NOT NULL,
  `score_percent` DECIMAL(4,1) GENERATED ALWAYS AS ((`score_obtained` / `total_mark`) * 100) VIRTUAL,
  `grade` VARCHAR(2)  GENERATED ALWAYS AS (
    CASE
      WHEN `score_percent` >= 80 THEN 'A+'
      WHEN `score_percent` >= 76 THEN 'A-'
      WHEN `score_percent` >= 70 THEN 'B+'
      WHEN `score_percent` >= 66 THEN 'B'
      WHEN `score_percent` >= 60 THEN 'C'
      WHEN `score_percent` >= 50 THEN 'D'
      WHEN `score_percent` >= 46 THEN 'E'
      WHEN `score_percent` <= 45 THEN 'F'
    END
  ) VIRTUAL,
  `passed` TINYINT(1) GENERATED ALWAYS AS (
    CASE
      WHEN `score_obtained` >= `pass_mark` THEN 1
      WHEN `score_obtained` < `pass_mark` THEN 0
    END
  ) VIRTUAL,
  `archived` TINYINT(1) DEFAULT 0,
  `fk_quizz` INT NOT NULL,
  `fk_student` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_student_quizz_stat_quizz1` FOREIGN KEY (`fk_quizz`) REFERENCES `quizz` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_quizz_stat_student1` FOREIGN KEY (`fk_student`) REFERENCES `student` (`index_number`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX IF NOT EXISTS student_quizz_stat_archived_idx1 ON `student_quizz_stat` (`score_percent`);
CREATE INDEX IF NOT EXISTS student_quizz_stat_archived_idx1 ON `student_quizz_stat` (`grade`);
CREATE INDEX IF NOT EXISTS student_quizz_stat_archived_idx1 ON `student_quizz_stat` (`passed`);
CREATE INDEX IF NOT EXISTS student_quizz_stat_archived_idx1 ON `student_quizz_stat` (`archived`);
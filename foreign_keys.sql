ALTER TABLE `semester` 
    ADD CONSTRAINT `fk_semester_academic_year1` FOREIGN KEY (`fk_academic_year`) REFERENCES `academic_year` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE `course` 
    ADD CONSTRAINT `fk_course_department1` FOREIGN KEY (`fk_department`) REFERENCES `department` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_course_category1` FOREIGN KEY (`fk_category`) REFERENCES `course_category` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE `room`
    ADD CONSTRAINT `fk_room_department1` FOREIGN KEY (`fk_department`) REFERENCES `department` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE `class`
  CONSTRAINT `fk_class_program1`FOREIGN KEY (`fk_program`) REFERENCES `programs` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE `student`
    ADD CONSTRAINT `fk_student_academic_year1` FOREIGN KEY (`fk_academic_year`) REFERENCES `academic_year` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_student_applicant1` FOREIGN KEY (`fk_applicant`) REFERENCES `applicants_login` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_student_department1` FOREIGN KEY (`fk_department`) REFERENCES `department` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_student_program1` FOREIGN KEY (`fk_program`) REFERENCES `programs` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_student_class1` FOREIGN KEY (`fk_class`) REFERENCES `class` (`code`) ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE `level`
    ADD CONSTRAINT `fk_course_registration_student1` FOREIGN KEY (`fk_student`) REFERENCES `student` (`index_number`) ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE `curriculum` 
    ADD CONSTRAINT `fk_curriculum_program1` FOREIGN KEY (`fk_program`) REFERENCES `program` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_curriculum_course1` FOREIGN KEY (`fk_course`) REFERENCES `course` (`code`) ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE `section` 
    ADD CONSTRAINT `fk_section_class1` FOREIGN KEY (`fk_class`) REFERENCES `class` (`code`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_section_course1` FOREIGN KEY (`fk_course`) REFERENCES `course` (`code`) ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE `schedule` 
    ADD CONSTRAINT `fk_schedule_section1` FOREIGN KEY (`fk_section`) REFERENCES `section` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_schedule_room1` FOREIGN KEY (`fk_room`) REFERENCES `room` (`number`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_schedule_semester1` FOREIGN KEY (`fk_semester`) REFERENCES `semester` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE `assigned_courses` 
    ADD CONSTRAINT `fk_assigned_courses_student1` FOREIGN KEY (`fk_student`) REFERENCES `student` (`index_number`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_assigned_courses_course1` FOREIGN KEY (`fk_course`) REFERENCES `course` (`code`) ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE `course_registration` 
    ADD CONSTRAINT `fk_course_registration_course1` FOREIGN KEY (`fk_course`) REFERENCES `course` (`code`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_course_registration_student1` FOREIGN KEY (`fk_student`) REFERENCES `student` (`index_number`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_course_registration_semester1` FOREIGN KEY (`fk_semester`) REFERENCES `semester` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE `staff` 
    ADD CONSTRAINT `fk_staff_department1` FOREIGN KEY (`fk_department`) REFERENCES `department` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE `lecture` 
    ADD CONSTRAINT `fk_lecture_staff1` FOREIGN KEY (`fk_staff`) REFERENCES `staff` (`number`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_lecture_section1` FOREIGN KEY (`fk_section`) REFERENCES `section` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `lecture_semester1` FOREIGN KEY (`fk_semester`) REFERENCES `semester` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

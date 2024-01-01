<?php

namespace Src\Controller;

use Src\System\DatabaseConnector;

class AdminController
{
    private $dm;

    public function __construct($host, $port, $db, $user, $pass)
    {
        $this->dm = new DatabaseConnector($host, $port, $db, $user, $pass);
    }

    public function loginStaff($email, $password)
    {
        $query = "SELECT * FROM `staff` WHERE `email` = :e";
        $data = $this->dm->runQuery($query, array(':e' => $email));
        if (!empty($data)) if (password_verify($password, $data[0]["password"])) return $data;
        return 0;
    }

    // CRUD for Academic Year
    public function addAcademicYear($data): mixed
    {
        $query = "INSERT INTO `academic_year` (`start_year`, `end_year`) VALUES (:sy, :ey)";
        return $this->dm->runQuery($query, array(
            ':sy' => $data["start-year"],
            ':ey' => $data["end-year"]
        ));
    }

    public function editAcademicYear($data): mixed
    {
        $query = "UPDATE `academic_year` SET `start_year` = :sy, `end_year` = :ey WHERE `id` = :i";
        return $this->dm->runQuery($query, array(
            ':i' => $data["academic-year"],
            ':sy' => $data["start-year"],
            ':ey' => $data["end-year"]
        ));
    }

    public function archiveAcademicYear($id): mixed
    {
        $query = "UPDATE `academic_year` SET `archived` = 1 WHERE `id` = :i";
        return $this->dm->runQuery($query, array(':i' => $id));
    }

    public function fetchAllAcademicYear(bool $isArchived = false): mixed
    {
        $query = "SELECT * FROM `academic_year` WHERE `archived` = :a";
        return $this->dm->runQuery($query, array(":a" => $isArchived));
    }

    public function fetchAcademicYearByID($id, bool $isArchived = false): mixed
    {
        $query = "SELECT * FROM `academic_year` WHERE `id` = :i AND `archived` = :a";
        return $this->dm->runQuery($query, array(':i' => $id, ":a" => $isArchived));
    }

    public function fetchAcademicYearByName($name, bool $isArchived = false): mixed
    {
        $query = "SELECT * FROM `academic_year` WHERE `name` = :n AND `archived` = :a";
        return $this->dm->runQuery($query, array(':n' => $name, ":a" => $isArchived));
    }

    //CRUD For Semester
    public function addSemester($data): mixed
    {
        $query = "INSERT INTO `semester` (`name`) VALUES (:n)";
        return $this->dm->runQuery($query, array(':n' => $data["name"]));
    }

    public function editSemester($data): mixed
    {
        $query = "UPDATE `semester` SET `name` = :n WHERE id = :i";
        return $this->dm->runQuery($query, array(
            ':i' => $data["semester"],
            ':n' => $data["name"]
        ));
    }

    public function archiveSemester($id): mixed
    {
        $query = "UPDATE `semester` SET `archived` = 1 WHERE `id` = :i";
        return $this->dm->runQuery($query, array(':i' => $id));
    }

    public function fetchAllSemester(bool $isArchived = false): mixed
    {
        $query = "SELECT * FROM `semester` WHERE `archived` = :a";
        return $this->dm->runQuery($query, array(":a" => $isArchived));
    }

    public function fetchSemesterByID($id, bool $isArchived = false): mixed
    {
        $query = "SELECT * FROM `semester` WHERE `id` = :i AND `archived` = :a";
        return $this->dm->runQuery($query, array(':i' => $id, ":a" => $isArchived));
    }

    public function fetchSemesterByName($name, bool $isArchived = false): mixed
    {
        $query = "SELECT * FROM `semester` WHERE `name` = :n AND `archived` = :a";
        return $this->dm->runQuery($query, array(':n' => $name, ":a" => $isArchived));
    }

    //CRUD For Department
    public function addDepartment(array $departments): mixed
    {
        $added = 0;
        foreach ($departments as $department) {
            $query = "INSERT INTO `department` (`name`) VALUES (:n)";
            $added += $this->dm->runQuery($query, array(':n' => $department["name"]));
        }
        return $added;
    }

    public function editDepartment($data): mixed
    {
        $query = "UPDATE `department` SET `name` = :n WHERE id = :i";
        return $this->dm->runQuery($query, array(
            ':i' => $data["department"],
            ':n' => $data["name"]
        ));
    }

    public function archiveDepartment(array $departments): mixed
    {
        $removed = 0;
        foreach ($departments as $department) {
            $query = "UPDATE `department` SET `archived` = 1 WHERE `id` = :i";
            $removed += $this->dm->runQuery($query, array(':i' => $department["id"]));
        }
        return $removed;
    }

    public function fetchAllDepartment(bool $isArchived = false): mixed
    {
        $query = "SELECT * FROM `department` WHERE `archived` = :a";
        return $this->dm->runQuery($query, array(":a" => $isArchived));
    }

    public function fetchDepartmentByID($departmentID, bool $isArchived = false): mixed
    {
        $query = "SELECT * FROM `department` WHERE `id` = :i AND `archived` = :a";
        return $this->dm->runQuery($query, array(':i' => $departmentID, ":a" => $isArchived));
    }

    public function fetchDepartmentByName($departmentName, bool $isArchived = false): mixed
    {
        $query = "SELECT * FROM `department` WHERE `name` = :n AND `archived` = :a";
        return $this->dm->runQuery($query, array(':n' => $departmentName, ":a" => $isArchived));
    }

    //CRUD For Program
    public function addProgram(array $programs): mixed
    {
        $added = 0;
        foreach ($programs as $program) {
            $query = "INSERT INTO `program` (`code`, `name`, `duration`, `dur_format`, `fk_department`) VALUES (:c, :n, :d, :f, :fkd)";
            $added += $this->dm->runQuery($query, array(
                ':c' => $program["code"],
                ':n' => $program["name"],
                ':d' => $program["duration"],
                ':f' => $program["dur_format"],
                ':n' => $program["department"]
            ));
        }
        return $added;
    }

    public function editProgram($data): mixed
    {
        $query = "UPDATE `program` SET `code` = :c, `name` = :n, `duration` = :d, `dur_format` = :f, `fk_department` = :fkd WHERE code = :c";
        return $this->dm->runQuery($query, array(
            ':c' => $data["code"],
            ':n' => $data["name"],
            ':d' => $data["duration"],
            ':f' => $data["dur_format"],
            ':fkd' => $data["department"]
        ));
    }

    public function archiveProgram(array $programs): mixed
    {
        $removed = 0;
        foreach ($programs as $program) {
            $query = "UPDATE `program` SET `archived` = 1 WHERE `code` = :c";
            $removed += $this->dm->runQuery($query, array(':c' => $program["code"]));
        }
        return $removed;
    }

    public function fetchAllProgramByDepartment($departmentID, bool $isArchived = false): mixed
    {
        $query = "SELECT p.`code` AS programCode, p.`name` AS programName, p.`duration` AS programDuration, 
        p.`dur_format` AS durationFormat, d.`id` AS departmentID, d.`name` AS departmentName 
        FROM `program` AS p, `department` AS d WHERE p.`fk_department` = d.`id` AND d.`id` = :d AND p.`archived` = :a";
        return $this->dm->runQuery($query, array(':d' => $departmentID, ":a" => $isArchived));
    }

    public function fetchProgramByCode($programCode, bool $isArchived = false): mixed
    {
        $query = "SELECT p.`code` AS programCode, p.`name` AS programName, p.`duration` AS programDuration, 
        p.`dur_format` AS durationFormat, d.`id` AS departmentID, d.`name` AS departmentName 
        FROM `program` AS p, `department` AS d WHERE p.`fk_department` = d.`id` AND p.`code` = :c AND p.`archived` = :a";
        return $this->dm->runQuery($query, array(':c' => $programCode, ":a" => $isArchived));
    }

    public function fetchProgramByName($programName, bool $isArchived = false): mixed
    {
        $query = "SELECT p.`code` AS programCode, p.`name` AS programName, p.`duration` AS programDuration, 
        p.`dur_format` AS durationFormat, d.`id` AS departmentID, d.`name` AS departmentName 
        FROM `program` AS p, `department` AS d WHERE p.`fk_department` = d.`id` AND p.`name` = :n AND p.`archived` = :a";
        return $this->dm->runQuery($query, array(':n' => $programName, ":a" => $isArchived));
    }

    //CRUD For Course
    public function addCourse(array $courses): mixed
    {
        $added = 0;
        foreach ($courses as $course) {
            $query = "INSERT INTO `course` (`code`, `name`, `credit_hours`, `fk_department`) VALUES (:c, :n, :ch, :fkd)";
            $added += $this->dm->runQuery($query, array(
                ':c' => $course["code"],
                ':n' => $course["name"],
                ':ch' => $course["credit_hours"],
                ':fkd' => $course["department"]
            ));
        }
        return $added;
    }

    public function editCourse($course): mixed
    {
        $query = "UPDATE `course` SET `code` = :c, `name` = :n, `credit_hours` = :ch, `fk_department` = :fkd WHERE `code` = :c";
        return $this->dm->runQuery($query, array(
            ':c' => $course["code"],
            ':n' => $course["name"],
            ':ch' => $course["credit_hours"],
            ':fkd' => $course["department"]
        ));
    }

    public function archiveCourse($courses): mixed
    {
        $removed = 0;
        foreach ($courses as $course) {
            $query = "UPDATE `course` SET `archived` = 1 WHERE `code` = :c";
            $removed += $this->dm->runQuery($query, array(':c' => $course["code"]));
        }
        return $removed;
    }

    public function fetchAllCourseByDepartment($departmentID, bool $isArchived = false): mixed
    {
        $query = "SELECT c.`code` AS courseCode, c.`name` AS courseName, c.`credit_hours` AS creditHours, 
        d.`id` AS departmentID, d.`name` AS departmentName FROM `course` AS c, department AS d 
        WHERE c.`fk_department` = d.`id` AND d.`id` = :d AND c.`archived` = :a";
        return $this->dm->runQuery($query, array(':d' => $departmentID, ":a" => $isArchived));
    }

    public function fetchCourseByCode($courseCode, bool $isArchived = false): mixed
    {
        $query = "SELECT c.`code` AS courseCode, c.`name` AS courseName, c.`credit_hours` AS creditHours, 
        d.`id` AS departmentID, d.`name` AS departmentName FROM `course` AS c, department AS d 
        WHERE c.`fk_department` = d.`id` AND c.`code` = :c AND c.`archived` = :a";
        return $this->dm->runQuery($query, array(':c' => $courseCode, ":a" => $isArchived));
    }

    public function fetchCourseByName($courseName, bool $isArchived = false): mixed
    {
        $query = "SELECT c.`code` AS courseCode, c.`name` AS courseName, c.`credit_hours` AS creditHours, 
        d.`id` AS departmentID, d.`name` AS departmentName FROM `course` AS c, department AS d 
        WHERE c.`fk_department` = d.`id` AND c.`name` = :n AND c.`archived` = :a";
        return $this->dm->runQuery($query, array(':n' => $courseName, ":a" => $isArchived));
    }

    //CRUD For Room
    public function addRoom(array $rooms): mixed
    {
        $added = 0;
        foreach ($rooms as $room) {
            $query = "INSERT INTO `room` (`number`, `capacity`, `location`, `fk_department`) VALUES (:n, :c, :l, :fkd)";
            $added += $this->dm->runQuery($query, array(
                ':n' => $room["number"],
                ':c' => $room["capacity"],
                ':l' => $room["location"],
                ':fkd' => $room["department"]
            ));
        }
        return $added;
    }

    public function editRoom($room): mixed
    {
        $query = "UPDATE `room` SET `number` = :n, `capacity` = :c, `location` = :l, `fk_department` = :fkd WHERE `number` = :n";
        return $this->dm->runQuery($query, array(
            ':n' => $room["number"],
            ':c' => $room["capacity"],
            ':l' => $room["location"],
            ':fkd' => $room["department"]
        ));
    }

    public function archiveRoom(array $rooms): mixed
    {
        $removed = 0;
        foreach ($rooms as $room) {
            $query = "UPDATE `room` SET `archived` = 1 WHERE `number` = :n";
            $removed += $this->dm->runQuery($query, array(':n' => $room["number"]));
        }
        return $removed;
    }

    public function fetchAllRoomByDepartment($departmentID, bool $isArchived = false): mixed
    {
        $query = "SELECT r.`number` AS roomNumber, r.`location` AS roomLocation, r.`capacity` AS roomCapacity, 
        d.`id` AS departmentID, d.`name` AS departmentName FROM `room` AS r, department AS d 
        WHERE r.`department` = d.`id` AND d.`id` = :d AND r.`archived` = :a";
        return $this->dm->runQuery($query, array(":d" => $departmentID, ":a" => $isArchived));
    }

    public function fetchRoomByNumber($roomNumber, bool $isArchived = false): mixed
    {
        $query = "SELECT r.`number` AS roomNumber, r.`location` AS roomLocation, r.`capacity` AS roomCapacity, 
        d.`id` AS departmentID, d.`name` AS departmentName FROM `room` AS r, department AS d 
        WHERE r.`department` = d.`id` AND r.`number` = :n AND r.`archived` = :a";
        return $this->dm->runQuery($query, array(':n' => $roomNumber, ":a" => $isArchived));
    }

    // CRUD for Class
    public function addClass(array $classes): mixed
    {
        $added = 0;
        foreach ($classes as $class) {
            $query = "INSERT INTO `class` (`code`, `fk_program`) VALUES (:c, :fkp)";
            $added += $this->dm->runQuery($query, array(
                ':c' => $class["code"],
                ':fkp' => $class["program"]
            ));
        }
        return $added;
    }

    public function editClass($class): mixed
    {
        $query = "UPDATE `class` SET `code` = :c, `fk_program` = :fkp WHERE `code` = :c";
        return $this->dm->runQuery($query, array(
            ':c' => $class["code"],
            ':fkp' => $class["program"]
        ));
    }

    public function archiveClass($classes): mixed
    {
        $removed = 0;
        foreach ($classes as $class) {
            $query = "UPDATE `class` SET `archived` = 1  WHERE `code` = :c";
            $removed += $this->dm->runQuery($query, array(':c' => $class["code"]));
        }
        return $removed;
    }

    public function fetchAllClassByDepartment($departmentID, bool $isArchived = false): mixed
    {
        $query = "SELECT c.`code` AS classCode, p.`code` AS programCode, p.`name` AS programName 
                    FROM `class` AS c, `program` AS p, `department` AS d 
                    WHERE p.`code` = c.`fk_program` AND p.`fk_department` = d.`id` AND d.`id` = :d AND c.`archived` = :a";
        return $this->dm->runQuery($query, array(":d" => $departmentID, ":a" => $isArchived));
    }

    public function fetchAllClassByProgram($programCode, bool $isArchived = false): mixed
    {
        $query = "SELECT c.`code` AS classCode, p.`code` AS programCode, p.`name` AS programName 
                    FROM `class` AS c, `program` AS p 
                    WHERE p.`code` = c.`fk_program` AND p.`code` = :p AND c.`archived` = :a";
        return $this->dm->runQuery($query, array(":p" => $programCode, ":a" => $isArchived));
    }

    public function fetchClassByCode($code, bool $isArchived = false): mixed
    {
        $query = "SELECT c.`code` AS classCode, p.`code` AS programCode, p.`name` AS programName 
                    FROM `class` AS c, `program` AS p, `department` AS d 
                    WHERE p.`code` = c.`fk_program` AND p.`fk_department` = d.`id` AND c.`code` = :c AND c.`archived` = :a";
        return $this->dm->runQuery($query, array(':c' => $code, ":a" => $isArchived));
    }

    // CRUD For Students
    public function editStudent($student): mixed
    {
        $query = "UPDATE `student` SET `class` = :c WHERE `index_number` = :i";
        return $this->dm->runQuery($query, array(':i' => $student["index-number"]));
    }

    public function archiveStudent(array $students): mixed
    {
        $archived = 0;
        foreach ($students as $student) {
            $query = "UPDATE `student` SET `archived` = 1  WHERE `index_number` = :i";
            $archived += $this->dm->runQuery($query, array(':i' => $student["index_number"]));
        }
        return $archived;
    }

    public function fetchAllStudentByDepartment($departmentID, bool $isArchived = false): mixed
    {
        $query = "SELECT s.`index_number` AS indexNumber, s.`app_number` AS appNumber, s.`email`, s.`phone_number` AS phoneNumber, 
        s.`first_name` AS firstName, s.`middle_name` AS middleName, s.`last_name` AS lastName, s.`suffix`, s.`gender`, s.`dob`, s.`nationality`, 
        s.`photo`, s.`date_admitted` AS dateAdmitted, s.`term_admitted` AS termAdmitted, s.`stream_admitted` AS streamAdmitted, 
        d.`id` AS departmentID, d.`name` AS departmentName 
        FROM `student` AS s, `department` AS d WHERE s.`fk_department` = d.`id` AND d.`id` = :d AND c.`archived` = :a";
        return $this->dm->runQuery($query, array(":d" => $departmentID, ":a" => $isArchived));
    }

    public function fetchAllStudentByProgram($programCode, bool $isArchived = false): mixed
    {
        $query = "SELECT s.`index_number` AS indexNumber, s.`app_number` AS appNumber, s.`email`, s.`phone_number` AS phoneNumber, 
        s.`first_name` AS firstName, s.`middle_name` AS middleName, s.`last_name` AS lastName, s.`suffix`, s.`gender`, s.`dob`, s.`nationality`, 
        s.`photo`, s.`date_admitted` AS dateAdmitted, s.`term_admitted` AS termAdmitted, s.`stream_admitted` AS streamAdmitted, 
        d.`id` AS departmentID, d.`name` AS departmentName FROM `student` AS s, `department` AS d, `class` AS c 
        WHERE s.`fk_department` = d.`id` AND s.`class` = c.`code` AND c.`fk_program` = :p AND s.`archived` = :a";
        return $this->dm->runQuery($query, array(":p" => $programCode, ":a" => $isArchived));
    }

    public function fetchAllStudentByClass($classCode, bool $isArchived = false): mixed
    {
        $query = "SELECT s.`index_number` AS indexNumber, s.`app_number` AS appNumber, s.`email`, s.`phone_number` AS phoneNumber, 
        s.`first_name` AS firstName, s.`middle_name` AS middleName, s.`last_name` AS lastName, s.`suffix`, s.`gender`, s.`dob`, s.`nationality`, 
        s.`photo`, s.`date_admitted` AS dateAdmitted, s.`term_admitted` AS termAdmitted, s.`stream_admitted` AS streamAdmitted, 
        d.`id` AS departmentID, d.`name` AS departmentName FROM `student` AS s, `department` AS d, `class` AS c 
        WHERE s.`fk_department` = d.`id` AND s.`class` = c.`code` AND c.`class` = :c AND s.`archived` = :a";
        return $this->dm->runQuery($query, array(":c" => $classCode, ":a" => $isArchived));
    }

    public function fetchAllStudentByIndexNumber($indexNumber, bool $isArchived = false): mixed
    {
        $query = "SELECT s.`index_number` AS indexNumber, s.`app_number` AS appNumber, s.`email`, s.`phone_number` AS phoneNumber, 
        s.`first_name` AS firstName, s.`middle_name` AS middleName, s.`last_name` AS lastName, s.`suffix`, s.`gender`, s.`dob`, s.`nationality`, 
        s.`photo`, s.`date_admitted` AS dateAdmitted, s.`term_admitted` AS termAdmitted, s.`stream_admitted` AS streamAdmitted, 
        d.`id` AS departmentID, d.`name` AS departmentName FROM `student` AS s, `department` AS d 
        WHERE s.`fk_department` = d.`id` AND s.`index_number` = :i AND s.`archived` = :a";
        return $this->dm->runQuery($query, array(":i" => $indexNumber, ":a" => $isArchived));
    }
}

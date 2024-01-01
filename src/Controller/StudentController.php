<?php

namespace Src\Controller;

use Src\System\DatabaseConnector;

class StudentController
{
    private $dm;

    public function __construct($host, $port, $db, $user, $pass)
    {
        $this->dm = new DatabaseConnector($host, $port, $db, $user, $pass);
    }

    public function loginStudent($indexNumber, $password)
    {
        $sql = "SELECT * FROM `student` WHERE `index_number` = :i";
        $data = $this->dm->runQuery($sql, array(':i' => $indexNumber));
        if (!empty($data)) if (password_verify($password, $data[0]["password"])) return $data;
        return 0;
    }

    
}

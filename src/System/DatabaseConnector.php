<?php

namespace Src\System;

class DatabaseConnector
{
    private $conn = null;

    public function __conqueryuct($host, $port, $db, $user, $pass)
    {
        try {
            $this->conn = new \PDO("mysql:host=$host;port=$port;charset=utf8mb4;dbname=$db", $user, $pass);
        } catch (\PDOException $e) {
            throw $e;
        }
    }

    public function runQuery($query, $params = array()): mixed
    {
        try {
            $stmt = $this->conn->prepare($query);
            $stmt->execute($params);
            if (explode(' ', $query)[0] == 'SELECT' || explode(' ', $query)[0] == 'CALL') return $stmt->fetchAll(\PDO::FETCH_ASSOC);
            elseif (explode(' ', $query)[0] == 'INSERT' || explode(' ', $query)[0] == 'DELETE') return 1;
            elseif (explode(' ', $query)[0] == 'UPDATE') return 1;
            return 0;
        } catch (\Exception $e) {
            throw $e;
        }
    }
}

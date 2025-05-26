<?php
class PeriphericController
{
    private PDO $db; // Instance de PDO

    public function __construct()
    {
        // Connexion à la BDD
        $host = "mysql"; // Or your MySQL service name from docker-compose.yaml
        $dbName = getenv("MYSQL_DATABASE");
        $port = 3306; // Default MySQL port
        $userName = getenv("MYSQL_USER");
        $password = getenv("MYSQL_PASSWORD"); // Use MYSQL_PASSWORD
        try {
            $this->setDb(new PDO("mysql:host=$host;dbname=$dbName;port=$port;charset=utf8mb4", $userName, $password));
            //echo "Connexion réussie !";
        } catch (PDOException $error) {
            // Log the error and/or rethrow to stop execution if DB is critical
            error_log("Database Connection Error: " . $error->getMessage());
            throw new RuntimeException("Failed to connect to the database: " . $error->getMessage(), 0, $error);
        }
    }
    public function setDb(PDO $db): void
    {
        $this->db = $db;
    }

    public function createPeripheric(Peripheric $peripheric): void
    {
        $req = $this->db->prepare("INSERT INTO `Peripheric` (Name, Type, Description) VALUES (:name, :type, :description)");

        $req->bindValue(":name", htmlspecialchars($peripheric->getName()), PDO::PARAM_STR);
        $req->bindValue(":type", htmlspecialchars($peripheric->getType()), PDO::PARAM_STR);
        $req->bindValue(":description", htmlspecialchars($peripheric->getDescription()), PDO::PARAM_STR);

        $req->execute();
    }

    public function updatePeripheric(Peripheric $peripheric): void
    {
        $req = $this->db->prepare("UPDATE `Peripheric` SET Name=:name, Type=:type, Description=:description WHERE id=:id");

        $req->bindValue(":name", htmlspecialchars($peripheric->getName()), PDO::PARAM_STR);
        $req->bindValue(":type", htmlspecialchars($peripheric->getType()), PDO::PARAM_STR);
        $req->bindValue(":description", htmlspecialchars($peripheric->getDescription()), PDO::PARAM_STR);
        $req->bindValue(":id", $peripheric->getId(), PDO::PARAM_INT);

        $req->execute();
    }
    public function deletePeripheric(int $id): void
    {
        $req = $this->db->prepare("DELETE FROM `Peripheric` WHERE id=:id");
        $req->bindValue(":id", $id, PDO::PARAM_INT);
        $req->execute();
    }
    public function getPeriphericById(int $id): Peripheric
    {
        $req = $this->db->prepare("SELECT * FROM `Peripheric` WHERE id=:id");
        $req->bindValue(":id", $id, PDO::PARAM_INT);
        $req->execute();
        $data = $req->fetch();
        return new Peripheric($data);
    }
    
}
    
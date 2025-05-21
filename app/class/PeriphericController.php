<?php
class PeriphericController
{
    private PDO $db; // Instance de PDO

    public function __construct()
    {
        $env = getenv("USER"); // récupération des donnés d'environnement 
        // Connexion à la BDD
        $host = "localhost";
        $dbName = $env["MYSQL_DATABASE"];
        $port = 8889;
        $userName = "root";
        $password = $env["MYSQL_ROOT_PASSWORD"];
        try {
            $this->setDb(new PDO("mysql:host=$host;dbname=$dbName;port=$port;charset=utf8mb4", $userName, $password));
            //echo "Connexion réussie !";
        } catch (PDOException $error) {
            echo "<p style='color:red'>{$error->getMessage()}</p>";
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
    
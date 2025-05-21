<?php

class Contentcontroller
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

    public function createModel(Content $content): void
    {
        $req = $this->db->prepare("INSERT INTO `Content` (Name, Description, Creation_Date, Path, Author_id, Type_id) VALUES (:name, :description, :creation_Date, :Path, :author_id, :type_id)");

        $req->bindValue(":name", htmlspecialchars($content->getName()), PDO::PARAM_STR);
        $req->bindValue(":Description", htmlspecialchars($content->getDescription()), PDO::PARAM_STR);
        $req->bindValue(":Creation_Date", time(), PDO::PARAM_STR);
        $req->bindValue(":Path", $content->getPath(), PDO::PARAM_STR);
        $req->bindValue(":author_id", $content->getAuthorId(), PDO::PARAM_STR);
        $req->bindValue(":type_id", $content->getTypeId(), PDO::PARAM_STR);

        $req->execute();
    }

    public function updateModel(): void {}

    public function deleteModel(int $id): void
    {
        $req = $this->db->prepare("DELETE FROM `Content` WHERE id=:id");
        $req->bindValue(":id", $id, PDO::PARAM_INT);
        $req->execute();
    }
    public function getModelById(int $id): Content
    {
        $req = $this->db->prepare("SELECT * FROM `Content` WHERE id=:id");
        $req->bindValue(":id", $id, PDO::PARAM_INT);
        $req->execute();
        $data = $req->fetch();
        return new Content($data);
    }

    public function getModelByUserId(int $id): array
    {
        $content = [];
        $req = $this->db->prepare("SELECT * FROM `Content` WHERE Author_id=:id");
        $req->bindValue(":id", $id, PDO::PARAM_INT);
        $req->execute();
        $datas = $req->fetchAll();
        foreach ($datas as $data) {
            $content[] = new Content($data);
        }
        return $content;
    }


    public function getAllModel(): array
    {
        $content = [];
        $req = $this->db->prepare("SELECT * FROM `Content` ORDER BY number");
        $req->execute();
        $datas = $req->fetchAll();
        foreach ($datas as $data) {
            $content[] = new Content($data);
        }
        return $content;
    }

    public function getModelByName(string $name): Content
    {
        $name = htmlspecialchars($name);
        $name = strip_tags($name);
        $name = strtolower($name);
        $name = ucfirst($name);
        // On prépare la requête
        $req = $this->db->prepare("SELECT * FROM `Content` WHERE Name = :Name");
        $req->bindValue(":Name", $name, PDO::PARAM_STR);
        $req->execute();
        $data = $req->fetch();
        return new Content($data);
    }
}
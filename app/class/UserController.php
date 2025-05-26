<?php
require_once "User.php";
class UserController
{
    private PDO $db; // Instance de PDO

    public function __construct()
    {
        // Connexion à la BDD
        $host = "mysql"; // Or your MySQL service name from docker-compose.yaml
        $dbName = "HexalabDB";
        $port = 3306; // Default MySQL port
        $userName = "app_user";
        $password = "app_pass";
        try {
            $this->setDb(new PDO("mysql:host=$host;dbname=$dbName;port=$port;charset=utf8mb4", $userName, $password));
            //echo "Connexion réussie !";
        } catch (PDOException $error) {
            error_log("Database Connection Error: " . $error->getMessage());
            throw new RuntimeException("Failed to connect to the database: " . $error->getMessage(), 0, $error);
        }
    }

    public function setDb(PDO $db): void
    {
        $this->db = $db;
    }

    public function createUser(User $user): void
    {
        $req = $this->db->prepare("INSERT INTO `User` (firstName, lastName, email, password, pfp) VALUES (:firstName, :lastName, :email, :password, :pfp)");

        $req->bindValue(":firstName", $user->getFirstName(), PDO::PARAM_STR);
        $req->bindValue(":lastName", $user->getLastName(), PDO::PARAM_STR);
        $req->bindValue(":email", $user->getEmail(), PDO::PARAM_STR);
        $req->bindValue(":password", $user->getPassword(), PDO::PARAM_STR);
        $req->bindValue(":pfp", $user->getPfp(), PDO::PARAM_STR);

        $req->execute();
    }

    public function updateUser(): void {}

    public function deleteUser(int $id): void
    {
        $req = $this->db->prepare("DELETE FROM `User` WHERE id=:id");
        $req->bindValue(":id", $id, PDO::PARAM_INT);
        $req->execute();
    }

    public function readUser(): void {}


    public function readAllUser(): array
    {
        $users = [];
        $req = $this->db->prepare("SELECT * FROM `user` ORDER BY number");
        $req->execute();
        $datas = $req->fetchAll();
        foreach ($datas as $data) {
            $users[] = new User($data);
        }
        return $users;
    }

    public function getUserByEmail(string $email): User
    {
        $req = $this->db->prepare("SELECT * FROM `User` WHERE email = :email");
        $req->bindValue(":email", $email, PDO::PARAM_STR);
        $req->execute();
        $data = $req->fetch();
        return new User($data);
    }

    public function getUserById(int $id): User
    {
        $req = $this->db->prepare("SELECT * FROM `User` WHERE id = :id");
        $req->bindValue(":id", $id, PDO::PARAM_INT);
        $req->execute();
        $data = $req->fetch();
        return new User($data);
    }
}
CREATE DATABASE hexalabdb;
USE hexalabdb;

-- Table: User
CREATE TABLE User (
    Id INT PRIMARY KEY,
    Name VARCHAR(255),
    Role VARCHAR(100),
    Password VARCHAR(255)
);

-- Table: Content
CREATE TABLE Content (
    id INT PRIMARY KEY,
    Author INT,
    Name VARCHAR(255),
    Descrp TEXT,
    type VARCHAR(100),
    path VARCHAR(255),
    Visibility VARCHAR(50),
    contributor INT,
    FOREIGN KEY (Author) REFERENCES User(Id),
    FOREIGN KEY (contributor) REFERENCES User(Id)
);

-- Table: Notif
CREATE TABLE Notif (
    Content INT,
    receiver INT,
    FOREIGN KEY (Content) REFERENCES Content(id),
    FOREIGN KEY (receiver) REFERENCES User(Id)
);

-- Table: Comment
CREATE TABLE Comment (
    ID INT PRIMARY KEY,
    Content TEXT
);

-- Table: Post_comment
CREATE TABLE Post_comment (
    id INT PRIMARY KEY
);

-- Table: post
CREATE TABLE post (
    ID INT PRIMARY KEY,
    Title VARCHAR(255),
    Desc TEXT,
    asset_path VARCHAR(255)
);

-- Table: request
CREATE TABLE request (
    id INT PRIMARY KEY,
    requester INT,
    Validator INT,
    State VARCHAR(50),
    periphery INT,
    Content INT,
    FOREIGN KEY (requester) REFERENCES User(Id),
    FOREIGN KEY (Validator) REFERENCES User(Id),
    FOREIGN KEY (periphery) REFERENCES periphery(id),
    FOREIGN KEY (Content) REFERENCES Content(id)
);

-- Table: periphery
CREATE TABLE periphery (
    id INT PRIMARY KEY,
    Name VARCHAR(255),
    Desc TEXT,
    type VARCHAR(100),
    state VARCHAR(50)
);

-- Table: concerne (User-Notif)
CREATE TABLE User_Notif (
    Notif_Content INT,
    User_Id INT,
    FOREIGN KEY (Notif_Content) REFERENCES Notif(Content),
    FOREIGN KEY (User_Id) REFERENCES User(Id)
);

-- Table: User-Content (concerne)
CREATE TABLE User_Content (
    Content_Id INT,
    User_Id INT,
    FOREIGN KEY (Content_Id) REFERENCES Content(id),
    FOREIGN KEY (User_Id) REFERENCES User(Id)
);

-- Table: User-periphery (concerne)
CREATE TABLE User_periphery (
    periphery_id INT,
    User_Id INT,
    FOREIGN KEY (periphery_id) REFERENCES periphery(id),
    FOREIGN KEY (User_Id) REFERENCES User(Id)
);

-- Table: User-Comment (Crée)
CREATE TABLE User_Comment (
    User_Id INT,
    Comment_ID INT,
    FOREIGN KEY (User_Id) REFERENCES User(Id),
    FOREIGN KEY (Comment_ID) REFERENCES Comment(ID)
);

-- Table: User-Post_comment (Crée)
CREATE TABLE User_Post_comment (
    User_Id INT,
    Post_comment_id INT,
    FOREIGN KEY (User_Id) REFERENCES User(Id),
    FOREIGN KEY (Post_comment_id) REFERENCES Post_comment(id)
);

-- Table: User-post (Crée)
CREATE TABLE User_post (
    User_Id INT,
    post_ID INT,
    FOREIGN KEY (User_Id) REFERENCES User(Id),
    FOREIGN KEY (post_ID) REFERENCES post(ID)
);

-- Table: Content-Comment (Crée)
CREATE TABLE Content_Comment (
    Content_id INT,
    Comment_ID INT,
    FOREIGN KEY (Content_id) REFERENCES Content(id),
    FOREIGN KEY (Comment_ID) REFERENCES Comment(ID)
);



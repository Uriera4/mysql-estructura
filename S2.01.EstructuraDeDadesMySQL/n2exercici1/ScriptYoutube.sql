DROP DATABASE IF EXISTS Youtube;
CREATE DATABASE Youtube;
USE Youtube;

CREATE TABLE Usuaris (
	IDUsuari INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(20) NOT NULL,
    NomUsuari VARCHAR(20) NOT NULL,
    DataNaixement DATE NOT NULL,
    Sexe ENUM("M", "F", "NB", "A", "T", "Altres", "NS") NOT NULL,
    Pais VARCHAR(20) NOT NULL,
    CodiPostal INT NOT NULL
);
CREATE TABLE Videos (
	IDVideo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    IDUsuari INT NOT NULL,
    Titol VARCHAR(50) NOT NULL,
    Descripcio VARCHAR(500) NOT NULL,
    Grandaria FLOAT NOT NULL,
    NomArxiuVideo VARCHAR(20) NOT NULL,
    Durada TIME NOT NULL,
    Thumbnail VARCHAR(300) NOT NULL,
    NReproduccions INT NOT NULL,
    NLikes INT NOT NULL,
    NDislikes INT NOT NULL,
    Visibilitat ENUM("Publica", "Oculta", "Privada"),
    DataHoraPublicacio DATETIME NOT NULL,
    FOREIGN KEY (IDUsuari) REFERENCES Usuaris(IDUsuari)
);
CREATE TABLE Etiquetes (
	IDEtiqueta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nom VARCHAR(30) NOT NULL
);
CREATE TABLE EtiquetesVideos (
	IDEtiqueta INT NOT NULL,
    IDVideo INT NOT NULL,
    FOREIGN KEY (IDEtiqueta) REFERENCES Etiquetes(IDEtiqueta),
    FOREIGN KEY (IDVideo) REFERENCES Videos(IDVideo)
);
CREATE TABLE Playlists (
	IDPlaylist INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    IDUsuari INT NOT NULL,
    Nom VARCHAR(30) NOT NULL,
    DataCreacio DATE NOT NULL,
    Visibilitat ENUM("Publica", "Privada") NOT NULL,
    FOREIGN KEY (IDUsuari) REFERENCES Usuaris(IDUsuari)
);
CREATE TABLE Canals (
	IDCanal INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    IDUsuari INT NOT NULL,
    Nom VARCHAR(30) NOT NULL,
    Descripcio VARCHAR(300) NOT NULL,
    DataCreacio DATE NOT NULL,
    FOREIGN KEY (IDUsuari) REFERENCES Usuaris(IDUsuari)
);
CREATE TABLE VideosCanals (
	IDCanal INT NOT NULL,
    IDVideo INT NOT NULL,
    FOREIGN KEY (IDCanal) REFERENCES Canals(IDCanal),
    FOREIGN KEY (IDVideo) REFERENCES Videos(IDVideo)
);
CREATE TABLE SubscripcionsCanals (
	IDCanal INT NOT NULL,
    IDUsuari INT NOT NULL,
    FOREIGN KEY (IDCanal) REFERENCES Canals(IDCanal),
    FOREIGN KEY (IDUsuari) REFERENCES Usuaris(IDUsuari)
);
CREATE TABLE ComentarisVideos (
	IDComentari INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    IDVideo INT NOT NULL,
    IDUsuari INT NOT NULL,
    TextComentari VARCHAR(300) NOT NULL,
    DataHora DATETIME NOT NULL,
    FOREIGN KEY (IDVideo) REFERENCES Videos(IDVideo),
    FOREIGN KEY (IDUsuari) REFERENCES Usuaris(IDUsuari)
);
CREATE TABLE LikeDislikeVideos (
	IDVideo INT NOT NULL,
    IDUsuari INT NOT NULL,
    Tipus ENUM("Like", "Dislike") NOT NULL,
    DataHora DATETIME NOT NULL,
    FOREIGN KEY (IDVideo) REFERENCES Videos(IDVideo),
    FOREIGN KEY (IDUsuari) REFERENCES Usuaris(IDUsuari),
    UNIQUE KEY (IDVideo, IDUsuari)
);
CREATE TABLE LikeDislikeComentaris (
	IDComentari INT NOT NULL,
    IDUsuari INT NOT NULL,
    Tipus ENUM("Like", "Dislike") NOT NULL,
    DataHora DATETIME NOT NULL,
    FOREIGN KEY (IDComentari) REFERENCES ComentarisVideos(IDComentari),
    FOREIGN KEY (IDUsuari) REFERENCES Usuaris(IDUsuari),
    UNIQUE KEY (IDComentari, IDUsuari)
);

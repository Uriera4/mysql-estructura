DROP DATABASE IF EXISTS Spotify;
CREATE DATABASE Spotify;
USE Spotify;

CREATE TABLE Usuaris (
	IDUsuari INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    NomUsuari VARCHAR(30) NOT NULL,
    Password VARCHAR(15) NOT NULL,
    Email VARCHAR(30) NOT NULL,
    DataNaixement DATE NOT NULL,
    Sexe ENUM("M", "F", "NB", "A", "T", "Altres", "NS") NOT NULL,
    Pais VARCHAR(20) NOT NULL,
    CodiPostal INT NOT NULL
);
CREATE TABLE Subscripcions (
	IDUsuariPremium INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    IDUsuari INT NOT NULL,
    DataInici DATE NOT NULL,
    DataRenovacio DATE NOT NULL,
    FormaPagament ENUM ("Targeta de crèdit", "Paypal"),
    FOREIGN KEY (IDUsuari) REFERENCES Usuaris(IDUsuari)
);
CREATE TABLE TargetesCredit (
    NumeroTarjeta VARCHAR(16) NOT NULL PRIMARY KEY,
    MesCaducitat INT NOT NULL CHECK (MesCaducitat>=1 AND MesCaducitat<=12),
    AnyCaducitat YEAR NOT NULL,
    CodiSeguretat VARCHAR(3) NOT NULL,
	IDUsuariPremium INT NOT NULL,
    FOREIGN KEY (IDUsuariPremium) REFERENCES Subscripcions(IDUsuariPremium)
);
CREATE TABLE ComptesPaypal (
    NomUsuari VARCHAR(20) NOT NULL PRIMARY KEY,
    IDUsuariPremium INT NOT NULL,
    FOREIGN KEY (IDUsuariPremium) REFERENCES Subscripcions(IDUsuariPremium)
);
CREATE TABLE Pagaments (
	IDOrdre INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    DataPagament DATE NOT NULL,
    TotalPagament INT NOT NULL,
	IDUsuariPremium INT NOT NULL,
    FOREIGN KEY (IDUsuariPremium) REFERENCES Subscripcions(IDUsuariPremium)
);
CREATE TABLE EstilsMusicals (
	IDEstilMusica INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nom VARCHAR(30) NOT NULL
);
CREATE TABLE Cançons (
	IDCanço INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Titol VARCHAR(20) NOT NULL,
    Durada TIME NOT NULL,
    NReproduccions INT NOT NULL,
    IDEstilMusica INT NOT NULL,
    FOREIGN KEY (IDEstilMusica) REFERENCES EstilsMusicals(IDEstilMusica)
);
CREATE TABLE Albums (
	IDAlbum INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Titol VARCHAR(30) NOT NULL,
    AnyPublicacio YEAR NOT NULL,
    ImatgePortada VARCHAR(300) NOT NULL,
    IDCanço INT NOT NULL,
    FOREIGN KEY (IDCanço) REFERENCES Cançons(IDCanço)
);
CREATE TABLE Artistes (
	IDArtista INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nom VARCHAR(60) NOT NULL,
    Imatge VARCHAR(300) NOT NULL,
    IDAlbum INT NOT NULL UNIQUE,
    FOREIGN KEY (IDAlbum) REFERENCES Albums(IDAlbum)
);
CREATE TABLE Playlists (
	IDPlaylist INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Titol VARCHAR(20) NOT NULL,
    NCançons INT NOT NULL,
    DataCreacio DATE NOT NULL,
    IDUsuari INT NOT NULL,
    FOREIGN KEY (IDUsuari) REFERENCES Usuaris(IDUsuari)
);
CREATE TABLE PlaylistsActives (
	IDPlaylistActiva INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    IDPlaylist INT NOT NULL,
    Estat VARCHAR(6) NOT NULL CHECK (Estat = 'Activa'),
    FOREIGN KEY (IDPlaylist) REFERENCES Playlists(IDPlaylist)
);
CREATE TABLE PlaylistsEsborrades (
	IDPlaylist INT NOT NULL,
    DataEliminacio DATE NOT NULL,
    Estat VARCHAR(9) NOT NULL CHECK (Estat = 'Esborrada'),
    FOREIGN KEY (IDPlaylist) REFERENCES Playlists(IDPlaylist)
);
CREATE TABLE PlaylistsCompartides (
    IDPlaylistActiva INT NOT NULL,
    IDUsuari INT NOT NULL,
    IDCanço INT NOT NULL,
    DataIntroduccio DATE NOT NULL,
    FOREIGN KEY (IDPlaylistActiva) REFERENCES PlaylistsActives(IDPlaylistActiva),
    FOREIGN KEY (IDUsuari) REFERENCES Usuaris(IDUsuari),
    FOREIGN KEY (IDCanço) REFERENCES Cançons(IDCanço)
);
CREATE TABLE SeguidorsArtistes (
    IDUsuari INT NOT NULL,
	IDArtista INT NOT NULL,
    FOREIGN KEY (IDUsuari) REFERENCES Usuaris(IDUsuari),
    FOREIGN KEY (IDArtista) REFERENCES Artistes(IDArtista)
);
CREATE TABLE AlbumsFavorits (
	IDUsuari INT NOT NULL,
	IDAlbum INT NOT NULL,
    FOREIGN KEY (IDUsuari) REFERENCES Usuaris(IDUsuari),
    FOREIGN KEY (IDAlbum) REFERENCES Albums(IDAlbum)
);
CREATE TABLE CançonsFavorites (
    IDUsuari INT NOT NULL,
	IDCanço INT NOT NULL,
	FOREIGN KEY (IDUsuari) REFERENCES Usuaris(IDUsuari),
    FOREIGN KEY (IDCanço) REFERENCES Cançons(IDCanço)
);

DROP DATABASE IF EXISTS Pizzeria;
CREATE DATABASE Pizzeria;
USE Pizzeria;

CREATE TABLE Provincies (
	IDProvincia INT NOT NULL AUTO_INCREMENT,
    Nom VARCHAR(30) NOT NULL,
    PRIMARY KEY (IDProvincia)
);
CREATE TABLE Localitats (
	IDLocalitat INT NOT NULL AUTO_INCREMENT,
    Nom VARCHAR(30) NOT NULL,
    IDProvincia INT NOT NULL,
    PRIMARY KEY (IDLocalitat),
    FOREIGN KEY (IDProvincia) REFERENCES Provincies(IDProvincia)
);
CREATE TABLE Clients (
	IDClient INT NOT NULL AUTO_INCREMENT,
    Nom VARCHAR(20) NOT NULL,
    Cognoms VARCHAR(60) NOT NULL,
    Adreça VARCHAR(50) NOT NULL,
    CodiPostal INT NOT NULL,
    IDLocalitat INT NOT NULL,
    Telefon INT NOT NULL,
    PRIMARY KEY (IDClient),
	FOREIGN KEY (IDLocalitat) REFERENCES Localitats(IDLocalitat)
);
CREATE TABLE Botigues (
	IDBotiga INT NOT NULL AUTO_INCREMENT,
    Adreça VARCHAR(100) NOT NULL,
    CodiPostal INT NOT NULL,
	IDLocalitat INT NOT NULL,
    PRIMARY KEY (IDBotiga),
    FOREIGN KEY (IDLocalitat) REFERENCES Localitats(IDLocalitat)
);
CREATE TABLE Treballadors (
	IDTreballador INT NOT NULL AUTO_INCREMENT,
    IDBotiga INT NOT NULL,
    Nom VARCHAR(20) NOT NULL,
    Cognoms VARCHAR(60) NOT NULL,
    NIF VARCHAR(9) NOT NULL UNIQUE,
    Telefon INT NOT NULL,
    Carrec ENUM("cuiner", "repartidor") NOT NULL,
    PRIMARY KEY (IDTreballador),
    FOREIGN KEY (IDBotiga) REFERENCES Botigues(IDBotiga)
);
CREATE TABLE CategoriesPizza (
	IDCategoriaPizza INT NOT NULL AUTO_INCREMENT,
    Nom VARCHAR(30) NOT NULL UNIQUE,
    PRIMARY KEY (IDCategoriaPizza)
);
CREATE TABLE Categories (
	IDCategoria INT NOT NULL AUTO_INCREMENT,
    TipusProducte ENUM("pizza", "hamburguesa", "beguda") NOT NULL,
    IDCategoriaPizza INT,
    PRIMARY KEY (IDCategoria),
    FOREIGN KEY (IDCategoriaPizza) REFERENCES CategoriesPizza(IDCategoriaPizza)
);
CREATE TABLE Productes (
	IDProducte INT NOT NULL AUTO_INCREMENT,
    Nom VARCHAR(30) NOT NULL,
    Descripcio VARCHAR(100) NOT NULL,
    Imatge VARCHAR(100) NOT NULL,
    Preu FLOAT NOT NULL,
    IDCategoria INT NOT NULL,
    PRIMARY KEY (IDProducte),
    FOREIGN KEY (IDCategoria) REFERENCES Categories(IDCategoria)
);
CREATE TABLE Comandes (
	IDComanda INT NOT NULL AUTO_INCREMENT,
    IDClient INT NOT NULL,
	IDBotiga INT NOT NULL,
    DataHoraComanda DATETIME NOT NULL,
    TipusComanda ENUM("repartiment a domicili", "recollida en botiga") NOT NULL,
    PreuTotal FLOAT NOT NULL,
    IDTreballadorRepartiment INT,
    DataHoraLliurament DATETIME,
    PRIMARY KEY (IDComanda),
    FOREIGN KEY (IDClient) REFERENCES Clients(IDClient),
    FOREIGN KEY (IDBotiga) REFERENCES Botigues(IDBotiga),
    FOREIGN KEY (IDTreballadorRepartiment) REFERENCES Treballadors(IDTreballador)
);
CREATE TABLE ComandaProducte (
	IDComanda INT NOT NULL,
    IDProducte INT NOT NULL,
    QuantitatProducte INT NOT NULL,
    PRIMARY KEY (IDComanda, IDProducte),
    FOREIGN KEY (IDComanda) REFERENCES Comandes(IDComanda),
    FOREIGN KEY (IDProducte) REFERENCES Productes(IDProducte)
);

INSERT INTO Provincies (Nom) VALUES ("Barcelona"), ("Girona"), ("Tarragona"), ("Lleida");
INSERT INTO Localitats (Nom, IDProvincia) VALUES ("Barcelona",1), ("Mataro",1), ("Girona",2), ("Begur",2), ("Tarragona",3), ("Calafell",3), ("Lleida",4), ("Espot",4);
INSERT INTO Clients (Nom, Cognoms, Adreça, CodiPostal, IDLocalitat, Telefon) VALUES ("Oriol", "Riera Lizcano", "C/ Marina", 08013, 1, 658876215), ("Marti", "Perez Perez", "C/ Muntanya", 48520, 3, 620589944),
("Cristina", "Fina Filipina", "C/ Arago", 08010, 1, 674111122), ("Raquel", "Arre Vasc", "C/ Nord", 08027, 8, 677743333), ("Ferran", "De Terra", "C/ Gambes", 15200, 5, 601147755);
INSERT INTO Botigues (Adreça, CodiPostal, IDLocalitat) VALUES ("C/ Nidea", 08001, 1), ("C/ Aquisegur", 08015, 1), ("C/ Tantlluny", 42350, 6), ("C/ Amagat", 08023, 3);
INSERT INTO Treballadors (IDBotiga, Nom, Cognoms, NIF, Telefon, Carrec) VALUES (1, "Gerard", "Treballa Molt", "41531968D", 678852311, "cuiner"), (1, "Martina", "Treballa Poc", "99781968E", 632225477, "repartidor"),
(2, "Alex", "Dorm Massa", "42100000F", 600011117, "repartidor"), (3, "Georgina", "Menja Poc", "10253122P", 677788855, "cuiner"), (4, "David", "Vora Mar", "12345678A", 608859944, "repartidor");
INSERT INTO CategoriesPizza (Nom) VALUES ("Supreme"), ("Especial"), ("Nadalenca"), ("Gourmet");
INSERT INTO Categories (TipusProducte) VALUES ("hamburguesa"), ("beguda");
INSERT INTO Categories (TipusProducte, IDCategoriaPizza) VALUES ("pizza", 1), ("pizza", 2), ("pizza", 3), ("pizza", 4);
INSERT INTO Productes (Nom, Descripcio, Imatge, Preu, IDCategoria) VALUES ("Vedella", "", "", 10, 1), ("Pollastre", "", "", 8, 1), ("Alberginia", "", "", 9, 1), ("Aigua", "", "", 2, 2), ("CocaCola", "", "", 3, 2),
("Cervesa", "", "", 4, 2), ("Margarita", "", "", 9, 3), ("Carbonara", "", "", 12, 3), ("Crispy Bacon", "", "", 12, 4), ("SuperPizza", "", "", 18, 5), ("7 Formatges", "", "", 15, 6);
INSERT INTO Comandes (IDClient, IDBotiga, DataHoraComanda, TipusComanda, PreuTotal) VALUES (1, 2, '2024-01-16 19:44:32', "recollida en botiga", 72), (2, 3, '2024-01-16 19:53:05', "recollida en botiga", 29);
INSERT INTO Comandes (IDClient, IDBotiga, DataHoraComanda, TipusComanda, PreuTotal, IDTreballadorRepartiment, DataHoraLliurament) VALUES (3, 1, '2024-01-15 14:03:22', "repartiment a domicili", 96, 2, '2024-01-15 14:47:34');
INSERT INTO ComandaProducte (IDComanda, IDProducte, QuantitatProducte) VALUES (1, 2, 1), (1, 4, 2), (1, 6, 6), (1, 8, 3), (2, 1, 1), (2, 5, 5), (2, 6, 1), (3, 6, 24);

/*Quantes begudes s'han venut a la Localitat de Barcelona i de quin tipus*/
SELECT Productes.Nom AS Begudes, SUM(QuantitatProducte) AS QuantitatVenuda FROM Productes 
	JOIN ComandaProducte ON Productes.IDProducte = ComandaProducte.IDProducte
    JOIN Comandes ON ComandaProducte.IDComanda = Comandes.IDComanda
    JOIN Clients ON Comandes.IDClient = Clients.IDClient
    WHERE IDCategoria = 2 AND IDLocalitat = 1
    GROUP BY Productes.Nom ORDER BY Productes.Nom;
    
/*Quantes comandes ha efectuat cada empleat*/
SELECT Treballadors.Nom AS Empleat, COUNT(IDTreballador) AS ComandesEfectuades FROM Treballadors
	JOIN Comandes ON Treballadors.IDBotiga = Comandes.IDBotiga
    GROUP BY Nom ORDER BY Nom;

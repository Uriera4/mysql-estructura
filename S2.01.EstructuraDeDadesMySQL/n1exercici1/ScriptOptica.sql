DROP DATABASE IF EXISTS Optica;
CREATE DATABASE Optica;
USE Optica;
CREATE TABLE adreces (
	IDAdreça INT NOT NULL AUTO_INCREMENT,
    Carrer VARCHAR(30) NOT NULL,
    Numero INT NOT NULL,
    Pis VARCHAR(5),
    Porta INT,
    Ciutat VARCHAR(30) NOT NULL,
    CodiPostal INT NOT NULL,
    Pais VARCHAR(30) NOT NULL,
	PRIMARY KEY (IDAdreça)
);   
CREATE TABLE proveidors (
	IDProveidor INT NOT NULL AUTO_INCREMENT,
	Nom VARCHAR(60) NOT NULL,
    IDAdreça INT NOT NULL,
    Telefon INT NOT NULL,
    Fax INT NOT NULL,
    NIF VARCHAR(9) NOT NULL,
	PRIMARY KEY (IDProveidor),
    FOREIGN KEY (IDAdreça) REFERENCES adreces(IDAdreça)
   );
CREATE TABLE clients (
	IDClient INT NOT NULL AUTO_INCREMENT,
    Nom VARCHAR(60) NOT NULL,
    IDAdreça INT NOT NULL,
    Telefon INT NOT NULL,
    CorreuElectronic VARCHAR(60) NOT NULL,
    DataRegistre DATE NOT NULL,
    RecomenatPer VARCHAR(60),
    PRIMARY KEY (IDClient),
    FOREIGN KEY (IDAdreça) REFERENCES adreces(IDAdreça)
);
CREATE TABLE ulleres (
	IDUlleres INT NOT NULL AUTO_INCREMENT,
    Marca VARCHAR(20) NOT NULL,
    TipusMontura ENUM("flotant", "pasta", "metalica") NOT NULL,
    ColorMontura VARCHAR(15) NOT NULL,
    ColorVidreEsquerra VARCHAR(15) NOT NULL,
    ColorVidreDreta VARCHAR(15) NOT NULL,
    Preu FLOAT NOT NULL,
	IDProveidor INT NOT NULL,
    PRIMARY KEY (IDUlleres),
    FOREIGN KEY (IDProveidor) REFERENCES proveidors(IDProveidor)
);
CREATE TABLE ventes (
	IDVenta INT NOT NULL AUTO_INCREMENT,
    IDUlleres INT NOT NULL,
	GraduacioEsquerra FLOAT NOT NULL,
    GraduacioDreta FLOAT NOT NULL,
	DataVenta DATE NOT NULL,
    Venedor VARCHAR(60) NOT NULL,
	IDClient INT NOT NULL,
    PRIMARY KEY (IDVenta),
    FOREIGN KEY (IDUlleres) REFERENCES ulleres(IDUlleres),
	FOREIGN KEY (IDClient) REFERENCES clients(IDClient)
);
/* iniciem adreces */
INSERT INTO adreces (Carrer, Numero, Ciutat, CodiPostal, Pais) VALUES ("C/ de Goya", 44, "Salamanca", 28001, "España");
INSERT INTO adreces (Carrer, Numero, Ciutat, CodiPostal, Pais) VALUES ("C/ Angel Guimera", 46, "Palma de Mallorca", 07004, "España");
INSERT INTO adreces (Carrer, Numero, Ciutat, CodiPostal, Pais) VALUES ("C/ Pallars", 73, "Barcelona", 08018, "España");
INSERT INTO adreces (Carrer, Numero, Ciutat, CodiPostal, Pais) VALUES ("C/ del Disfrute", 777, "CiudadIncreible", 44444, "España");
INSERT INTO adreces (Carrer, Numero, Pis, Porta, Ciutat, CodiPostal, Pais) VALUES ("C/ Marina", 200, 2, 1, "Barcelona", 08013, "España");
INSERT INTO adreces (Carrer, Numero, Pis, Porta, Ciutat, CodiPostal, Pais) VALUES ("C/ Progreso", 32, 1, 1, "Valencia", 12547, "España");
INSERT INTO adreces (Carrer, Numero, Pis, Porta, Ciutat, CodiPostal, Pais) VALUES ("C/ Esparrago", 101, 7, 3, "Bilbao", 44201, "España");
INSERT INTO adreces (Carrer, Numero, Pis, Porta, Ciutat, CodiPostal, Pais) VALUES ("C/ Sense Nom", 1, "baix", 2, "Zarautz", 33331, "España");
INSERT INTO adreces (Carrer, Numero, Pis, Porta, Ciutat, CodiPostal, Pais) VALUES ("C/ Amb Nom", 999, 4, 2, "Salamanca", 14200, "España");
/* iniciem proveidors */
INSERT INTO proveidors (Nom, IDAdreça, Telefon, Fax, NIF) VALUES ("MULTIOPTICAS", 1, 915753430, 915753430, "F28465193");
INSERT INTO proveidors (Nom, IDAdreça, Telefon, Fax, NIF) VALUES ("GENERAL OPTICA", 2, 971582799, 971582580, "B07887250");
INSERT INTO proveidors (Nom, IDAdreça, Telefon, Fax, NIF) VALUES ("PROSUN", 3, 934392051, 934392051, "A08829483");
INSERT INTO proveidors (Nom, IDAdreça, Telefon, Fax, NIF) VALUES ("MI OPTICA PREFERIDA", 4, 999777666, 999111000, "O12345678");
/* iniciem clients */
INSERT INTO clients (Nom, IDAdreça, Telefon, CorreuElectronic, DataRegistre, RecomenatPer) VALUES ("Oriol", 5, 648849287, "oriolriera@hotmail.com", '2007-01-15', NULL);
INSERT INTO clients (Nom, IDAdreça, Telefon, CorreuElectronic, DataRegistre, RecomenatPer) VALUES ("Maria", 6, 653328751, "mariasoyyo@hotmail.com", '2020-05-23', "Oriol");
INSERT INTO clients (Nom, IDAdreça, Telefon, CorreuElectronic, DataRegistre, RecomenatPer) VALUES ("Arnau", 7, 674420311, "eselcorreoreal@hotmail.com", '2007-07-07', "Oriol");
INSERT INTO clients (Nom, IDAdreça, Telefon, CorreuElectronic, DataRegistre, RecomenatPer) VALUES ("Elvira", 8, 698765432, "elviratimo@hotmail.com", '2023-02-01', NULL);
INSERT INTO clients (Nom, IDAdreça, Telefon, CorreuElectronic, DataRegistre, RecomenatPer) VALUES ("Didac", 9, 666111222, "didactic@hotmail.com", '2024-01-10', "Maria");
/* iniciem ulleres */
INSERT INTO ulleres (Marca, TipusMontura, ColorMontura, ColorVidreEsquerra, ColorVidreDreta, Preu, IDProveidor) VALUES ("Ray-Ban", "metalica", "negra", "translucid", "translucid", 110, 1);
INSERT INTO ulleres (Marca, TipusMontura, ColorMontura, ColorVidreEsquerra, ColorVidreDreta, Preu, IDProveidor) VALUES ("Ray-Ban", "pasta", "vermella", "verd", "verd", 85, 1);
INSERT INTO ulleres (Marca, TipusMontura, ColorMontura, ColorVidreEsquerra, ColorVidreDreta, Preu, IDProveidor) VALUES ("Ray-Ban", "flotant", "blanca", "translucid", "translucid", 100, 1);
INSERT INTO ulleres (Marca, TipusMontura, ColorMontura, ColorVidreEsquerra, ColorVidreDreta, Preu, IDProveidor) VALUES ("Polaroid", "flotant", "blanca", "translucid", "translucid", 65, 2);
INSERT INTO ulleres (Marca, TipusMontura, ColorMontura, ColorVidreEsquerra, ColorVidreDreta, Preu, IDProveidor) VALUES ("Polaroid", "metalica", "taronja", "translucid", "translucid", 95, 2);
INSERT INTO ulleres (Marca, TipusMontura, ColorMontura, ColorVidreEsquerra, ColorVidreDreta, Preu, IDProveidor) VALUES ("Emporio Armani", "metalica", "negra", "translucid", "translucid", 150, 3);
INSERT INTO ulleres (Marca, TipusMontura, ColorMontura, ColorVidreEsquerra, ColorVidreDreta, Preu, IDProveidor) VALUES ("Emporio Armani", "metalica", "negra", "verd", "verd", 180, 3);
INSERT INTO ulleres (Marca, TipusMontura, ColorMontura, ColorVidreEsquerra, ColorVidreDreta, Preu, IDProveidor) VALUES ("Emporio Armani", "pasta", "blau", "negre", "negre", 135, 3);
INSERT INTO ulleres (Marca, TipusMontura, ColorMontura, ColorVidreEsquerra, ColorVidreDreta, Preu, IDProveidor) VALUES ("Lacoste", "metalica", "verd", "negre", "negre", 230, 2);
INSERT INTO ulleres (Marca, TipusMontura, ColorMontura, ColorVidreEsquerra, ColorVidreDreta, Preu, IDProveidor) VALUES ("Lacoste", "flotant", "blanc", "translucid", "translucid", 190, 2);
INSERT INTO ulleres (Marca, TipusMontura, ColorMontura, ColorVidreEsquerra, ColorVidreDreta, Preu, IDProveidor) VALUES ("Les millors ulleres", "metalica", "negre", "translucid", "translucid", 348, 4);
INSERT INTO ulleres (Marca, TipusMontura, ColorMontura, ColorVidreEsquerra, ColorVidreDreta, Preu, IDProveidor) VALUES ("Les millors ulleres", "pasta", "turquesa", "translucid", "translucid", 303, 4);
INSERT INTO ulleres (Marca, TipusMontura, ColorMontura, ColorVidreEsquerra, ColorVidreDreta, Preu, IDProveidor) VALUES ("Les millors ulleres", "flotant", "rosa", "translucid", "translucid", 214, 4);
/* iniciem ventas */
INSERT INTO ventes (IDUlleres, GraduacioEsquerra, GraduacioDreta, DataVenta, Venedor, IDClient) VALUES (11, 0, 0.5, '2007-01-15', "Ramon", 1);
INSERT INTO ventes (IDUlleres, GraduacioEsquerra, GraduacioDreta, DataVenta, Venedor, IDClient) VALUES (8, 3.5, 3.5, '2020-05-23', "Erica", 2);
INSERT INTO ventes (IDUlleres, GraduacioEsquerra, GraduacioDreta, DataVenta, Venedor, IDClient) VALUES (7, 3.5, 4.5, '2020-05-24', "Erica", 2);
INSERT INTO ventes (IDUlleres, GraduacioEsquerra, GraduacioDreta, DataVenta, Venedor, IDClient) VALUES (1, 1, 2.5, '2007-07-07', "Ramon", 3);
INSERT INTO ventes (IDUlleres, GraduacioEsquerra, GraduacioDreta, DataVenta, Venedor, IDClient) VALUES (7, 4, 4.25, '2023-02-01', "Erica", 4);
INSERT INTO ventes (IDUlleres, GraduacioEsquerra, GraduacioDreta, DataVenta, Venedor, IDClient) VALUES (5, 1.25, 1.25, '2024-01-10', "Ramon", 5);
INSERT INTO ventes (IDUlleres, GraduacioEsquerra, GraduacioDreta, DataVenta, Venedor, IDClient) VALUES (9, 3, 3.5, '2015-10-25', "Erica", 1);
INSERT INTO ventes (IDUlleres, GraduacioEsquerra, GraduacioDreta, DataVenta, Venedor, IDClient) VALUES (3, 4, 5.5, '2013-07-07', "Erica", 3);
INSERT INTO ventes (IDUlleres, GraduacioEsquerra, GraduacioDreta, DataVenta, Venedor, IDClient) VALUES (12, 4.5, 5, '2023-12-30', "Ramon", 4);
INSERT INTO ventes (IDUlleres, GraduacioEsquerra, GraduacioDreta, DataVenta, Venedor, IDClient) VALUES (2, 4, 4, '2020-05-10', "Erica", 1);
INSERT INTO ventes (IDUlleres, GraduacioEsquerra, GraduacioDreta, DataVenta, Venedor, IDClient) VALUES (4, 4, 4.5, '2023-06-02', "Erica", 2);
INSERT INTO ventes (IDUlleres, GraduacioEsquerra, GraduacioDreta, DataVenta, Venedor, IDClient) VALUES (7, 5, 6, '2018-07-10', "Ramon", 3);
INSERT INTO ventes (IDUlleres, GraduacioEsquerra, GraduacioDreta, DataVenta, Venedor, IDClient) VALUES (10, 5.5, 6, '2020-08-13', "Ramon", 3);
INSERT INTO ventes (IDUlleres, GraduacioEsquerra, GraduacioDreta, DataVenta, Venedor, IDClient) VALUES (13, 7, 7, '2023-02-26', "Ramon", 3);
INSERT INTO ventes (IDUlleres, GraduacioEsquerra, GraduacioDreta, DataVenta, Venedor, IDClient) VALUES (12, 4.5, 5, '2023-06-20', "Erica", 1);

/*Total factures dels clients del 2020 al 2024 */
SELECT Nom AS Client, COUNT(Nom) AS TotalFactures2020_2024 FROM clients 
	JOIN ventes ON ventes.IDClient = clients.IDClient 
    WHERE DataVenta BETWEEN '2020-01-01' AND '2023-12-31'
    GROUP BY Nom ORDER BY Nom;
    
/*Models d'ulleres venuts per els empleats durant el 2023 */
SELECT Marca AS Model, COUNT(Marca) AS QuantitatVenuda2023, Venedor FROM ulleres 
	JOIN ventes ON ventes.IDUlleres = ulleres.IDUlleres
	WHERE DataVenta BETWEEN '2023-01-01' AND '2023-12-31'
	GROUP BY Marca, Venedor ORDER BY Marca;
    
/*Proveïdors que han subministrat ulleres venudes amb èxit per l'òptica*/
SELECT Nom AS Proveidor, COUNT(Nom) AS QuantitatVenuda FROM proveidors
	JOIN ulleres ON ulleres.IDProveidor = proveidors.IDProveidor
    JOIN ventes ON ulleres.IDUlleres = ventes.IDUlleres
    GROUP BY Nom ORDER BY Nom;
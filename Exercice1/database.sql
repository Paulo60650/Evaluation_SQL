DROP DATABASE IF EXISTS exercice1 ;
-- Si la base de donnée exercice1 existe elle est supprimée
CREATE DATABASE exercice1;
-- Création de la base de donnée exercice1
USE exercice1;
-- Les commandes suivantes seront insérées dans la base ecercice1
-- On déclare les tables avec uniquement des clés primaires avant cellescontenant des clés étrangères
CREATE TABLE produit (
-- Création d'une table. Utilisation de int car nous voulons des nombres et de 
-- VARCHAR car nous voulons une string, le (50) est donner une limite de 50 caractères
	pro_num		INT,
	pro_lib		VARCHAR(50),
	pro_desc	VARCHAR(50),
	PRIMARY KEY (pro_num));
-- Déclarartion de la clé primaire du tableau
CREATE TABLE client (
-- Création d'une table 
	cli_num		INT AUTO_INCREMENT, 
	cli_nom		VARCHAR(50),
	cli_adres	VARCHAR(50), 
	cli_tel		VARCHAR(30),
	PRIMARY KEY (cli_num));
-- Déclarartion de la clé primaire du tableau
CREATE TABLE commande (
-- Création d'une table 
	com_num			INT AUTO_INCREMENT, 
	com_cli_num		INT,
	com_date		DATETIME,
	com_obs			VARCHAR(50),
	PRIMARY KEY (com_num),
    -- Déclarartion de la clé primaire du tableau
	FOREIGN KEY (com_cli_num) REFERENCES client(cli_num)
    -- Déclarartion d'une clé étrangère lié à la table client(via la clé primaire cli_num)
	);

CREATE TABLE vente (
	vnt_com_num		INT, 
	vnt_pro_num		INT, 
	vnt_est_qte		INT, 
	PRIMARY KEY (vnt_com_num, vnt_pro_num),
      -- Déclarartion d'une clé primaire 
	FOREIGN KEY (vnt_com_num) REFERENCES commande(com_num),
     -- Déclarartion d'une clé étrangère lié à la table commande(via la clé primaire com_num)
	FOREIGN KEY (vnt_pro_num) REFERENCES produit(pro_num)
     -- Déclarartion d'une clé étrangère lié à la table produit(via la clé primaire pro_num)
	);
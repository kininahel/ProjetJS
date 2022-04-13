-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 08 mars 2022 à 19:02
-- Version du serveur : 5.7.36
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `filelec`
--

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `clientsInsertErreur`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `clientsInsertErreur` (IN `nom` VARCHAR(50), IN `tel` VARCHAR(10), IN `email` VARCHAR(50), IN `mdp` VARCHAR(50), IN `adresse` VARCHAR(100), IN `cp` VARCHAR(5), IN `ville` VARCHAR(100), IN `pays` VARCHAR(50), IN `etat` ENUM("Prospect","Client Courant","Client Grand Courant"), IN `role` ENUM("Client","Admin"))  Begin
    declare codeErreur int;
    declare continue handler for sqlexception set codeErreur = 1;
    set codeErreur = 0;
    insert into clients (nom, tel, email, mdp, adresse, cp, ville, pays, etat, role) values (nom, tel, email, mdp, adresse, cp, ville, pays, etat, role);
    if codeErreur = 0
        then
            insert into erreurs (texte, heure) values ('Insertion Client OK', NOW());
    end if ;
    if codeErreur = 1
        then
            insert into erreurs (texte, heure) values ('Insertion Client KO - Erreurs lors de l\'insertion', NOW());
    end if ;
End$$

DROP PROCEDURE IF EXISTS `countFromTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `countFromTable` (IN `nomTable` VARCHAR(50), OUT `nb` INTEGER)  Begin
    declare cmd varchar(255);
    set @requete = concat('SELECT count(*) into @resultat FROM ', nomTable);
    prepare cmd from @requete;
    execute cmd;
    deallocate prepare cmd;
    set nb = @resultat;
End$$

DROP PROCEDURE IF EXISTS `deleteFromTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteFromTable` (IN `nomTable` VARCHAR(50), IN `nomColonne` VARCHAR(100), IN `nomValeur` VARCHAR(50))  Begin
    declare cmd varchar(255);
    set @requete = concat('DELETE FROM ', nomTable, ' WHERE ', nomColonne, '=\'', nomValeur, '\'');
    prepare cmd from @requete;
    execute cmd;
    deallocate prepare cmd;
End$$

DROP PROCEDURE IF EXISTS `delete_client`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_client` (`idc` INT)  Begin
    delete from clients where idClient = idc;
End$$

DROP PROCEDURE IF EXISTS `delete_part`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_part` (`idp` INT)  Begin
    delete from particulier where idClient = idp;
End$$

DROP PROCEDURE IF EXISTS `delete_pro`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_pro` (`idpro` INT)  Begin
    delete from professionnel where idClient = idpro;
End$$

DROP PROCEDURE IF EXISTS `insertOnTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertOnTable` (IN `nomTable` VARCHAR(50), IN `nomColonnes` VARCHAR(100), IN `nomValeurs` VARCHAR(255))  Begin
    declare cmd varchar(255);
    set @requete  = 
    concat('INSERT INTO ', nomTable, '(', nomColonnes, ') VALUES ( ', nomValeurs,' )');
    prepare cmd from @requete;
    execute cmd;
    deallocate prepare cmd;
End$$

DROP PROCEDURE IF EXISTS `insert_client`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_client` (IN `idc` INT, IN `nomc` VARCHAR(50), IN `telc` VARCHAR(10), IN `emailc` VARCHAR(50), IN `mdpc` VARCHAR(50), IN `adressec` VARCHAR(100), IN `cpc` VARCHAR(5), IN `villec` VARCHAR(50), IN `paysc` VARCHAR(50), IN `etatc` ENUM("Prospect","Client Courant","Client Grand Courant"), IN `rolec` ENUM("Client","Admin"))  Begin
    insert into clients (idClient, nom, tel, email, mdp, adresse, cp, ville, pays, etat, role) values (idc, nomc, telc, emailc, mdpc, adressec, cpc, villec, paysc, etatc, rolec);
End$$

DROP PROCEDURE IF EXISTS `insert_part`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_part` (IN `idp` INT, IN `nomp` VARCHAR(50), IN `prenomp` VARCHAR(50), IN `telp` VARCHAR(10), IN `emailp` VARCHAR(50), IN `mdpp` VARCHAR(50), IN `adressep` VARCHAR(100), IN `cpp` VARCHAR(5), IN `villep` VARCHAR(50), IN `paysp` VARCHAR(50), IN `etatp` ENUM("Prospect","Client Courant","Client Grand Courant"), IN `rolep` ENUM("Client","Admin"))  Begin
    insert into particulier (idClient, nom, prenom, tel, email, mdp, adresse, cp, ville, pays, etat, droit) values (idp, nomp, prenomp, telp, emailp, mdpp, adressep, cpp, villep, paysp, etatp, rolep);
End$$

DROP PROCEDURE IF EXISTS `insert_pro`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_pro` (IN `idpro` INT, IN `nompro` VARCHAR(50), IN `telpro` VARCHAR(10), IN `emailpro` VARCHAR(50), IN `mdppro` VARCHAR(50), IN `adressepro` VARCHAR(100), IN `cppro` VARCHAR(5), IN `villepro` VARCHAR(50), IN `payspro` VARCHAR(50), IN `numSpro` VARCHAR(50), IN `statutpro` VARCHAR(50), IN `etatpro` ENUM("Prospect","Client Courant","Client Grand Courant"), IN `rolepro` ENUM("Client","Admin"))  Begin
    insert into professionnel (idClient, nom, tel, email, mdp, adresse, cp, ville, pays, numSIRET, statut, etat, role) values (idpro, nompro, telpro, emailpro, mdppro, adressepro, cppro, villepro, payspro, numSpro, statutpro, etatpro, rolepro);
End$$

DROP PROCEDURE IF EXISTS `selectFromTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectFromTable` (IN `nomTable` VARCHAR(50))  Begin
    declare cmd varchar(255);
    set @requete = concat('SELECT * FROM ', nomTable, ' \G ');
    prepare cmd from @requete;
    execute cmd;
    deallocate prepare cmd;
End$$

DROP PROCEDURE IF EXISTS `selectFromTableOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectFromTableOptions` (IN `nomTable` VARCHAR(50), IN `nomColonne` VARCHAR(200), IN `nomColonneWhere` VARCHAR(100), IN `nomValeur` VARCHAR(100))  Begin
    declare cmd varchar(255);
    if nomColonneWhere = ''
        then
            set @requete = concat('SELECT ', nomColonne, ' FROM ', nomTable);
    else
        set @requete = concat('SELECT ', nomColonne, ' FROM ', nomTable, ' WHERE ', nomColonneWhere, '=\'', nomValeur, '\'');
    end if ;
    prepare cmd from @requete;
    execute cmd;
    deallocate prepare cmd;
End$$

DROP PROCEDURE IF EXISTS `selectWhereFromTableInt`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectWhereFromTableInt` (IN `nomTable` VARCHAR(50), IN `nomColonne` VARCHAR(50), IN `nomValeur` VARCHAR(100))  Begin
    declare cmd varchar(255);
    set @requete = concat('SELECT * FROM ', nomTable, ' WHERE ', nomColonne, ' = ', nomValeur);
    prepare cmd from @requete;
    execute cmd;
    deallocate prepare cmd;
End$$

DROP PROCEDURE IF EXISTS `selectWhereFromTableString`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectWhereFromTableString` (IN `nomTable` VARCHAR(50), IN `nomColonne` VARCHAR(50), IN `nomValeur` VARCHAR(100))  Begin
    declare cmd varchar(255);
    set @requete = concat('SELECT * FROM ', nomTable, ' WHERE ', nomColonne, '=\'' , nomValeur, '\'');
    prepare cmd from @requete;
    execute cmd;
    deallocate prepare cmd;
End$$

DROP PROCEDURE IF EXISTS `statschema`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `statschema` (`nomBdd` VARCHAR(60))  Begin
    declare nbview, nbtrigger, nbprocedure, nbfunction int;

    select count(*) into nbview 
    from information_schema.views
    where TABLE_SCHEMA = nomBdd;

    select count(*) into nbtrigger
    from information_schema.triggers
    where TRIGGER_SCHEMA = nomBdd;

    select count(*) into nbprocedure
    from information_schema.ROUTINES
    where ROUTINE_SCHEMA = nomBdd
    and ROUTINE_TYPE = 'procedure';

    select count(*) into nbfunction
    from information_schema.ROUTINES
    where ROUTINE_SCHEMA = nomBdd
    and ROUTINE_TYPE = 'function';

    insert into BDD values (nomBdd, nbview, nbtrigger, nbprocedure, nbfunction);

    select * from BDD;
End$$

DROP PROCEDURE IF EXISTS `typesInsertErreur`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `typesInsertErreur` (IN `libelle` VARCHAR(50))  Begin
    declare codeErreur int;
    declare continue handler for sqlexception set codeErreur = 1;
    set codeErreur = 0;
    insert into types (libelle) values (libelle);
    if codeErreur = 0
        then
            insert into erreurs (texte, heure) values ('Insertion Type OK', NOW());
    end if ;
    if codeErreur = 1
        then
            insert into erreurs (texte, heure) values ('Insertion Type KO - Problème de Libellé', NOW());
    end if ;
End$$

DROP PROCEDURE IF EXISTS `update_client`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_client` (`idc` INT, `nomc` VARCHAR(50), `telc` VARCHAR(10), `emailc` VARCHAR(50), `mdpc` VARCHAR(50), `adressec` VARCHAR(100), `cpc` VARCHAR(5), `villec` VARCHAR(50), `paysc` VARCHAR(50), `etatc` ENUM("Prospect","Client Courant","Client Grand Courant"), `rolec` ENUM("Client","Admin"))  Begin
    update clients
    set nom = nomc, tel = telc, email = emailc, mdp = mdpv, adresse = adressec, cp = cpc, ville = villec, pays = paysc, etat = etatc, role = droitc
    where idClient = idc;
End$$

DROP PROCEDURE IF EXISTS `update_part`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_part` (`idp` INT, `nomp` VARCHAR(50), `prenomp` VARCHAR(50), `telp` VARCHAR(10), `emailp` VARCHAR(50), `mdpp` VARCHAR(50), `adressep` VARCHAR(100), `cpp` VARCHAR(5), `villep` VARCHAR(50), `paysp` VARCHAR(50), `etatp` ENUM("Prospect","Client Courant","Client Grand Courant"), `rolep` ENUM("Client","Admin"))  Begin
    update particulier
    set nom = nomp, prenom = prenomp, tel = telp, email = emailp, mdp = mdpp, adresse = adressep, cp = cpp, ville = villep, pays = paysp, etat = etatp, role = rolep
    where idClient = idp;
End$$

DROP PROCEDURE IF EXISTS `update_pro`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_pro` (`idpro` INT, `nompro` VARCHAR(50), `telpro` VARCHAR(10), `emailpro` VARCHAR(50), `mdppro` VARCHAR(50), `adressepro` VARCHAR(100), `cppro` VARCHAR(5), `villepro` VARCHAR(50), `payspro` VARCHAR(50), `numSpro` VARCHAR(50), `statutpro` VARCHAR(50), `typepro` ENUM("Particulier","Professionnel"), `etatpro` ENUM("Prospect","Client Courant","Client Grand Courant"), `rolepro` ENUM("Client","Admin"))  Begin
    update clients
    set nom = nompro, tel = telpro, email = emailpro, mdp = mdppro, adresse = adressepro, cp = cppro, ville = villepro, pays = payspro, etat = etatpro, role = rolepro
    where idClient = idpro;
End$$

--
-- Fonctions
--
DROP FUNCTION IF EXISTS `email_existe`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `email_existe` (`newemail` VARCHAR(50)) RETURNS INT(11) Begin
    select count(*) from clients where email = newemail into @result;
    return @result;
End$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `idadmin` int(11) NOT NULL AUTO_INCREMENT,
  `mail` varchar(50) DEFAULT NULL,
  `mdp` varchar(100) DEFAULT NULL,
  `droit` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idadmin`),
  UNIQUE KEY `mail` (`mail`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `admin`
--

INSERT INTO `admin` (`idadmin`, `mail`, `mdp`, `droit`) VALUES
(1, 'admin@gmail.com', '107d348bff437c999a9ff192adcb78cb03b8ddc6', 1);

-- --------------------------------------------------------

--
-- Structure de la table `bdd`
--

DROP TABLE IF EXISTS `bdd`;
CREATE TABLE IF NOT EXISTS `bdd` (
  `nom_bdd` varchar(60) NOT NULL,
  `nb_views` int(11) DEFAULT NULL,
  `nb_triggers` int(11) DEFAULT NULL,
  `nb_procedures` int(11) DEFAULT NULL,
  `nb_functions` int(11) DEFAULT NULL,
  PRIMARY KEY (`nom_bdd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `bdd`
--

INSERT INTO `bdd` (`nom_bdd`, `nb_views`, `nb_triggers`, `nb_procedures`, `nb_functions`) VALUES
('filelec', 14, 40, 19, 1);

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `idClient` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) DEFAULT NULL,
  `tel` varchar(10) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `mdp` varchar(50) DEFAULT NULL,
  `adresse` varchar(100) DEFAULT NULL,
  `cp` varchar(5) DEFAULT NULL,
  `ville` varchar(100) DEFAULT NULL,
  `pays` varchar(50) DEFAULT NULL,
  `etat` enum('Prospect','Client Courant','Client Grand Courant') DEFAULT NULL,
  `role` enum('Client','Admin') DEFAULT NULL,
  PRIMARY KEY (`idClient`),
  UNIQUE KEY `tel` (`tel`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `clients`
--

INSERT INTO `clients` (`idClient`, `nom`, `tel`, `email`, `mdp`, `adresse`, `cp`, `ville`, `pays`, `etat`, `role`) VALUES
(1, 'BRUAIRE', '0000000000', 'tombruaire@gmail.com', '107d348bff437c999a9ff192adcb78cb03b8ddc6', '5 rue de TEST', '92300', 'Levallois', 'France', 'Client Grand Courant', 'Admin'),
(2, 'PART1', '0000000001', 'tom1.particulier@gmail.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '5 rue des Particulier', '92300', 'Levallois', 'France', 'Client Grand Courant', 'Admin'),
(3, 'PART2', '0000000002', 'tom2.particulier@gmail.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '5 rue des Particulier', '92300', 'Levallois', 'France', 'Client Grand Courant', 'Admin'),
(4, 'PRO2', '0000000005', 'tom5.professionnel@gmail.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '5 rue des Professionnel', '95300', 'Levallois', 'France', 'Prospect', 'Admin'),
(5, 'PRO3', '0000000006', 'tom6.professionnel@gmail.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '5 rue des Professionnel', '95300', 'Levallois', 'France', 'Prospect', 'Admin');

--
-- Déclencheurs `clients`
--
DROP TRIGGER IF EXISTS `countClientsDelete`;
DELIMITER $$
CREATE TRIGGER `countClientsDelete` AFTER DELETE ON `clients` FOR EACH ROW Begin
    update compteur
    set nombre = nombre - 1
    where idcompteur = 1;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `countClientsInsert`;
DELIMITER $$
CREATE TRIGGER `countClientsInsert` AFTER INSERT ON `clients` FOR EACH ROW Begin
    update compteur
    set nombre = nombre + 1
    where idcompteur = 1;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `deleteClient`;
DELIMITER $$
CREATE TRIGGER `deleteClient` BEFORE DELETE ON `clients` FOR EACH ROW Begin
Insert into histoClients select *, sysdate(), user(), 'DELETE'
From clients
Where idClient = old.idClient;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `insertClient`;
DELIMITER $$
CREATE TRIGGER `insertClient` AFTER INSERT ON `clients` FOR EACH ROW Begin
Insert into histoClients select *, sysdate(), user(), 'INSERT'
From clients
Where idClient = new.idClient;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `updateClient`;
DELIMITER $$
CREATE TRIGGER `updateClient` BEFORE UPDATE ON `clients` FOR EACH ROW Begin
Insert into histoClients select *, sysdate(), user(), 'UPDATE'
From clients
Where idClient = old.idClient;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `valide_insertion`;
DELIMITER $$
CREATE TRIGGER `valide_insertion` BEFORE INSERT ON `clients` FOR EACH ROW Begin
    if email_existe(new.email)
        then signal sqlstate '45000'
        set message_text = 'Impossible !';
    end if ;
End
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `commandes`
--

DROP TABLE IF EXISTS `commandes`;
CREATE TABLE IF NOT EXISTS `commandes` (
  `numCommande` int(8) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `cp` varchar(5) NOT NULL,
  `ville` varchar(100) NOT NULL,
  `pays` varchar(50) NOT NULL,
  `mode_payement` varchar(50) NOT NULL,
  `etatCommande` varchar(100) NOT NULL,
  `montantTotalHT` decimal(12,2) DEFAULT NULL,
  `montantTotalTTC` decimal(12,2) DEFAULT NULL,
  `TVA` decimal(10,2) DEFAULT NULL,
  `dateCommande` date DEFAULT NULL,
  `dateLivraison` date DEFAULT NULL,
  `idClient` int(11) NOT NULL,
  PRIMARY KEY (`numCommande`),
  KEY `idClient` (`idClient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déclencheurs `commandes`
--
DROP TRIGGER IF EXISTS `countCommandesDelete`;
DELIMITER $$
CREATE TRIGGER `countCommandesDelete` AFTER DELETE ON `commandes` FOR EACH ROW Begin
    update compteur
    set nombre = nombre - 1
    where idcompteur = 6;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `countCommandesInsert`;
DELIMITER $$
CREATE TRIGGER `countCommandesInsert` AFTER INSERT ON `commandes` FOR EACH ROW Begin
    update compteur
    set nombre = nombre + 1
    where idcompteur = 6;
End
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `commentaires`
--

DROP TABLE IF EXISTS `commentaires`;
CREATE TABLE IF NOT EXISTS `commentaires` (
  `idCom` int(11) NOT NULL AUTO_INCREMENT,
  `idProduit` int(11) NOT NULL,
  `idClient` int(11) NOT NULL,
  `contenu` varchar(255) NOT NULL,
  `client_id` int(11) NOT NULL,
  `dateHeurePost` datetime NOT NULL,
  PRIMARY KEY (`idCom`),
  KEY `idProduit` (`idProduit`),
  KEY `idClient` (`idClient`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `commentaires`
--

INSERT INTO `commentaires` (`idCom`, `idProduit`, `idClient`, `contenu`, `client_id`, `dateHeurePost`) VALUES
(1, 1, 1, 'Commentaire produit TOKAI LAR-15B', 1, '2022-03-08 20:01:36'),
(2, 2, 1, 'Commentaire produit PIONEER MVH-S110UB', 1, '2022-03-08 20:01:36'),
(3, 3, 1, 'Commentaire produit SONY WX-920BT', 1, '2022-03-08 20:01:36'),
(4, 4, 1, 'Commentaire produit JVC KW-V420BT', 1, '2022-03-08 20:01:36'),
(5, 1, 2, 'Commentaire produit TOKAI LAR-15B 2', 2, '2022-03-08 20:01:36');

-- --------------------------------------------------------

--
-- Structure de la table `compteur`
--

DROP TABLE IF EXISTS `compteur`;
CREATE TABLE IF NOT EXISTS `compteur` (
  `idcompteur` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) DEFAULT NULL,
  `nombre` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idcompteur`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `compteur`
--

INSERT INTO `compteur` (`idcompteur`, `libelle`, `nombre`) VALUES
(1, 'Nombre de clients', 10),
(2, 'Nombre de clients particulier', 3),
(3, 'Nombre de clients professionnel', 0),
(4, 'Nombre de types', 6),
(5, 'Nombre de produits', 24),
(6, 'Nombre de commandes', 0);

-- --------------------------------------------------------

--
-- Structure de la table `erreurs`
--

DROP TABLE IF EXISTS `erreurs`;
CREATE TABLE IF NOT EXISTS `erreurs` (
  `id_erreur` int(11) NOT NULL AUTO_INCREMENT,
  `texte` varchar(255) NOT NULL,
  `heure` datetime NOT NULL,
  PRIMARY KEY (`id_erreur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `factures`
--

DROP TABLE IF EXISTS `factures`;
CREATE TABLE IF NOT EXISTS `factures` (
  `idFacture` int(11) NOT NULL AUTO_INCREMENT,
  `dateHeureFacture` datetime NOT NULL,
  `idClient` int(11) NOT NULL,
  `idProduit` int(11) NOT NULL,
  `numCommande` int(8) NOT NULL,
  PRIMARY KEY (`idFacture`),
  KEY `idClient` (`idClient`),
  KEY `idProduit` (`idProduit`),
  KEY `numCommande` (`numCommande`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `histoclients`
--

DROP TABLE IF EXISTS `histoclients`;
CREATE TABLE IF NOT EXISTS `histoclients` (
  `idClient` int(11) NOT NULL DEFAULT '0',
  `nom` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `tel` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `mdp` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `adresse` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `cp` varchar(5) CHARACTER SET utf8 DEFAULT NULL,
  `ville` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `pays` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `etat` enum('Prospect','Client Courant','Client Grand Courant') CHARACTER SET utf8 DEFAULT NULL,
  `role` enum('Client','Admin') CHARACTER SET utf8 DEFAULT NULL,
  `dateHeureAction` datetime NOT NULL,
  `user` varchar(93) CHARACTER SET utf8 DEFAULT NULL,
  `action` varchar(10) CHARACTER SET cp850 NOT NULL DEFAULT '',
  PRIMARY KEY (`idClient`,`dateHeureAction`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `histoclients`
--

INSERT INTO `histoclients` (`idClient`, `nom`, `tel`, `email`, `mdp`, `adresse`, `cp`, `ville`, `pays`, `etat`, `role`, `dateHeureAction`, `user`, `action`) VALUES
(2, 'PART1', '0000000001', 'tom1.particulier@gmail.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '5 rue des Particulier', '92300', 'Levallois', 'France', 'Client Grand Courant', 'Admin', '2022-03-08 20:01:35', 'root@localhost', 'INSERT'),
(3, 'PART2', '0000000002', 'tom2.particulier@gmail.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '5 rue des Particulier', '92300', 'Levallois', 'France', 'Client Grand Courant', 'Admin', '2022-03-08 20:01:35', 'root@localhost', 'INSERT'),
(4, 'PRO2', '0000000005', 'tom5.professionnel@gmail.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '5 rue des Professionnel', '95300', 'Levallois', 'France', 'Prospect', 'Admin', '2022-03-08 20:01:35', 'root@localhost', 'INSERT'),
(5, 'PRO3', '0000000006', 'tom6.professionnel@gmail.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '5 rue des Professionnel', '95300', 'Levallois', 'France', 'Prospect', 'Admin', '2022-03-08 20:01:35', 'root@localhost', 'INSERT');

-- --------------------------------------------------------

--
-- Structure de la table `histocommandes`
--

DROP TABLE IF EXISTS `histocommandes`;
CREATE TABLE IF NOT EXISTS `histocommandes` (
  `numCommande` int(8) NOT NULL DEFAULT '0',
  `nom` varchar(50) CHARACTER SET utf8 NOT NULL,
  `adresse` varchar(255) CHARACTER SET utf8 NOT NULL,
  `cp` varchar(5) CHARACTER SET utf8 NOT NULL,
  `ville` varchar(100) CHARACTER SET utf8 NOT NULL,
  `pays` varchar(50) CHARACTER SET utf8 NOT NULL,
  `mode_payement` varchar(50) CHARACTER SET utf8 NOT NULL,
  `etatCommande` varchar(100) CHARACTER SET utf8 NOT NULL,
  `montantTotalHT` decimal(12,2) DEFAULT NULL,
  `montantTotalTTC` decimal(12,2) DEFAULT NULL,
  `TVA` decimal(10,2) DEFAULT NULL,
  `dateCommande` date DEFAULT NULL,
  `dateLivraison` date DEFAULT NULL,
  `idClient` int(11) NOT NULL,
  `dateHeureAction` datetime NOT NULL,
  `user` varchar(93) CHARACTER SET utf8 DEFAULT NULL,
  `action` varchar(10) CHARACTER SET cp850 NOT NULL DEFAULT '',
  PRIMARY KEY (`numCommande`,`dateHeureAction`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `histoproduits`
--

DROP TABLE IF EXISTS `histoproduits`;
CREATE TABLE IF NOT EXISTS `histoproduits` (
  `idProduit` int(11) NOT NULL DEFAULT '0',
  `nomProduit` varchar(150) CHARACTER SET utf8 NOT NULL,
  `imageProduit` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `descriptionProduit` longtext CHARACTER SET utf8,
  `qteProduit` int(3) NOT NULL,
  `prixProduit` decimal(6,2) NOT NULL,
  `idType` int(11) NOT NULL,
  `date_ajout` datetime NOT NULL,
  `dateHeureAction` datetime NOT NULL,
  `user` varchar(93) CHARACTER SET utf8 DEFAULT NULL,
  `action` varchar(10) CHARACTER SET cp850 NOT NULL DEFAULT '',
  PRIMARY KEY (`idProduit`,`dateHeureAction`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `histotypes`
--

DROP TABLE IF EXISTS `histotypes`;
CREATE TABLE IF NOT EXISTS `histotypes` (
  `idType` int(11) NOT NULL DEFAULT '0',
  `libelle` varchar(50) CHARACTER SET utf8 NOT NULL,
  `dateHeureAction` datetime NOT NULL,
  `user` varchar(93) CHARACTER SET utf8 DEFAULT NULL,
  `action` varchar(10) CHARACTER SET cp850 NOT NULL DEFAULT '',
  PRIMARY KEY (`idType`,`dateHeureAction`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `idMessage` int(11) NOT NULL AUTO_INCREMENT,
  `id_exp` int(11) NOT NULL,
  `id_dest` int(11) NOT NULL,
  `date_envoi` datetime DEFAULT NULL,
  `contenu` longtext,
  `lu` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idMessage`,`id_exp`,`id_dest`),
  KEY `id_exp` (`id_exp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `panier`
--

DROP TABLE IF EXISTS `panier`;
CREATE TABLE IF NOT EXISTS `panier` (
  `numCommande` int(8) NOT NULL,
  `nomProduit` varchar(100) NOT NULL,
  `prix` int(11) NOT NULL,
  `quantite` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déclencheurs `panier`
--
DROP TRIGGER IF EXISTS `calculDelete`;
DELIMITER $$
CREATE TRIGGER `calculDelete` BEFORE DELETE ON `panier` FOR EACH ROW Begin
Update commandes
Set montantTotalHT = montantTotalHT - (
select sum(prixProduit * old.quantite)
from produits p
where p.nomProduit = old.nomProduit
group by numCommande
),
TVA = montantTotalHT * 0.2,
montantTotalTTC = montantTotalHT + TVA
Where numCommande = old.numCommande;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `calculInsert`;
DELIMITER $$
CREATE TRIGGER `calculInsert` AFTER INSERT ON `panier` FOR EACH ROW Begin
Update commandes co
Set montantTotalHT = montantTotalHT + (
select sum(prixProduit * new.quantite)
from produits p
where p.nomProduit = new.nomProduit
group by new.numCommande
),
TVA = montantTotalHT * 0.20,
montantTotalTTC = TVA + montantTotalHT
Where numCommande = new.numCommande;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `calculUpdate`;
DELIMITER $$
CREATE TRIGGER `calculUpdate` BEFORE UPDATE ON `panier` FOR EACH ROW Begin
Declare qte int;
Declare mth decimal(10,2) default 0;
If new.quantite < old.quantite
Then
Set qte = old.quantite - (
select new.quantite
from panier
where numCommande = old.numCommande
and nomProduit = old.nomProduit
);
Select sum(prixProduit * qte) into mth
From produits p
Where p.nomProduit = old.nomProduit;
Update commandes
Set montantTotalHT = montantTotalHT - mth,
TVA = montantTotalHT * 0.2,
montantTotalTTC = montantTotalHT + TVA
Where numCommande = old.numCommande;
Else
Set qte = (
select new.quantite
from panier
Where numCommande = old.numCommande
and nomProduit = old.nomProduit
) - old.quantite;
Select sum(prixProduit * qte) into mth
From produits p
Where p.nomProduit = old.nomProduit;
Update commandes
Set montantTotalHT = montantTotalHT + mth,
TVA = montantTotalHT * 0.2,
montantTotalTTC = montantTotalTTC + TVA
Where numCommande = new.numCommande;
End if ;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `transactionDelete`;
DELIMITER $$
CREATE TRIGGER `transactionDelete` AFTER DELETE ON `panier` FOR EACH ROW Begin
Update produits
Set qteProduit = qteProduit + old.quantite
Where nomProduit = old.nomProduit;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `transactionInsert`;
DELIMITER $$
CREATE TRIGGER `transactionInsert` AFTER INSERT ON `panier` FOR EACH ROW Begin
Update produits
Set qteProduit = qteProduit - new.quantite
Where nomProduit = new.nomProduit;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `transactionUpdate`;
DELIMITER $$
CREATE TRIGGER `transactionUpdate` AFTER UPDATE ON `panier` FOR EACH ROW Begin
Update produits
Set qteProduit = qteProduit - new.quantite
Where nomProduit = new.nomProduit;
End
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `particulier`
--

DROP TABLE IF EXISTS `particulier`;
CREATE TABLE IF NOT EXISTS `particulier` (
  `idClient` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `tel` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `mdp` varchar(50) NOT NULL,
  `adresse` varchar(100) NOT NULL,
  `cp` varchar(5) NOT NULL,
  `ville` varchar(100) NOT NULL,
  `pays` varchar(50) NOT NULL,
  `etat` enum('Prospect','Client Courant','Client Grand Courant') DEFAULT NULL,
  `role` enum('Client','Admin') DEFAULT NULL,
  PRIMARY KEY (`idClient`),
  UNIQUE KEY `tel` (`tel`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `particulier`
--

INSERT INTO `particulier` (`idClient`, `nom`, `prenom`, `tel`, `email`, `mdp`, `adresse`, `cp`, `ville`, `pays`, `etat`, `role`) VALUES
(1, 'PART1', 'Tom1', '0000000001', 'tom1.particulier@gmail.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '5 rue des Particulier', '92300', 'Levallois', 'France', 'Client Grand Courant', 'Admin'),
(2, 'PART2', 'Tom2', '0000000002', 'tom2.particulier@gmail.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '5 rue des Particulier', '92300', 'Levallois', 'France', 'Client Grand Courant', 'Admin');

--
-- Déclencheurs `particulier`
--
DROP TRIGGER IF EXISTS `beforeInsertParticulier`;
DELIMITER $$
CREATE TRIGGER `beforeInsertParticulier` BEFORE INSERT ON `particulier` FOR EACH ROW Begin
    set new.mdp = sha1(new.mdp);
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `beforeUpdateParticulier`;
DELIMITER $$
CREATE TRIGGER `beforeUpdateParticulier` BEFORE UPDATE ON `particulier` FOR EACH ROW Begin
    set new.mdp = sha1(new.mdp);
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `countClientsPartDelete`;
DELIMITER $$
CREATE TRIGGER `countClientsPartDelete` AFTER DELETE ON `particulier` FOR EACH ROW Begin
    update compteur
    set nombre = nombre - 1
    where idcompteur = 2;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `countClientsPartInsert`;
DELIMITER $$
CREATE TRIGGER `countClientsPartInsert` AFTER INSERT ON `particulier` FOR EACH ROW Begin
    update compteur
    set nombre = nombre + 1
    where idcompteur = 2;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `delete_particulier`;
DELIMITER $$
CREATE TRIGGER `delete_particulier` BEFORE DELETE ON `particulier` FOR EACH ROW Begin
    delete from clients where idClient = old.idClient;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `insert_particulier_auto_increment`;
DELIMITER $$
CREATE TRIGGER `insert_particulier_auto_increment` BEFORE INSERT ON `particulier` FOR EACH ROW Begin
    declare c, x, p int;
    select max(idClient) into x from professionnel;
    if x = 1
        then
            set new.idClient = x + 1;
    end if ;
    insert into clients values (new.idClient, new.nom, new.tel, new.email, new.mdp, new.adresse, new.cp, new.ville, new.pays, new.etat, new.role);
    select count(*) into p
    from professionnel
    where idClient = new.idClient;
    if p > 0
        then signal sqlstate '45000'
        set message_text = 'Impossible !';
    end if ;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `update_particulier`;
DELIMITER $$
CREATE TRIGGER `update_particulier` AFTER UPDATE ON `particulier` FOR EACH ROW Begin
    update clients
    set nom = new.nom, prenom = new.prenom, tel = new.tel, email = new.email, mdp = new.mdp, adresse = new.adresse, cp = new.cp, ville = new.ville, pays = new.pays, etat = new.etat, role = new.role
    where idClient = old.idClient;
End
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

DROP TABLE IF EXISTS `produits`;
CREATE TABLE IF NOT EXISTS `produits` (
  `idProduit` int(11) NOT NULL AUTO_INCREMENT,
  `nomProduit` varchar(150) NOT NULL,
  `imageProduit` varchar(255) DEFAULT NULL,
  `descriptionProduit` longtext,
  `qteProduit` int(3) NOT NULL,
  `prixProduit` decimal(6,2) NOT NULL,
  `idType` int(11) NOT NULL,
  `date_ajout` datetime NOT NULL,
  PRIMARY KEY (`idProduit`),
  UNIQUE KEY `nomProduit` (`nomProduit`),
  KEY `idType` (`idType`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `produits`
--

INSERT INTO `produits` (`idProduit`, `nomProduit`, `imageProduit`, `descriptionProduit`, `qteProduit`, `prixProduit`, `idType`, `date_ajout`) VALUES
(1, 'TOKAI LAR-15B', 'TOKAI_LAR-15B.jpg', 'Téléphonie mais-libre via Bluetooth.', 22, '19.99', 1, '2022-03-08 20:01:31'),
(2, 'PIONEER MVH-S110UB', 'PIONEER_MVH-S110UB.jpg', 'Contrôle de l\'autoratio à partir d\'un smartphone.', 25, '39.99', 1, '2022-03-08 20:01:31'),
(3, 'SONY WX-920BT', 'SONY_WX-920BT.jpg', 'Téléphonie mains-libre via Bluetooth et commande vocal SIRI.', 30, '199.99', 1, '2022-03-08 20:01:31'),
(4, 'JVC KW-V420BT', 'JVC_KW-V420BT.jpg', 'Téléphonie mais-libre via Bluetooth et commande vocal SIRI.', 5, '399.99', 1, '2022-03-08 20:01:31'),
(5, 'MAPPY ULTI E538', 'MAPPY_ULTI_E538.jpg', 'Limitation de vitesse et mode de visualisation Realview.', 3, '79.99', 2, '2022-03-08 20:01:31'),
(6, 'GARMIN DRIVE 51 LMT-S SE', 'GARMIN_DRIVE_51_LMT-S_SE.jpg', 'Alerte les zonnes de danger et carte de l\'Europe (15 pays) gratuits à vie.', 5, '129.99', 2, '2022-03-08 20:01:31'),
(7, 'POIDS LOURD SNOOPER PL6600', 'POIDS_LOURD_SNOOPER_PL6600.jpg', 'Guidage prenant en compte le gabarit.', 7, '599.00', 2, '2022-03-08 20:01:31'),
(8, 'PIONEER AVIC-F88DAB', 'PIONEER_AVIC-F88DAB.jpg', 'Carte de l\'Europe (45 pays) et info trafic, compatible avec AppleCartPay et Android Auto.', 8, '1299.00', 2, '2022-03-08 20:01:31'),
(9, 'CAMERA DE RECUL BEEPER RWEC100X-RF', 'CAMERA_DE_RECUL_BEEPER_RWEC100X-RF.jpg', 'Angle de vue 140° horizontale.', 9, '199.99', 3, '2022-03-08 20:01:31'),
(10, 'CAMERA DE RECUL BEEPER RWEC200X-BL', 'CAMERA_DE_RECUL_BEEPERRWEC200X-BL.jpg', 'Angle de vue 140° horizontale.', 10, '359.99', 3, '2022-03-08 20:01:31'),
(11, 'CAMERA EMBARQUEE NEXTBASE NBDVR-101 HD', 'CAMERA_EMBARQUEE_NEXTBASE_NBDVR-101_HD.jpg', 'Angle de vue 120°, sortie audio AV et microphone intégré.', 11, '89.99', 3, '2022-03-08 20:01:31'),
(12, 'CAMERA DE RECUL + ECRAN BEEPER RW037-P', 'CAMERA_DE_RECUL_+_ECRAN_BEEPER_RW037-P.jpg', 'Angle de vue 150° horizontale.', 12, '89.99', 3, '2022-03-08 20:01:31'),
(13, 'PIONEER Ts-13020 I', 'PIONEER_Ts-13020_I.jpg', 'Diamètre de 13 cm et puissace de 130 Watts.', 13, '22.99', 4, '2022-03-08 20:01:31'),
(14, 'FOCAL 130 AC', 'FOCAL_130_AC.jpg', 'Diamètre de 13 cm et puissace de 100 Watts.', 14, '89.99', 4, '2022-03-08 20:01:31'),
(15, 'MTX T6S652', 'MTX_T6S652.jpg', 'Diamètre de 16.5 cm et puissance de 400 Watts.', 15, '129.99', 4, '2022-03-08 20:01:31'),
(16, 'FOCAL PS 165 F3', 'FOCAL_PS_165_F3.jpg', 'Diamètre de 16.5 cm et puissance de 160 Watts.', 16, '399.00', 4, '2022-03-08 20:01:31'),
(17, 'SUPERTOOTH BUDDY NOIR', 'SUPERTOOTH_BUDDY_NOIR.jpg', 'Connexion simultanéé de 2 téléphones, reconnexion automatique au téléphone.', 17, '35.99', 5, '2022-03-08 20:01:31'),
(18, 'PARROT NEO 2 HD', 'PARROT_NEO_2_HD.jpg', 'Connexion simultanéé de 2 téléphones, applications smartphones dédiées avec fonctions exclusives.', 18, '79.99', 5, '2022-03-08 20:01:31'),
(19, 'PARROT MKI9200', 'PARROT_MKI9200.jpg', 'Diffusion vocale et musicale sur les Haut-parleurs, télécommande sans fil positionnable au volant, connexion simultanée de 2 téléphones.', 19, '249.00', 5, '2022-03-08 20:01:31'),
(20, 'PARROT MKI9000', 'PARROT_MKI9000.jpg', 'Diffusion vocale et musicale sur les Haut-parleurs, connexion simultanée de 2 téléphones, conversations de qualité grâce aux doubles microphones.', 20, '169.99', 5, '2022-03-08 20:01:31'),
(21, 'MTX RFL4001D', 'MTX_RFL4001D.jpg', 'Puissance maximale de 12 000 W, dimensions en cm : 20.4 x 62.6 x 5.9', 21, '999.00', 6, '2022-03-08 20:01:31'),
(22, 'JBL GX-A3001', 'JBL_GX-A3001.jpg', 'Puissance maximale de 415 W, dimensions en cm : 10.8 x 33.6 x 25', 22, '149.99', 6, '2022-03-08 20:01:31'),
(23, 'MTX TR275', 'MTX_TR275.jpg', 'Puissance de 660 W, dimensions en cm : 14.2 x 13.4 x 5.1', 23, '275.00', 6, '2022-03-08 20:01:31'),
(24, 'CALIBEER CA75.2', 'CALIBEER_CA75.2.jpg', 'Puissance maximale de 150 W, dimensions en cm : 3.8 x 7.8 x 10', 24, '42.99', 6, '2022-03-08 20:01:31');

--
-- Déclencheurs `produits`
--
DROP TRIGGER IF EXISTS `countProduitsDelete`;
DELIMITER $$
CREATE TRIGGER `countProduitsDelete` AFTER DELETE ON `produits` FOR EACH ROW Begin
    update compteur
    set nombre = nombre - 1
    where idcompteur = 5;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `countProduitsInsert`;
DELIMITER $$
CREATE TRIGGER `countProduitsInsert` AFTER INSERT ON `produits` FOR EACH ROW Begin
    update compteur
    set nombre = nombre + 1
    where idcompteur = 5;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `deleteProduit`;
DELIMITER $$
CREATE TRIGGER `deleteProduit` BEFORE DELETE ON `produits` FOR EACH ROW Begin
Insert into histoProduits select *, sysdate(), user(), 'DELETE'
From produits
Where idProduit = old.idProduit;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `insertProduit`;
DELIMITER $$
CREATE TRIGGER `insertProduit` AFTER INSERT ON `produits` FOR EACH ROW Begin
Insert into histoProduits select *, sysdate(), user(), 'INSERT'
From produits
Where idProduit = new.idProduit;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `updateProduit`;
DELIMITER $$
CREATE TRIGGER `updateProduit` BEFORE UPDATE ON `produits` FOR EACH ROW Begin
Insert into histoProduits select *, sysdate(), user(), 'UPDATE'
From produits
Where idProduit = old.idProduit;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `verifPrixInsert`;
DELIMITER $$
CREATE TRIGGER `verifPrixInsert` BEFORE INSERT ON `produits` FOR EACH ROW Begin
If new.prixProduit <= 0
Then signal sqlstate '45000'
Set message_text = 'Impossible !';
End if ;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `verifPrixUpdate`;
DELIMITER $$
CREATE TRIGGER `verifPrixUpdate` BEFORE UPDATE ON `produits` FOR EACH ROW Begin
If new.prixProduit <= 0
Then signal sqlstate '45000'
Set message_text = 'Impossible !';
End if ;
End
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `professionnel`
--

DROP TABLE IF EXISTS `professionnel`;
CREATE TABLE IF NOT EXISTS `professionnel` (
  `idClient` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `tel` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `mdp` varchar(50) NOT NULL,
  `adresse` varchar(100) NOT NULL,
  `cp` varchar(5) NOT NULL,
  `ville` varchar(100) NOT NULL,
  `pays` varchar(50) NOT NULL,
  `numSIRET` varchar(50) NOT NULL,
  `statut` varchar(50) NOT NULL,
  `etat` enum('Prospect','Client Courant','Client Grand Courant') DEFAULT NULL,
  `role` enum('Client','Admin') DEFAULT NULL,
  PRIMARY KEY (`idClient`),
  UNIQUE KEY `tel` (`tel`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `professionnel`
--

INSERT INTO `professionnel` (`idClient`, `nom`, `tel`, `email`, `mdp`, `adresse`, `cp`, `ville`, `pays`, `numSIRET`, `statut`, `etat`, `role`) VALUES
(1, 'PRO2', '0000000005', 'tom5.professionnel@gmail.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '5 rue des Professionnel', '95300', 'Levallois', 'France', '521 868 267 00014', 'SARL', 'Prospect', 'Admin'),
(2, 'PRO3', '0000000006', 'tom6.professionnel@gmail.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '5 rue des Professionnel', '95300', 'Levallois', 'France', '521 868 267 00014', 'SARL', 'Prospect', 'Admin');

--
-- Déclencheurs `professionnel`
--
DROP TRIGGER IF EXISTS `beforeInsertProfessionnel`;
DELIMITER $$
CREATE TRIGGER `beforeInsertProfessionnel` BEFORE INSERT ON `professionnel` FOR EACH ROW Begin
    set new.mdp = sha1(new.mdp);
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `beforeUpdateProfessionnel`;
DELIMITER $$
CREATE TRIGGER `beforeUpdateProfessionnel` BEFORE UPDATE ON `professionnel` FOR EACH ROW Begin
    set new.mdp = sha1(new.mdp);
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `countClientsProInsert`;
DELIMITER $$
CREATE TRIGGER `countClientsProInsert` AFTER DELETE ON `professionnel` FOR EACH ROW Begin
    update compteur
    set nombre = nombre - 1
    where idcompteur = 3;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `delete_professionnel`;
DELIMITER $$
CREATE TRIGGER `delete_professionnel` BEFORE DELETE ON `professionnel` FOR EACH ROW Begin
    delete from clients where idClient = old.idClient;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `insert_professionnel_auto_increment`;
DELIMITER $$
CREATE TRIGGER `insert_professionnel_auto_increment` BEFORE INSERT ON `professionnel` FOR EACH ROW Begin
    declare c, x, p int;
    select max(idClient) into x from particulier;
    if x = 1
        then
            set new.idClient = x + 1;
    end if ;
    insert into clients values (new.idClient, new.nom, new.tel, new.email, new.mdp, new.adresse, new.cp, new.ville, new.pays, new.etat, new.role);
    select count(*) into p
    from particulier
    where idClient = new.idClient;
    if p > 0
        then signal sqlstate '45000'
        set message_text = 'Impossible !';
    end if ;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `update_professionnel`;
DELIMITER $$
CREATE TRIGGER `update_professionnel` AFTER UPDATE ON `professionnel` FOR EACH ROW Begin
    update clients
    set nom = new.nom, tel = new.tel, email = new.email, mdp = new.mdp, adresse = new.adresse, cp = new.cp, ville = new.ville, pays = new.pays, numSIRET = new.numSIRET, statut = new.statut, etat = new.etat, role = new.role
    where idClient = old.idClient;
End
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `tp`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `tp`;
CREATE TABLE IF NOT EXISTS `tp` (
`libelle` varchar(50)
,`nomProduit` varchar(150)
);

-- --------------------------------------------------------

--
-- Structure de la table `types`
--

DROP TABLE IF EXISTS `types`;
CREATE TABLE IF NOT EXISTS `types` (
  `idType` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(50) NOT NULL,
  PRIMARY KEY (`idType`),
  UNIQUE KEY `libelle` (`libelle`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `types`
--

INSERT INTO `types` (`idType`, `libelle`) VALUES
(3, 'Aide à la conduite'),
(6, 'Amplificateur'),
(1, 'Autoradio'),
(2, 'GPS'),
(4, 'Haut-parleurs'),
(5, 'Kit mains-libre');

--
-- Déclencheurs `types`
--
DROP TRIGGER IF EXISTS `checkTypeInsert`;
DELIMITER $$
CREATE TRIGGER `checkTypeInsert` BEFORE INSERT ON `types` FOR EACH ROW Begin
If new.libelle = (select libelle from types where libelle = new.libelle)
Then signal sqlstate '45000'
Set message_text = 'Ce type est déjà enregistré !';
End if ;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `countTypesDelete`;
DELIMITER $$
CREATE TRIGGER `countTypesDelete` AFTER DELETE ON `types` FOR EACH ROW Begin
    update compteur
    set nombre = nombre - 1
    where idcompteur = 4;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `countTypesInsert`;
DELIMITER $$
CREATE TRIGGER `countTypesInsert` AFTER INSERT ON `types` FOR EACH ROW Begin
    update compteur
    set nombre = nombre + 1
    where idcompteur = 4;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `deleteType`;
DELIMITER $$
CREATE TRIGGER `deleteType` BEFORE DELETE ON `types` FOR EACH ROW Begin
Insert into histoTypes select *, sysdate(), user(), 'DELETE'
From types
Where idType = old.idType;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `insertType`;
DELIMITER $$
CREATE TRIGGER `insertType` AFTER INSERT ON `types` FOR EACH ROW Begin
Insert into histoTypes select *, sysdate(), user(), 'INSERT'
From types
Where idType = new.idType;
End
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `updateType`;
DELIMITER $$
CREATE TRIGGER `updateType` BEFORE UPDATE ON `types` FOR EACH ROW Begin
Insert into histoTypes select *, sysdate(), user(), 'UPDATE'
From types
Where idType = old.idType;
End
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vclients`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `vclients`;
CREATE TABLE IF NOT EXISTS `vclients` (
`idClient` int(11)
,`nom` varchar(50)
,`tel` varchar(10)
,`email` varchar(50)
,`mdp` varchar(50)
,`adresse` varchar(100)
,`cp` varchar(5)
,`ville` varchar(100)
,`pays` varchar(50)
,`etat` enum('Prospect','Client Courant','Client Grand Courant')
,`role` enum('Client','Admin')
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vcommandes`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `vcommandes`;
CREATE TABLE IF NOT EXISTS `vcommandes` (
`numCommande` int(8)
,`nom` varchar(50)
,`adresse` varchar(255)
,`cp` varchar(5)
,`ville` varchar(100)
,`pays` varchar(50)
,`mode_payement` varchar(50)
,`etatCommande` varchar(100)
,`montantTotalHT` decimal(12,2)
,`montantTotalTTC` decimal(12,2)
,`TVA` decimal(10,2)
,`dateCommande` varchar(10)
,`dateLivraison` varchar(10)
,`idClient` int(11)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vcommentaires`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `vcommentaires`;
CREATE TABLE IF NOT EXISTS `vcommentaires` (
`idCom` int(11)
,`idProduit` int(11)
,`idClient` varchar(50)
,`contenu` varchar(255)
,`client_id` int(11)
,`dateHeurePost` varchar(21)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vfactures`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `vfactures`;
CREATE TABLE IF NOT EXISTS `vfactures` (
`idFacture` int(11)
,`dateHeureFacture` varchar(21)
,`nom` varchar(50)
,`email` varchar(50)
,`adresse` varchar(100)
,`cp` varchar(5)
,`ville` varchar(100)
,`pays` varchar(50)
,`nomProduit` varchar(150)
,`prixProduit` decimal(6,2)
,`montantTotalHT` decimal(12,2)
,`montantTotalTTC` decimal(12,2)
,`TVA` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vhistoclients`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `vhistoclients`;
CREATE TABLE IF NOT EXISTS `vhistoclients` (
`idClient` int(11)
,`nom` varchar(50)
,`dateHeureAction` varchar(21)
,`action` varchar(10)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vhistocommandes`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `vhistocommandes`;
CREATE TABLE IF NOT EXISTS `vhistocommandes` (
`numCommande` int(8)
,`nom` varchar(50)
,`dateHeureAction` varchar(21)
,`action` varchar(10)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vhistoproduits`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `vhistoproduits`;
CREATE TABLE IF NOT EXISTS `vhistoproduits` (
`idProduit` int(11)
,`nomProduit` varchar(150)
,`dateHeureAction` varchar(21)
,`action` varchar(10)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vhistotypes`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `vhistotypes`;
CREATE TABLE IF NOT EXISTS `vhistotypes` (
`idType` int(11)
,`libelle` varchar(50)
,`dateHeureAction` varchar(21)
,`action` varchar(10)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vmessages`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `vmessages`;
CREATE TABLE IF NOT EXISTS `vmessages` (
`idMessage` int(11)
,`id_exp` varchar(50)
,`id_dest` varchar(50)
,`date_envoi` varchar(21)
,`contenu` longtext
,`lu` int(11)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vpanier`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `vpanier`;
CREATE TABLE IF NOT EXISTS `vpanier` (
`idProduit` int(11)
,`nomProduit` varchar(150)
,`prixProduit` decimal(6,2)
,`qteProduit` int(3)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vproduits`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `vproduits`;
CREATE TABLE IF NOT EXISTS `vproduits` (
`idProduit` int(11)
,`nomProduit` varchar(150)
,`imageProduit` varchar(255)
,`descriptionProduit` longtext
,`qteProduit` int(3)
,`prixProduit` decimal(6,2)
,`libelle` varchar(50)
,`date_ajout` varchar(21)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vstatproduits`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `vstatproduits`;
CREATE TABLE IF NOT EXISTS `vstatproduits` (
`NOM_PRODUIT` varchar(150)
,`Autoradio` double
,`GPS` double
,`Aide à la conduite` double
,`Haut-parleurs` double
,`Kit mains-libre` double
,`Amplificateurs` double
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vtypes`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `vtypes`;
CREATE TABLE IF NOT EXISTS `vtypes` (
`idType` int(11)
,`libelle` varchar(50)
);

-- --------------------------------------------------------

--
-- Structure de la vue `tp`
--
DROP TABLE IF EXISTS `tp`;

DROP VIEW IF EXISTS `tp`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tp`  AS SELECT `t`.`libelle` AS `libelle`, `p`.`nomProduit` AS `nomProduit` FROM (`types` `t` join `produits` `p`) WHERE (`t`.`idType` = `p`.`idType`) ORDER BY `t`.`libelle` ASC ;

-- --------------------------------------------------------

--
-- Structure de la vue `vclients`
--
DROP TABLE IF EXISTS `vclients`;

DROP VIEW IF EXISTS `vclients`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vclients`  AS SELECT `clients`.`idClient` AS `idClient`, `clients`.`nom` AS `nom`, `clients`.`tel` AS `tel`, `clients`.`email` AS `email`, `clients`.`mdp` AS `mdp`, `clients`.`adresse` AS `adresse`, `clients`.`cp` AS `cp`, `clients`.`ville` AS `ville`, `clients`.`pays` AS `pays`, `clients`.`etat` AS `etat`, `clients`.`role` AS `role` FROM `clients` ORDER BY `clients`.`idClient` DESC ;

-- --------------------------------------------------------

--
-- Structure de la vue `vcommandes`
--
DROP TABLE IF EXISTS `vcommandes`;

DROP VIEW IF EXISTS `vcommandes`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vcommandes`  AS SELECT `commandes`.`numCommande` AS `numCommande`, `commandes`.`nom` AS `nom`, `commandes`.`adresse` AS `adresse`, `commandes`.`cp` AS `cp`, `commandes`.`ville` AS `ville`, `commandes`.`pays` AS `pays`, `commandes`.`mode_payement` AS `mode_payement`, `commandes`.`etatCommande` AS `etatCommande`, `commandes`.`montantTotalHT` AS `montantTotalHT`, `commandes`.`montantTotalTTC` AS `montantTotalTTC`, `commandes`.`TVA` AS `TVA`, date_format(`commandes`.`dateCommande`,'%d/%m/%Y') AS `dateCommande`, date_format(`commandes`.`dateLivraison`,'%d/%m/%Y') AS `dateLivraison`, `commandes`.`idClient` AS `idClient` FROM `commandes` ORDER BY `commandes`.`numCommande` DESC ;

-- --------------------------------------------------------

--
-- Structure de la vue `vcommentaires`
--
DROP TABLE IF EXISTS `vcommentaires`;

DROP VIEW IF EXISTS `vcommentaires`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vcommentaires`  AS SELECT `co`.`idCom` AS `idCom`, `p`.`idProduit` AS `idProduit`, `cl`.`nom` AS `idClient`, `co`.`contenu` AS `contenu`, `co`.`client_id` AS `client_id`, date_format(`co`.`dateHeurePost`,'%d/%m/%Y %H:%i') AS `dateHeurePost` FROM ((`commentaires` `co` join `produits` `p` on((`co`.`idProduit` = `p`.`idProduit`))) join `clients` `cl` on((`co`.`idClient` = `cl`.`idClient`))) GROUP BY `co`.`idCom` ;

-- --------------------------------------------------------

--
-- Structure de la vue `vfactures`
--
DROP TABLE IF EXISTS `vfactures`;

DROP VIEW IF EXISTS `vfactures`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vfactures`  AS SELECT `f`.`idFacture` AS `idFacture`, date_format(`f`.`dateHeureFacture`,'%d/%m/%Y %H:%i') AS `dateHeureFacture`, `c`.`nom` AS `nom`, `c`.`email` AS `email`, `c`.`adresse` AS `adresse`, `c`.`cp` AS `cp`, `c`.`ville` AS `ville`, `c`.`pays` AS `pays`, `p`.`nomProduit` AS `nomProduit`, `p`.`prixProduit` AS `prixProduit`, `co`.`montantTotalHT` AS `montantTotalHT`, `co`.`montantTotalTTC` AS `montantTotalTTC`, `co`.`TVA` AS `TVA` FROM (((`factures` `f` join `clients` `c` on((`f`.`idClient` = `c`.`idClient`))) join `produits` `p` on((`f`.`idProduit` = `p`.`idProduit`))) join `commandes` `co` on((`f`.`numCommande` = `co`.`numCommande`))) GROUP BY `f`.`idFacture` ;

-- --------------------------------------------------------

--
-- Structure de la vue `vhistoclients`
--
DROP TABLE IF EXISTS `vhistoclients`;

DROP VIEW IF EXISTS `vhistoclients`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vhistoclients`  AS SELECT `histoclients`.`idClient` AS `idClient`, `histoclients`.`nom` AS `nom`, date_format(`histoclients`.`dateHeureAction`,'%d/%m/%Y %H:%i') AS `dateHeureAction`, `histoclients`.`action` AS `action` FROM `histoclients` ORDER BY `histoclients`.`idClient` DESC ;

-- --------------------------------------------------------

--
-- Structure de la vue `vhistocommandes`
--
DROP TABLE IF EXISTS `vhistocommandes`;

DROP VIEW IF EXISTS `vhistocommandes`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vhistocommandes`  AS SELECT `histocommandes`.`numCommande` AS `numCommande`, `histocommandes`.`nom` AS `nom`, date_format(`histocommandes`.`dateHeureAction`,'%d/%m/%Y %H:%i') AS `dateHeureAction`, `histocommandes`.`action` AS `action` FROM `histocommandes` ORDER BY `histocommandes`.`numCommande` DESC ;

-- --------------------------------------------------------

--
-- Structure de la vue `vhistoproduits`
--
DROP TABLE IF EXISTS `vhistoproduits`;

DROP VIEW IF EXISTS `vhistoproduits`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vhistoproduits`  AS SELECT `histoproduits`.`idProduit` AS `idProduit`, `histoproduits`.`nomProduit` AS `nomProduit`, date_format(`histoproduits`.`dateHeureAction`,'%d/%m/%Y %H:%i') AS `dateHeureAction`, `histoproduits`.`action` AS `action` FROM `histoproduits` ORDER BY `histoproduits`.`idProduit` DESC ;

-- --------------------------------------------------------

--
-- Structure de la vue `vhistotypes`
--
DROP TABLE IF EXISTS `vhistotypes`;

DROP VIEW IF EXISTS `vhistotypes`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vhistotypes`  AS SELECT `histotypes`.`idType` AS `idType`, `histotypes`.`libelle` AS `libelle`, date_format(`histotypes`.`dateHeureAction`,'%d/%m/%Y %H:%i') AS `dateHeureAction`, `histotypes`.`action` AS `action` FROM `histotypes` ORDER BY `histotypes`.`idType` DESC ;

-- --------------------------------------------------------

--
-- Structure de la vue `vmessages`
--
DROP TABLE IF EXISTS `vmessages`;

DROP VIEW IF EXISTS `vmessages`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vmessages`  AS SELECT `m2`.`idMessage` AS `idMessage`, `a`.`nom` AS `id_exp`, `b`.`nom` AS `id_dest`, date_format(`m1`.`date_envoi`,'%d/%m/%Y %H:%i') AS `date_envoi`, `m2`.`contenu` AS `contenu`, `m2`.`lu` AS `lu` FROM (((`clients` `a` join `clients` `b`) join `messages` `m1`) join `messages` `m2`) WHERE ((`m1`.`id_exp` = `a`.`idClient`) AND (`m2`.`id_dest` = `b`.`idClient`) AND (`m1`.`date_envoi` = `m2`.`date_envoi`)) ;

-- --------------------------------------------------------

--
-- Structure de la vue `vpanier`
--
DROP TABLE IF EXISTS `vpanier`;

DROP VIEW IF EXISTS `vpanier`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vpanier`  AS SELECT `produits`.`idProduit` AS `idProduit`, `produits`.`nomProduit` AS `nomProduit`, `produits`.`prixProduit` AS `prixProduit`, `produits`.`qteProduit` AS `qteProduit` FROM `produits` ;

-- --------------------------------------------------------

--
-- Structure de la vue `vproduits`
--
DROP TABLE IF EXISTS `vproduits`;

DROP VIEW IF EXISTS `vproduits`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vproduits`  AS SELECT `p`.`idProduit` AS `idProduit`, `p`.`nomProduit` AS `nomProduit`, `p`.`imageProduit` AS `imageProduit`, `p`.`descriptionProduit` AS `descriptionProduit`, `p`.`qteProduit` AS `qteProduit`, `p`.`prixProduit` AS `prixProduit`, `t`.`libelle` AS `libelle`, date_format(`p`.`date_ajout`,'%d/%m/%Y %H:%i') AS `date_ajout` FROM (`produits` `p` join `types` `t`) WHERE (`p`.`idType` = `t`.`idType`) ORDER BY `p`.`idProduit` DESC ;

-- --------------------------------------------------------

--
-- Structure de la vue `vstatproduits`
--
DROP TABLE IF EXISTS `vstatproduits`;

DROP VIEW IF EXISTS `vstatproduits`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vstatproduits`  AS SELECT ifnull(`vproduits`.`nomProduit`,'TOTAL') AS `NOM_PRODUIT`, sum(if((`vproduits`.`libelle` = 'Autoradio'),`vproduits`.`prixProduit`,'')) AS `Autoradio`, sum(if((`vproduits`.`libelle` = 'GPS'),`vproduits`.`prixProduit`,'')) AS `GPS`, sum(if((`vproduits`.`libelle` = 'Aide à la conduite'),`vproduits`.`prixProduit`,'')) AS `Aide à la conduite`, sum(if((`vproduits`.`libelle` = 'Haut-parleurs'),`vproduits`.`prixProduit`,'')) AS `Haut-parleurs`, sum(if((`vproduits`.`libelle` = 'Kit mains-libre'),`vproduits`.`prixProduit`,'')) AS `Kit mains-libre`, sum(if((`vproduits`.`libelle` = 'Amplificateur'),`vproduits`.`prixProduit`,'')) AS `Amplificateurs` FROM `vproduits` GROUP BY `vproduits`.`nomProduit` ;

-- --------------------------------------------------------

--
-- Structure de la vue `vtypes`
--
DROP TABLE IF EXISTS `vtypes`;

DROP VIEW IF EXISTS `vtypes`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vtypes`  AS SELECT `types`.`idType` AS `idType`, `types`.`libelle` AS `libelle` FROM `types` ORDER BY `types`.`idType` DESC ;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commandes`
--
ALTER TABLE `commandes`
  ADD CONSTRAINT `commandes_ibfk_1` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `commentaires`
--
ALTER TABLE `commentaires`
  ADD CONSTRAINT `commentaires_ibfk_1` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commentaires_ibfk_2` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `factures`
--
ALTER TABLE `factures`
  ADD CONSTRAINT `factures_ibfk_1` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `factures_ibfk_2` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `factures_ibfk_3` FOREIGN KEY (`numCommande`) REFERENCES `commandes` (`numCommande`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`id_exp`) REFERENCES `clients` (`idClient`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `produits`
--
ALTER TABLE `produits`
  ADD CONSTRAINT `produits_ibfk_1` FOREIGN KEY (`idType`) REFERENCES `types` (`idType`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

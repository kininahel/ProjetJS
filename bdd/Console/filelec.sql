-- source c:\wamp\www\filelec\bdd\Console\filelec.sql

Drop database if exists filelec;
Create database if not exists filelec;
Use filelec;

Drop table if exists clients;
Create table if not exists clients (
	idClient int(11) auto_increment,
	nom varchar(50),
	tel varchar(10) UNIQUE,
	email varchar(50) UNIQUE,
	mdp varchar(50),
	adresse varchar(100),
	cp varchar(5),
	ville varchar(100),
	pays varchar(50),
	etat enum("Prospect", "Client Courant", "Client Grand Courant"),
    role enum("Client", "Admin"),
	primary key (idClient)
) ENGINE=InnoDB, CHARSET=utf8;

-- TEST MOT DE PASSE OUBLIE (mdp : Azerty123)
Insert into clients values (null, "BRUAIRE", "0000000000", "tombruaire@gmail.com", "107d348bff437c999a9ff192adcb78cb03b8ddc6", "5 rue de TEST", "92300", "Levallois", "France", "Client Grand Courant", "Admin");

Create or replace view vClients (idClient, nom, tel, email, mdp, adresse, cp, ville, pays, etat, role) as
Select idClient, nom, tel, email, mdp, adresse, cp, ville, pays, etat, role
From clients
Order by idClient desc;

Drop table if exists histoClients;
Create table if not exists histoClients as select *, sysdate() dateHeureAction, user() user, '__________' action
From clients
Where 2=0;

Alter table histoClients
add primary key (idClient, dateHeureAction);

Create or replace view vHistoClients (idClient, nom, dateHeureAction, action) as
Select idClient, nom, date_format(dateHeureAction, '%d/%m/%Y %H:%i'), action
From histoClients
Order by idClient
Desc;

Drop trigger if exists insertClient;
Delimiter //
Create trigger insertClient
After insert on clients
For each row
Begin
	Insert into histoClients select *, sysdate(), user(), 'INSERT'
	From clients
	Where idClient = new.idClient;
End //
Delimiter ;

Drop trigger if exists updateClient;
Delimiter //
Create trigger updateClient
Before update on clients
For each row
Begin
	Insert into histoClients select *, sysdate(), user(), 'UPDATE'
	From clients
	Where idClient = old.idClient;
End //
Delimiter ;

Drop trigger if exists deleteClient;
Delimiter //
Create trigger deleteClient
Before delete on clients
For each row
Begin
	Insert into histoClients select *, sysdate(), user(), 'DELETE'
	From clients
	Where idClient = old.idClient;
End //
Delimiter ;

Drop procedure if exists insert_client;
Delimiter //
Create procedure insert_client(in idc int, in nomc varchar(50), in telc varchar(10), in emailc varchar(50), in mdpc varchar(50), in adressec varchar(100), in cpc varchar(5), in villec varchar(50), in paysc varchar(50), in etatc enum("Prospect", "Client Courant", "Client Grand Courant"), in rolec enum("Client", "Admin"))
Begin
    insert into clients (idClient, nom, tel, email, mdp, adresse, cp, ville, pays, etat, role) values (idc, nomc, telc, emailc, mdpc, adressec, cpc, villec, paysc, etatc, rolec);
End //
Delimiter ;

Drop procedure if exists update_client;
Delimiter //
Create procedure update_client(idc int, nomc varchar(50), telc varchar(10), emailc varchar(50), mdpc varchar(50), adressec varchar(100), cpc varchar(5), villec varchar(50), paysc varchar(50), etatc enum("Prospect", "Client Courant", "Client Grand Courant"), rolec enum("Client", "Admin"))
Begin
    update clients
    set nom = nomc, tel = telc, email = emailc, mdp = mdpv, adresse = adressec, cp = cpc, ville = villec, pays = paysc, etat = etatc, role = droitc
    where idClient = idc;
End //
Delimiter ;

Drop procedure if exists delete_client;
Delimiter //
Create procedure delete_client(idc int)
Begin
    delete from clients where idClient = idc;
End //
Delimiter ;

Drop table if exists particulier;
Create table if not exists particulier (
    idClient int(11) auto_increment,
    nom varchar(50) not null,
    prenom varchar(50) not null,
    tel varchar(10) not null UNIQUE,
    email varchar(50) not null UNIQUE,
    mdp varchar(50) not null,
    adresse varchar(100) not null,
    cp varchar(5) not null,
    ville varchar(100) not null,
    pays varchar(50) not null,
    etat enum("Prospect", "Client Courant", "Client Grand Courant"),
    role enum("Client", "Admin"),
    primary key (idClient)
) ENGINE=InnoDB, CHARSET=utf8;

Drop trigger if exists beforeInsertParticulier;
Delimiter //
Create trigger beforeInsertParticulier
Before insert on particulier
For each row
Begin
    set new.mdp = sha1(new.mdp);
End //
Delimiter ;

Drop trigger if exists beforeUpdateParticulier;
Delimiter //
Create trigger beforeUpdateParticulier
Before update on particulier
For each row
Begin
    set new.mdp = sha1(new.mdp);
End //
Delimiter ;

Drop trigger if exists update_particulier;
Delimiter //
Create trigger update_particulier
After update on particulier
For each row
Begin
    update clients
    set nom = new.nom, prenom = new.prenom, tel = new.tel, email = new.email, mdp = new.mdp, adresse = new.adresse, cp = new.cp, ville = new.ville, pays = new.pays, etat = new.etat, role = new.role
    where idClient = old.idClient;
End //
Delimiter ;

Drop trigger if exists delete_particulier;
Delimiter //
Create trigger delete_particulier
Before delete on particulier
For each row
Begin
    delete from clients where idClient = old.idClient;
End //
Delimiter ;

Drop procedure if exists insert_part;
Delimiter //
Create procedure insert_part(in idp int, in nomp varchar(50), in prenomp varchar(50), in telp varchar(10), in emailp varchar(50), in mdpp varchar(50), in adressep varchar(100), in cpp varchar(5), in villep varchar(50), in paysp varchar(50), in etatp enum("Prospect", "Client Courant", "Client Grand Courant"), in rolep enum("Client", "Admin"))
Begin
    insert into particulier (idClient, nom, prenom, tel, email, mdp, adresse, cp, ville, pays, etat, droit) values (idp, nomp, prenomp, telp, emailp, mdpp, adressep, cpp, villep, paysp, etatp, rolep);
End //
Delimiter ;

Drop procedure if exists update_part;
Delimiter //
Create procedure update_part(idp int, nomp varchar(50), prenomp varchar(50), telp varchar(10), emailp varchar(50), mdpp varchar(50), adressep varchar(100), cpp varchar(5), villep varchar(50), paysp varchar(50), etatp enum("Prospect", "Client Courant", "Client Grand Courant"), rolep enum("Client", "Admin"))
Begin
    update particulier
    set nom = nomp, prenom = prenomp, tel = telp, email = emailp, mdp = mdpp, adresse = adressep, cp = cpp, ville = villep, pays = paysp, etat = etatp, role = rolep
    where idClient = idp;
End //
Delimiter ;

Drop procedure if exists delete_part;
Delimiter //
Create procedure delete_part(idp int)
Begin
    delete from particulier where idClient = idp;
End //
Delimiter ;

Drop table if exists professionnel;
Create table if not exists professionnel (
    idClient int(11) not null auto_increment,
    nom varchar(50) not null,
    tel varchar(10) not null UNIQUE,
    email varchar(50) not null UNIQUE,
    mdp varchar(50) not null,
    adresse varchar(100) not null,
    cp varchar(5) not null,
    ville varchar(100) not null,
    pays varchar(50) not null,
    numSIRET varchar(50) not null,
    statut varchar(50) not null,
    etat enum("Prospect", "Client Courant", "Client Grand Courant"),
    role enum("Client", "Admin"),
    primary key (idClient)
) ENGINE=InnoDB, CHARSET=utf8;

Drop trigger if exists beforeInsertProfessionnel;
Delimiter //
Create trigger beforeInsertProfessionnel
Before insert on professionnel
For each row
Begin
    set new.mdp = sha1(new.mdp);
End //
Delimiter ;

Drop trigger if exists beforeUpdateProfessionnel;
Delimiter //
Create trigger beforeUpdateProfessionnel
Before update on professionnel
For each row
Begin
    set new.mdp = sha1(new.mdp);
End //
Delimiter ;

Drop trigger if exists update_professionnel;
Delimiter //
Create trigger update_professionnel
After update on professionnel
For each row
Begin
    update clients
    set nom = new.nom, tel = new.tel, email = new.email, mdp = new.mdp, adresse = new.adresse, cp = new.cp, ville = new.ville, pays = new.pays, numSIRET = new.numSIRET, statut = new.statut, etat = new.etat, role = new.role
    where idClient = old.idClient;
End //
Delimiter ;

Drop trigger if exists delete_professionnel;
Delimiter //
Create trigger delete_professionnel
Before delete on professionnel
For each row
Begin
    delete from clients where idClient = old.idClient;
End //
Delimiter ;

Drop trigger if exists  insert_particulier_auto_increment;
Delimiter //
Create trigger insert_particulier_auto_increment
Before insert on particulier
For each row
Begin
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
End //
Delimiter ;

Drop trigger if exists  insert_professionnel_auto_increment;
Delimiter //
Create trigger insert_professionnel_auto_increment
Before insert on professionnel
For each row
Begin
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
End //
Delimiter ;

Drop procedure if exists insert_pro;
Delimiter //
Create procedure insert_pro(in idpro int, in nompro varchar(50), in telpro varchar(10), in emailpro varchar(50), in mdppro varchar(50), in adressepro varchar(100), in cppro varchar(5), in villepro varchar(50), in payspro varchar(50), in numSpro varchar(50), in statutpro varchar(50), in etatpro enum("Prospect", "Client Courant", "Client Grand Courant"), in rolepro enum("Client", "Admin"))
Begin
    insert into professionnel (idClient, nom, tel, email, mdp, adresse, cp, ville, pays, numSIRET, statut, etat, role) values (idpro, nompro, telpro, emailpro, mdppro, adressepro, cppro, villepro, payspro, numSpro, statutpro, etatpro, rolepro);
End //
Delimiter ;

Drop procedure if exists update_pro;
Delimiter //
Create procedure update_pro(idpro int, nompro varchar(50), telpro varchar(10), emailpro varchar(50), mdppro varchar(50), adressepro varchar(100), cppro varchar(5), villepro varchar(50), payspro varchar(50), numSpro varchar(50), statutpro varchar(50), typepro enum("Particulier", "Professionnel"), etatpro enum("Prospect", "Client Courant", "Client Grand Courant"), rolepro enum("Client", "Admin"))
Begin
    update clients
    set nom = nompro, tel = telpro, email = emailpro, mdp = mdppro, adresse = adressepro, cp = cppro, ville = villepro, pays = payspro, etat = etatpro, role = rolepro
    where idClient = idpro;
End //
Delimiter ;

Drop procedure if exists delete_pro;
Delimiter //
Create procedure delete_pro(idpro int)
Begin
    delete from professionnel where idClient = idpro;
End //
Delimiter ;

Drop table if exists types;
Create table if not exists types (
	idType int(11) not null auto_increment,
	libelle varchar(50) not null UNIQUE,
	primary key (idType)
) ENGINE=InnoDB, CHARSET=utf8;

Insert into types values
(1, "Autoradio"),
(2, "GPS"),
(3, "Aide à la conduite"),
(4, "Haut-parleurs"),
(5, "Kit mains-libre"),
(6, "Amplificateur");

Create or replace view vTypes (idType, libelle) as
Select idType, libelle
From types
Order by idType
Desc;

Drop trigger if exists checkTypeInsert;
Delimiter //
Create trigger checkTypeInsert
Before insert on types
For each row
Begin
	If new.libelle = (select libelle from types where libelle = new.libelle)
		Then signal sqlstate '45000'
		Set message_text = 'Ce type est déjà enregistré !';
	End if ;
End //
Delimiter ;

Drop table if exists histoTypes;
Create table if not exists histoTypes as select *, sysdate() dateHeureAction, user() user, '__________' action
From types
Where 2=0;

Alter table histoTypes
add primary key (idType, dateHeureAction);

Create or replace view vHistoTypes (idType, libelle, dateHeureAction, action) as
Select idType, libelle, date_format(dateHeureAction, '%d/%m/%Y %H:%i'), action
From histoTypes
Order by idType
Desc;

Drop trigger if exists insertType;
Delimiter //
Create trigger insertType
After insert on types
For each row
Begin
	Insert into histoTypes select *, sysdate(), user(), 'INSERT'
	From types
	Where idType = new.idType;
End //
Delimiter ;

Drop trigger if exists updateType;
Delimiter //
Create trigger updateType
Before update on types
For each row
Begin
	Insert into histoTypes select *, sysdate(), user(), 'UPDATE'
	From types
	Where idType = old.idType;
End //
Delimiter ;

Drop trigger if exists deleteType;
Delimiter //
Create trigger deleteType
Before delete on types
For each row
Begin
	Insert into histoTypes select *, sysdate(), user(), 'DELETE'
	From types
	Where idType = old.idType;
End //
Delimiter ;

Drop table if exists produits;
Create table if not exists produits (
    idProduit int(11) not null auto_increment,
    nomProduit varchar(150) not null UNIQUE,
    imageProduit varchar(255),
    descriptionProduit longtext,
    qteProduit int(3) not null,
    prixProduit decimal(6,2) not null,
    idType int(11) not null,
    date_ajout datetime not null,
    primary key (idProduit),
    foreign key (idType) references types (idType)
    on update cascade
    on delete cascade
) ENGINE=InnoDB, CHARSET=utf8;

Insert into produits values
(1, "TOKAI LAR-15B", "TOKAI_LAR-15B.jpg", "Téléphonie mais-libre via Bluetooth.", 22, 19.99, 1, sysdate()),
(2, "PIONEER MVH-S110UB", "PIONEER_MVH-S110UB.jpg", "Contrôle de l'autoratio à partir d'un smartphone.", 25, 39.99, 1, sysdate()),
(3, "SONY WX-920BT", "SONY_WX-920BT.jpg", "Téléphonie mains-libre via Bluetooth et commande vocal SIRI.", 30, 199.99, 1, sysdate()),
(4, "JVC KW-V420BT", "JVC_KW-V420BT.jpg", "Téléphonie mais-libre via Bluetooth et commande vocal SIRI.", 5, 399.99, 1, sysdate()),
(5, "MAPPY ULTI E538", "MAPPY_ULTI_E538.jpg", "Limitation de vitesse et mode de visualisation Realview.", 3, 79.99, 2, sysdate()),
(6, "GARMIN DRIVE 51 LMT-S SE", "GARMIN_DRIVE_51_LMT-S_SE.jpg", "Alerte les zonnes de danger et carte de l'Europe (15 pays) gratuits à vie.", 5, 129.99, 2, sysdate()),
(7, "POIDS LOURD SNOOPER PL6600", "POIDS_LOURD_SNOOPER_PL6600.jpg", "Guidage prenant en compte le gabarit.", 7, 599.0, 2, sysdate()),
(8, "PIONEER AVIC-F88DAB", "PIONEER_AVIC-F88DAB.jpg", "Carte de l'Europe (45 pays) et info trafic, compatible avec AppleCartPay et Android Auto.", 8, 1299, 2, sysdate()),
(9, "CAMERA DE RECUL BEEPER RWEC100X-RF", "CAMERA_DE_RECUL_BEEPER_RWEC100X-RF.jpg", "Angle de vue 140° horizontale.", 9, 199.99, 3, sysdate()),
(10, "CAMERA DE RECUL BEEPER RWEC200X-BL", "CAMERA_DE_RECUL_BEEPERRWEC200X-BL.jpg", "Angle de vue 140° horizontale.", 10, 359.99, 3, sysdate()),
(11, "CAMERA EMBARQUEE NEXTBASE NBDVR-101 HD", "CAMERA_EMBARQUEE_NEXTBASE_NBDVR-101_HD.jpg", "Angle de vue 120°, sortie audio AV et microphone intégré.", 11, 89.99, 3, sysdate()),
(12, "CAMERA DE RECUL + ECRAN BEEPER RW037-P", "CAMERA_DE_RECUL_+_ECRAN_BEEPER_RW037-P.jpg", "Angle de vue 150° horizontale.", 12, 89.99, 3, sysdate()),
(13, "PIONEER Ts-13020 I", "PIONEER_Ts-13020_I.jpg", "Diamètre de 13 cm et puissace de 130 Watts.", 13, 22.99, 4, sysdate()),
(14, "FOCAL 130 AC", "FOCAL_130_AC.jpg", "Diamètre de 13 cm et puissace de 100 Watts.", 14, 89.99, 4, sysdate()),
(15, "MTX T6S652", "MTX_T6S652.jpg", "Diamètre de 16.5 cm et puissance de 400 Watts.", 15, 129.99, 4, sysdate()),
(16, "FOCAL PS 165 F3", "FOCAL_PS_165_F3.jpg", "Diamètre de 16.5 cm et puissance de 160 Watts.", 16, 399, 4, sysdate()),
(17, "SUPERTOOTH BUDDY NOIR", "SUPERTOOTH_BUDDY_NOIR.jpg", "Connexion simultanéé de 2 téléphones, reconnexion automatique au téléphone.", 17, 35.99, 5, sysdate()),
(18, "PARROT NEO 2 HD", "PARROT_NEO_2_HD.jpg", "Connexion simultanéé de 2 téléphones, applications smartphones dédiées avec fonctions exclusives.", 18, 79.99, 5, sysdate()),
(19, "PARROT MKI9200", "PARROT_MKI9200.jpg", "Diffusion vocale et musicale sur les Haut-parleurs, télécommande sans fil positionnable au volant, connexion simultanée de 2 téléphones.", 19, 249, 5, sysdate()),
(20, "PARROT MKI9000", "PARROT_MKI9000.jpg", "Diffusion vocale et musicale sur les Haut-parleurs, connexion simultanée de 2 téléphones, conversations de qualité grâce aux doubles microphones.", 20, 169.99, 5, sysdate()),
(21, "MTX RFL4001D", "MTX_RFL4001D.jpg", "Puissance maximale de 12 000 W, dimensions en cm : 20.4 x 62.6 x 5.9", 21, 999, 6, sysdate()),
(22, "JBL GX-A3001", "JBL_GX-A3001.jpg", "Puissance maximale de 415 W, dimensions en cm : 10.8 x 33.6 x 25", 22, 149.99, 6, sysdate()),
(23, "MTX TR275", "MTX_TR275.jpg", "Puissance de 660 W, dimensions en cm : 14.2 x 13.4 x 5.1", 23, 275, 6, sysdate()),
(24, "CALIBEER CA75.2", "CALIBEER_CA75.2.jpg", "Puissance maximale de 150 W, dimensions en cm : 3.8 x 7.8 x 10", 24, 42.99, 6, sysdate());

Create or replace view vProduits (idProduit, nomProduit, imageProduit, descriptionProduit, qteProduit, prixProduit, libelle, date_ajout) as
Select p.idProduit, p.nomProduit, p.imageProduit, p.descriptionProduit, p.qteProduit, p.prixProduit, t.libelle, date_format(date_ajout, '%d/%m/%Y %H:%i')
From produits p, types t
Where p.idType = t.idType
Order by idProduit
Desc;

Drop trigger if exists verifPrixInsert;
Delimiter //
Create trigger verifPrixInsert
Before insert on produits
For each row
Begin
	If new.prixProduit <= 0
		Then signal sqlstate '45000'
		Set message_text = 'Impossible !';
	End if ;
End //
Delimiter ;

Drop trigger if exists verifPrixUpdate;
Delimiter //
Create trigger verifPrixUpdate
Before update on produits
For each row
Begin
	If new.prixProduit <= 0
		Then signal sqlstate '45000'
		Set message_text = 'Impossible !';
	End if ;
End //
Delimiter ;

Drop table if exists histoProduits;
Create table if not exists histoProduits as select *, sysdate() dateHeureAction, user() user, '__________' action
From produits
Where 2=0;

Alter table histoProduits
add primary key (idProduit, dateHeureAction);

Create or replace view vHistoProduits (idProduit, nomProduit, dateHeureAction, action) as
Select idProduit, nomProduit, date_format(dateHeureAction, '%d/%m/%Y %H:%i'), action
From histoProduits
Order by idProduit
Desc;

Drop trigger if exists insertProduit;
Delimiter //
Create trigger insertProduit
After insert on produits
For each row
Begin
	Insert into histoProduits select *, sysdate(), user(), 'INSERT'
	From produits
	Where idProduit = new.idProduit;
End //
Delimiter ;

Drop trigger if exists updateProduit;
Delimiter //
Create trigger updateProduit
Before update on produits
For each row
Begin
	Insert into histoProduits select *, sysdate(), user(), 'UPDATE'
	From produits
	Where idProduit = old.idProduit;
End //
Delimiter ;

Drop trigger if exists deleteProduit;
Delimiter //
Create trigger deleteProduit
Before delete on produits
For each row
Begin
	Insert into histoProduits select *, sysdate(), user(), 'DELETE'
	From produits
	Where idProduit = old.idProduit;
End //
Delimiter ;

Drop table if exists commandes;
Create table if not exists commandes (
	numCommande int(8) not null auto_increment,
	nom varchar(50) not null,
	adresse varchar(255) not null,
	cp varchar(5) not null,
	ville varchar(100) not null,
	pays varchar(50) not null,
	mode_payement varchar(50) not null,
	etatCommande varchar(100) not null,
	montantTotalHT decimal(12,2),
	montantTotalTTC decimal(12,2),
	TVA decimal(10,2),
	dateCommande date,
	dateLivraison date,
	idClient int(11) not null,
	primary key (numCommande),
	foreign key (idClient) references clients (idClient)
    on update cascade
    on delete cascade
) ENGINE=InnoDB, CHARSET=utf8;

Create or replace view vCommandes (numCommande, nom, adresse, cp, ville, pays, mode_payement, etatCommande, montantTotalHT, montantTotalTTC, TVA, dateCommande, dateLivraison, idClient) as
Select numCommande, nom, adresse, cp, ville, pays, mode_payement, etatCommande, montantTotalHT, montantTotalTTC, TVA, date_format(dateCommande, '%d/%m/%Y'), date_format(dateLivraison, '%d/%m/%Y'), idclient
From commandes
Order by numCommande
Desc;

Drop table if exists histoCommandes;
Create table if not exists histoCommandes as select *, sysdate() dateHeureAction, user() user, '__________' action
From commandes
Where 2=0;

Alter table histoCommandes
add primary key (numCommande, dateHeureAction);

Create or replace view vHistoCommandes (numCommande, nom, dateHeureAction, action) as
Select numCommande, nom, date_format(dateHeureAction, '%d/%m/%Y %H:%i'), action
From histoCommandes
Order by numCommande
Desc;

Drop table if exists panier;
Create table if not exists panier (
	numCommande int(8) not null,
	nomProduit varchar(100) not null,
	prix int(11) not null,
	quantite int(3) not null
) ENGINE=InnoDB, CHARSET=utf8;

Create or replace view vPanier (idProduit, nomProduit, prixProduit, qteProduit) as
Select idProduit, nomProduit, prixProduit, qteProduit
From produits;

Drop trigger if exists transactionInsert;
Delimiter //
Create trigger transactionInsert
After insert on panier
For each row
Begin
	Update produits
	Set qteProduit = qteProduit - new.quantite
	Where nomProduit = new.nomProduit;
End //
Delimiter ;

Drop trigger if exists transactionUpdate;
Delimiter //
Create trigger transactionUpdate
After update on panier
For each row
Begin
	Update produits
	Set qteProduit = qteProduit - new.quantite
	Where nomProduit = new.nomProduit;
End //
Delimiter ;

Drop trigger if exists transactionDelete;
Delimiter //
Create trigger transactionDelete
After delete on panier
For each row
Begin
	Update produits
	Set qteProduit = qteProduit + old.quantite
	Where nomProduit = old.nomProduit;
End //
Delimiter ;

Drop trigger if exists calculInsert;
Delimiter //
Create trigger calculInsert
After insert on panier
For each row
Begin
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
End //
Delimiter ;

Drop trigger if exists calculUpdate;
Delimiter //
Create trigger calculUpdate
Before update on panier
For each row
Begin
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
End //
Delimiter ;

Drop trigger if exists calculDelete;
Delimiter //
Create trigger calculDelete
Before delete on panier
For each row
Begin
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
End //
Delimiter ;

Drop table if exists factures;
Create table if not exists factures (
	idFacture int(11) not null auto_increment,
	dateHeureFacture datetime not null,
	idClient int(11) not null,
	idProduit int(11) not null,
	numCommande int(8) not null,
	primary key (idFacture),
	foreign key (idClient) references clients (idClient)
	on update cascade
	on delete cascade,
	foreign key (idProduit) references produits (idProduit)
	on update cascade
	on delete cascade,
	foreign key (numCommande) references commandes (numCommande)
	on update cascade
	on delete cascade
) ENGINE=InnoDB, CHARSET=utf8;

Create or replace view vFactures (idFacture, dateHeureFacture, nom, email, adresse, cp, ville, pays, nomProduit, prixProduit, montantTotalHT, montantTotalTTC, TVA) as
Select f.idFacture, date_format(f.dateHeureFacture, '%d/%m/%Y %H:%i'), c.nom, c.email, c.adresse, c.cp, c.ville, c.pays, p.nomProduit, p.prixProduit, co.montantTotalHT, co.montantTotalTTC, co.TVA
From factures f inner join clients c
on f.idClient = c.idClient
inner join produits p
on f.idProduit = p.idProduit
inner join commandes co
on f.numCommande = co.numCommande
Group by f.idFacture;

Drop table if exists messages;
Create table if not exists messages (
    idMessage int(11) not null auto_increment,
    id_exp int(11) not null,
    id_dest int(11) not null,
    date_envoi datetime,
    contenu longtext,
    lu int not null default 0,
    primary key (idMessage, id_exp, id_dest),
    foreign key (id_exp) references clients (idClient)
    on update cascade
    on delete cascade
) ENGINE=InnoDB, CHARSET=utf8;

Create or replace view vMessages (idMessage, id_exp, id_dest, date_envoi, contenu, lu) as
Select m2.idMessage, a.nom, b.nom, date_format(m1.date_envoi, '%d/%m/%Y %H:%i'), m2.contenu, m2.lu
From clients a, clients b, messages m1, messages m2
Where m1.id_exp = a.idClient and m2.id_dest = b.idClient and m1.date_envoi = m2.date_envoi;

Drop table if exists admin;
Create table admin (
    idadmin int(11) not null auto_increment,
    mail varchar(50) UNIQUE,
    mdp varchar(100),
    droit int not null default 0,
    primary key (idadmin)
) ENGINE=InnoDB;

Insert into admin values
(null, "admin@gmail.com", "107d348bff437c999a9ff192adcb78cb03b8ddc6", 1);

Drop table if exists compteur;
Create table compteur (
    idcompteur int(11) not null auto_increment,
    libelle varchar(255),
    nombre int not null default 0,
    primary key (idcompteur)
) ENGINE=InnoDB;

Insert into compteur values
(1, "Nombre de clients", 6),
(2, "Nombre de clients particulier", 1),
(3, "Nombre de clients professionnel", 0),
(4, "Nombre de types", 6),
(5, "Nombre de produits", 24),
(6, "Nombre de commandes", 0);

Drop trigger if exists countClientsInsert;
Delimiter //
Create trigger countClientsInsert
After insert on clients
For each row
Begin
    update compteur
    set nombre = nombre + 1
    where idcompteur = 1;
End //
Delimiter ; 

Drop trigger if exists countClientsDelete;
Delimiter //
Create trigger countClientsDelete
After delete on clients
For each row
Begin
    update compteur
    set nombre = nombre - 1
    where idcompteur = 1;
End //
Delimiter ; 

Drop trigger if exists countClientsPartInsert;
Delimiter //
Create trigger countClientsPartInsert
After insert on particulier
For each row
Begin
    update compteur
    set nombre = nombre + 1
    where idcompteur = 2;
End //
Delimiter ; 

Drop trigger if exists countClientsPartDelete;
Delimiter //
Create trigger countClientsPartDelete
After delete on particulier
For each row
Begin
    update compteur
    set nombre = nombre - 1
    where idcompteur = 2;
End //
Delimiter ; 

Drop trigger if exists countClientsProInsert;
Delimiter //
Create trigger countClientsProInsert
After insert on professionnel
For each row
Begin
    update compteur
    set nombre = nombre + 1
    where idcompteur = 3;
End //
Delimiter ; 

Drop trigger if exists countClientsProInsert;
Delimiter //
Create trigger countClientsProInsert
After delete on professionnel
For each row
Begin
    update compteur
    set nombre = nombre - 1
    where idcompteur = 3;
End //
Delimiter ; 

Drop trigger if exists countTypesInsert;
Delimiter //
Create trigger countTypesInsert
After insert on types
For each row
Begin
    update compteur
    set nombre = nombre + 1
    where idcompteur = 4;
End //
Delimiter ; 

Drop trigger if exists countTypesDelete;
Delimiter //
Create trigger countTypesDelete
After delete on types
For each row
Begin
    update compteur
    set nombre = nombre - 1
    where idcompteur = 4;
End //
Delimiter ; 

Drop trigger if exists countProduitsInsert;
Delimiter //
Create trigger countProduitsInsert
After insert on produits
For each row
Begin
    update compteur
    set nombre = nombre + 1
    where idcompteur = 5;
End //
Delimiter ; 

Drop trigger if exists countProduitsDelete;
Delimiter //
Create trigger countProduitsDelete
After delete on produits
For each row
Begin
    update compteur
    set nombre = nombre - 1
    where idcompteur = 5;
End //
Delimiter ; 

Drop trigger if exists countCommandesInsert;
Delimiter //
Create trigger countCommandesInsert
After insert on commandes
For each row
Begin
    update compteur
    set nombre = nombre + 1
    where idcompteur = 6;
End //
Delimiter ; 

Drop trigger if exists countCommandesDelete;
Delimiter //
Create trigger countCommandesDelete
After delete on commandes
For each row
Begin
    update compteur
    set nombre = nombre - 1
    where idcompteur = 6;
End //
Delimiter ; 

Drop procedure if exists countFromTable;
Delimiter //
Create procedure countFromTable(in nomTable varchar(50), out nb integer)
Begin
    declare cmd varchar(255);
    set @requete = concat('SELECT count(*) into @resultat FROM ', nomTable);
    prepare cmd from @requete;
    execute cmd;
    deallocate prepare cmd;
    set nb = @resultat;
End //
Delimiter ;

set @value = 0;
call countFromTable('clients', @value);
select @value;

Drop procedure if exists selectFromTable;
Delimiter //
Create procedure selectFromTable(in nomTable varchar(50))
Begin
    declare cmd varchar(255);
    set @requete = concat('SELECT * FROM ', nomTable, ' \G ');
    prepare cmd from @requete;
    execute cmd;
    deallocate prepare cmd;
End //
Delimiter ;

call selectFromTable('clients') \G;

/* PROCEDURE : SELECT WHERE ENTIER */
Drop procedure if exists selectWhereFromTableInt;
Delimiter //
Create procedure selectWhereFromTableInt(in nomTable varchar(50), in nomColonne varchar(50), in nomValeur varchar(100))
Begin
    declare cmd varchar(255);
    set @requete = concat('SELECT * FROM ', nomTable, ' WHERE ', nomColonne, ' = ', nomValeur);
    prepare cmd from @requete;
    execute cmd;
    deallocate prepare cmd;
End //

call selectWhereFromTableInt('clients', 'idClient', 1) \G;

/* PROCEDURE : SELECT WHERE STRING */
Drop procedure if exists selectWhereFromTableString;
Delimiter //
Create procedure selectWhereFromTableString(in nomTable varchar(50), in nomColonne varchar(50), in nomValeur varchar(100))
Begin
    declare cmd varchar(255);
    set @requete = concat('SELECT * FROM ', nomTable, ' WHERE ', nomColonne, '=\'' , nomValeur, '\'');
    prepare cmd from @requete;
    execute cmd;
    deallocate prepare cmd;
End //
Delimiter ;

call selectWhereFromTableString('types', 'libelle', 'GPS') \G;

Drop procedure if exists selectFromTableOptions;
Delimiter //
Create procedure selectFromTableOptions(in nomTable varchar(50), in nomColonne varchar(200), in nomColonneWhere varchar(100), in nomValeur varchar(100))
Begin
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
End //
Delimiter ;

call selectFromTableOptions('clients', '*', '', '') \G;
call selectFromTableOptions('clients', 'nom', '', '') \G;
call selectFromTableOptions('clients', '*', 'idClient', '1') \G;
-- call selectFromTableOptions('clients', '*', 'nom', 'tombruaire') \G;

Drop procedure if exists deleteFromTable;
Delimiter //
Create procedure deleteFromTable(in nomTable varchar(50), in nomColonne varchar(100), in nomValeur varchar(50))
Begin
    declare cmd varchar(255);
    set @requete = concat('DELETE FROM ', nomTable, ' WHERE ', nomColonne, '=\'', nomValeur, '\'');
    prepare cmd from @requete;
    execute cmd;
    deallocate prepare cmd;
End //
Delimiter ;

-- call deleteFromTable('clients', 'idClient', '5');

Drop procedure if exists insertOnTable;
Delimiter //
Create procedure insertOnTable(in nomTable varchar(50), in nomColonnes varchar(100), in nomValeurs varchar(255))
Begin
    declare cmd varchar(255);
    set @requete  = 
    concat('INSERT INTO ', nomTable, '(', nomColonnes, ') VALUES ( ', nomValeurs,' )');
    prepare cmd from @requete;
    execute cmd;
    deallocate prepare cmd;
End //
Delimiter ;

Drop table if exists erreurs;
Create table if not exists erreurs (
    id_erreur int(11) not null auto_increment,
    texte varchar(255) not null,
    heure datetime not null,
    primary key (id_erreur)
) ENGINE=InnoDB;

Drop procedure if exists typesInsertErreur;
Delimiter //
Create procedure typesInsertErreur (in libelle varchar(50))
Begin
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
End //
Delimiter ;

-- call typesInsertErreur('GPS45');
-- call typesInsertErreur('GP2');

Drop procedure if exists clientsInsertErreur;
Delimiter //
Create procedure clientsInsertErreur (in nom varchar(50), in tel varchar(10), in email varchar(50), in mdp varchar(50), in adresse varchar(100), in cp varchar(5), in ville varchar(100), in pays varchar(50), in etat enum("Prospect", "Client Courant", "Client Grand Courant"), in role enum("Client", "Admin"))
Begin
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
End //
Delimiter ;

-- AJOUT D'UN PARTICULIER
Insert into particulier values (null, "PART1", "Tom1", "0000000001", "tom1.particulier@gmail.com", "123", "5 rue des Particulier", "92300", "Levallois", "France", "Client Grand Courant", "Admin");

Select * from particulier \G
Select * from clients \G

-- AJOUT D'UN PROFESSIONNEL
Insert into professionnel values (null, "PRO1", "0000000004", "tom4.professionnel@gmail.com", "123", "5 rue des Professionnel", "95300", "Levallois", "France", "521 868 267 00014", "SARL", "Prospect", "Admin");

Select * from professionnel \G
Select * from clients \G

-- AJOUT D'UN PARTICULIER
Insert into particulier values (null, "PART2", "Tom2", "0000000002", "tom2.particulier@gmail.com", "123", "5 rue des Particulier", "92300", "Levallois", "France", "Client Grand Courant", "Admin");

Select * from particulier \G
Select * from clients \G

-- AJOUT D'UN PROFESSIONNEL
Insert into professionnel values (null, "PRO2", "0000000005", "tom5.professionnel@gmail.com", "123", "5 rue des Professionnel", "95300", "Levallois", "France", "521 868 267 00014", "SARL", "Prospect", "Admin");

Select * from professionnel \G
Select * from clients \G

-- AJOUT D'UN PARTICULIER
Insert into particulier values (null, "PART3", "Tom2", "0000000003", "tom3.particulier@gmail.com", "123", "5 rue des Particulier", "92300", "Levallois", "France", "Client Grand Courant", "Admin");

Select * from particulier \G
Select * from clients \G

Insert into professionnel values (null, "PRO3", "0000000006", "tom6.professionnel@gmail.com", "123", "5 rue des Professionnel", "95300", "Levallois", "France", "521 868 267 00014", "SARL", "Prospect", "Admin");

Select * from professionnel \G
Select * from clients \G

Drop table if exists commentaires;
Create table if not exists commentaires (
    idCom int(11) not null auto_increment,
    idProduit int(11) not null,
    idClient int(11) not null,
    contenu varchar(255) not null,
    client_id int(11) not null,
    dateHeurePost datetime not null,
    primary key (idCom),
    foreign key (idProduit) references produits (idProduit)
    on update cascade
    on delete cascade,
    foreign key (idClient) references clients (idClient)
    on update cascade
    on delete cascade
) ENGINE=InnoDB, CHARSET=utf8;

Insert into commentaires values
(1, 1, 1, "Commentaire produit TOKAI LAR-15B", 1, sysdate()),
(2, 2, 1, "Commentaire produit PIONEER MVH-S110UB", 1, sysdate()),
(3, 3, 1, "Commentaire produit SONY WX-920BT", 1, sysdate()),
(4, 4, 1, "Commentaire produit JVC KW-V420BT", 1, sysdate()),
(5, 1, 2, "Commentaire produit TOKAI LAR-15B 2", 2, sysdate());

Create or replace view vCommentaires (idCom, idProduit, idClient, contenu, client_id, dateHeurePost) as
Select co.idCom, p.idProduit, cl.nom, co.contenu, co.client_id, date_format(co.dateHeurePost, '%d/%m/%Y %H:%i')
From commentaires co inner join produits p
on co.idProduit = p.idProduit
inner join clients cl
on co.idClient = cl.idClient
Group by co.idCom;

Select * from vCommentaires;

Create or replace view TP (libelle, nomProduit) as
select t.libelle, p.nomProduit
from types t, produits p
where t.idType = p.idType
order by t.libelle;

Drop table if exists BDD;
Create table if not exists BDD (
    nom_bdd varchar(60) not null,
    nb_views int,
    nb_triggers int,
    nb_procedures int,
    nb_functions int,
    primary key (nom_bdd)
) ENGINE=InnoDB;

Drop procedure if exists statschema;
Delimiter //
Create procedure statschema (nomBdd varchar(60))
Begin
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
End //
Delimiter ;

Select * from BDD;

SELECT
    ifnull(nomProduit, 'TOTAL') NOM_PRODUIT,
    SUM(IF(libelle='Autoradio', prixProduit, NULL)) AS 'Autoradio',
    SUM(IF(libelle='GPS', prixProduit, NULL)) AS 'GPS',
    SUM(IF(libelle='Aide à la conduite', prixProduit, NULL)) AS 'Aide à la conduite',
    SUM(IF(libelle='Haut-parleurs', prixProduit, NULL)) AS 'Haut-parleurs',
    SUM(IF(libelle='Kit mains-libre', prixProduit, NULL)) AS 'Kit mains-libre',
    SUM(IF(libelle='Amplificateur', prixProduit, NULL)) AS 'Amplificateurs'
FROM vProduits
GROUP BY nomProduit with rollup;
-- OU
SELECT
    ifnull(nomProduit, 'TOTAL') NOM_PRODUIT,
    SUM(IF(libelle='Autoradio', prixProduit, "")) AS 'Autoradio',
    SUM(IF(libelle='GPS', prixProduit, "")) AS 'GPS',
    SUM(IF(libelle='Aide à la conduite', prixProduit, "")) AS 'Aide à la conduite',
    SUM(IF(libelle='Haut-parleurs', prixProduit, "")) AS 'Haut-parleurs',
    SUM(IF(libelle='Kit mains-libre', prixProduit, "")) AS 'Kit mains-libre',
    SUM(IF(libelle='Amplificateur', prixProduit, "")) AS 'Amplificateurs'
FROM vProduits
GROUP BY nomProduit with rollup;

Create or replace view vstatproduits as
SELECT
    ifnull(nomProduit, 'TOTAL') NOM_PRODUIT,
    SUM(IF(libelle='Autoradio', prixProduit, "")) AS 'Autoradio',
    SUM(IF(libelle='GPS', prixProduit, "")) AS 'GPS',
    SUM(IF(libelle='Aide à la conduite', prixProduit, "")) AS 'Aide à la conduite',
    SUM(IF(libelle='Haut-parleurs', prixProduit, "")) AS 'Haut-parleurs',
    SUM(IF(libelle='Kit mains-libre', prixProduit, "")) AS 'Kit mains-libre',
    SUM(IF(libelle='Amplificateur', prixProduit, "")) AS 'Amplificateurs'
FROM vProduits
GROUP BY nomProduit with rollup;

Select * from vstatproduits;

Drop function if exists email_existe;
Delimiter //
Create function email_existe(newemail varchar(50))
returns int
Begin
    select count(*) from clients where email = newemail into @result;
    return @result;
End //
Delimiter ;

Drop trigger if exists valide_insertion;
Delimiter //
Create trigger valide_insertion
Before insert on clients
For each row
Begin
    if email_existe(new.email)
        then signal sqlstate '45000'
        set message_text = 'Impossible !';
    end if ;
End //
Delimiter ;

call statschema('filelec');

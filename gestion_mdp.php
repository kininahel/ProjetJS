<?php

if (isset($_GET['section'])) {
	$section = $_GET['section'];
} else {
	$section = null;
}

if (isset($_POST['recupmdp'])) {
	$recupemail = $_POST['recupemail'];
	if ($recupemail != "") {
		if (filter_var($recupemail, FILTER_VALIDATE_EMAIL)) {
			$unControleur->setTable("clients");
			$where1 = array("email"=>$recupemail);
			$unClient = $unControleur->selectWhere($where1);
			if ($unClient == 0) {
				$erreur = "Adresse email incorrecte !";
			} else {
				$email = $unClient['email'];
				$_SESSION['recupemail'] = $recupemail;
				$recupcode = "";
				for ($i=0; $i<8; $i++) {
					$recupcode .= mt_rand(0,9);
				}
				$unControleur->setTable("recuperation");
				$where1 = array("email"=>$recupemail);
				$recupemail_exist = $unControleur->selectWhereRowCount($where1);
				if ($recupemail_exist == 1) {
					$unControleur->setTable("recuperation");
					$where2 = array("email"=>$recupemail);
					$tab = array("code"=>$recupcode);
					$recupupdate =  $unControleur->edit($tab, $where2);
				} else {
					$unControleur->setTable("recuperation");
					$tab = array(
						"email"=>$recupemail,
						"code"=>$recupcode,
						"confirme"=>0
					);
					$recupinsert = $unControleur->insert($tab);
				}

				$header = "MIME-Version: 1.0\r\n";
				$header .= 'From: "Filelec"<t.bruaire@gmail.com>'."\n";
				$header .= 'Content-Type:text/html; charset="utf-8"'."\n";
				$header .= 'Content-Transfer-Encoding: 8bit';

				$message = '
                <!DOCTYPE html>
                <html>
                <head>
                	<meta carset="utf-8">
                </head>
                <body>
                <h2>Bonjour <b>'.$email.'</b>,</h2><br>
                <p>Voici code récupération est : <b>'.$recupcode.'</b></p>
                </body>
                </html>
                ';

				mail($recupemail, "Rénitialisation du mot de passe", $message, $header);
				//header('Location: recuperation-mdp?section=code');
			}
		} else {
			$erreur = "Format de l'adresse email invalide !";
		}
	} else {
		$erreur = "Veuillez saisir votre adresse email.";
	}
}

if (isset($_POST['verif_submit'])) {
	$verif_code = $_POST['verif_code'];
	if ($verif_code != "") {
		$unControleur->setTable("recuperation");
		$where3 = array("email"=>$_SESSION['recupemail'], "code"=>$verif_code);
		$success = $unControleur->selectWhere($where3);
		if ($success == 0) {
			$erreur = "Code de vérification invalide !";
		} else {
			$unControleur->setTable("recuperation");
			$where4 = array("email"=>$_SESSION['recupemail']);
			$tab = array("confirme"=>1);
			$unControleur->edit($tab, $where4);
			header('Location: recuperation-mdp?section=changemdp');
		}
	} else {
		$erreur = "Veuillez saisir votre code de vérification !";
	}
}

if (isset($_POST['newmotdepasse'])) {
	$unControleur->setTable("recuperation");
	$where5 = array("email"=>$_SESSION['recupemail']);
	$verif_confirme = $unControleur->selectWhere($where5);
	if ($verif_confirme['confirme'] == 1) {
		$newmdp = sha1($_POST['newmdp']);
		$newmdp2 = sha1($_POST['newmdp2']);
		if ($newmdp != "") {
			if ($newmdp2 != "") {
				if ($newmdp == $newmdp2) {
					$unControleur->setTable("clients");
					$where6 = array("email"=>$_SESSION['recupemail']);
					$tab = array("mdp"=>$newmdp);
					$unControleur->edit($tab, $where6);
					$unControleur->setTable("recuperation");
					$where7 = array("email"=>$_SESSION['recupemail']);
					$unControleur->delete($where7);
					// DECONNEXION DU CLIENT
					unset($_SESSION['idClient']);
					session_destroy();
					// REDIRECTION
					echo "<script>
						alert('Votre mot de passe a bien été modifié !');
						window.location.href='connexion';
					</script>";
				} else {
					$erreur = "Les mots de passes ne correspondent pas !";
				}
			} else {
				$erreur = "Veuillez confirmer votre mot de passe !";
			}
		} else {
			$erreur = "Veuillez saisir un mot de passe !";
		}
	} else {
		$erreur = "";
	}
}

require_once("vue/recuperation-mdp.php");

?>
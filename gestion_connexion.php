<?php

if (isset($_POST['nbTentatives'])) {
 	$nbTentatives = $_POST['nbTentatives'];
} else {
 	$nbTentatives = 0;
}

if (isset($_POST['Connexion'])) {
	$unControleur->setTable("clients");
	$email = $_POST['email'];
	$mdp = sha1($_POST['mdp']);
	if ($email != "") {
		if ($mdp != "") {
			$where1 = array("email"=>$email);
			$checkEmail = $unControleur->selectWhere($where1);
			if ($checkEmail) {
				$where = array("email"=>$email, "mdp"=>$mdp);
				$unClient = $unControleur->selectWhere($where); 
				if (isset($unClient['idClient'])) {
						if (isset($_POST['remember-me'])) { // Si la checkbox "Se souvenir de moi" est cochée
                        	setcookie('email', $email, time() + 365*24*3600, null, null, false, true);
                        	setcookie('mdp', $mdp, time() + 365*24*3600, null, null, false, true);
                    	}
						$_SESSION['idClient'] = $unClient['idClient'];
						$_SESSION['nom'] = $unClient['nom'];
						$_SESSION['email'] = $unClient['email'];
						$_SESSION['tel'] = $unClient['tel'];
						$_SESSION['adresse'] = $unClient['adresse'];
						$_SESSION['cp'] = $unClient['cp'];
						$_SESSION['ville'] = $unClient['ville'];
						$_SESSION['pays'] = $unClient['pays'];
						$_SESSION['role'] = $unClient['role'];
						header('Location: /filelec/');
				} else {
					$erreur = "Veuillez vérifier vos identifiants !";
					$nbTentatives ++;
					if ($nbTentatives > 2) {
						$unControleur->setActif(0, $email);
						$nbTentatives = 0;
					}
				}
			} else {
				$erreur = "Adresse email incorrecte.";
			}
		} else {
			$erreur = "Veuillez saisir votre mot de passe.";
		}
	} else {
		$erreur = "Veuillez saisir votre adresse email.";
	}
}

require_once("vue/connexion.php");

?>
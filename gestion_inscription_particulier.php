<?php

if (isset($_SESSION['idClient'])) {
    header('Location: /filelec/');
    exit();
}

if (isset($_POST['InscriptionParticulier'])) {
	$unControleur->setTable("particulier");
	$nom = $_POST['nom'];
	$prenom = $_POST['prenom'];
	$tel = $_POST['tel'];
	$email = $_POST['email'];
	$mdp = $_POST['mdp'];
	$mdp2 = $_POST['mdp2'];
	$adresse = $_POST['adresse'];
	$cp = $_POST['cp'];
	$ville = $_POST['ville'];
	$pays = $_POST['pays'];
	if ($nom != "") {
		if (preg_match("#^[a-zA-Z][a-zA-Z0-9-_\.]{1,50}$#", $nom)) {
			if ($prenom != "") {
				if (preg_match("#^[a-zA-Z][a-zA-Z0-9-_\.]{1,50}$#", $prenom)) {
					$telLength = strlen($tel);
					if ($telLength <= 10) {
						$where2 = array("tel"=>$tel);
						$checkTel = $unControleur->selectWhere($where2);
						if (!$checkTel) {
							if ($email != "") {
								if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
									if (preg_match("#^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]{2,6}$#", $_POST['email'])) {
										$where3 = array("email"=>$email);
										$checkEmail = $unControleur->selectWhere($where3);
										if (!$checkEmail) {
											if ($mdp != "") {
												if (preg_match("#(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$#", $_POST['mdp'])) {
													if ($mdp == $mdp2) {
														if ($adresse != "") {
															if ($cp != "") {
																if (preg_match("#^[0-9]{5}|2[A-B][0-9]{3}$#", $cp)) {
																	if ($ville != "") {
																		if ($pays != "") {
																			if (preg_match("#^[a-zA-Z][a-zA-Z0-9-_\.]{1,50}$#", $pays)) {
																				$tab = array(
																					"nom"=>$nom,
																					"prenom"=>$prenom,
																					"tel"=>$tel,
																					"email"=>$email,
																					"mdp"=>$mdp,
																					"adresse"=>$adresse,
																					"cp"=>$cp,
																					"ville"=>$ville,
																					"pays"=>$pays,
																					"etat"=>'Prospect',
																					"role"=>'Client'
																				);
																				$unControleur->insert($tab);
																				echo '<script language="javascript">document.location.replace("connexion");</script>';
																				exit();
																			} else {
																				$erreur = "Le pays ne doit pas dépasser 50 caractères !";
																			}
																		} else {
																			$erreur = "Veuillez saisir un pays.";
																		}
																	} else {
																		$erreur = "Veuillez saisir une ville";
																	}
																} else {
																	$erreur = "Format du code postal invalide !";
																}
															} else {
																$erreur = "Veuillez saisir un code postal.";
															}
														} else {
															$erreur = "Veuillez saisir une adresse.";
														}
													} else {
														$erreur = "Les mots de passe ne correspondent pas !";
													}
												} else {
													$erreur = "Votre mot de passe doit contenir au moins 1 lettre MAJUCULE, 1 lettre minuscule, 1 chiffre et 8 caractères minimum.";
												}
											} else {
												$erreur = "Veuillez saisir un mot de passe.";
											}
										} else {
											$erreur = "Adresse email déjà utilisé.";
										}
									} else {
										$erreur = "Format de l'adresse email invalide !";
									}
								} else {
									$erreur = "Format de l'adresse email invalide !";
								}
							} else {
								$erreur = "Veuillez saisir une adresse email.";
							}
						} else {
							$erreur = "Ce numéro de téléphone est déjà utilisé !";
						}
					} else {
						$erreur = "Le numéro de téléphone ne doit pas dépasser 10 chiffres !";
					}
				} else {
					$erreur = "Le prénom ne doit pas dépasser 50 caractères !";
				}
			} else {
				$erreur = "Veuillez saisir un prénom.";
			}
		} else {
			$erreur = "Le nom ne doit pas dépasser 50 caractères !";
		}
	} else {
		$erreur = "Veuillez saisir un nom.";
	}
}
require_once("vue/inscription-particulier.php");

?>

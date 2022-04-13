<?php

if (isset($_SESSION['idClient'])) {
    header('Location: /filelec/');
    exit();
}

if (isset($_POST['InscriptionProfessionnel'])) {
	$unControleur->setTable("professionnel");
	$nom = $_POST['nom'];
	$tel = $_POST['tel'];
	$email = $_POST['email'];
	$mdp = $_POST['mdp'];
	$mdp2 = $_POST['mdp2'];
	$adresse = $_POST['adresse'];
	$cp = $_POST['cp'];
	$ville = $_POST['ville'];
	$pays = $_POST['pays'];
	$statut = $_POST['statut'];
	if ($nom != "") {
		if (preg_match("#^[a-zA-Z][a-zA-Z0-9-_\.]{1,50}$#", $nom)) {
			$telLength = strlen($tel);
			if ($telLength <= 10) {
				$where1 = array("tel"=>$tel);
				$checkTel = $unControleur->selectWhere($where1);
				if (!$checkTel) {
					if ($email != "") {
						if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
							if (preg_match("#^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]{2,6}$#", $_POST['email'])) {
								$where2 = array("email"=>$email);
								$checkEmail = $unControleur->selectWhere($where2);
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
																		if ($statut != "") {
																			if (preg_match("#^[a-zA-Z][a-zA-Z0-9-_\.]{1,50}$#", $statut)) {
																				$tab = array(
																					"nom"=>$nom,
																					"tel"=>$tel,
																					"email"=>$email,
																					"mdp"=>$mdp,
																					"adresse"=>$adresse,
																					"cp"=>$cp,
																					"ville"=>$ville,
																					"pays"=>$pays,
																					"numSIRET"=>'521 868 267 00014',
																					"statut"=>$statut,
																					"etat"=>'Prospect',
																					"role"=>'Client'
																				);
																				$unControleur->insert($tab);
																				echo '<script language="javascript">document.location.replace("connexion");</script>';
																				exit();
																			} else {
																				$erreur = "Le statut ne doit pas dépasser 50 caractères !";
																			}
																		} else {
																			$erreur = "Veuillez saisir un statut.";
																		}
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
			$erreur = "Le nom ne doit dépasser 50 caractères !";
		}
	} else {
		$erreur = "Veuillez saisir un nom.";
	}
}
require_once("vue/inscription-professionnel.php");

?>

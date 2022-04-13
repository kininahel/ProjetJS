<?php

class Modele {

	private $pdo;
	private $uneTable;

	public function __construct($hostname, $database, $username, $password) {
		$this->pdo = null;
		try {
			$this->pdo = new PDO("mysql:host=".$hostname.";dbname=".$database.";charset=utf8", $username, $password);
			$this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING);
		} catch (PDOException $e) {
			die("Erreur de connexion à la base de données : " . $e->getMessage());
		}
	}

	public function setTable($uneTable) {
		$this->uneTable = $uneTable;
	}

	public function selectAll($chaine) {
		if ($this->pdo != null) {
			$requete = "SELECT ".$chaine." FROM ".$this->uneTable;
			$select = $this->pdo->prepare($requete);
			$select->execute();
			return $select->fetchAll();
		} else {
			return null;
		}
	}

	public function selectAllMessages() {
		if ($this->pdo != null) {
			$requete = "SELECT * FROM vMessages ORDER BY date_envoi DESC";
			$select = $this->pdo->prepare($requete);
			$select->execute();
			return $select->fetchAll();
		} else {
			return null;
		}
	}

	public function selectWhere($where) {
		if ($this->pdo != null) {
			$champs = array();
			$donnees = array();
			foreach ($where as $key => $value) {
				$champs[] = $key. " = :".$key;
				$donnees[":".$key] = $value;
			}
			$chaineWhere = implode(" AND ", $champs);
			$requete = "SELECT * FROM ".$this->uneTable." WHERE ".$chaineWhere;
			$select = $this->pdo->prepare($requete);
			$select->execute($donnees);
			return $select->fetch();
		} else {
			return null;
		}
	}

	public function insert($tab) {
		if ($this->pdo != null) {
			$champs = array();
			$donnees = array();
			foreach ($tab as $key => $value) {
				$champs[] = ":".$key;
				$donnees[":".$key] = $value;
			}
			$chaine = implode(", ", $champs);
			$requete = "INSERT INTO ".$this->uneTable." VALUES (null, ".$chaine.") ";
			$insert = $this->pdo->prepare($requete);
			$insert->execute($donnees);
		} else {
			return null;
		}
	}

	public function delete($where) {
		if ($this->pdo != null) {
			$champs = array();
			$donnees = array();
			foreach ($where as $key => $value) {
				$champs[] = $key." = :".$key;
				$donnees[":".$key] = $value;
			}
			$chaine = implode(" AND ", $champs);
			$requete = "DELETE FROM ".$this->uneTable." WHERE ".$chaine;
			$delete = $this->pdo->prepare($requete);
			$delete->execute($donnees);
		} else {
			return null;
		}
	}

	public function deleteAll() {
		if ($this->pdo != null) {
			$requete = "DELETE FROM ".$this->uneTable;
			$delete = $this->pdo->prepare($requete);
			$delete->execute();
		} else {
			return null;
		}
	}

	public function edit($tab, $where) {
		if ($this->pdo != null) {
			$champs = array();
			$donnees = array();
			foreach ($tab as $key => $value) {
				$champs[] = $key." =:".$key;
				$donnees[":".$key] = $value;
			}
			$chaine = implode(", ", $champs);
			$champsWhere = array();
			foreach ($where as $key => $value) {
				$champsWhere[] = $key." =:".$key;
				$donnees[":".$key] = $value;
			}
			$chaineWhere = implode(" AND ", $champsWhere);
			$requete = "UPDATE ".$this->uneTable." SET ".$chaine." WHERE ".$chaineWhere;
			$update = $this->pdo->prepare($requete);
			$update->execute($donnees);
		} else {
			return null;
		}
	}

	public function selectSearch($mot, $tab) {
		if ($this->pdo != null) {
			$donnees = array();
			$champs = array();
			foreach ($tab as $key) {
				$champs[] = $key." LIKE :mot";
				$donnees[":mot"] = "%".$mot."%";
			}
			$chaineWhere = implode(" OR ", $champs);
			$requete = "SELECT * FROM ".$this->uneTable." WHERE ".$chaineWhere;
			$select = $this->pdo->prepare($requete);
			$select->execute($donnees);
			return $select->fetchAll();
		} else {
			return null;
		}
	}

	public function count() {
		if ($this->pdo != null) {
			$requete = "SELECT count(*) as nb FROM ".$this->uneTable;
			$select = $this->pdo->prepare($requete);
			$select->execute();
			return $select->fetch()["nb"];
		} else {
			return null;
		}
	}

	public function countWhere($where) {
		if ($this->pdo != null) {
			$champs = array();
			$donnees = array();
			foreach ($where as $key => $value) {
				$champs[] = $key. " = :".$key;
				$donnees[":".$key] = $value;
			}
			$chaineWhere = implode(" AND ", $champs);
			$requete = "SELECT count(*) as nb FROM ".$this->uneTable." WHERE ".$chaineWhere;
			$select = $this->pdo->prepare($requete);
			$select->execute($donnees);
			return $select->fetch()["nb"];
		} else {
			return null;
		}
	}

	public function getIdProduit() {
		if ($this->pdo != null) {
			$requete = "SELECT idProduit FROM produits";
			$select = $this->pdo->query($requete);
			return $select->rowCount();
		} else {
			return null;
		}
	}

	public function selectAllProduits($depart, $produitsParPage) {
		if ($this->pdo != null) {
			$requete = "SELECT * FROM produits ORDER BY idProduit LIMIT :depart, :produitsParPage";
			$select = $this->pdo->prepare($requete);
			$select->bindValue(':depart', $depart, PDO::PARAM_INT);
			$select->bindValue(':produitsParPage', $produitsParPage, PDO::PARAM_INT);
			$select->execute();
			return $select->fetchAll();
		} else {
			return null;
		}
	}

	public function selectAllCommentaires($where) {
		if ($this->pdo != null) {
			$champs = array();
			$donnees = array();
			foreach ($where as $key => $value) {
				$champs[] = $key. " = :".$key;
				$donnees[":".$key] = $value;
			}
			$chaineWhere = implode(" AND ", $champs);
			$requete = "SELECT idCom, idProduit, idClient, contenu, client_id, dateHeurePost FROM vCommentaires WHERE ".$chaineWhere. " ORDER BY idCom DESC";
			$select = $this->pdo->prepare($requete);
			$select->execute($donnees);
			return $select->fetchAll();
		} else {
			return null;
		}
	}

	public function setActif($valeur, $email) {
		if ($this->pdo != null) {
			$requete = "UPDATE clients SET lvl = :valeur WHERE email = :email";
			$update = $this->pdo->prepare($requete);
			$update->bindValue(':valeur', $valeur, PDO::PARAM_INT);
			$update->bindValue(':email', $email, PDO::PARAM_STR);
			$update->execute();
		} else {
			return null;
		}
	}

	public function auth($lvl) {
		if ($this->pdo != null) {
			if (isset($_SESSION['lvl']) && $_SESSION['lvl'] >= $lvl) {
				return true;
			} else {
				$redirection = <<<EOT
				<script type='text/javascript'>window.location.replace("/filelec/dashboard");</script>
				EOT;
				echo($redirection);
			}
		} else {
			return null;
		}
	}

	public function headerContact($title) {
		$html = "<div class='card-header' style='background-color: #ADD8E6;'>";
		$html .= "<h3 class='text-center text-dark'>";
		$html .= "<svg xmlns='http://www.w3.org/2000/svg' width='50' height='50' fill='currentColor' class='bi bi-envelope-fill' viewBox='0 0 16 16'>";
  		$html .= "<path d='M.05 3.555A2 2 0 0 1 2 2h12a2 2 0 0 1 1.95 1.555L8 8.414.05 3.555zM0 4.697v7.104l5.803-3.558L0 4.697zM6.761 8.83l-6.57 4.027A2 2 0 0 0 2 14h12a2 2 0 0 0 1.808-1.144l-6.57-4.027L8 9.586l-1.239-.757zm3.436-.586L16 11.801V4.697l-5.803 3.546z'/>";
		$html .= "</svg>";
		$html .= "</h3>";
		$html .= "<p class='text-center fw-bold fs-3'>$title</p>";
		$html .= "</div>";
		return $html;
	}

	public function input($name, $text, $type) {
		$html = "<input type='{$type}' name='{$name}' id='{$name}' placeholder='{$text}' class='form-control'>";
		return $html;
	}

	public function inputLabel($id, $text, $type) {
		$html = "<div class='mb-3'>";
		$html .= "<label for='{$id}' class='form-label'>$text</label>";
		$html .= "<input type='{$type}' name='{$id}' id='{$id}' class='form-control'>";
		$html .= "</div>";
		return $html;
	}

	public function inputContact($id, $text, $type) {
		$html = "<div class='mb-3'>";
		$html .= "<label for='{$id}' class='form-label fw-bold'>$text</label>";
		$html .= "<input type='{$type}' name='{$id}' id='{$id}' class='form-control'>";
		$html .= "</div>";
		return $html;
	}

	public function textareaContact($id, $text) {
		$html = "<div class='mb-3'>";
		$html .= "<label for='{$id}' class='form-label fw-bold'>$text</label>";
		$html .= "<textarea name='{$id}' id='{$id}' class='form-control'></textarea>";
		$html .= "</div>";
		return $html;
	}

	public function buttonsContact() {
		$html = "<div class='d-flex justify-content-center'>";
		$html .= "<button type='reset' class='btn btn-lg btn-danger me-2'>";
		$html .= "<svg xmlns='http://www.w3.org/2000/svg' width='30' height='30' fill='currentColor' class='bi bi-x' viewBox='0 0 16 16'>";
  		$html .= "<path d='M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z'/>";
		$html .= "</svg>";
		$html .= "</button>";
		$html .= "<button type='submit' name='submit' class='btn btn-lg btn-success'>";
		$html .= "<svg xmlns='http://www.w3.org/2000/svg' width='30' height='30' fill='currentColor' class='bi bi-check2' viewBox='0 0 16 16'>";
  		$html .= "<path d='M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z'/>";
		$html .= "</svg>";
		$html .= "</button>";
		$html .= "</div>";
		return $html;
	}

	public function updateProduit($imageProduit, $where) {
		if ($this->pdo != null) {
			$champs = array();
			$donnees = array();
			foreach ($where as $key => $value) {
				$champs[] = $key. " = :".$key;
				$donnees[":".$key] = $value;
			}
			$chaineWhere = implode(" AND ", $champs);
			$requete = "UPDATE produits SET imageProduit = '$imageProduit' WHERE idProduit = ".$chaineWhere;
			$update = $this->pdo->query($requete);
		} else {
			return null;
		}
	}

	public function selectClientWhereCookie() {
		if ($this->pdo != null) {
			$requete = "SELECT * FROM clients WHERE email = ? and mdp = ?";
		    $select = $this->pdo->prepare($requete);
		    $select->execute(array($_COOKIE['email'], $_COOKIE['mdp']));
		    $select->fetch();
		    return $select->rowCount();
		} else {
			return null;
		}
	}

	public function selectWhereRowCount($where) {
		if ($this->pdo != null) {
			$champs = array();
			$donnees = array();
			foreach ($where as $key => $value) {
				$champs[] = $key. " = :".$key;
				$donnees[":".$key] = $value;
			}
			$chaineWhere = implode(" AND ", $champs);
			$requete = "SELECT * FROM ".$this->uneTable." WHERE ".$chaineWhere;
			$select = $this->pdo->prepare($requete);
			$select->execute($donnees);
			$select->fetch();
			return $select->rowCount();
		} else {
			return null;
		}
	}

	public function insertProduit($nomProduit, $imageProduit, $descriptionProduit, $qteProduit, $prixProduit, $date_ajout) {
		if ($this->pdo != null) {
			$insert = $this->pdo->prepare("INSERT INTO produits (nomProduit, imageProduit, descriptionProduit, qteProduit, prixProduit, date_ajout) VALUES (:nomProduit, :imageProduit, :descriptionProduit, :qteProduit, :prixProduit, :date_ajout)");
			$insert->bindValue(':nomProduit', $nomProduit, PDO::PARAM_STR);
			$insert->bindValue(':imageProduit', $imageProduit, PDO::PARAM_STR);
			$insert->bindValue(':descriptionProduit', $descriptionProduit, PDO::PARAM_STR);
			$insert->bindValue(':qteProduit', $qteProduit, PDO::PARAM_INT);
			$insert->bindValue(':prixProduit', $prixProduit, PDO::PARAM_INT);
			$insert->bindValue(':date_ajout', $date_ajout, PDO::PARAM_STR);
			$insert->execute();
			$image_id = $insert->lastInsertId();
			$image_name = $image_id.".".$extensionUpload;
			move_uploaded_file($imageProduit['tmp_name'], "assets/images/produits/".$image_name."");
			$update = $this->pdo->prepare("UPDATE produits SET imageProduit = :imageProduit WHERE idProduit = :idProduit");
			$update->bindValue(':imageProduit', $image_name, PDO::PARAM_STR);
			$update->bindValue(':idProduit', $image_id, PDO::PARAM_INT);
			$update->execute();
		} else {
			return null;
		}
	}

}

?>

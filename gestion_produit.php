<?php

$unControleur->setTable("produits");

$produitView = 0;

if (isset($_GET['view'])) {
	$unControleur->setTable("produits");
	$produitView = 1;
	$idProduit = $_GET['view'];
	$where1 = array("idProduit"=>$idProduit);
	$leProduit = $unControleur->selectWhere($where1);
	$unControleur->setTable("commentaires");
	$where2 = array("idProduit"=>$idProduit);
	$nbCommentaires = $unControleur->countWhere($where2);
	$unControleur->setTable("vCommentaires");
	$where3 = array("idProduit"=>$idProduit);
	$lesCommentaires = $unControleur->selectAllCommentaires($where3);

	$editCom = null;

	$unControleur->setTable("commentaires");
	if (isset($_GET['action']) && isset($_GET['idCom']) && isset($_GET['idProduit'])) {
		$action = $_GET['action'];
		$idCom = $_GET['idCom'];
		$idProduit2 = $_GET['idProduit'];
		switch ($action) {
			case 'delete': // SUPPRESSION DU COMMENTAIRE
				$where4 = array(
					"idCom"=>$idCom, 
					"idProduit"=>$idProduit2, 
					"idClient"=>$_SESSION['idClient'],
					"client_id"=>$_SESSION['idClient']
				);
				$unControleur->setTable("commentaires");
				$unControleur->delete($where4);
				$redirection = <<<EOT
				<script type='text/javascript'>window.location.replace("produit?view=$idProduit2");</script>
				EOT;
				echo($redirection);
				break;
			case 'edit': // ÉDITION DU COMMENTAIRE
				$where5 = array(
					"idCom"=>$idCom, 
					"idProduit"=>$idProduit2, 
					"idClient"=>$_SESSION['idClient']
				);
				$editCom = $unControleur->selectWhere($where5);
				break;
		}
	}

	if (isset($_POST['Edit'])) {
		$unControleur->setTable("commentaires");
		$whereEdit = array(
			"idCom"=>$idCom, 
			"idProduit"=>$idProduit2, 
			"idClient"=>$_SESSION['idClient'],
			"client_id"=>$_SESSION['idClient'],
		);
		$tab = array(
			"contenu"=>$_POST['contenu'],
			"dateHeurePost"=>date("Y-m-d H:i:s", strtotime("+1 hour"))
		);
		$unControleur->edit($tab, $whereEdit);
		$redirection = <<<EOT
			<script type='text/javascript'>window.location.replace("produit?view=$idProduit");</script>
		EOT;
		echo($redirection);
	}

	if (isset($_POST['Poster'])) {
		$unControleur->setTable("commentaires");
		$tab = array(
			"idProduit"=>$idProduit,
			"idClient"=>$_SESSION['idClient'],
			"contenu"=>$_POST['contenu'],
			"clien_id"=>$_SESSION['idClient'],
			"dateHeurePost"=>date("Y-m-d H:i:s", strtotime("+1 hour"))
		);
		$unControleur->insert($tab);
		$redirection = <<<EOT
		<script type='text/javascript'>window.location.replace("produit?view=$idProduit");</script>
		EOT;
		echo($redirection);
	}

}

require_once("vue/produit.php");

?>
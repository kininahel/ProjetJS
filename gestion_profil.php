<?php
if (isset($_SESSION['idClient'])) {

	$leClient = null;

	$unControleur->setTable("clients");

	if (isset($_GET['action']) && isset($_GET['idClient'])) {
		$action = $_GET['action'];
		$idClient = $_GET['idClient'];
		$where = array("idClient"=>$idClient);
		switch ($action) {
			case 'edit':
				$leClient = $unControleur->selectWhere($where);
				break;
		}
	}

	require_once("vue/profil.php");

	if (isset($_POST['Modifier'])) {
		$unControleur->setTable("clients");
		$tab = array(
			"nom"=>$_POST['nom'],
			"tel"=>$_POST['tel'],
			"email"=>$_POST['email'],
			"mdp"=>$_POST['mdp'],
			"adresse"=>$_POST['adresse'],
			"cp"=>$_POST['cp'],
			"ville"=>$_POST['ville'],
			"pays"=>$_POST['pays']
		);
		$where = array("idClient"=>$_POST['idClient']);
		$unControleur->edit($tab, $where);
		echo '<script language="javascript">document.location.replace("deconnexion");</script>';
	}

	if (isset($_POST['Supprimer'])) {
		$where = array("email"=>$_POST['email'], "mdp"=>sha1($_POST['mdp']));
		$unClient = $unControleur->selectWhere($where);
		if (isset($unClient['email'])) {
			$unControleur->delete($where);
			echo '<script language="javascript">document.location.replace("deconnexion");</script>';
		}
	}

} else {
	header('Location: /filelec/');
}
?>
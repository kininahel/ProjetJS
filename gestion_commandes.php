<?php

$conn = mysqli_connect("localhost", "root", "", "filelec");

if (isset($_SESSION['idClient'])) {

	if ($_SERVER['REQUEST_METHOD'] == "POST") {

		if (isset($_POST['payement'])) {

			$unControleur->setTable("commandes");

			$requete1 = "INSERT INTO commandes (nom, adresse, cp, ville, pays, mode_payement, etatCommande, montantTotalHT, montantTotalTTC, TVA, dateCommande, dateLivraison, idClient) VALUES ('$_POST[nom]', '$_POST[adresse]', '$_POST[cp]', '$_POST[ville]', '$_POST[pays]', '$_POST[mode_payement]', 'En cours de préparation...', 0, 0, 0, CURDATE(), '2022-02-28', '$_POST[idClient]')";

			/*
			$unControleur->setTable("factures");

			$tab = array(
				"dateHeureFacture"=>date("Y-m-d H:i:s", strtotime("+1 hour")),
				"idClient"=>$_SESSION['idClient'],
				"idProduit"=>,
				"numCommande"=>mysqli_insert_id($requete1)
			);
			$unControleur->insert($tab);
			*/

			if (mysqli_query($conn, $requete1)) {
				$numCommande = mysqli_insert_id($conn);
				$requete2 = "INSERT INTO panier (numCommande, nomProduit, prix, quantite) VALUES (?,?,?,?)";
				$stmt = mysqli_prepare($conn, $requete2);
				if ($stmt) {
					mysqli_stmt_bind_param($stmt, "isii", $numCommande, $nomProduit, $prix, $quantite);
					foreach ($_SESSION['panier'] as $key => $values) {
						$nomProduit = $values['nomProduit'];
						$prix = $values['prixProduit'];
						$quantite = $values['qteProduit'];
						mysqli_stmt_execute($stmt);
					}
					unset($_SESSION['panier']);
					header('Location: commandes');
				}
			}
		}

		if (isset($_POST['Annuler'])) {
			$numCommande = $_POST['numCommande'];
			$where1 = array("numCommande"=>$numCommande);
			$where2 = array("numCommande"=>$numCommande);
			$unControleur->setTable("commandes");
			$unControleur->delete($where1);
			$unControleur->setTable("panier");
			$unControleur->delete($where2);
			header('Location: commandes');
		}

	}

	require_once("vue/commandes.php");

} else {
	header('Location: connexion');
}

?>

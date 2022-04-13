<?php

if (isset($_SESSION['idClient'])) {

	if ($_SERVER['REQUEST_METHOD'] == "POST") {
/* $_SERVER['REQUEST_METHOD'] : Méthode de la requête utilisée pour accéder à la page (== "POST") */

		if (isset($_POST['Ajouter'])) {
			if (isset($_SESSION['panier'])) {
				$mesArticles = array_column($_SESSION['panier'], 'nomProduit');
				if (in_array($_POST['nomProduit'], $mesArticles)) {
					echo "<script>
						alert('Produit déjà ajouté dans le panier');
						window.location.href='produits';
					</script>";
				} else {
					$count = count($_SESSION['panier']);
					$_SESSION['panier'][$count] = array(
						'idProduit'=>$_POST['idProduit'],
						'nomProduit'=>$_POST['nomProduit'],
						'prixProduit'=>$_POST['prixProduit'],
						'qteProduit'=>$_POST['qteProduit']
					);
				}
			} else {
				$_SESSION['panier'][0] = array(
					'idProduit'=>$_POST['idProduit'],
					'nomProduit'=>$_POST['nomProduit'],
					'prixProduit'=>$_POST['prixProduit'],
					'qteProduit'=>$_POST['qteProduit']
				);
				header('Location: panier');
			}
		}

		if (isset($_POST['Supprimer'])) {
			foreach ($_SESSION['panier'] as $key => $value) {
				if ($value['nomProduit'] == $_POST['nomProduit']) {
					unset($_SESSION['panier'][$key]);
					$_SESSION['panier'] = array_values($_SESSION['panier']);
					header('Location: panier');
				}
			}
		}

		if (isset($_POST['ModifierQte'])) {
			foreach ($_SESSION['panier'] as $key => $value) {
				if ($value['nomProduit'] == $_POST['nomProduit']) {
					$_SESSION['panier'][$key]['qteProduit'] = $_POST['ModifierQte'];
					header('Location: panier');
				}
			}
		}

	}

	require_once("vue/panier.php");

} else {
	header('Location: connexion');
}

?>
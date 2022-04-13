<?php

$produitsParPage = 8;

$produitsTotales = $unControleur->getIdProduit();

$pagesTotales = ceil($produitsTotales / $produitsParPage);

if (isset($_GET['p']) and !empty($_GET['p']) and $_GET['p'] > 0) {
	$_GET['p'] = intval($_GET['p']);
	$pageCourante = $_GET['p'];
} else {
	$pageCourante = 1;
}

$pagePrecedente = $pageCourante - 1;

$pageSuivante = $pageCourante + 1;

$depart = ($pageCourante-1) * $produitsParPage;

$unControleur->setTable("produits");

if (isset($_POST['Rechercher'])) {
	$mot = $_POST['mot'];
	$tab = array("nomProduit", "prixProduit");
	$lesProduits = $unControleur->selectSearch($mot, $tab);
	if (!$lesProduits) {
		$erreur = "Aucun résultat";
		if (isset($_POST['Refesh'])) {
			header('Location: produits');
		}
	}
} else {
	$lesProduits = $unControleur->selectAllProduits($depart, $produitsParPage);
}

require_once("vue/produits.php");

?>
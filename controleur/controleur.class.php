<?php

require_once("modele/modele.class.php");

class Controleur {

	private $unModele;

	public function __construct($hostname, $database, $username, $password) {
		$this->unModele = new Modele($hostname, $database, $username, $password);
	}

	public function setTable($uneTable) {
		$this->unModele->setTable($uneTable);
	}

	public function selectAll($chaine = "*") {
		return $this->unModele->selectAll($chaine);
	}

	public function selectAllMessages() {
		return $this->unModele->selectAllMessages();
	}

	public function selectWhere($where) {
		return $this->unModele->selectWhere($where);
	}

	public function insert($tab) {
		$this->unModele->insert($tab);
	}

	public function delete($where) {
		$this->unModele->delete($where);
	}

	public function deleteAll() {
		$this->unModele->deleteAll();
	}

	public function edit($tab, $where) {
		$this->unModele->edit($tab, $where);
	}

	public function selectSearch($mot, $tab) {
		return $this->unModele->selectSearch($mot, $tab);
	}

	public function count() {
		return $this->unModele->count();
	}

	public function countWhere($where) {
		return $this->unModele->countWhere($where);
	}

	public function getIdProduit() {
		return $this->unModele->getIdProduit();
	}

	public function selectAllProduits($depart, $produitsParPage) {
		return $this->unModele->selectAllProduits($depart, $produitsParPage);
	}

	public function selectAllCommentaires($where) {
		return $this->unModele->selectAllCommentaires($where);
	}

	public function setActif($valeur, $email) {
		$this->unModele->setActif($valeur, $email);
	}

	public function auth($lvl) {
		$this->unModele->auth($lvl);
	}

	public function headerContact($title) {
		return $this->unModele->headerContact($title);
	}

	public function input($name, $text, $type = "text") {
		return $this->unModele->input($name, $text, $type);
	}

	public function inputLabel($id, $text, $type = "text") {
		return $this->unModele->inputLabel($id, $text, $type);
	}

	public function inputContact($id, $text, $type = "text") {
		return $this->unModele->inputContact($id, $text, $type);
	}

	public function textareaContact($id, $text) {
		return $this->unModele->textareaContact($id, $text);
	}

	public function buttonsContact() {
		return $this->unModele->buttonsContact();
	}

	public function updateProduit($imageProduit, $where) {
		$this->unModele->insertImage($imageProduit, $where);
	}

	public function selectClientWhereCookie() {
		return $this->unModele->selectClientWhereCookie();
	}

	public function selectWhereRowCount($where) {
		return $this->unModele->selectWhereRowCount($where);
	}

	public function insertProduit($nomProduit, $imageProduit, $descriptionProduit, $qteProduit, $prixProduit, $date_ajout) {
		$this->unModele->insertProduit($nomProduit, $imageProduit, $descriptionProduit, $qteProduit, $prixProduit, $date_ajout);
	}

}

?>

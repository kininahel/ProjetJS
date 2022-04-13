<?php

if (!isset($_SESSION['idClient']) and isset($_COOKIE['email'],$_COOKIE['mdp']) and !empty($_COOKIE['email']) and !empty($_COOKIE['mdp'])) {
    $unControleur->setTable("clients");
    $clientexist = $unControleur->selectClientWhereCookie();
    if ($clientexist == 1) {
        $where = array("email"=>$_COOKIE['email'], "mdp"=>$_COOKIE['mdp']);
        $unClient = $unControleur->selectWhere($where); 
        $_SESSION['idClient'] = $unClient['idClient'];
        $_SESSION['nom'] = $unClient['nom'];
        $_SESSION['prenom'] = $unClient['prenom'];
        $_SESSION['pseudo'] = $unClient['pseudo'];
        $_SESSION['email'] = $unClient['email'];
        $_SESSION['tel'] = $unClient['tel'];
        $_SESSION['adresse'] = $unClient['adresse'];
        $_SESSION['cp'] = $unClient['cp'];
        $_SESSION['ville'] = $unClient['ville'];
        $_SESSION['pays'] = $unClient['pays'];
        $_SESSION['lvl'] = $unClient['lvl'];
        echo '<script language="javascript">document.location.replace("/filelec/");</script>';
    }
}

?>
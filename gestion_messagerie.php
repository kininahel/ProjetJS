<?php

if (!isset($_SESSION['idClient'])) {
    header('Location: /filelec/connexion');
    exit();
}

$unControleur->setTable("messages");

if (isset($_GET['action']) && isset($_GET['id_exp'])) {
    $unControleur->setTable("messages");
    $action = $_GET['action'];
    $id_exp = $_GET['id_exp'];
    $where = array('id_exp'=>$id_exp);
    if ($action == 'sup') {
        $unControleur->delete($where);
        // echo '<script language="javascript">document.location.replace("messages");</script>';
    }
}

if (isset($_POST['Envoyer'])) {
    $unControleur->setTable("messages");
    $tab = array(
        "id_exp"=>$_SESSION['idClient'],
        "id_dest"=>$_POST['id_dest'],
        "date_envoi"=>date("Y-m-d H:i:s", strtotime("+1 hour")),
        "contenu"=>$_POST['contenu'],
        "lu"=>0
    );
    $unControleur->insert($tab);
    echo '<script language="javascript">document.location.replace("messages");</script>';
}

$unControleur->setTable("vMessages");
$lesMessages = $unControleur->selectAllMessages();

require_once("vue/messages.php");

?>

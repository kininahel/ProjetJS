

<div class="container">
	<div class="row">
		<div class="d-flex justify-content-center">
			<div class="col-auto text-center text-light border rounded bg-dark my-5">
				<h1>&nbsp;Mes commandes&nbsp;</h1>
			</div>
		</div>
		<?php
			$requete = "SELECT numCommande, nom, adresse, cp, ville, pays, mode_payement, etatCommande, montantTotalHT, montantTotalTTC, TVA, date_format(dateCommande, '%d/%m/%Y'), date_format(dateLivraison, '%d/%m/%Y') FROM commandes WHERE idClient = ".$_SESSION['idClient'];
			$resultat = mysqli_query($conn, $requete);
			while ($commande = mysqli_fetch_assoc($resultat)) {
		?>
		<div class="d-flex justify-content-center">
			<div class="col-auto">
				<div class="card mb-5 animate__animated animate__zoomIn">
					<div class="card-header">
						<h3 class="text-center">
							Commande n°<?= $commande['numCommande']; ?>
						</h3>
					</div>
					<div class="card-body">
                        <p class="card-text">
							<b>Nom :</b> <?= $commande['nom']; ?>
						</p>
                        <p class="card-text">
							<b>Date commande :</b> <?= $commande["date_format(dateCommande, '%d/%m/%Y')"]; ?>
						</p>
						<p class="card-text">
							<b>Adresse de livraison :</b> <?= $commande['adresse']; ?>, <?= $commande['cp']; ?> <?= $commande['ville']; ?> - <?= $commande['pays']; ?>
						</p>
						<p class="card-text">
							<b>Moyen de payement :</b> <?= $commande['mode_payement']; ?>
						</p>
						<p class="card-text">
							<table class="table text-center">
								<thead>
									<tr>
										<th scope="col">Produit(s)</th>
										<th scope="col">Prix Unitaire</th>
										<th scope="col">Quantité</th>
										<th scope="col">Prix total</th>
									</tr>
								</thead>
								<tbody>
									<?php
										$commandes = "SELECT * FROM panier WHERE numCommande = '$commande[numCommande]' ";
										$resultCommande = mysqli_query($conn, $commandes);
										while ($uneCommande = mysqli_fetch_assoc($resultCommande)) {
									?>
									<tr>
										<td><?= $uneCommande['nomProduit']; ?></td>
										<td>
											<?= number_format($uneCommande['prix'], 2, ',', ' '); ?> €
											<input type="hidden" class="iprice" value="<?= $uneCommande['prix']; ?>">
										</td>
										<td>
											<?= $uneCommande['quantite']; ?>
											<input class="text-center iquantity" type="hidden"  value="<?= $uneCommande['quantite']; ?>">
										</td>
										<td class="itotal"></td>
									</tr>
									<?php } ?>
								</tbody>
							</table>
						</p>
						<p class="card-text">
							<b>Montant total HT :</b> <?= number_format($commande['montantTotalHT'], 2, ',', ' '); ?> €
		 				</p>
		 				<p class="card-text">
							<b>Montant total TTC :</b> <?= number_format($commande['montantTotalTTC'], 2, ',', ' '); ?> €
		 				</p>
		 				<p class="card-text">
		 					<b>Etat de la commande :</b> <?= $commande['etatCommande']; ?>
		 				</p>
		 				<p class="card-text">
		 					<b>Date de livraison garantie :</b> <?= $commande["date_format(dateLivraison, '%d/%m/%Y')"]; ?>
		 				</p>
					</div>
					<div class="card-footer">
						<div class="d-flex justify-content-center">
							<form method="POST" action="commandes">
								<input type="hidden" name="numCommande" value="<?= $commande['numCommande']; ?>">
								<button type="submit" name="Annuler" onclick="return(confirm('Voulez-vous vraiment annuler cette commande ?'));" class="btn btn-danger me-2">
									Annuler la commande
								</button>
							</form>
							<a class="btn btn-primary" target="_blank" onclick="window.print();return false;">Imprimer</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<?php } ?>
	</div>
</div>

<script type="text/javascript">
    let gt = 0;
    const iprice = document.getElementsByClassName('iprice');
    const iquantity = document.getElementsByClassName('iquantity');
    const itotal = document.getElementsByClassName('itotal');
    const gtotal = document.getElementById('gtotal');

    function subTotal() {
		gt = 0;
		for (i=0; i<iprice.length; i++) {
			itotal[i].innerText = (iprice[i].value) * (iquantity[i].value) + " €";
			gt = gt + (iprice[i].value) * (iquantity[i].value);
		}
		gtotal.innerText = gt + " €";
	}

	subTotal();
</script>

<div class="container mt-4">
	<div class="row">
		<div class="d-flex justify-content-center">
			<div class="col-auto text-center border rounded bg-light my-5">
				<h1>&nbsp;Mon panier&nbsp;</h1>
			</div>
		</div>
		<div class="col-lg-8">
			<div class="card">
				<div class="card-body">
					<table class="table text-center">
						<thead>
							<tr>
								<th scope="col">Numéro</th>
								<th scope="col">Produit</th>
								<th scope="col">Prix</th>
								<th scope="col">Quantité</th>
								<th scope="col">Total</th>
								<th scope="col">Opération</th>
							</tr>
						</thead>
						<tbody>
							<?php 
							if (isset($_SESSION['panier'])) {
								foreach ($_SESSION['panier'] as $key => $value) {
								?>
								<tr>
									<td><?= $value['idProduit']; ?></td>
									<td><?= $value['nomProduit']; ?></td>
									<input type="hidden" name="nomProduit" value="<?= $value['nomProduit']; ?>">
									<td>
										<?= number_format($value['prixProduit'], 2, ',', ' '); ?> €
										<input type="hidden" class="iprice" value="<?= $value['prixProduit']; ?>">
									</td>
									<td>
										<form method="POST" action="panier">
											<input class="text-center iquantity form-control" onchange="this.form.submit();" type="number" min="1" max="15" name="ModifierQte" value="<?= $value['qteProduit']; ?>">
										</form>
									</td>
									<td class="itotal"></td>
									<td>
										<form method="post" action="panier">
											<button name="Supprimer" class="btn btn-sm btn-outline-danger">
												<i class="bi bi-x-lg"></i>
											</button>
											<input type="hidden" name="nomProduit" value="<?= $value['nomProduit']; ?>">
										</form>
									</td>
								</tr>
							<?php } } else { ?>
								<tr>
									<td colspan="6" style="font: 600 16px system-ui;">
										Vous n'avez aucun article dans votre panier.
									</td>
								</tr>
							<?php } ?>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="col-lg-4">
			<div class="card mb-5">
				<div class="card-body">
					<h3>Montant Total : </h3>
					<h5 class="text-end mb-5" id="gtotal"></h5>
					<?php if (isset($_SESSION['panier']) && count($_SESSION['panier']) > 0) { ?>
					<form method="POST" action="commandes">
                        <input type="hidden" name="idClient" value="<?= $_SESSION['idClient']; ?>">
						<input type="hidden" name="nom" value="<?= $_SESSION['nom']; ?>">
						<input type="hidden" name="adresse" value="<?= $_SESSION['adresse']; ?>">
						<input type="hidden" name="cp" value="<?= $_SESSION['cp']; ?>">
						<input type="hidden" name="ville" value="<?= $_SESSION['ville']; ?>">
						<input type="hidden" name="pays" value="<?= $_SESSION['pays']; ?>">
						<style type="text/css">
							input[type="radio"] {display: none;}
							label {color: black; font-family: 'Poppins', sans-serif; font-size: 12pt; border: 2px solid #01cc65; border-radius: 5px; padding: 10px 50px; display: flex; align-items: center; cursor: pointer;}
							label:before {content: ""; height: 30px; width: 30px; border: 3px solid #01cc65; border-radius: 50%; margin-right: 20px;}
							input[type="radio"]:checked + label {background-color: #01cc65; color: white;}
							input[type="radio"]:checked + label:before {height: 30px; width: 30px; border: 10px solid white; background-color: #01cc65;}
						</style>
						<div class="mb-3">
							<div class="form-check mb-3">
								<input type="radio" name="mode_payement" id="option1" value="Carte bancaire" checked>
								<label class="form-check-label" for="option1">
								 	Carte bancaire
								</label>
							</div>
							<div class="form-check">
								<input type="radio" name="mode_payement" id="option2" value="PayPal">
								<label class="form-check-label" for="option2">
								 	PayPal
								</label>
							</div>
						</div>
						<div class="d-flex justify-content-center">
							<button name="payement" class="btn btn-success btn-lg w-100">
								Valider la commande
							</button>
						</div>
					</form>
					<?php } else { ?>
						<p class="card-text text-center">
							Veuillez ajouter des articles dans votre panier avant de passer une commande.
						</p>
					<?php } ?>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	var gt = 0;
	var iprice = document.getElementsByClassName('iprice');
	var iquantity = document.getElementsByClassName('iquantity');
	var itotal = document.getElementsByClassName('itotal');
	var gtotal = document.getElementById('gtotal');

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
<div class="container reveal mt-4 mb-5">
	<div class="row align-items-center">
		<div class="col-lg-6 mx-auto">
			<div class="card mb-4">
				<div class="card-header">
					<div class="d-flex justify-content-center">
						<div class="col-auto text-center text-light border rounded bg-primary">
							<h1>&nbsp;Mon profil&nbsp;</h1>
						</div>
					</div>
				</div>
				<?php if (isset($_GET['action']) && isset($_GET['idClient'])) { ?>
				<form method="post" action="profil">
					<div class="card-body">
						<div class="row d-flex justify-content-center">
							<div class="col-auto">
								<div class="alert alert-warning alert-dismissible fade show" role="alert">
									<strong>Vous devrez vous reconnecté après la validation.</strong>
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
								</div>
							</div>
						</div>
						<input type="hidden" name="idClient" value="<?= $_SESSION['idClient']; ?>">
						<div class="mb-2">
							<input type="text" name="nom" class="form-control" value="<?= ($leClient != null ? $_SESSION['nom'] : null); ?>">
						</div>
						<div class="mb-2">
							<input type="tel" name="tel" maxlength="10" class="form-control" value="<?= ($leClient != null ? $_SESSION['tel'] : null); ?>">
						</div>
						<div class="mb-2">
							<input type="email" name="email" class="form-control" value="<?= ($leClient != null ? $_SESSION['email'] : null); ?>">
						</div>
						<div class="mb-2">
							<input type="password" name="mdp" placeholder="Redéfinissez / changer votre mot de passe (Obligatoire)" class="form-control" required>
							<!-- MESSAGE ALERT MOT DE PASSE
							<?= ($leClient != null ? "<p class='text-danger fw-bold'>Redéfinissez / changez votre mot de passe ! <i>(Obligatoire)</i></p>" : null); ?>
							-->
						</div>
						<div class="mb-2">
							<input type="text" name="adresse" class="form-control" value="<?= ($leClient != null ? $_SESSION['adresse'] : null); ?>">
						</div>
						<div class="mb-2">
							<input type="text" name="cp" maxlength="5" class="form-control" value="<?= ($leClient != null ? $_SESSION['cp'] : null); ?>">
						</div>
						<div class="mb-2">
							<input type="text" name="ville" class="form-control" value="<?= ($leClient != null ? $_SESSION['ville'] : null); ?>">
						</div>
						<div class="mb-2">
							<input type="text" name="pays" class="form-control" value="<?= ($leClient != null ? $_SESSION['pays'] : null); ?>">
						</div>
					</div>
					<div class="card-footer">
						<div class="d-flex justify-content-center">
							<a href="profil" class="btn btn-danger me-2">
								Annuler
							</a>
							<button type="submit" name="Modifier" class="btn btn-primary">
								Valider
							</button>
						</div>
					</div>
				</form>
				<?php } else { ?>
				<div class="card-body">
					<p class="card-text">
						<b>Nom :</b> <?= $_SESSION['nom']; ?>
					</p>
					<p class="card-text">
						<b>Téléphone :</b> <?= $_SESSION['tel']; ?>
					</p>
					<p class="card-text">
						<b>Adresse email :</b> <?= $_SESSION['email']; ?>
					</p>
					<p class="card-text">
						<b>Mot de passe :</b> <i>Vous seul le connaissez.</i>
					</p>
					<p class="card-text">
						<b>Adresse :</b> <?= $_SESSION['adresse']; ?>
					</p>
					<p class="card-text">
						<b>Code postal :</b> <?= $_SESSION['cp']; ?>
					</p>
					<p class="card-text">
						<b>Ville :</b> <?= $_SESSION['ville']; ?>
					</p>
					<p class="card-text">
						<b>Pays :</b> <?= $_SESSION['pays']; ?>
					</p>
					<hr>
					<p class="card-text">
						<b>Adresse de livraison :</b> <?= $_SESSION['adresse']; ?>, <?= $_SESSION['cp']; ?> <?= $_SESSION['ville']; ?>
					</p>
				</div>
				<div class="card-footer">
					<div class="d-flex justify-content-center">
						<a href="profil?action=edit&idClient=<?= $_SESSION['idClient']; ?>" onclick="return(confirm('Vous devrez redéfinir votre mot de passe, ou bien le changer. Continuer ?'));" class="btn btn-primary text-light me-2">
							Modifier mon profil
						</a>
						<button type="button" class="btn btn-danger text-light" data-bs-toggle="modal" data-bs-target="#deleteCompte">
								Supprimer mon compte
						</button>
					</div>
				</div>
				<?php } ?>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="deleteCompte" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
  	<div class="modal-dialog modal-dialog-centered">
    	<div class="modal-content bg-dark text-light">
      		<div class="modal-header">
        		<h5 class="modal-title">Suppression du compte</h5>
        		<button type="button" class="btn-close bg-light" data-bs-dismiss="modal" aria-label="Close"></button>
      		</div>
      		<form method="post" action="">
      			<div class="modal-body">
      				<div class="d-flex justify-content-center">
      					<div class="col-auto">
							<div class="alert alert-warning alert-dismissible fade show" role="alert">
								<strong>Vous serez déconnecté après la suppression.</strong>
								<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
							</div>
						</div>
      				</div>
	        		<div class="mb-3">
	        			<label for="email" class="form-label">Adresse email</label>
	        			<input type="email" name="email" class="form-control">
	        		</div>
	        		<div class="mb-3">
	        			<label for="mdp" class="form-label">Mot de passe</label>
	        			<input type="password" name="mdp" class="form-control">
	        		</div>
	      		</div>
	      		<div class="modal-footer justify-content-center">
	        		<div class="d-flex">
	        			<button type="button" class="btn btn-warning me-2" data-bs-dismiss="modal">
		        			Annuler
		        		</button>
		        		<button type="submit" name="Supprimer" onclick="return(confirm('Voulez-vous vraiment supprimer votre compte ?'));" class="btn btn-danger">
		        			Supprimer le compte
		        		</button>
	        		</div>
	      		</div>
      		</form>
    	</div>
  	</div>
</div>
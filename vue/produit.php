<div class="container mt-4">
	<div class="row">
		<div class="d-flex justify-content-center">
			<div class="col-lg-5 col-md-5 col-sm-12">
				<form method="POST" action="panier">
					<div class="card rounded mb-5 animate__animated animate__jackInTheBox">
						<div class="card-header">
							<h3 class="text-center">
								<?= $leProduit['nomProduit']; ?>
							</h3>
						</div>
						<div class="card-body">
							<div class="d-flex justify-content-center">
								<img src="assets/images/produits/<?= $leProduit['imageProduit']; ?>" width="300" class="img-fluit" alt="<?= $leProduit['nomProduit']; ?>">
							</div>
							<figcaption class="blockquote-footer mt-3">
    							<cite title="Description"><?= $leProduit['descriptionProduit']; ?></cite>
  							</figcaption>
  							<h4 class="text-center font-weight-bold mb-3">
  								<?= number_format($leProduit['prixProduit'], 2, ',', ' '); ?> €
  							</h4>
  							<?php if (isset($_SESSION['idClient'])) { ?>
  							<div class="mb-3">
								<div class="row d-flex justify-content-center">
									<div class="col-auto">
										<input type="number" name="qteProduit" min="1" max="<?= $leProduit['qteProduit']; ?>" value="1" class="form-control">
									</div>
								</div>
							</div>
							<?php } ?>
							<input type="hidden" name="idProduit" value="<?= $leProduit['idProduit']; ?>">
							<input type="hidden" name="nomProduit" value="<?= $leProduit['nomProduit']; ?>">
							<input type="hidden" name="prixProduit" value="<?= $leProduit['prixProduit']; ?>">
						</div>
						<?php if (isset($_SESSION['idClient'])) { ?>
						<div class="card-footer" style="background-color: #fff;">
							<div class="d-flex justify-content-center">
								<button type="submit" name="Ajouter" class="btn btn-success">
									+ Ajouter au panier
								</button>
							</div>
						</div>
						<?php } else { ?>
							<p class="card-text text-center">
								<i>Vous devez vous connecter pour pouvoir acheter ce produit.</i>
							</p>
						<?php } ?>
						<div class="d-flex justify-content-center mt-4 mb-3">
							<a href="javascript:history.back()" class="btn btn-secondary">Retour</a>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div style="margin-bottom: 50px!important;">
			<div class="row d-flex justify-content-center">
				<div class="col-lg-9 col-md-9 col-sm-12">
					<div class="container mt-5">
					    <div class="row justify-content-center">
					        <div class="col-md-8">
					            <div class="headings d-flex justify-content-between align-items-center mb-3">
					                <div class="card">
					                	<div class="card-header">
					                		<h5>Commentaires (<?= $nbCommentaires; ?>)</h5>
					                	</div>
					                </div>
					            </div>
					            <div class="card p-3 mt-2">
					            	<?php if (isset($_SESSION['idClient'])) { ?>
					            	<form method="post" action="">
					            		<div class="card-body">
					            			<div class="input-group mb-3">
					            				<textarea name="contenu" placeholder="Votre message" class="form-control" aria-describedby="basic-addon2"><?= ($editCom != null ? $editCom['contenu'] : null); ?></textarea>
					            				<?php if ($editCom != null) { ?>
					            				<button type="submit" name="Edit" class="btn">
					            					<span class="input-group-text btn-primary" id="basic-addon2">
					            						Poster
					            					</span>
					            				</button>
					            				<?php } else { ?>
					            				<button type="submit" name="Poster" class="btn">
					            					<span class="input-group-text btn-success" id="basic-addon2">
					            						Poster
					            					</span>
					            				</button>
					            				<?php } ?>
					            			</div>
					            		</div>
					            	</form>
					            	<?php } else { ?>
					            	<p class="card-text text-center">
					            		<i>Vous devez vous connecter pour pouvoir poster un commentaire.</i>
					            	</p>
					            	<?php } ?>
					            </div>
					            <?php foreach ($lesCommentaires as $unCommentaire) { ?>
					            <div class="card p-3 mt-2 animate__animated animate__fadeInUp">
					                <div class="d-flex justify-content-between align-items-center">
					                    <div class="user d-flex flex-row align-items-center">
				                    		<span>
				                    			<small class="font-weight-bold text-primary">
				                    				<b><?= $unCommentaire['idClient']; ?></b>
				                    			</small><br>
				                    			<small class="font-weight-bold">
				                    				<?= $unCommentaire['contenu']; ?>
				                    			</small>
				                    		</span> 
					                    </div> 
					                    <small><?= $unCommentaire['dateHeurePost']; ?></small>
					                </div>
					                <?php if (isset($_SESSION['idClient']) && $_SESSION['idClient'] == $unCommentaire['client_id']) { ?>
					                <div class="action d-flex justify-content-between mt-2 align-items-center">
					                    <div class="reply px-4"> 
					                    	<small>
					                    		<a href="produit?view=<?= $leProduit['idProduit']; ?>&action=edit&idCom=<?= $unCommentaire['idCom']; ?>&idProduit=<?= $unCommentaire['idProduit']; ?>" class="me-2" style="text-decoration: none;" class="text-primary">
					                    			Modifier
					                    		</a>
					                    	</small> 
					                    	<span class="dots" style="height: 4px; width: 4px; margin-bottom: 2px; background-color: #bbb; border-radius: 50%; display: inline-block;"></span> 
					                    	<small>
				                    			<a href="produit?view=<?= $leProduit['idProduit']; ?>&action=delete&idCom=<?= $unCommentaire['idCom']; ?>&idProduit=<?= $unCommentaire['idProduit']; ?>" onclick="return(confirm('Voulez-vous vraiment supprimer votre commentaire ?'));" class="ms-2" style="text-decoration: none; color: red;">
				                    				Supprimer
				                    			</a>
					                    	</small> 
					                    </div>
					                </div>
					            	<?php } ?>
					            </div>
					        	<?php } ?>
					        </div>
					    </div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
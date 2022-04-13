<div class="container mt-4">
	<div class="row d-flex justify-content-center">
		<div class="col-xxl-6">
			<div class="card border border-5 reveal-1 mb-5" style="background-color: #ADD8E6; border-color: #ADD8E6!important;">
				<?= $unControleur->headerContact("Nous contacter"); ?>
				<div class="card-body" style="border-radius: .25rem!important; background-color: #ADD8E6;">
					<form method="post" action="">
						<?= $unControleur->inputContact("email", "Adresse email (<i>Obligatoire</i>)", "email"); ?>
						<?= $unControleur->inputContact("sujet", "Sujet du message (<i>Obligatoire</i>)", "text"); ?>
						<?= $unControleur->textareaContact("message", "Message (<i>Obligatoire</i>)"); ?>
						<?= $unControleur->buttonsContact(); ?>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

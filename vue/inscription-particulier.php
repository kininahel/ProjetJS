<?php if (isset($erreur)) { ?>
<div class="container mt-4">
	<div class="row d-flex justify-content-center">
		<div class="col-auto">
			<div class="alert alert-warning alert-dismissible fade show" role="alert">
				<strong><?= $erreur; ?></strong>
				<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</div>
	</div>
</div>
<?php } ?>

<script type="text/javascript">
/*
    function traiterNom() {
        let nom = document.getElementById("nom").value;
        lengthnom = nom.length === 1 && nom.match(/[a-z]/i);
        if (nom.length === 0) {
            alert("Veuillez saisir votre nom");
            document.getElementById("nom").style.backgroundColor = "red";
        } else if (nom.length < 2) {
            alert("Votre nom est trop court !");
            document.getElementById("nom").style.backgroundColor = "red";
        } else if (nom.length > 50) {
            alert("Votre nom est trop long !");
            document.getElementById("nom").style.backgroundColor = "red";
        } else {
            nom = nom.toUpperCase();
            document.getElementById("nom").value = nom;
        }
    }

    function traiterPrenom() {
        let prenom = document.getElementById("prenom").value;
        lengthprenom = prenom.length === 1 && prenom.match(/[a-z]/i);
        if (prenom.length === 0) {
            alert("Veuillez saisir votre prenom");
            document.getElementById("prenom").style.backgroundColor = "red";
        } else if (prenom.length < 2) {
            alert("Votre prenom est trop court !");
            document.getElementById("prenom").style.backgroundColor = "red";
        } else if (prenom.length > 50) {
            alert("Votre prenom est trop long !");
            document.getElementById("prenom").style.backgroundColor = "red";
        } else {
            prenom = (prenom.substring(0, 1).toUpperCase()) + (prenom.substring(1)).toLowerCase();
            document.getElementById("prenom").value = prenom;
        }
    }

    function traiterPseudo() {
        let pseudo = document.getElementById("pseudo").value;
        lengthpseudo = pseudo.length === 1 && pseudo.match(/[a-zA-Z][a-zA-Z0-9-_\.]/i);
        if (pseudo.length === 0) {
            alert("Veuillez saisir votre pseudo");
            document.getElementById("pseudo").style.backgroundColor = "red";
        } else if (pseudo.length < 2) {
            alert("Votre pseudo est trop court !");
            document.getElementById("pseudo").style.backgroundColor = "red";
        } else if (pseudo.length > 50) {
            alert("Votre pseudo est trop long !");
            document.getElementById("pseudo").style.backgroundColor = "red";
        }
    }

    function traiterTel() {
        let tel = document.getElementById("tel").value;
        lengthtel = tel.length === 1 && tel.match(/[0-9]/i);
        if (tel.length === 0) {
            alert("Veuillez saisir votre tel");
        } else if (tel.length < 2) {
            alert("Votre numéro de téléphone est trop court !");
            document.getElementById("tel").style.backgroundColor = "red";
        } else if (tel.length > 10) {
            alert("Votre numéro de téléphone est trop long !");
            document.getElementById("tel").style.backgroundColor = "red";
        }
    }

    function traiterEmail() {
        let email = document.getElementById("email").value;
        lengthemail = email.length === 1 && tel.match(/[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]/i);
        let cEmail=0, cPoint=0;
        for (let i=0; i<email.length; i++) {
            if (email.charAt(i) === '@') {
                cEmail ++;
            } else if (email.charAt(i) === '.') {
                cPoint ++;
            }
        }
        if (cEmail === 1 && cPoint >= 1) {
            if (email.length === 0) {
                alert("Veuillez saisir votre email");
            } else if (email.length < 2) {
                alert("Votre adresse email est trop courte !");
                document.getElementById("email").style.backgroundColor = "red";
            } else if (email.length > 50) {
                alert("Votre adresse email est trop longue !");
                document.getElementById("email").style.backgroundColor = "red";
            }
        } else {
            document.getElementById("email").style.backgroundColor = "red";
            alert("Votre adresse email doit contenir un @ et un . !");
        }
              
    }

    function traiterMdp() {
        let mdp = document.getElementById("mdp").value;
        lengthmdp = mdp.length === 1 && mdp.match(/(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z])/i);
        if (mdp.length === 0) {
            alert("Veuillez saisir votre mot de passe");
            document.getElementById("mdp").style.backgroundColor = "red";
        } else if (mdp.length < 8) {
            alert("Votre mot de passe est trop court !");
            document.getElementById("mdp").style.backgroundColor = "red";
        }
    }

    function traiterAdresse() {
        let adresse = document.getElementById("adresse").value;
        lengthadresse = adresse.length === 1 && adresse.match(/[a-zA-Z][a-zA-Z0-9]/i;
        if (adresse.length === 0) {
            alert("Veuillez saisir votre adresse");
        } else if (adresse.length < 2) {
            alert("Votre adresse est trop courte !");
            document.getElementById("adresse").style.backgroundColor = "red";
        } else if (adresse.length > 100) {
            alert("Votre adresse est trop longue !");
            document.getElementById("adresse").style.backgroundColor = "red";
        }
    }

    function traiterCp() {
        let cp = document.getElementById("cp").value;
        lengthcp = cp.length === 1 && cp.match(/[A-Z0-9]/i;
        if (cp.length === 0) {
            alert("Veuillez saisir votre code postale");
        } else if (cp.length < 5) {
            alert("Votre code postale est trop court !");
            document.getElementById("cp").style.backgroundColor = "red";
        } else if (cp.length > 5) {
            alert("Votre code potale est trop long !");
            document.getElementById("cp").style.backgroundColor = "red";
        }
    }

    function traiterVille() {
        let ville = document.getElementById("ville").value;
        lengthville = ville.length === 1 && ville.match(/[a-zA-Z][a-zA-Z]/i;
        if (ville.length === 0) {
            alert("Veuillez saisir votre ville");
        } else if (ville.length < 2) {
            alert("Votre ville est trop courte !");
            document.getElementById("ville").style.backgroundColor = "red";
        } else if (ville.length > 100) {
            alert("Votre ville est trop longue !");
            document.getElementById("ville").style.backgroundColor = "red";
        } else {
            ville = (ville.substring(0, 1).toUpperCase()) + (ville.substring(1)).toLowerCase();
            document.getElementById("ville").value = ville;
        }
    }

    function traiterPays() {
        let pays = document.getElementById("pays").value;
        lengthpays = pays.length === 1 && pays.match(/[a-zA-Z][a-zA-Z]/i;
        if (pays.length === 0) {
            alert("Veuillez saisir votre pays");
        } else if (pays.length < 2) {
            alert("Votre pays est trop court !");
            document.getElementById("pays").style.backgroundColor = "red";
        } else if (pays.length > 100) {
            alert("Votre pays est trop long !");
            document.getElementById("pays").style.backgroundColor = "red";
        } else {
            pays = (pays.substring(0, 1).toUpperCase()) + (pays.substring(1)).toLowerCase();
            document.getElementById("pays").value = pays;
        }
    }

    function traiterStatut() {
        let statut = document.getElementById("statut").value;
        lengthstatut = statut.length === 1 && statut.match(/[a-zA-Z][a-zA-Z]/i;
        if (statut.length === 0) {
            alert("Veuillez saisir votre statut");
        } else if (statut.length < 2) {
            alert("Votre statut est trop court !");
            document.getElementById("statut").style.backgroundColor = "red";
        } else if (statut.length > 50) {
            alert("Votre statut est trop long !");
            document.getElementById("statut").style.backgroundColor = "red";
        } else {
            statut = (statut.substring(0, 1).toUpperCase()) + (statut.substring(1)).toLowerCase();
            document.getElementById("statut").value = statut;
        }
    }
*/
</script>

<div class="limiter mt-4">
	<div class="container-login100">
		<div class="wrap-login100 mb-5 reveal-1" style="width: 800px; background-color: #006400;">
			<div class="formulaire">
				<form method="post" action="" class="login100-form validate-form">
					<span class="login100-form-logo">
						<i class="bi bi-person-plus"></i>
					</span>
					<span class="login100-form-title p-b-34 p-t-27">
						Inscription d'un Particulier
					</span>
					<div class="row mb-5">
						<div class="col-6">
							<div class="wrap-input100">
								<input type="text" name="nom" id="nom" spellcheck="false" placeholder="Votre nom" maxlength="50" pattern="^[a-zA-Z][a-zA-Z0-9-_\.]{1,50}$" class="input100" onblur="traiterNom()" required>
								<span class="focus-input100" data-placeholder="&#xf207;"></span>
								<span class="counter" id="counterNom">50</span>
							</div>
						</div>
						<div class="col-6">
							<div class="wrap-input100">
								<input type="text" name="prenom" id="prenom" spellcheck="false" placeholder="Votre prénom" maxlength="50" pattern="^[a-zA-Z][a-zA-Z0-9-_\.]{1,50}$" class="input100" onblur="traiterPrenom()" required>
								<span class="focus-input100" data-placeholder="&#xf207;"></span>
								<span class="counter" id="counterPrenom">50</span>
							</div>
						</div>
					</div>
					<div class="row mb-5">
						<div class="col-6">
							<div class="wrap-input100">
								<input type="tel" name="tel" id="tel" spellcheck="false" maxlength="10" placeholder="Votre téléphone" class="input100" onblur="traiterTel()" required>
								<span class="focus-input100" data-placeholder="&#xf2c8;"></span>
								<span class="counter" id="counterTel">10</span>
							</div>
						</div>
					</div>
					<div class="wrap-input100 mb-5">
						<input type="email" name="email" id="email" spellcheck="false" placeholder="Votre adresse email" maxlength="50" pattern="^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]{2,6}$" class="input100" onblur="traiterEmail()" required>
						<span class="focus-input100" data-placeholder="&#xf15a;"></span>
						<span class="counter" id="counterEmail">50</span>
					</div>
					<div class="wrap-input100 mb-5">
						<input type="password" name="mdp" id="mdp" spellcheck="false" placeholder="Votre mot de passe" maxlength="50" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$" class="input100" onblur="traiterMdp()" required>
						<span class="focus-input100" data-placeholder="&#xf191;"></span>
						<span class="counter" id="counterMdp">50</span>
					</div>
					<div id="box" style="display: none;">
						<p id="security-mdp"></p>
					</div>
					<div class="wrap-input100 mb-5">
						<input type="password" name="mdp2" id="mdp2" spellcheck="false" placeholder="Confirmation de votre mot de passe" maxlength="50" class="input100" required>
						<span class="focus-input100" data-placeholder="&#xf191;"></span>
						<span class="counter" id="counterMdp2">50</span>
					</div>
					<div class="wrap-input100 mb-5">
						<input type="text" name="adresse" id="adresse" spellcheck="false" placeholder="Votre adresse" maxlength="100" class="input100" onblur="traiterAdresse()" required>
						<span class="focus-input100" data-placeholder="&#xf299;"></span>
						<span class="counter" id="counterAdresse">100</span>
					</div>
					<div class="row mb-5">
						<div class="col-4">
							<div class="wrap-input100">
								<input type="text" name="cp" id="cp" spellcheck="false" maxlength="5" placeholder="Votre code postal" pattern="^[0-9]{5}|2[A-B][0-9]{3}$" class="input100" onblur="traiterCp()" required>
								<span class="focus-input100" data-placeholder="&#xf299;"></span>
								<span class="counter" id="counterCp">5</span>
							</div>
						</div>
						<div class="col-8">
							<div class="wrap-input100">
								<input type="text" name="ville" id="ville" spellcheck="false" placeholder="Votre ville" maxlength="100" class="input100" onblur="traiterVille()" required>
								<span class="focus-input100" data-placeholder="&#xf133;"></span>
								<span class="counter" id="counterVille">100</span>
							</div>
						</div>
					</div>
					<div class="row mb-5">
						<div class="col-6">
							<div class="wrap-input100">
								<input type="text" name="pays" id="pays" spellcheck="false" placeholder="Votre pays" maxlength="50" class="input100" onblur="traiterPays()" required>
								<span class="focus-input100" data-placeholder="&#xf162;"></span>
								<span class="counter" id="counterPays">50</span>
							</div>
						</div>
					</div>
					<input type="hidden" name="role" value="Client">
					<div class="container-login100-form-btn" style="justify-content: center;">
						<button type="submit" name="InscriptionParticulier" class="btn btn-lg text-light fw-bold" style="background-color: #008080; border-color: #AFEEEE;">
							Créer un compte
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- COMPTEUR DE CARACTERES -->
<script type="text/javascript">
	
	// Compteur de caractères pour le nom
	const nom = document.getElementById("nom")
	counterNom = document.querySelector("form #counterNom"),
	maxLengthNom = nom.getAttribute("maxlength");
	nom.onkeyup = ()=> {
  		counterNom.innerText = maxLengthNom - nom.value.length;
	}

	// Compteur de caractères pour le prénom
	const prenom = document.getElementById("prenom")
	counterPrenom = document.querySelector("form #counterPrenom"),
	maxLengthPrenom = nom.getAttribute("maxlength");
	prenom.onkeyup = ()=> {
  		counterPrenom.innerText = maxLengthPrenom - prenom.value.length;
	}

	// Compteur de caractères pour le téléphone
	const tel = document.getElementById("tel")
	counterTel = document.querySelector("form #counterTel"),
	maxLengthTel = tel.getAttribute("maxlength");
	tel.onkeyup = ()=> {
  		counterTel.innerText = maxLengthTel - tel.value.length;
	}

	// Compteur de caractères pour l'adresse email
	const email = document.getElementById("email")
	counterEmail = document.querySelector("form #counterEmail"),
	maxLengthEmail = email.getAttribute("maxlength");
	email.onkeyup = ()=> {
  		counterEmail.innerText = maxLengthEmail - email.value.length;
	}

	// Compteur de caractères pour la confirmation du mot de passe
	const mdp2 = document.getElementById("mdp2")
	counterMdp2 = document.querySelector("form #counterMdp2"),
	maxLengthMdp2 = mdp2.getAttribute("maxlength");
	mdp2.onkeyup = ()=> {
  		counterMdp2.innerText = maxLengthMdp2 - mdp2.value.length;
	}

	// Compteur de caractères pour l'adresse
	const adresse = document.getElementById("adresse")
	counterAdresse = document.querySelector("form #counterAdresse"),
	maxLengthAdresse = adresse.getAttribute("maxlength");
	adresse.onkeyup = ()=> {
  		counterAdresse.innerText = maxLengthAdresse - adresse.value.length;
	}

	// Compteur de caractères pour le code postal
	const cp = document.getElementById("cp")
	counterCp = document.querySelector("form #counterCp"),
	maxLengthCp = cp.getAttribute("maxlength");
	cp.onkeyup = ()=> {
  		counterCp.innerText = maxLengthCp - cp.value.length;
	}

	// Compteur de caractères pour la ville
	const ville = document.getElementById("ville")
	counterVille = document.querySelector("form #counterVille"),
	maxLengthVille = ville.getAttribute("maxlength");
	ville.onkeyup = ()=> {
  		counterVille.innerText = maxLengthVille - ville.value.length;
	}

	// Compteur de caractères pour le pays
	const pays = document.getElementById("pays")
	counterPays = document.querySelector("form #counterPays"),
	maxLengthPays = pays.getAttribute("maxlength");
	pays.onkeyup = ()=> {
  		counterPays.innerText = maxLengthPays - pays.value.length;
	}

</script>
<!-- / COMPTEUR DE CARACTERES -->

<!-- SUPPRESSION DES ESPACES -->
<script>

	// Suppression des espaces pour le nom
	$("input#nom").on({
		keydown: function(e) {
			if (e.which === 32)
				return false
		},
		change: function() {
			this.value = this.value.replace(/\s/g, "");
		}
	});

	// Suppression des espaces pour le prénom
	$("input#prenom").on({
		keydown: function(e) {
			if (e.which === 32)
				return false
		},
		change: function() {
			this.value = this.value.replace(/\s/g, "");
		}
	});

	// Suppression des espaces pour le téléphone
	$("input#tel").on({
		keydown: function(e) {
			if (e.which === 32)
				return false
		},
		change: function() {
			this.value = this.value.replace(/\s/g, "");
		}
	});

	// Suppression des espaces pour l'adresse email
	$("input#email").on({
		keydown: function(e) {
			if (e.which === 32)
				return false
		},
		change: function() {
			this.value = this.value.replace(/\s/g, "");
		}
	});

	// Suppression des espaces pour le code postal
	$("input#cp").on({
		keydown: function(e) {
			if (e.which === 32)
				return false
		},
		change: function() {
			this.value = this.value.replace(/\s/g, "");
		}
	});

</script>
<!-- / SUPPRESSION DES ESPACES -->


<!-- SUPPRESSION DES LETTRES DANS LES INPUT TEL ET CP -->
<script type="text/javascript">
/* Cette fonction permet d'insérer seulement des chiffres compris entre 0 et 9 */
/* Elle est résistante aux : 
- Copier Coller
- Glisser Déposer
- Raccouris clavier
- Opération de menu contextuel
- Touches non typables
- Position d'insertion
- Différentes disposition du clavier */
/* Elle est également supportable sur tous les navigateurs depuis IE 9. */

	function onlyNumber(textbox, inputFilter) {
  		["input", "keydown", "keyup", "mousedown", "mouseup", "select", "contextmenu", "drop"].forEach(function(event) {
    		textbox.addEventListener(event, function() {
      			if (inputFilter(this.value)) {
        			this.oldValue = this.value;
        			this.oldSelectionStart = this.selectionStart;
        			this.oldSelectionEnd = this.selectionEnd;
      			} else if (this.hasOwnProperty("oldValue")) {
        			this.value = this.oldValue;
        			this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
      			} else {
        			this.value = "";
      			}
    		});
  		});
	}

	onlyNumber(document.getElementById("tel"), function(value) {
  		return /^\d*?\d*$/.test(value); // Allow digits and '.' only, using a RegExp
	});

	onlyNumber(document.getElementById("cp"), function(value) {
  		return /^\d*?\d*$/.test(value); // Allow digits and '.' only, using a RegExp
	});

</script>
<!-- / SUPPRESSION DES LETTRES DANS LES INPUT TEL ET CP -->

<!-- TÉLÉPHONE : AJOUT D'UN ESPACE APRES LA SAISIE DE 2 CHIFFRES -->
<script type="text/javascript">
	/* OPTIONNEL
	document.getElementById('tel').addEventListener('input', function (e) {
  		e.target.value = e.target.value.replace(/[^\dA-Z]/g, '').replace(/(.{2})/g, '$1 ').trim();
	}); */
</script>
<!-- / TÉLÉPHONE : AJOUT D'UN ESPACE APRES LA SAISIE DE 2 CHIFFRES -->

<!-- VÉRIFICATION DE LA SÉCURITÉ DU MOT DE PASSE -->
<script type="text/javascript">

// Déclaration des variables
const password = document.getElementById("mdp"); // ID du champ de mot de passe
const security = document.getElementById("security-mdp"); // ID du texte de la box

// Si l'utilisateur ne saisi aucun caractère, alors on affiche rien
security.innerHTML = "";

// Si l'utilisateur clique sur le champ de mot de passe, la box apparaît mais pas le texte.
password.onfocus = function() {
  document.getElementById("box").style.display = "block";
}

// Si l'utilisateur clique en dehors du champ de mot de passe, la box disparaît.
password.onblur = function() {
  document.getElementById("box").style.display = "none";
}

// Déclaration des variables de caractères
var MAJUSCULE = /[A-Z]/g; // Lettres MAJUSCULES
var minuscule = /[a-z]/g; // Lettres minuscules
var chiffre = /[0-9]/g;   // Chiffres

/* Création d'un fonction permettant de détecter les caractères saisis. */

// Si l'utilisateur commence à inscire son mot de passe dans le champ,
// on vérifie les caractères saisis, donc la sécurité.
password.onkeyup = function() {
// Véfification du mot de passe saisi : 
	
	// Sécurité du mot de passe : très faible
	// Si "A" ou "a" ou "1" est saisi, alors on affiche la sécurité du mot de passe
  	if(password.value.match(MAJUSCULE) || password.value.match(minuscule) || password.value.match(chiffre)) {
    	security.innerHTML = "<p class='text-light'><i class='fas fa-shield-alt'></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sécurité du mot de passe : <font color='#FF6347'>Très faible</font></p>";

    	// Sécurité du mot de passe : faible
    	// Si "Aa" ou "A1", ou "aA" ou "a1" ou "1a" ou "1A" est saisi, alors on continu
    	if ( (password.value.match(MAJUSCULE) && password.value.match(minuscule)) || (password.value.match(MAJUSCULE) && password.value.match(chiffre)) || (password.value.match(minuscule) && password.value.match(MAJUSCULE)) ||  (password.value.match(minuscule) && password.value.match(chiffre)) || (password.value.match(chiffre) && password.value.match(minuscules)) || (password.value.match(chiffre) && password.value.match(MAJUSCULE)) ) {
	  		security.innerHTML = "<p class='text-light'><i class='fas fa-shield-alt'></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sécurité du mot de passe : <font color='orange'>Faible</font></p>";

	  		// Sécurité du mot de passe : moyen
	    	// Si "Aa1" ou "A1a", ou "aA1" ou "a1A" ou "1aA" ou "1Aa" saisi, alors on continu
	  		if ( (password.value.match(MAJUSCULE) && password.value.match(minuscule) && password.value.match(chiffre)) || (password.value.match(MAJUSCULE) && password.value.match(chiffre) && password.value.match(minuscule)) || (password.value.match(minuscule) && password.value.match(MAJUSCULE) && password.value.match(chiffre)) || (password.value.match(minuscule) && password.value.match(chiffre) && password.value.match(majuscule)) || (password.value.match(chiffre) && password.value.match(minuscule) && password.value.match(MAJUSCULE)) || (password.value.match(chiffre) && password.value.match(MAJUSCULE) && password.value.match(minuscule)) ) {
		  		security.innerHTML = "<p class='text-light'><i class='fas fa-shield-alt'></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sécurité du mot de passe : <font color='aqua'>Moyen</font></p>";

		  		// Sécurité du mot de passe : fort
		  		// Si le mot de passe saisi est supérieur à 8 caractères,
		  		// on dit l'utilisateur que son mot de passe est sécurisé.
		  		if (password.value.length > 8) {
			  		security.innerHTML = "<p class='text-light'><i class='fas fa-shield-alt'></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sécurité du mot de passe : <font color='#00FF00'>Fort</font></p>";
			  	} else {
			  		// Si le mot de passe de l'utilisateur est inférieur à 8,
			  		// on affiche à nouveau la 3ème condition
			  		security.innerHTML = "<p class='text-light'><i class='fas fa-shield-alt'></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sécurité du mot de passe : <font color='aqua'>Moyen</font></p>";
			  	}
		  	} else {
		  		// Si l'utilisateur enlève un caractère,
		  		// on affiche à nouveau la 2ème condition
		  		security.innerHTML = "<p class='text-light'><i class='fas fa-shield-alt'></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sécurité du mot de passe : <font color='orange'>Faible</font></p>";
		  	}
	  	} else {
	  		// Si l'utilisateur enlève un caractère,
	  		// on affiche à nouveau la 1ère condition
	  		security.innerHTML = "<p class='text-light'><i class='fas fa-shield-alt'></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sécurité du mot de passe : <font color='#FF6347'>Très faible</font></p>";
	  	}
	} else {
		// Si l'utilisateur ne saisi aucun caractère,
		// alors on affiche rien
	 	security.innerHTML = "";
	}
}
</script>
<!-- / VÉRIFICATION DE LA SÉCURITÉ DU MOT DE PASSE -->

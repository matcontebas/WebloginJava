/**
 * Gestione banner del cookie
 */
function nascondibanner() {
	var cookie=document.getElementById('cookiebanner');
	//var cookie=document.getElementsByClassName('cookie-banner');
	//Impostare la propietà display a none fa sparire l'elemento (in questo caso div) e libera lo spazio occupato dall'elemento stesso
	cookie.style.display="none";
}

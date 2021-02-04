/**
 * http://usejsdoc.org/
 */
function MyFunction(campouser, campopsw) {
	/* per usare questa function è necessario prevedere nell'HTML un tag <p id="err"> </p> dove viene scritto il tipo di errore*/
	var user=campouser;
	var lunguser=user.length;
	var psw=campopsw;
	var lungpsw=psw.length;
	//alert("lunghezza password: " + lungpsw);
	if (lunguser < 5 || lungpsw < 5) {
		// l'alert seguente serve solo per debug
		//alert ("lunghezza user o psw minore di 5 caratteri: "+ user + " "+ lunguser + " password " + psw + " " + lungpsw +" form bloccato");
		var messaggio= document.getElementById("err");
		messaggio.innerHTML = "User o Password inferiori a 5 caratteri";
		return false;
	} else {
		alert ("Viva!!! lunghezza user e psw maggiore uguale a 5 caratteri;  \n user: "+ user + " lunghezza: " + lunguser + "; \n password: "+ psw + " lunghezza: "+ lungpsw +"; \n Form va avanti");
		return true;
	}
}
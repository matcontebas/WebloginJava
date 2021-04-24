/**
 * http://usejsdoc.org/
 */
function MyFunction(campouser, campopsw) {
	/* per usare questa function è necessario prevedere nell'HTML un tag <p id="err"> </p> dove viene scritto il tipo di errore*/
	var user=campouser;
	var lunguser=user.length;
	var psw=campopsw;
	var lungpsw=psw.length;
	var messaggio= document.getElementById("err");
	//alert("lunghezza password: " + lungpsw);
	if (lunguser < 5 || lungpsw < 5) {
		// l'alert seguente serve solo per debug
		//alert ("lunghezza user o psw minore di 5 caratteri: "+ user + " "+ lunguser + " password " + psw + " " + lungpsw +" form bloccato");	
		messaggio.innerHTML = "User o Password inferiori a 5 caratteri";
		return false;
	} else {
		// i due seguenti cicli while controllano che nella nuova user e nuova psw non ci siano caratteri ASCII > 127
		var i = 0;
		while (i< user.length){
			if(user.charCodeAt(i)>127){
				//alert("attenzione");
				messaggio.innerHTML= "carattere non permesso: "+user.charAt(i);
				return false;
			}
			i++;
		}
		var k=0;
		while (k < psw.length){
			if(psw.charCodeAt(k)>127){
				//alert("attenzione psw");
				messaggio.innerHTML= "carattere non permesso: "+psw.charAt(k);
				return false;
			}
			k++;
		}
		//alert ("Viva!!! lunghezza user e psw maggiore uguale a 5 caratteri;  \n user: "+ user + " lunghezza: " + lunguser + "; \n password: "+ psw + " lunghezza: "+ lungpsw +"; \n Form va avanti");
		return true;
	}
}
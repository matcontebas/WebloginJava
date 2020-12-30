package com.backend_java.jsp;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Crittohash256 {
	
	public static byte[] GetSHA(String input) throws NoSuchAlgorithmException
	{
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		return md.digest(input.getBytes(StandardCharsets.UTF_8));
	}
	/*
	 * il metodo Convertihextostring, prende in ingresso un array di byte contenente
	 * la codifica in hash e li trasforma in una stringa.
	 * Questo metodo funziona per qualunque tipo di codifica hash.
	 * Nel caso specifico si tratta SHA-256
	 * perch� il metodo GetSHA � impostato su SHA-256.
	 * Il messaggio in ingresso � un array di 32 byte (32x8=256 bit come previsto da SHA-256).
	 * Viene innescato un ciclo for da 0 a 32 (per SHA-256 hash.length=32) che legge ogni byte
	 * e viene trasformato in due cifre hex (ogni byte � rappresentato da 2 cifre hex).
	 * Quindi l'uscita sar� una stringa con 64 caratteri esadecimali.
	 * 
	 * Una nota per quanto riguarda la rappresentazione esadecimale dei byte: il byte viene rappresentato come intero con segno;
	 * Questo significa che un numero positivo ha una normale rappresentazione binaria e quindi una rappresentazione con
	 * due cifre esadecimali mentre il numero negativo � rappresentato in binario in complemento a due: per esempio il numero -7
	 * � rappresentato come F9 poich� il primo semibyte � tutto ad uno il secondo byte � pari a 9 esadecimale poich� la rappresentazione
	 * di -7 in complemento a due � 1001.
	 * 
	 * Un altro punto sulla costruzione della stringa finale: se un byte contiene un valore positivo
	 * inferiore a 15 (1111), significa che il primo semibyte � tutto a zero. In questo caso la conversione hex sarebbe fatta
	 * con una sola cifra esadecimale. Per questo viene inserito il controllo if (hex.lenght()==1)... che provvede ad inserire
	 * la prima cifra esadecimale a zero per consentire la rappresentazione del byte con due cifre hex. Per esempio
	 * la cifra 3 sarebbe rappresentata in hex come 3. Per questo la lunghezza della stringa sarebbe 1 e quindi va aggiunto lo 0
	 * per ripristinare la corretta rappresentazione hex come '03'.
	 * 
	 * 
	 */
	public static String Convertihextostring (byte[] hash) {
		StringBuilder hexstring=new StringBuilder ();
		for (int i=0;i < hash.length;i++) {
			String hex = Integer.toHexString(0xFF & hash[i]);
			if (hex.length()==1) {
				hexstring.append('0');
			}
			hexstring.append(hex);
			//Attenzione, l'istruzione sottostante System.out... � molto importante per il debug. NON CANCELLARE
			//System.out.print("contatore: "+ i +"; byte hex: "+hex+"; lunghezza stringa: " + hex.length()+ "; hash: "+ hash[i]+"\n");
		}
		
		
		return hexstring.toString();
	}

}

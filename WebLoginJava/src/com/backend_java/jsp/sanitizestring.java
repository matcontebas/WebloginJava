package com.backend_java.jsp;

public class sanitizestring {
	
	/**
	 * il seguente metodo pulisce la stringa originale dai tag HTML che potrebbero introdurre codice malevolo
	 * (cross site scripting)
	 * @param originalstring: la stringa originale in ingresso
	 * @return ritorna la stringa bonificata
	 */
	public String bonificataghtml (String originalstring){
		if (originalstring==null||originalstring.isEmpty()) {return originalstring;}
		//Con l'istruzione sottostante si toglie la sottostringa<*>.
		originalstring=originalstring.replaceAll("<.*?>", "");
		
		//la seguente istruzione funziona, toglie i caratteri <,>,/,;,: in qualsiasi sequenza
		originalstring=originalstring.replaceAll("<|>|/|;|:", "");
		String stringabonificata=originalstring;
		return stringabonificata.trim();
	}
	/**
	 * il seguente metodo elimina da una stringa tutti i char > 127 ovvero i caratteri non ASCII (p. es: £, è, ì, etc)
	 * @param stringadabonificare
	 * @return stringabonificata
	 */
	public String eliminacharnonASCII (String originalstring) {
		if (originalstring==null||originalstring.isEmpty()) {return originalstring;}
		String stringabonificata=null;
		StringBuffer sb=new StringBuffer();
		char ch;
		for (int i=0;i<originalstring.length();i++) {
			ch=originalstring.charAt(i);
			if (ch < 127) {
				sb.append(ch);		
			}
		}
		stringabonificata=sb.toString();
		return stringabonificata.trim();
	}

}

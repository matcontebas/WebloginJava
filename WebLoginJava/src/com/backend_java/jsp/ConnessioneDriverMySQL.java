package com.backend_java.jsp;

public class ConnessioneDriverMySQL {
	private int errore;
	public ConnessioneDriverMySQL() {
		//Costruttore
		//il costruttore inizializza la variabile errore a zero
		this.setErrore(0);	
	}	
	public void connettiDriver() {
		final int CARICAMENTO_DRIVER_OK=1;
		final int CARICAMENTO_DRIVER_KO=0;
			// Step 1: Loading or registering Oracle JDBC driver class
		    	try {
		    		// Percorso del driver suggerito da HTML.it: com.mysql.jdbc.Driver.
		    		//Quello inserito viene definito deprecated e viene suggerito dal debug quello che ho inserito.
		    		Class.forName("com.mysql.cj.jdbc.Driver");
		    		this.setErrore(CARICAMENTO_DRIVER_OK);
		    	}
		    	catch(ClassNotFoundException cnfex) {

		    		System.out.println("Problem in loading or "
		    				+ "registering MySQL JDBC driver");
		    		cnfex.printStackTrace();
		    		this.setErrore(CARICAMENTO_DRIVER_KO);
		    	}
	 }
	private void setErrore(int a) {
		 // Setter: l'ho messo "Private" perchè il metodo serve solo all'interno dell'oggetto
		 this.errore=a;
	 }
	public int getErrore() {
		//getter
		return errore;
	}
}

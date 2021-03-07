package com.backend_java.jsp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class cercavaloreinDB {

	/**
	 * Costruttore che assegna il valore dell'oggetto Connection ricevuto come parametro
	 * @param conn è l'oggetto Connection in ingresso
	 */
	public cercavaloreinDB(Connection conn) {
		// TODO Auto-generated constructor stub
		this.setConnessione(conn);
	}
//connessione è la variabile privata di tipo Connection a cui verrà assegnato il valore in ingresso al costruttore
	private Connection connessione;
	/**
	 * getter
	 * @return restituisce l'oggetto Connection
	 */
	public Connection getConnessione() {
		return connessione;
	}
	/**
	 * setter di connessione
	 * @param connessione assegna al'oggetto connessione un valore
	 */
	public void setConnessione(Connection connessione) {
		this.connessione = connessione;
	}
	/**
	 * il metodo controlla se la connessione è ancora in piedi
	 * @return restituisce un boolean: true se la connessione è chiusa, false se la connessione è aperta quindi in piedi
	 */
	public boolean testconnessione() {
		//se la connessione è stata chiusa, il metodo ritorna true 
		try {
		return getConnessione().isClosed();
		} catch (Exception e) {
			//e.getCause();
			//e.printStackTrace();
			return true;
		}
	}
	/**
	 * Il metodo esegue la ricerca di un valore (testodacercare) nel campo (campotabella) della tabella (tabella).
	 * Serve per costruire una query a campi variabili associata all'oggetto Connection ricevuto come input dal costruttore
	 * @param tabella nome della tabella del DB
	 * @param campotabella nome del campo su cui fare la ricerca
	 * @param testodacercare testo da cercare
	 * @return restituisce un intero per segnalare l'esito dell'operazione;
	 * i valori sono: 1 (match trovato), 0 (match non trovato), 10 (errore SQLException)
	 */
	public int eseguiricerca (String tabella, String campotabella, String testodacercare) {
			String sql= "SELECT * FROM "+ tabella + " WHERE "+ campotabella+ " = ?";
			try {
				PreparedStatement p_stm = getConnessione().prepareStatement(sql);
				p_stm.setString(1, testodacercare);
				ResultSet rs = p_stm.executeQuery();
				int count=0;
				while (rs.next()) {
					count++;
				}
				if (count>0) {
					//System.out.print("\n"+ "count: " + count + " Record trovato");
					//USER PRESENTE NEL DB
					return 1;
				}
				else {
					//System.out.print("\n"+ "count: " + count + " Record NON trovato");
					//USER NON PRESENTE NEL DB
					return 0;
				}
				//throw new SQLException("Exception sql autogenerata");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				//Errore generico
				//e.printStackTrace();
				return 10;
			}
	}
}

package com.backend_java.jsp;
import java.sql.*;


public class ConnessioneDBMySQL {
	private int errore;
	public ConnessioneDBMySQL() {
		// Costruttore
		setErrore (0);
	}
	public int getErrore() {
		return errore;
	}
	private void setErrore(int errore) {
		this.errore = errore;
	}
	public Connection connettiDB(String indirizzoDB, String user, String psw) {
		Connection connection = null;
		String dbURL = "jdbc:mysql://" + indirizzoDB;
/* Attenzione, l'istruzione return deve essere inserita sia nel blocco try che nel blocco catch.
Il motivo è che in caso di errore viene eseguito il codice del blocco catch e senza un return il 
controllo non passerebbe al chiamante e quindi sarebbe inutile la variabile errore che è stata definita
con il relativo setter e getter. Quindi senza il return l'esecuzione si fermerebbe dopo il codice del catch e
il controllo non tornerebbe al chiamante. In alternativa si poteva mettere finally con all'interno un solo
return valido per i due blocchi try e get. Il compilatore in questo caso fornisce un warning poichè non è previsto
un return nel blocco finally perchè può sovrascrivere eventuali gestioni di errori.*/
		try {
			// Step 2.A: Create and get connection using DriverManager class
			connection = DriverManager.getConnection(dbURL,user,psw);
			setErrore(1);
			return connection;
		}
		catch (SQLException sqlex){
			sqlex.printStackTrace();
			setErrore(0);
			return connection;
		}
	}
}

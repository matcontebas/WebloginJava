<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.backend_java.jsp.*"%>
<%@ page errorPage="PaginaErrore.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link type="text/css" rel="stylesheet" href=tabellaformat.css>
<title>Visualizzazione user</title>
</head>
<body>
	<h2>Visualizzazione elenco user</h2>
	<%
		String hostname = "localhost";
		String dbname = "matteo";
		String tabella = "login";
		String colonnauser = "userlogin";
		String userdb = "AccountProva";
		String passdb = "rn5skCZucrBfARRaCzUT.";
		HttpSession sessione = request.getSession();
		/*attenzione che session.getAttribute restituisce un Object quindi per trasformarlo in stringa occorre fare o il casting
		 String nomeutente= (String) sessione.getAttribute("login") oppure usare il metodo toString che vale per tutta la classe
		 Object*/
		String nomeutente = sessione.getAttribute("login").toString();
		out.print("<p>Ciao " + nomeutente + "</p>");
		String user_da_cercare = request.getParameter("userdacercare");
		//out.print("<p>User da cercare: " + user_da_cercare+ "</p>");
		ConnessioneDriverMySQL connettidriver = new ConnessioneDriverMySQL();
		connettidriver.connettiDriver();
		final int NOERRORE = 1;
		if (connettidriver.getErrore() == NOERRORE) {
			out.print("<p>" + "Connessione driver ok" + "</p>");
		} else {
			out.print("<p>" + "Errore caricamento driver" + "</p>");
		}
		ConnessioneDBMySQL impostaconnessioneDB = new ConnessioneDBMySQL();
		Connection connessione = impostaconnessioneDB.connettiDB("localhost:3306/matteo?serverTimezone=UTC", userdb,
				passdb);
		if (impostaconnessioneDB.getErrore() == NOERRORE) {
			out.print("<p>" + "Connessione DB ok" + "</p>");
		} else {
			//out.print("<p>" + "Errore connessione DB" + "</p>");
			//----ATTENZIONE, LA GESTIONE DELLE EXCEPTION NON FUNZIONA SUL BROWSER INTERNO DI ECLIPSE--------------
			throw new SQLException(
					"Errore SQL generato da visualizzauser.jsp a causa della mancata connessione al DB");
		}
		sanitizestring bonificastringa = new sanitizestring();
		String userbonificata = bonificastringa.bonificataghtml(user_da_cercare);
		out.print("<p>Stringa bonificata: " + userbonificata + "</p>");
		//Ricerca stringa
		cercavaloreinDB ricerca = new cercavaloreinDB(connessione);
		//Rifaccio un rapido test della connessione
		if (!ricerca.testconnessione()) {
			out.print("<p>connessione aperta</p>");
			//il prossimo if controlla se la stringa userbonificata è vuota.
			if (userbonificata == "") {
				//----------------DA IMPLEMENTARE-------------------------
				out.print("<p><b>Elenco record</b></p>");
				String sql = "SELECT * FROM " + tabella;
				try{
					//In questo caso, non è necessario usare i prepared statement
					//perchè si tratta di sql senza parametri esterni
					Statement stm = connessione.createStatement();
					ResultSet rs = stm.executeQuery(sql);
					int i=0;
					out.print("<table>");
					out.print("<tr><th>Id</th><th>User</th></tr>");
					while (rs.next()){
						out.print("<tr><td>"+rs.getInt(1)+"</td><td>"+rs.getString(2)+"</td></tr>");
						i++;
					}
					out.print("</table>");
					out.print("<p><b>Numero record: "+i+"</b></p>");
				}catch(SQLException e){
//---------------Da gestire meglio---------------------------------
					e.printStackTrace();
					out.print("<p>Errore, SQL Exception</p>");
				}

				//----------------------------------------------------------------------------------------
			} else {//se la stringa userbonificata non è vuota, allora la cerco nel DB
				int esitoricerca = ricerca.eseguiricerca(tabella, colonnauser, userbonificata);
				switch (esitoricerca) {
				case 0:
					out.print("<p>user non trovata");
					break;
				case 1:
					out.print("<p><b>user presente nel DB</b></p>");
					break;
				case 10:
					out.print("<p>Errore generico (codice 10 da cercavaloreinDB.java) " + esitoricerca + "</p>");
					out.print("<p><a href='login.html'>Torna alla Homepage</a></p>");
					break;
				}
			}
			//inserire qui
		} else {
			//da gestire la mancanza connessione
			out.print("<p>connessione chiusa</p>");
			//throw new SQLException("Errore SQL generato da visualizzauser.jsp a causa della mancata connessione al DB");
		}

		out.print("<p><a href='form_visualizza.jsp'>Nuova user da visualizzare</a></p>");
		out.print("<p><a href='login.html'>oppure ritorna alla homepage</a></p>");
	%>
</body>
</html>
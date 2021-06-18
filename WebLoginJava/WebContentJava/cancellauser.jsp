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
<title>Esito cancellazione record</title>
</head>
<body>
	<h3>cancellazione record (cancellauser.jsp)</h3>
	<div>
		<%
			HttpSession sessione = request.getSession();
		//controllo se la sessione è attiva
			if (sessione.getAttribute("login") != null) {
				String nomeutente = sessione.getAttribute("login").toString();
				String indirizzoDB = "localhost:3306/matteo?serverTimezone=UTC";
				String dbname = "matteo";
				String tabella = "login";
				String colonnauser = "userlogin";
				String userDB = "AccountProva";
				String passDB = "rn5skCZucrBfARRaCzUT.";
				String user_da_cancellare = request.getParameter("user_da_cancellare");
				final int NOERRORE = 1;
				//Primo controllo: non si può cancellare l'account Amministratore.
				if (user_da_cancellare.equalsIgnoreCase("Administrator")){
					throw new Exception ("Non si può cancellare l'account Amministratore");
				}
				//Secondo controllo: non si può cancellare l'account corrente
				if (user_da_cancellare.equalsIgnoreCase(nomeutente)){
					throw new Exception ("Non si può cancellare l'account corrente");
				}
				ConnessioneDriverMySQL connettidriver = new ConnessioneDriverMySQL();
				connettidriver.connettiDriver();
				ConnessioneDBMySQL impostaconnessioneDB = new ConnessioneDBMySQL();
				Connection connessione = impostaconnessioneDB.connettiDB(indirizzoDB, userDB, passDB);
				if (connettidriver.getErrore() == NOERRORE && impostaconnessioneDB.getErrore() == NOERRORE) {
					out.print("<p>connessione ok</p>");
					out.print("<p>user da cancellare: " + user_da_cancellare + "</p>");
					//l'oggetto check di tipo cercavaloreinDB mette a disposizione metodi per controllare se una stringa è presente o meno nel DB
					cercavaloreinDB check = new cercavaloreinDB(connessione);
					int esitoricerca = check.eseguiricerca(tabella, colonnauser, user_da_cancellare);
					switch (esitoricerca) {
					case 1:
						//SQL di cancellazione
						String sql = "DELETE FROM " + tabella + " WHERE " + colonnauser + " = ?";
						try {
							PreparedStatement p_stm = connessione.prepareStatement(sql);
							p_stm.setString(1, user_da_cancellare);
							//p_stm.executeQuery();
							int i = p_stm.executeUpdate();
							if (i > 0) {
								out.print("<p style = 'color:red'>cancellazione OK</p>");
							} else {
								out.print("<p> cancellazione fallita</p>");
							}
							out.print("<p><a href='form_cancella_user.jsp'>cancella altri record</a>");
							out.print("<p><a href='login.html'>oppure ritorna alla homepage</a></p>");
						} catch (Exception e) {
							throw new SQLException("Errore SQL generato da cancellauser.jsp a causa della mancata connessione al DB");
						}
						break;
					case 0:
						//user non presente in DB
						out.print("<p>user non presente in DB</p>");
						out.print("<p><a href='form_cancella_user.jsp'>Riprova l'inserimento</a>");
						out.print("<p><a href='login.html'>oppure ritorna alla homepage</a></p>");
						break;
					case 10:
						out.print("<p>Errore SQL da cercavaloreinDB</p>");
						break;
					}
				} else {
					//----ATTENZIONE, LA GESTIONE DELLE EXCEPTION NON FUNZIONA SUL BROWSER INTERNO DI ECLIPSE--------------
					throw new SQLException(
							"Errore SQL generato da cancellauser.jsp a causa della mancata connessione al DB");
				}
			} else {
				//questo else si accoppia con l'if che c'è all'inizio per il controllo della sessione
				out.print("<p>" + "Login non effettuato" + "</p>");
				out.print("<a href= 'login.html'> Home </a>");
			}
		%>
	</div>
</body>
</html>
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
<title>Inserimento nuovo utente</title>
</head>
<body>
	<section>
		<header>
			<h3>
				<b>Esito inserimento nuovo utente</b>
			</h3>
		</header>
		<article>
			<%
				HttpSession sessione = request.getSession();
				if (sessione.getAttribute("login") != null) {
					String nomeutente = sessione.getAttribute("login").toString();
			%>
		</article>
		<article>
			<header>
				<b>Esito connessione a DB</b>
			</header>
			<%
				String hostname = "localhost";
					String dbname = "matteo";
					String tabella = "login";
					String colonnauser="userlogin";
					String colonnapsw="pswlogin";
					String user = "AccountProva";
					String pass = "rn5skCZucrBfARRaCzUT.";
					String usersicura = null;
					String userpulita = null;
					String pswsicura = null;
					String pswpulita = null;
					String pswcrypt = null;
					final int LUNGHEZZAMINIMA_USER_PSW = 5;
					final int NOERRORE = 1;
					ConnessioneDriverMySQL connettidriver = new ConnessioneDriverMySQL();
					connettidriver.connettiDriver();
					if (connettidriver.getErrore() == 1) {
						out.print("<p>" + "Connessione driver ok" + "</p>");
					} else {
						out.print("<p>" + "Errore caricamento driver" + "</p>");
					}
					ConnessioneDBMySQL impostaconnessioneDB = new ConnessioneDBMySQL();
					Connection connessione = impostaconnessioneDB.connettiDB("localhost:3306/matteo?serverTimezone=UTC",
							"AccountProva", "rn5skCZucrBfARRaCzUT.");
					if (impostaconnessioneDB.getErrore() == NOERRORE) {
						out.print("<p>" + "Connessione DB ok" + "</p>");
					} else {
						out.print("<p>" + "Errore connessione DB" + "</p>");
					}
					if (connettidriver.getErrore() == NOERRORE && impostaconnessioneDB.getErrore() == NOERRORE) {
						/*definisco la variabile temp di tipo sanitizestring che è un mio oggetto che ha un metodo per bonificare
						le stringhe per evitare il cross site scripting*/
						sanitizestring temp = new sanitizestring();
						usersicura = temp.bonificataghtml(request.getParameter("newuser"));
						pswsicura = temp.bonificataghtml(request.getParameter("newpsw"));
						/*la classe sanitize ha anche un metodo per elminare dalla stringa tutti i caratteri ASCII
						superiori a 127*/
						userpulita = temp.eliminacharnonASCII(usersicura);
						pswpulita = temp.eliminacharnonASCII(pswsicura);
						//CONTROLLO CHE DOPO LA BONIFICA LA USER E LA PSW ABBIANO LUNGHEZZA IDONEA	
						if (userpulita.length() >= LUNGHEZZAMINIMA_USER_PSW
								&& pswpulita.length() >= LUNGHEZZAMINIMA_USER_PSW) {
							//-----------------Controllo che la user non sia presente nel DB------------------------------
							cercavaloreinDB cercaval = new cercavaloreinDB(connessione);
							if (!cercaval.testconnessione()) {
								out.print("<p>connessione aperta</p>");
								int esitoricerca = cercaval.eseguiricerca(tabella, colonnauser, userpulita);
								switch (esitoricerca) {
								case 1:
									out.print("<p>user presente nel DB</p>");
									out.print("<p><a href='form_new_user.jsp'>Riprova l'inserimento</a>");
									out.print("<p><a href='login.html'>oppure ritorna alla homepage</a></p>");
									break;
								case 0:
									out.print("<p>record non trovato " + esitoricerca + "</p>");
									//-----------------CRIPTARE USER&PASSWORD----------------------------------
									//inserimento nuovo record
									pswcrypt=Crittohash256.Convertihextostring(Crittohash256.GetSHA(pswpulita));
									String sql = "INSERT INTO " + tabella + " (" + colonnauser +", " + colonnapsw +")" +" values (?,?)";
									try {
										PreparedStatement pstm = connessione.prepareStatement(sql);
										pstm.setString(1, userpulita);
										pstm.setString(2, pswcrypt);
										pstm.executeUpdate();
										out.print("<p><b>Inserimento avvenuto con successo</b></p>");
										connessione.close();
									} catch (SQLException e) {
										e.printStackTrace();
										out.print("<p>Errore, SQL Exception</p>");
									}
									break;
								case 10:
									out.print("<p>Errore generico (codice 10 da cercavaloreinDB.java) " + esitoricerca
											+ "</p>");
									out.print("<p><a href='login.html'>Torna alla Homepage</a></p>");
									break;
								}
							} else {
								out.print("<p>connessione chiusa</p>");
							}

						} else {
							out.print(
									"<p>La user o la password dopo la bonifica dai caratteri non permessi non è maggiore di "
											+ LUNGHEZZAMINIMA_USER_PSW + "</p>");
							out.print("<p><a href='form_new_user.jsp'>Torna al form di inserimento</a></p>");
						}
					}
				} else {
					//questo else si accoppia con l'if che c'è all'inizio per il controllo della sessione
					out.print("<p>" + "Login non effettuato" + "</p>");
					out.print("<a href= 'login.html'> Home </a>");
				}
			%>
		</article>
	</section>
</body>
</html>
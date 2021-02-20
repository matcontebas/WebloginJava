<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.backend_java.jsp.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Inserimento nuovo utente</title>
</head>
<body>
	<header>
		<p>Esito inserimento nuovo utente</p>
	</header>
	<section>
		<header>
			<h3>
				<b>Utente richiedente</b>
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
					String user = "AccountProva";
					String pass = "rn5skCZucrBfARRaCzUT.";
					String usersicura = null;
					String userpulita = null;
					String pswsicura = null;
					String pswpulita = null;
					String pswcrypt = null;
					final int LUNGHEZZAMINIMA_USER_PSW=5;
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
						//out.print("<p>" + "user senza tag HTML: " + usersicura + "</p>");
						//out.print("<p>" + "psw senza tag HTML: " + pswsicura + "</p>");
						//out.print("<h2>seconda bonifica</h2>");
						/*la classe sanitize ha anche un metodo per elminare dalla stringa tutti i caratteri ASCII
						superiori a 127*/
						userpulita = temp.eliminacharnonASCII(usersicura);
						pswpulita = temp.eliminacharnonASCII(pswsicura);
						//out.print("<p>" + "user senza ASCII >127: " + userpulita + " lunghezza stringa: "+userpulita.length()+"</p>");
						//out.print("<p>" + "psw senza ASCII >127: " + pswpulita + " lunghezza stringa: "+pswpulita.length()+"</p>");
						//CONTROLLO CHE DOPO LA BONIFICA LA USER E LA PSW ABBIANO LUNGHEZZA IDONEA	
						if (userpulita.length() >= LUNGHEZZAMINIMA_USER_PSW && pswpulita.length() >= LUNGHEZZAMINIMA_USER_PSW) {
							//-----------------Controllare che la user non sia presente nel DB------------------------------

						} else {
							out.print("<p>La user o la password dopo la bonifica dai caratteri non permessi non è maggiore di "+LUNGHEZZAMINIMA_USER_PSW+"</p>");
							out.print("<p><a href='form_new_user.jsp'>Torna al form di inserimento</a></p>");
						}
					}
				} else {
					out.print("<p>" + "Login non effettuato" + "</p>");
					out.print("<a href= 'login.html'> Home </a>");
				}
			%>
		</article>
	</section>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.backend_java.jsp.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Validazione login</title>
</head>
<body>
	<h1>Validazione Login</h1>
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
		ConnessioneDriverMySQL connettidriver = new ConnessioneDriverMySQL();
		connettidriver.connettiDriver();
		final int NOERRORE = 1;
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
			sanitizestring temp = new sanitizestring();
			/*la classe sanitize string ha un metodo bonofocataghtml che bonifica la stringa dai tag HTML per evitare
			il cross site scripting*/
			usersicura = temp.bonificataghtml(request.getParameter("user"));
			pswsicura = temp.bonificataghtml(request.getParameter("psw"));
			//out.print("<p>"+"psw senza tag HTML: "+ pswsicura+"</p>");
			//out.print("<h2>seconda bonifica</h2>");
			/*la classe sanitize ha anche un metodo per elminare dalla stringa tutti i caratteri ASCII
			superiori a 127*/
			userpulita = temp.eliminacharnonASCII(usersicura);
			pswpulita = temp.eliminacharnonASCII(pswsicura);
			pswcrypt = Crittohash256.Convertihextostring(Crittohash256.GetSHA(pswpulita));
			try {
				/*nelle seguenti righe, faccio l'interrogazione al DB con il Prepared Statement piuttosto
				che con lo Statement perchè questo mi consente di evitare l'SQL Injection*/
				String sql1= "SELECT * FROM login WHERE userlogin = ? AND pswlogin= ?";
				PreparedStatement p_stm = connessione.prepareStatement(sql1);
				p_stm.setString(1, userpulita);
				p_stm.setString(2, pswcrypt);
				p_stm.execute();// da utilizzare per vedere se vero o falso o togliere???
				ResultSet rs=p_stm.executeQuery();
				/*le istruzioni seguenti commentate rappresentano l'interrogazione del DB con lo Satement
				che ho già usato nei precedenti programmi.
				Statement stm = connessione.createStatement();
				String sql = "SELECT * FROM login WHERE userlogin = '" + userpulita + "' AND pswlogin = '"
						+ pswcrypt + "'";
				ResultSet rs = stm.executeQuery(sql);
				*/
				int contarecord=0;
				while (rs.next()){
					++contarecord;
				}
				if (contarecord>0) {
					out.print("<p><b>login corretto</b></p>");
				}else{
					out.print("<p><b>login NON corretto</b></p>");
					response.sendRedirect("LoginErrato.html");//il metodo response.Redirect è analogo a Header di PHP
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				out.print("<p>Errore SQL</p>");
			}
		} else {
			out.print("<p>Errore di caricamento del driver o connessione a DB</p>");
		}
	%>
	<ul>
		<li><p>
				<b>User: </b><%=userpulita%></p></li>
		<li><p>
				<b>psw: </b><%=pswpulita%></p></li>
	</ul>

</body>
</html>
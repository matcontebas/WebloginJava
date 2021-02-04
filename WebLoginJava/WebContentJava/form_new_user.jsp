<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link type="text/css" rel="stylesheet" href="StileModuloNewUser.css">
<script type="text/javascript" src="controlloinput.js"></script>
<title>Form inserimento new user</title>
</head>
<body>
	<h1>Inserimento nuovo user</h1>
	<%
		HttpSession sessione = request.getSession();
		if (sessione.getAttribute("login") != null) {
			/*attenzione che session.getAttribute restituisce un Object quindi per trasformarlo in stringa occorre fare o il casting
			 String nomeutente= (String) sessione.getAttribute("login") oppure usare il metodo toString che vale per tutta la classe
			 Object*/
			String nomeutente = sessione.getAttribute("login").toString();
			out.print("<p>Ciao " + nomeutente + "</p>");
	%>
	<!-- article è un contenitore analogo a div -->
	<article>
		<form name="moduloinserimento" action="inseriscinewuser.jsp"
			method="post"
			onsubmit="return MyFunction(document.getElementById('new_user').value ,document.getElementById('new_psw').value)">
			<p>
				user: <input name="newuser" id="new_user" type="text" required>
			</p>
			<p>
				psw: <input name="newpsw" id="new_psw" type="password" required>
			</p>
			<p>
				<input name="bottoneinvio" value="invio" type="submit"> <input
					value="Reimposta" type="reset">
			</p>
		</form>
	</article>
	<%
		} else {
			out.print("<p><b>login NON effettuato</b></p>");
			out.print("<p><a href='login.html'>Torna alla pagina di login</a></p>");
		}
	%>
	<footer>
		<p id="err" class="errore"></p>
		<p>modulo PHP in esecuzione: esegui_task</p>
	</footer>

</body>
</html>
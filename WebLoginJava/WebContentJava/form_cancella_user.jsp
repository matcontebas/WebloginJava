<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link type="text/css" rel="stylesheet" href="StileModuloNewUser.css">
<title>cancellazione user</title>
</head>
<body>
	<h1>cancellazione user</h1>
	<%
		HttpSession sessione = request.getSession();
		if (sessione.getAttribute("login") != null) {
			/*attenzione che session.getAttribute restituisce un Object quindi per trasformarlo in stringa occorre fare o il casting
			 String nomeutente= (String) sessione.getAttribute("login") oppure usare il metodo toString che vale per tutta la classe
			 Object*/
			String nomeutente = sessione.getAttribute("login").toString();
			out.print("<p>Ciao " + nomeutente + "</p>");
	%>
	<article>
		<form action="cancellauser.jsp" method="post">
			<p>
				user da cancellare:<input name="user_da_cancellare" type="text" required>
			</p>
			<p>
				<input type="submit" value="invia">
				<input type="reset" value="reset">
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
		<p>modulo jsp in esecuzione: form_cancella_user.jsp</p>
	</footer>
</body>
</html>
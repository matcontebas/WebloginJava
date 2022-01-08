<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Visualizzazione user</title>
<link type="text/css" rel="stylesheet" href=StileModuloNewUser.css>
</head>
<body>
	<h1>Visualizzazione user presenti in DB</h1>
	<%
		HttpSession sessione = request.getSession();
		if (sessione.getAttribute("login") != null) {
			/*attenzione che session.getAttribute restituisce un Object quindi per trasformarlo in stringa occorre fare o il casting
			 String nomeutente= (String) sessione.getAttribute("login") oppure usare il metodo toString che vale per tutta la classe
			 Object*/
			String nomeutente = sessione.getAttribute("login").toString();
			out.print("<p>Ciao " + nomeutente + "</p>");
		}
	%>
	<article>
		<form name="modulovisualizzazione" action="visualizzauser.jsp"
			method="post">
			<p>
				user:<input name="userdacercare" id=user_da_cercare type="text">
			</p>
			<p>
				<input name="bottone" value="invio" type="submit"> <input
					value="reset" type="reset">
			</p>
		</form>
		<p>Per ottenere l'elenco delle user presenti nel DB lasciare vuoto il campo user e
		premere invio</p>
	</article>
	<footer>
		<p id="err" class="errore">modulo jsp in esecuzione: form_visualizza.jsp</p>
	</footer>
</body>
</html>
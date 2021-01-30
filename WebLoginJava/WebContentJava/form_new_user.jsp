<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
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

		} else {
			out.print("<p><b>login NON effettuato</b></p>");
			out.print("<p><a href='login.html'>Torna alla pagina di login</a></p>");
		}
	%>

</body>
</html>
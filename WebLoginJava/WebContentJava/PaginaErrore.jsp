<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Pagina errore</title>
</head>
<body>
	<div class="message">
		Siamo spiacenti, si � verificato un errore durante l'esecuzione:<br />
		<br />
		<p><%=exception.getMessage()%></p>
		<p><a href='login.html'>ritorna alla homepage</a>
	</div>
</body>
</html>
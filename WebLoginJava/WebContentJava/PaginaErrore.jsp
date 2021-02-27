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
		Siamo spiacenti, si è verificato un errore durante l'esecuzione:<br />
		<br />
		<%=exception.getMessage()%>
	</div>
</body>
</html>
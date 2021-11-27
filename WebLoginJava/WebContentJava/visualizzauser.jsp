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
<title>Visualizzazione user</title>
</head>
<body>
	<h2>Visualizzazione elenco user</h2>
	<%
		HttpSession sessione = request.getSession();
	/*attenzione che session.getAttribute restituisce un Object quindi per trasformarlo in stringa occorre fare o il casting
	 String nomeutente= (String) sessione.getAttribute("login") oppure usare il metodo toString che vale per tutta la classe
	 Object*/
	 String nomeutente= sessione.getAttribute("login").toString();
	 out.print("<p>Ciao " + nomeutente + "</p>");
	 String user_da_cercare=request.getParameter("userdacercare");
	 out.print("User da cercare: "+user_da_cercare);
	%>
</body>
</html>
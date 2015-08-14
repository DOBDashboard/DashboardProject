<%
response.setHeader("Cache-Control","no-cache"); // HTTP 1.1
response.setHeader("Pragma","no-cache"); // HTTP 1.0
response.setDateHeader ("Expires", 0); // prevents caching at the Proxy cache
%>

<%-- FOR AJAX/JSON loading of the Time To Permit Breakdown of Task for Self Cert Projects
Used for the loading the results seamlessly to the the DIV in the dashboard main page
--%>



<%@ page contentType="text/plain" %>
<%@ page import="dashboard.*" %>

<%
	String col[][] =  DatabaseManager.getTaskAgeForOwnerIndividual(request.getParameter("ownerName")); 
		String nameIs = request.getParameter("ownerName");
     int ctr = col.length; %>

     <%out.println ("{"); %>
     "taskAgeForOwnerIndividual": [
     <%for (int j = 0; j < ctr; j++) { %>
      <%out.println ("{"); %>
      "taskName": "<%=col[j][0]%>",
      "ct": "<%=col[j][1]%>", 
      "ftn": "<%=col[j][2]%>", 
      "thirty": "<%=col[j][3]%>", 
      "fifty": "<%=col[j][4]%>", 
      "hundred": "<%=col[j][5]%>", 
      "hplus": "<%=col[j][6]%>", 
      "nameOfClicked": "<%=nameIs%>",
      "typeOf": "<%="Individual"%>",
       <%if (j < (ctr-1)) {out.println ("},");}  else {out.println ("}");}%>
     <%}%>
     <%out.println ("]"); %>
     <%out.println ("}"); %>
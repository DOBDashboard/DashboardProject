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
	String col[][] =  DatabaseManager.getTaskAgeForOwnerGroup(request.getParameter("groupName")); 
	String nameIs = request.getParameter("groupName");
     int ctr = col.length; %>

     <%out.println ("{"); %>
     "taskAgeForOwnerGroup": [
     <%for (int j = 0; j < ctr; j++) { %>
      <%out.println ("{"); %>
      "groupName": "<%=col[j][0]%>",
      "ct": "<%=col[j][1]%>",
      "nameOfClicked": "<%=nameIs%>",
       <%if (j < (ctr-1)) {out.println ("},");}  else {out.println ("}");}%>
     <%}%>
     <%out.println ("]"); %>
     <%out.println ("}"); %>
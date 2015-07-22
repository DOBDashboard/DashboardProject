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
String col[][] =  DatabaseManager.searchProject(request.getParameter("projectName"));  
		String searchThis = request.getParameter("projectName");
int ctr = col.length; %>

<%out.println ("{"); %>
"tap": [
<%for (int j = 0; j < ctr; j++) { %>
 <%out.println ("{"); %>
 "Name": "<%=col[j][0]%>",
 "HeaderName": "<%= "Search Project" %>",
 "SearchName": "<%=searchThis%>",
      <%if (j < (ctr-1)) {out.println ("},");}  else {out.println ("}");}%>
    <%}%>
    <%out.println ("]"); %>
    <%out.println ("}"); %>



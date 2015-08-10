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
	String age = request.getParameter("ranges");
	String[] temp = age.split("-");
			
	String col[][] =  DatabaseManager.getTaskAgeUserSplitGroup(request.getParameter("taskname"), request.getParameter("ownername"), Integer.parseInt(temp[0]), Integer.parseInt(temp[1]) ); 
    String thisName = request.getParameter("taskname");
	int ctr = col.length; %>

     <%out.println ("{"); %>
     "taskAgeUserSplitInside": [
     <%for (int j = 0; j < ctr; j++) { %>
      <%out.println ("{"); %>
      "prj": "<%=col[j][0]%>", 
      "clickedThis": "<%=thisName%>",
      "typeIs": "<%= "Group" %>",
       <%if (j < (ctr-1)) {out.println ("},");}  else {out.println ("}");}%>
     <%}%>
     <%out.println ("]"); %>
     <%out.println ("}"); %>
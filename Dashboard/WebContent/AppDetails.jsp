	
	
	<%-- Displays the project task details --%>
	
	
<%@ page contentType="text/html" %>
<%@ page import="dashboard.*" %>


<%
	String age = request.getParameter("prj");
	int ztr = 0;
	
	String col[][] =  DatabaseManager.getPrjActivityDetails(request.getParameter("prj"));  
	int ctr = col.length; 
	
	String three;
	String six;
	String nine;
%>


<%
	try
	{
%>
<%
	if(ctr <= 0)
	{	
		
%>

		<html>
		<body>
			<table align = "center" style = "width: 700px; height: 500px; border: 25px outset red; 
						border-radius: 25px;
						background-color: white;  color: black; align: center; text-align: center;">
			<tr>
			<td>
			<h1><b>This application is in ProjectDox but workflow has not yet been started for this project.</b></h1>
			<img src="img/exclamationMark.png" title = "Error!" alt="exclamationMarkError"
				style = "align: center; width: 200px; height:200px;">
			</td>
			</tr>
			</table>
		</body>
		</html>	
		
<%
	}// end of if(ctr <= 0)
	else
	{			
%>
	
	
	<html>
	
		<style>
		
		#mainTable tr td
		{
			border: 1.5px solid gray;
			
			outline: thin solid;
			font-family: "Times New Roman", Times, serif;
		}
		
		#mainTable
		{
			background-color: #E3E3E3;
			
		}
		</style>
		
		
		<table id = "mainTable" align = "center">
			<tr style = "text-align: center; background-color: gray; font-size: 24px;">
				<td colspan = 9 style = "vertical-align: top; "><b><%=col[0][0]%></b></td>
			</tr>
			
			 <tr style = "background-color: gray;"> 
				 <td><b>FlowInstanceName</b></td>
				 <td><b>TaskName</b></td>
				 <td><b>TaskStatus</b></td>
				 <td><b>DateCreated</b></td>
				 <td><b>DateUpdated</b></td>
				 <td><b>GroupName</b></td>
				 <td><b>TaskUser</b></td>
				 <td><b>ReviewCycle</b></td>
				 <td><b>CompletedDays</b></td>
			 </tr>
	
<% 
			int sumOfCompletedDays = 0;

			
			int x;
			for (int j = 0; j < ctr; j++) 
			{ 	
				three = col[j][3];
				six = col[j][6];
				nine = col[j][9];
				
				
				if(col[j][6] == null)
				{
					col[j][6] = "NULL";
					x = 5;
				}
				
				if( col[j][1].toLowerCase().contains("zoning") && (ztr == 0))
				{ 
					ztr = 1;
%>				
					<tr style = "background-color: black;">
						<td colspan = 10 style = "color: white; text-align: center;">Zoning</td>
					</tr>
<% 
					if((col[j][6].equalsIgnoreCase("Applicant")) && (col[j][3].equalsIgnoreCase("Pending"))) //if first group in zoning is pending by applicant
					{
						if(col[j][9] != null)
						{
							sumOfCompletedDays = Integer.parseInt(col[j][9]) + sumOfCompletedDays;
						}
%>
						<tr style = "background-color: #1E90FF; color:#b22424;">
							 <td><%=col[j][1]%> </td>
							 <td><%=col[j][2]%></td>
							 <td><%=col[j][3]%></td>
							 <td><%=col[j][4]%></td>
							 <td><%=col[j][5]%> </td>
							 <td><%=col[j][6]%></td>
							 <td><%=col[j][7]%></td>
							 <td><%=col[j][8]%></td>
							 <td><%=col[j][9]%> </td>
						</tr>
<%
					}
					else if(col[j][6].equalsIgnoreCase("Applicant")) // if the first groupName in zoning is "Applicant"
					{
						if(col[j][9] != null)
						{
							sumOfCompletedDays = Integer.parseInt(col[j][9]) + sumOfCompletedDays;
						}
%>
						<tr style = "background-color: #1E90FF;">
						
							 <td><%=col[j][1]%> </td>
							 <td><%=col[j][2]%></td>
							 <td><%=col[j][3]%></td>
							 <td><%=col[j][4]%></td>
							 <td><%=col[j][5]%> </td>
							 <td><%=col[j][6]%></td>
							 <td><%=col[j][7]%></td>
							 <td><%=col[j][8]%></td>
							 <td><%=col[j][9]%> </td>
						</tr>
<%
					}
					else if(col[j][3].equalsIgnoreCase("Pending")) // if the first TaskStatus in zoning is "Pending"
					{
%>
						<tr style = "color: #b22424;">
							 <td><%=col[j][1]%> </td>
							 <td><%=col[j][2]%></td>
							 <td><%=col[j][3]%></td>
							 <td><%=col[j][4]%></td>
							 <td><%=col[j][5]%> </td>
							 <td><%=col[j][6]%></td>
							 <td><%=col[j][7]%></td>
							 <td><%=col[j][8]%></td>
							 <td><%=col[j][9]%> </td>
						</tr>
<%
					}
					else
					{
%>
						<tr>
							<td><%=col[j][1]%> </td>
							<td><%=col[j][2]%></td>
							<td><%=col[j][3]%></td>
							<td><%=col[j][4]%></td>
							<td><%=col[j][5]%> </td>
							<td><%=col[j][6]%></td>
							<td><%=col[j][7]%></td>
							<td><%=col[j][8]%></td>
							<td><%=col[j][9]%></td>
						</tr> 
<%
					}
				}// end of the big if outside
				else if((col[j][6].equalsIgnoreCase("Applicant")) && (col[j][3].equalsIgnoreCase("Pending"))) //if task is pending by an Applicant
				{
					if(col[j][9] != null)
					{
						sumOfCompletedDays = Integer.parseInt(col[j][9]) + sumOfCompletedDays;
					}
%>
					<tr style = "background-color: #1E90FF; color:#b22424;">
						 <td><%=col[j][1]%> </td>
						 <td><%=col[j][2]%></td>
						 <td><%=col[j][3]%></td>
						 <td><%=col[j][4]%></td>
						 <td><%=col[j][5]%> </td>
						 <td><%=col[j][6]%></td>
						 <td><%=col[j][7]%></td>
						 <td><%=col[j][8]%></td>
						 <td><%=col[j][9]%> </td>
					</tr>
<%
				}
				else if(col[j][6].equalsIgnoreCase("Applicant")) // if the groupName is "Applicant"
				{
					if(col[j][9] != null)
					{
						sumOfCompletedDays = Integer.parseInt(col[j][9]) + sumOfCompletedDays;
					}
%>
				<tr style = "background-color: #1E90FF;">
				
					 <td><%=col[j][1]%> </td>
					 <td><%=col[j][2]%></td>
					 <td><%=col[j][3]%></td>
					 <td><%=col[j][4]%></td>
					 <td><%=col[j][5]%> </td>
					 <td><%=col[j][6]%></td>
					 <td><%=col[j][7]%></td>
					 <td><%=col[j][8]%></td>
					 <td><%=col[j][9]%> </td>
				</tr>
<%
				}
				else if(col[j][3].equalsIgnoreCase("Pending")) // if the TaskStatus is "Pending"
				{
%>
				<tr style = "color: #b22424;">
					 <td><%=col[j][1]%></td>
					 <td><%=col[j][2]%></td>
					 <td><%=col[j][3]%></td>
					 <td><%=col[j][4]%></td>
					 <td><%=col[j][5]%></td>
					 <td><%=col[j][6]%></td>
					 <td><%=col[j][7]%></td>
					 <td><%=col[j][8]%></td>
					 <td><%=col[j][9]%></td>
				</tr>
<%
				}
				else // everything else 
				{
%>
				<tr>			
					 <td><%=col[j][1]%> </td>
					 <td><%=col[j][2]%></td>
					 <td><%=col[j][3]%></td>
					 <td><%=col[j][4]%></td>
					 <td><%=col[j][5]%> </td>
					 <td><%=col[j][6]%></td>
					 <td><%=col[j][7]%></td>
					 <td><%=col[j][8]%></td>
					 <td><%=col[j][9]%> </td>
				</tr>
<%
				}
			}
%>	
			<tr style = "text-align: right; background-color: gray;">
				<td colspan = 9>Applicant's Total Days Completed: <b><%=sumOfCompletedDays%></b></td>
			</tr>
	
		</table>
	</html>
	
<%
	
		}
   } 
   catch(Exception e) 
   {
%>
	   
	   	<script>alert("Error here at end");</script>
<%
   } 
%>

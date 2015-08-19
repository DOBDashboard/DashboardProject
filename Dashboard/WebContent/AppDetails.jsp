<%-- Displays the project task details --%>
	
	
<%@ page contentType="text/html" %>
<%@ page import="dashboard.*" %>
	<script type = "text/javascript" src = "jquery-1.11.3.js"></script>
	<script src="Chart.js"></script>
<%
	String age = request.getParameter("prj");
	int ztr = 0;
	
	String col[][] =  DatabaseManager.getPrjActivityDetails(request.getParameter("prj"));  
	int ctr = col.length; 
	int applicantCount = 0; //applicant number of days to complete zoning not included
	int totalCount = 0; //total number of days to complete zoning not included 
	int dobCount = 0;//DOB number of days to complete zoning not included
	
	int dobAndApplicantCombined = 0; // total number of days for dob and its applicant combined
	int zoningAndApplicantCombined = 0; // total number of days for zoning and its applicant combined
	int applicantInZoning = 0; // total number of days for applicant in zoning
	int zoningCount = 0; // total number of days to complete zoning
	
			
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
		html
		{
		/*	background-color: #E3E3E3;
	*/
		background-image: url(img/cityhall.jpg);
		margin: 0 auto;
		width: 100%;
		background-attachment: fixed;
		background-size: cover;
		
		}
		#mainTable tr td
		{
			border: 1.5px solid gray;
			
			outline: thin solid;
			font-family: "Times New Roman", Times, serif;
		}
		
		#outerMainTable
		{
			width : 1100px;	
			border: 5px solid #1A6680;
			border-radius: 5px;
			font-family: "Times New Roman", Times, serif;
			background-color: #FFF0E0;
			align: center;
			CELLSPACING: 0;
			padding: 0px;
			opacity: .97;
		}
		
		#mainTable
		{
			background-color: #E3E3E3;
			
		}
		</style>
		
		<table id = "outerMainTable"align = "center">
		
		<tr style = "text-align: center; background-color: #CCC0B3; font-size: 24px;">
			<td colspan = 9 style = "vertical-align: top; "><b><%=col[0][0]%></b></td>
		</tr>
		
		<tr style = "height: 5px; width: 100%;">
		<td style = "content:' ';  display:block; border:1px solid #1A6680; background-color: #1A6680;"></td>
	</tr>
	
	<tr>
		<td style = "content: ' ';"></td>
	<tr>
		
		<tr>
		<td>
		<div>
		<table id = "mainTable" align = "center" style = "margin-top:365px; width: 99%;">
					
			 <tr style = "background-color: #CCC0B3;"> 
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
				if(col[j][6] == null)
				{
					col[j][6] = "NULL";
					x = 5;
				}
				
				if( col[j][1].toLowerCase().contains("zoning") && (ztr == 0))
				{ 
					ztr = 1;
%>				
					<tr>
						<td style = "content: ' ';" colspan = 9></td>
					<tr>
							
					<tr style = "background-color: black;">
						<td colspan = 10 style = "color: white; text-align: center;">Zoning</td>
					</tr>
<% 
					// if first group in zoning is pending by applicant
					if((col[j][6].equalsIgnoreCase("Applicant")) && (col[j][3].equalsIgnoreCase("Pending")))
					{
						if(col[j][9] != null)
						{
							sumOfCompletedDays = Integer.parseInt(col[j][9]) + sumOfCompletedDays;
						}
%>
						<tr style = "background-color: #8EC8FF; color:#b22424;">
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
						<tr style = "background-color: #8EC8FF;">
						
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
				// if task is pending by an Applicant
				else if((col[j][6].equalsIgnoreCase("Applicant")) && (col[j][3].equalsIgnoreCase("Pending"))) 
				{
					if(col[j][9] != null)
					{
						sumOfCompletedDays = Integer.parseInt(col[j][9]) + sumOfCompletedDays;
					}
%>
					<tr style = "background-color: #8EC8FF; color:#b22424;">
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
				<tr style = "background-color: #8EC8FF;">
				
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
			
			for( int j = 0; j < ctr; j++)
			{
				if (!col[j][1].toLowerCase().contains("zoning"))
				{
					if(col[j][6].equalsIgnoreCase("Applicant") && col[j][9] != null )
					{
						applicantCount = applicantCount + Integer.parseInt(col[j][9]);
						totalCount = totalCount + Integer.parseInt(col[j][9]);
						dobAndApplicantCombined = dobAndApplicantCombined + Integer.parseInt(col[j][9]);
					}
					else if(col[j][9] != null)
					{
						dobCount = dobCount + Integer.parseInt(col[j][9]);
						totalCount = totalCount + Integer.parseInt(col[j][9]);		
						dobAndApplicantCombined = dobAndApplicantCombined + Integer.parseInt(col[j][9]);
					}
				}
				else
				{
					if(col[j][9] != null && !col[j][6].equalsIgnoreCase("Applicant"))
					{
						zoningCount = zoningCount + Integer.parseInt(col[j][9]);	
						totalCount = totalCount + Integer.parseInt(col[j][9]);
						zoningAndApplicantCombined = zoningAndApplicantCombined + Integer.parseInt(col[j][9]);
					}
					else if(col[j][9] != null && col[j][6].equalsIgnoreCase("Applicant"))
					{
						applicantInZoning = applicantInZoning + Integer.parseInt(col[j][9]);
						totalCount = totalCount + Integer.parseInt(col[j][9]);
						zoningAndApplicantCombined = zoningAndApplicantCombined + Integer.parseInt(col[j][9]);
					}
				}
			}
			
%>	
			<tr style = "text-align: right; background-color: gray;">
				<td colspan = 9>Applicant's Total Days Completed: <b><%=sumOfCompletedDays%></b></td>
			</tr>
	
		</table>
		
		<table align = "left" style = "top:60px; position:absolute; background-color: #FFF0E0;  width: 340px; z-index: 10;">
			<tr style = "align: center;">
				<td style = "text-align: center;">	
					<h4>Total Days Taken by Group</h4>
					<canvas id="clients" style = "width:100%;" height= "280px"></canvas>
				
						<script>
							
							var barData = {
							    labels: ['Applicant', 'DOB', 'DOB Total Time', 'Zoning'],
							    datasets: [
							        {
							            label: 'Days To Complete',
							            fillColor: '#382765',
							            data: [<%=applicantCount%>, <%=dobCount%>,<%= applicantCount + dobCount%>, <%=zoningCount%>]
							        },
							       
							    ]
							};
							
							
							
							$(document).ready(function() {
								var context = document.getElementById('clients').getContext('2d');
								var clientsChart = new Chart(context).Bar(barData);
								});		
						</script>
						
					</td> 	
			</tr>
			
					
		</table>
		
		</div>
		</td>
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
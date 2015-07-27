<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@ page import="java.util.*"%>

<jsp:include page="fetchProjects.jsp" /> 

<jsp:include page="fetchSelfCertT2P.jsp" /> 
<jsp:include page="fetchCombinedCertT2P.jsp" /> 
<jsp:include page="fetchSprNonSelfCert.jsp" /> 
<jsp:include page="fetchTaskCount.jsp" /> 
<jsp:include page="fetchTaskByAge.jsp" /> 
<jsp:include page="fetchOwnerByTask.jsp" />
<jsp:include page="fetchTaskAgeForOwner.jsp" />
<jsp:include page="fetchTaskAgeForOwnerIndividual.jsp" />
<jsp:include page="fetchTaskAgeUserSplit.jsp" />

<% String d[][] = dashboard.DatabaseManager.getT2P_SPR_SelfCert();  
   String n[][] = dashboard.DatabaseManager.getT2P_SPR_NonSelfCert();  
   String c[][] = dashboard.DatabaseManager.getT2P_All();  
   Double t2p_sc =0.0;
   Double t2p_spr =0.0;
   Double t2p_All = 0.0;
%>


<% String q[] = dashboard.DatabaseManager.getQueue(); 
String flowqueue[][] = dashboard.DatabaseManager.getWorkflowQueue(); 
String taskqueue[][] = dashboard.DatabaseManager.getPdoxTasksQueue(); 

String queueAge[][] = dashboard.DatabaseManager.getQueueAgeSplit();
String ownerTask[][] = dashboard.DatabaseManager.getQueueOwnerByTaskAge();
%>

<div id = "averagePermitTimesTableDIV">
<form id = "table_selection">
	<table id = "averagePermitTimesTable" style = "background-color: #FFFAF6; border-style: groove; border-color: #FFFAF6; border-width: 1px;" align = "center">
		<tr style = "line-height: 3px">
			<td style = "height: 6px; text-align: center; width: 90%;" valign = "top">
				<h3>Average Task Times</h3>
			</td>
			
			<td style = "width: 10%; align: right;">
				<img src="img/helpIcon.ico" title = "Click for Help" alt="helpIcon" id = "helpIconButton2"  
					onmouseover = '' style = "cursor: pointer; width: 25px; height: 25px;" >		
			</td>
		</tr>
		
		<tr style = "line-height: 3px"> 
			<td  style = "height: 3px;" valign = "top" align = "center" colspan = 2>
				<div>
					<b>All</b>
					<input type = "radio"
						   name = "tableButtons"
						   id = "table3Button" 
						   onmouseover='' style='cursor: pointer;' 
						   onClick = "displayTasksCC(); table_selected();" checked>
						   	      		
					<b>Regular SPR</b>
					<input type = "radio"
						   name = "tableButtons"
						   id = "table2Button"
						    onmouseover='' style='cursor: pointer;' 
						   onClick = "displayTasksSPR(); table_selected();">
						   
		   			<b>Self Cert</b>
					<input type = "radio"
						   name = "tableButtons"
						   id = "table1Button"
						    onmouseover='' style='cursor: pointer;' 
						   onClick = "displayTasksSC(); table_selected();" >
				</div>
			<td>
		</tr>
	
		<tr>
			<td colspan = 2>					
				<div id = "combinedCertAverageDiv">	
					</div>
					
				<div id = "selfCertAverageTimesDiv"> 
					</div>
					
				<div id = "sprNonSelfCertAverageTimesDiv">	
					</div>		
			</td>
		</tr>
	</table>
</form>
</div>	
	
	
<div id = "taskQueueTableDIV">	
<form id = "taskQueForm">
	<table id = "taskQueueTable"  style = "background-color: #FFFAF6; border-style: groove; border-color: #FFFAF6; border-width: 1px;" align = "center">
		<tr style = "line-height: 3px;">
			<td style = "height: 6px; text-align: center; width: 90%;" valign = "top" >
				<h3><b>Task Queue Split</b></h3>
			</td>
			
			<td style = "width: 10%; align: right;">
				<img src="img/helpIcon.ico" title = "Click for Help" alt="helpIcon" id = "helpIconButton"  
				onmouseover = '' style = "cursor: pointer; width: 25px; height: 25px; " onClick = "help_button_clicked()" >		
			</td>
		</tr>

		<tr style = "line-height: 3px">
			<td  style = "height: 3px;" valign = "top" align = "center" colspan = 2>
				<div>
					<b>Task Count</b>	
					<input type = "radio"
						   name = "taskQueueButtons"
						   id = "taskCountTableButton"
						    onmouseover='' style='cursor: pointer;' 
						   onClick = "displayTaskCount(); task_table_selected();">
					
					<b>Task by Age</b>	
					<input type = "radio"
						   name = "taskQueueButtons"
						   id = "taskByAgeTableButton"
						    onmouseover='' style='cursor: pointer;'  
						   onClick = "displayTaskByAge(); task_table_selected();">
					   
	   				<b>Owner by Task Age</b>	
					<input type = "radio"
						   name = "taskQueueButtons"
						   id = "ownerByTaskAgeTableButton"
						    onmouseover='' style='cursor: pointer;' 
						   onClick = "displayOwnerByTask(); task_table_selected();">
			  	</div>	
			</td>
		</tr>

		
		<tr>
			<td colspan = 2>	
				<div id = "ownerTutorialPictureDIV">
					<img src="img/tutorial.PNG" alt="HowToNavigateThisTable" style=" width:400px; height:525px; ">		
				</div>
				
				<div id = "taskCountDiv">
				</div>
				
				<div id = "taskByAgeDiv">
				</div>
			
				<div id = "ownerByTaskAgeDiv">
				</div>
			</td>
		</tr>
	</table>
</form>
</div>

<div id = "messageBoardDIV">
	<table id = "messageBoardTable" >
		<tr>
			<td valign = top>
				<div id = "messageBoardTableScrollDIV">
					<p style= "font-size:8pt;" id="msgBoard"></p>
				</div>
			</td>
		</tr>
	</table>
</div>



<%-- 
*For loading the Time to Permit breakdown for self cert projects
--%>


	
<script type="text/javascript">
var adtHttp;
var t;
var adtmarker1;
function displayTaskAgeUserSplit(taskname) 
{
	console.log("Entering displayTaskAgeUserSplit()");
	document.getElementById("msgBoard").innerHTML = null;
		
	 adtHttp = GetXmlHttpObject();
	 
	if (adtHttp == null) {
	  alert ("Browser does not support HTTP Request");
	  return;} 
	
	 var url = "TaskAgeUserSplit_JSON.jsp?taskName="+taskname;
	 adtHttp.onreadystatechange = TaskAgeUserSplitStateChanged;
	 adtHttp.open("GET",url,true);
	 adtHttp.send(null);
	console.log("Exiting displayTaskAgeUserSplit()");
}
function TaskAgeUserSplitStateChanged() 
{ 	
	console.log("Entering TaskAgeUserSplitStateChanged()");
	if (adtHttp.readyState == 4 || adtHttp.readyState=="complete")
	{
		var at = eval('(' + adtHttp.responseText + ')');
		
		var ctl = at.taskAgeUserSplit.length;
		
		
		console.log(at.taskAgeUserSplit.length);
		
		console.log("INSIDE TaskAgeUserSplitStateChanged() of loop");
	
		var contentString;
		
		document.getElementById("msgBoard").style.backgroundColor = '#CCFFCC';
		
		if(ctl <= 0)
		{	
			document.getElementById("msgBoard").innerHTML = '<p>No Tasks assigned/All Task Completed</p>';
		}
		else
		{
			for (i=0; i <ctl; i++ ) 
			{ 
				if(i == 0)
				{
					document.getElementById("msgBoard").style.outline = "thin solid";			
					contentString =	
						"<table id = 'innerTable' style = 'outline: thin solid; width: 100%;'>" + 
							"<tr style = 'text-align: center;'>" + 
								"<td style = 'align: center; font-size:8pt;' colspan = 7>" + 
									"<b>" + at.taskAgeUserSplit[0].clickedThis + "</b>" + 
								"</td>" + 
							"</tr>" + 
							
							"<tr>" + 
								"<td>Owner</td><td>Total</td><td>0-15</td><td>16-30</td><td>31-50</td><td>51-100</td><td>101+</td>" + 
							"</tr>";
				}
				
				contentString = contentString + 
							'<tr style = "background-color: white;">' + 
							'<td style = "align: center; font-size:8pt;"><b>' + at.taskAgeUserSplit[i].userName + '</b></td><td>';
								
				if(at.taskAgeUserSplit[i].ct != "null")
				{
					contentString = contentString + at.taskAgeUserSplit[i].ct;
				}
				
				contentString = contentString + '</td>';
				
				if(at.taskAgeUserSplit[i].ftn != "null")
				{
					contentString = contentString + '<td style = "cursor: pointer;" onmouseover = "">' + at.taskAgeUserSplit[i].ftn + '</td>';
				// NEEDS WORK	
					contentString = contentString + "<span class = 'taskAgeUserSplitFtnSpan'>" + 
							'<a href=\'http://10.220.30.129:8080/Dashboard/AppDetails.jsp?prj='+at.tap[i].Name +'\' target=\'_blank\')>'+
								at.tap[i].Name + '</a><br>';
					
					/*
					contentString = '<a href=\'http://10.220.30.129:8080/Dashboard/AppDetails.jsp?prj='+at.tap[i].Name +'\' target=\'_blank\')>'+at.tap[i].Name ;
              		contentString = contentString + '</a><br>';
					*/
					
					
				}
				else
				{
					contentString = contentString + '<td></td>';
				}
				
				contentString = contentString + '<td>';
				
				if(at.taskAgeUserSplit[i].thirty != "null")
				{
					contentString = contentString + at.taskAgeUserSplit[i].thirty;
				}
				
				contentString = contentString + '</td><td>';
				
				if(at.taskAgeUserSplit[i].fifty != "null")
				{
					contentString = contentString + at.taskAgeUserSplit[i].fifty;
				}
				
				contentString = contentString + '</td><td>';				
				
				if(at.taskAgeUserSplit[i].hundred != "null")
				{
					contentString = contentString + at.taskAgeUserSplit[i].hundred;
				}
				
				contentString = contentString + '</td><td>';
				
				if(at.taskAgeUserSplit[i].hplus != "null")
				{
					contentString = contentString + at.taskAgeUserSplit[i].hplus;
				}
				
				contentString = contentString + '</td></tr>';	
			}
			document.getElementById("msgBoard").innerHTML = contentString + "</table>";
		}
	}
	console.log("TaskAgeUserSplitStateChanged()");
}
</script>
<html>
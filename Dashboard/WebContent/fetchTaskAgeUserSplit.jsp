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
					contentString = "<table id = 'innerTable' style = 'outline: thin solid; width: 100%;'><tr style = 'text-align: center;'><td style = 'align: center; font-size:8pt;' colspan = 2><b>" + at.taskAgeUserSplit[0].clickedThis + "</b></td></tr>";
				}
				
				contentString = contentString + '<tr style = "background-color: white;"><td style = "align: center; font-size:8pt;"><b>' +
								at.taskAgeUserSplit[i].userName + "</td><td>" + at.taskAgeUserSplit[i].ct + "</td></tr>";	
			}
			document.getElementById("msgBoard").innerHTML = contentString + "</table>";
		}		   			
   		//contentString = '<a href=\'http://10.220.30.129:8080/Dashboard/AppDetails.jsp?prj='+at.taskAgeForOwnerGroup[i].Name +'\' target=\'_blank\')>'+at.taskAgeForOwnerGroup[i].Name ;
   		//document.getElementById("msgBoard").innerHTML = document.getElementById("msgBoard").innerHTML + contentString + '</a><br>';
  			//	document.getElementById("msgBoard").innerHTML = document.getElementById("msgBoard").innerHTML + contentString;
	}
	console.log("TaskAgeUserSplitStateChanged()");
}

</script>
<html>
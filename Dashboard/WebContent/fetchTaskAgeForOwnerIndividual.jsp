<%-- 
*For loading the Time to Permit breakdown for self cert projects

--%>


	
<script type="text/javascript">

var adtHttp;
var t;
var adtmarker1;
 
function displayTaskAgeForOwnerIndividual(ownername)
{
	console.log("Entering displayTaskAgeForOwnerIndividual()");
	document.getElementById("msgBoard").innerHTML = null;
		
	 adtHttp = GetXmlHttpObject();
	 
	if (adtHttp == null) {
	  alert ("Browser does not support HTTP Request");
	  return;} 
	
	 var url = "taskAgeForOwnerIndividual_JSON.jsp?ownerName="+ownername;
	 adtHttp.onreadystatechange = ownerByTaskAgeIndividualStateChanged;
	 adtHttp.open("GET",url,true);
	 adtHttp.send(null);
	console.log("Exiting displayTaskAgeForOwnerIndividual()");	
}

function ownerByTaskAgeIndividualStateChanged() 
{ 	
	console.log("Entering ownerByTaskAgeStateChanged()");
	
	if (adtHttp.readyState == 4 || adtHttp.readyState=="complete")
	{
		var at = eval('(' + adtHttp.responseText + ')');
		
		console.log(at.taskAgeForOwnerIndividual.length);
	
		var ctl = at.taskAgeForOwnerIndividual.length;
		
		console.log(at.taskAgeForOwnerIndividual.length);
		
		
		console.log("INSIDE ownerByTaskAgeStateChanged() of loop");
	
		var contentString;
		document.getElementById("msgBoard").style.backgroundColor = '#B2FFFF';
		
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
					document.getElementById("msgBoard").style.overflowY = "none";
					contentString = 
						"<div id = 'taskAgeForOwnerIndividualSpanId' style = 'text-align: center; font-size: 14pt;'>Click on the clickable links below to get started!</div>" +
						"<div>" + 
							"<table id = 'innerTable' style = 'overflow-y: auto; height: 100%;outline: thin solid; width: 100%;'>" + 
								"<tr style = 'text-align: center;'>" + 
									"<td style = 'align: center; font-size:8pt;'>" +
										"<b>" + at.taskAgeForOwnerIndividual[0].nameOfClicked + "</b>" + 
									"</td>" + 
								"</tr>" + 
								
								"<tr>" +
									"<td style = 'width: 100%; overflow: hidden; text-overflow: ellipsis;'>Task</td><td>Total</td><td>0-15</td><td>16-30</td><td>31-50</td><td>51-100</td><td>101+</td>" +
								"</tr>";
				}
				
				contentString = contentString + 
								'<tr style = "background-color: white;">' + 
									'<td style = "align: center; font-size:8pt;">' +
										'<b>' +	at.taskAgeForOwnerIndividual[i].taskName + "</td>" + 
									"<td>" + at.taskAgeForOwnerIndividual[i].ct + "</td>" + 
								"</tr>";	
			
		   		//contentString = '<a href=\'http://10.220.30.129:8080/Dashboard/AppDetails.jsp?prj='+at.taskAgeForOwnerIndividual[i].Name +'\' target=\'_blank\')>'+at.taskAgeForOwnerIndividual[i].Name ;
		   		//document.getElementById("msgBoard").innerHTML = document.getElementById("msgBoard").innerHTML + contentString + '</a><br>';
	   			//	document.getElementById("msgBoard").innerHTML = document.getElementById("msgBoard").innerHTML + contentString;
			}
			document.getElementById("msgBoard").innerHTML = contentString + 
							"</table>" + 
						"</div>";
		}
	}
	console.log("ownerByTaskAgeStateChanged()");
}

</script>

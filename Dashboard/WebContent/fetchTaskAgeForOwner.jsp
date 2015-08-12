<%-- 
*For loading the Time to Permit breakdown for self cert projects

--%>


	
<script type="text/javascript">

var adtHttp;
var t;
var adtmarker1;


function displayTaskAgeForOwnerGroup(groupname) 
{
	console.log("Entering displayTaskAgeForOwnerGroup()");
	document.getElementById("msgBoard").innerHTML = null;
		
	 adtHttp = GetXmlHttpObject();
	 
	if (adtHttp == null) {
	  alert ("Browser does not support HTTP Request");
	  return;} 
	
	 var url = "taskAgeForOwner_JSON.jsp?groupName="+groupname;
	 adtHttp.onreadystatechange = ownerByTaskAgeStateChanged;
	 adtHttp.open("GET",url,true);
	 adtHttp.send(null);
	console.log("Exiting displayTaskAgeForOwnerGroup()");
}

function ownerByTaskAgeStateChanged() 
{ 	
	console.log("Entering ownerByTaskAgeStateChanged()");

	if (adtHttp.readyState == 4 || adtHttp.readyState=="complete")
	{
		var at = eval('(' + adtHttp.responseText + ')');
		
		var ctl = at.taskAgeForOwnerGroup.length;
		
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
						"<div id = 'taskAgeForOwnerGroupSpanId' style = 'text-align: center; font-size: 14pt;'>Click on the clickable links below to get started!</div>" +
						"<div>" + 			
							"<table id = 'innerTable' style = 'outline: overflow-y: auto; height: 100%;thin solid; width: 100%;'>" + 
								"<tr style = 'text-align: center;'>" + 
									"<td style = 'align: center; font-size:8pt;'>" + 
										"<b>" + at.taskAgeForOwnerGroup[0].nameOfClicked + "</b>" + 
									"</td>" +
								"</tr>" + 
								
								"<tr>" +
									"<td style = 'width: 100%; overflow: hidden; text-overflow: ellipsis;'>Task</td><td>Total</td><td>0-15</td><td>16-30</td><td>31-50</td><td>51-100</td><td>101+</td>" +
								"</tr>";
				}
				
				contentString = contentString + 
								'<tr style = "background-color: white;">' + 
									'<td style = "align: center; font-size:8pt;">' + 
										'<b>' + at.taskAgeForOwnerGroup[i].groupName + "</td>" + 
									"<td>" + at.taskAgeForOwnerGroup[i].ct + "</td>" + 
								"</tr>";	
			}
			document.getElementById("msgBoard").innerHTML = contentString + 
								"</table>" + 
							"</div>";
		}		
	}
	console.log("ownerByTaskAgeStateChanged()");
}

</script>

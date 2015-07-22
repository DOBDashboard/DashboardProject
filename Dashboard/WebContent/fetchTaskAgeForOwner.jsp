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
		
		
		console.log(at.taskAgeForOwnerGroup.length);
				
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
					contentString = "<table id = 'innerTable' style = 'outline: thin solid; width: 100%;'><tr style = 'text-align: center;'><td style = 'align: center; font-size:8pt;' colspan = 2><b>" + at.taskAgeForOwnerGroup[0].nameOfClicked + "</b></td></tr>";
				}
				
				contentString = contentString + '<tr style = "background-color: white;"><td style = "align: center; font-size:8pt;"><b>' +
								at.taskAgeForOwnerGroup[i].groupName + "</td><td>" + at.taskAgeForOwnerGroup[i].ct + "</td></tr>";	
			}
			document.getElementById("msgBoard").innerHTML = contentString + "</table>";
		}		
	}
	console.log("ownerByTaskAgeStateChanged()");
}

</script>

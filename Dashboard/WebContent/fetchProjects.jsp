<%-- 
*For loading the Project Names of Projects with matching Task Name and Task Age

**Markers will be displayed only when the user checks the ADT check box
--%>


	
<script type="text/javascript">

var adtHttp;
var t;
var adtmarker1;

function displayPrjs(task, age) 
{
	console.log("Entering displayPrjs()");
	document.getElementById("msgBoard").innerHTML = null;
		
	adtHttp = GetXmlHttpObject();
		 
	if (adtHttp == null) 
	{
	  alert ("Browser does not support HTTP Request");
	  return;
	 } 

	 var url="TaskAgeProjects_JSON.jsp?tname="+task+"&range="+age;
	 adtHttp.onreadystatechange = ADTstateChanged;
	 adtHttp.open("GET",url,true);
	 adtHttp.send(null);
	 
	console.log("Exiting displayPrjs()");
}

function displayPrjsOwnerGroupTask(task, age) 
{
	console.log("Entering displayPrjsOwnerGroupTask()");

	document.getElementById("msgBoard").innerHTML = null;
		
	adtHttp = GetXmlHttpObject();
			 
	if (adtHttp == null) 
	{
	  alert ("Browser does not support HTTP Request");
	  return;
	 } 
	
	 var url="OwnerTaskGroupProjects_JSON.jsp?tname="+task+"&range="+age;
	 adtHttp.onreadystatechange = ADTstateChanged;
	 adtHttp.open("GET",url,true);
	 adtHttp.send(null);
	 
	console.log("Exitng displayPrjsOwnerGroupTask()");
}

function displayPrjsOwnerIndividualTask(task, age)
{
	console.log("Entering displayPrjsOwnerIndividualTask()");

	document.getElementById("msgBoard").innerHTML = null;
	
	adtHttp = GetXmlHttpObject();

	if (adtHttp == null) 
	{
		  alert ("Browser does not support HTTP Request");
		  return;
	} 
	
	 var url="OwnerTaskIndividualProjects_JSON.jsp?tname="+task+"&range="+age;
	 adtHttp.onreadystatechange = ADTstateChanged;
	 adtHttp.open("GET",url,true);
	 adtHttp.send(null);
	 
	console.log("Exiting displayPrjsOwnerIndividualTask()");
}

function searchProject(searchThisProject) 
{
	console.log("Entering searchProject()");

	document.getElementById("msgBoard").innerHTML = null;
		
	adtHttp = GetXmlHttpObject();
			 
	if (adtHttp == null) 
	{
	  alert ("Browser does not support HTTP Request");
	  return;
	 } 
	//alert("-"+searchThisProject + "-");
	 var url="SearchProjects.jsp?projectName="+searchThisProject;
	 adtHttp.onreadystatechange = ADTstateChanged;
	 adtHttp.open("GET",url,true);
	 adtHttp.send(null);
	 
	console.log("Exiting searchProject()");
}

function ADTstateChanged() 
{ 	
	console.log("Entering ADTstateChanged()");
	
	if (adtHttp.readyState == 4 || adtHttp.readyState=="complete")
	{
		//alert("one");
		var at = eval('(' + adtHttp.responseText + ')');
		//alert(at);
		console.log("Inside of if() inside ADTstateChanged()");
		var ctl = at.tap.length;
		//alert(ctl);
		var headerString;
		console.log("INSIDE ADTstateChanged() of loop");
		var counter = 0;
		
		for (i=0; i <ctl; i++ ) 
		{ 
			var contentString;
			// CHANGE MADE HERE!
      		
			
			//str1.toLowerCase().contains(str2.toLowerCase())
      		//if(i == 0 && at.tap[0].HeaderName == "Search Project" && at.tap[0].Name == at.tap[0].SearchName)
			if(at.tap[0].HeaderName == "Search Project")
      		{
      			console.log("----Search Project" + at.tap[i].Name);
				if(i == 0)
      			{
      				document.getElementById("msgBoard").style.backgroundColor = '#33CCFF';
      				contentString = '<a href=\'http://10.220.30.129:8080/Dashboard/AppDetails.jsp?prj='+at.tap[i].Name +'\' target=\'_blank\')>'+at.tap[i].Name ;
              		contentString = contentString + '</a><br>';
              		
              		counter++; 
              		
              		if(ctl == i+1)
              		{
              			headingString = "<p style = 'text-align: center;'><b>" + counter + " Match found!</b></p>"; 
              			document.getElementById("msgBoard").innerHTML = headingString + contentString;
              			
              			break;
              		}
      			}
      			else
      			{
      	   			contentString = contentString + '<a href=\'http://10.220.30.129:8080/Dashboard/AppDetails.jsp?prj='+at.tap[i].Name +'\' target=\'_blank\')>'+at.tap[i].Name ;
              		contentString = contentString + '</a><br>';
              		
              		counter++;
              		
          			headingString = "<p style = 'text-align: center;'><b>" + counter + " Match found!</b></p>"; 
          			document.getElementById("msgBoard").innerHTML = headingString + contentString;   				
      			}
      			
   				
      			
			}
			else 
			{
				if(i == 0 && at.tap[0].HeaderName == "Task Age")
	   			{
					document.getElementById("msgBoard").style.backgroundColor = '#CCFFCC';
					
					document.getElementById("msgBoard").innerHTML = document.getElementById("msgBoard").innerHTML + 
	   						'<p style = "align: center; font-size:8pt;"><b>Task Age ' +
	   						" for " + at.tap[i].TaskName + " at " + at.tap[i].Range + "</b></p>";	
	   				
	   			}
	   			else if(i == 0 && at.tap[0].HeaderName == "Owner Task")
	   			{
	   				document.getElementById("msgBoard").style.backgroundColor = '#B2FFFF';
	   				document.getElementById("msgBoard").innerHTML = document.getElementById("msgBoard").innerHTML + 
	   						'<p style = "align: center; font-size:8pt;"><b>Owner by Task Age ' +
	   						" for " + at.tap[i].GroupName + " at " + at.tap[i].Range + "</b></p>";	
	   				
	   			}
			   			   			
		   		contentString = '<a href=\'http://10.220.30.129:8080/Dashboard/AppDetails.jsp?prj='+at.tap[i].Name +'\' target=\'_blank\')>'+at.tap[i].Name ;
		   		document.getElementById("msgBoard").innerHTML = document.getElementById("msgBoard").innerHTML + contentString + '</a><br>';
			}
		}
		
		
	}
	console.log("Exiting ADTstateChanged()");
}

function GetXmlHttpObject()
{
var xmlHttp=null;
try
  {
  // Firefox, Opera 8.0+, Safari
  xmlHttp=new XMLHttpRequest();
  }
catch (e)
  {
  // Internet Explorer
  try
    {
    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }
  catch (e)
    {
    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
  }
return xmlHttp;
} 


</script>


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

function clearContent()
{
	document.getElementById("msgBoard").innerHTML = "";
}


$("#searchButton").click(function() {
    $('html,body').animate({
        scrollTop: $("#msgBoard").offset().top},
        'slow');
});

$("#searchProjectsDIV").keypress(function(event){
    if(event.keyCode == 13){
     $('#searchButton').click();
      //  validate(); doesn't need to be called from here
    }
});



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
		
		var headerString;
		console.log("INSIDE ADTstateChanged() of loop");
		var counter = 0;
		
		// project not found 
		// also do clear result button
		if(ctl == 0)
		{
			document.getElementById("msgBoard").style.backgroundColor = '#33CCFF';
			document.getElementById("msgBoard").style.align = "center";
			document.getElementById("msgBoard").style.textAlign = "center";
			contentString = "<p style = 'font-size = 22pt;'><b>Project doesn't exist!</b></p>";
			/*document.getElementById("msgBoard").innerHTML = contentString + 
			"<img src = 'img/sadImage.jpeg' style = 'width: 150px; height; height: 150px;'>";
			*/
			document.getElementById("msgBoard").innerHTML = contentString + 
				"<img src = 'img/notFound.jpg' style = 'width: 150px; height; height: 150px;'>" + 
				"<br>" +
				"<input type = 'button' value = 'Clear Content' id = 'clearMsgBoard' onClick = 'clearContent();'>";
			return;
			
		}
		
		for (i=0; i <ctl; i++ ) 
		{ 
			var contentString;
			document.getElementById("msgBoard").style.align = "left";
			document.getElementById("msgBoard").style.textAlign = "left";

			
			if(at.tap[0].HeaderName == "Search Project")
      		{
				// if only 1 match is found
      			//alert(at.tap[i].Name);
				if(i == 0)
      			{
					
					console.log("i is 0");
					console.log("----Search Project" + at.tap[i].Name);
					
					document.getElementById("msgBoard").style.backgroundColor = '#33CCFF';
      				contentString = '<a href=\'http://10.220.30.129:8080/Dashboard/AppDetails.jsp?prj='+at.tap[i].Name +'\' target=\'_blank\')>'+at.tap[i].Name ;
              		contentString = contentString + '</a><br>';
              		
              		counter++; 
              		
              		if(ctl == i+1)
              		{
              			headingString = "<p style = 'text-align: center;'><b>" + counter + " Match found!</b></p>"; 
              			document.getElementById("msgBoard").innerHTML = headingString + contentString;
              			
              			return;
              		}
      			}
      			else
      			{
      				console.log("i is more than 0----");
      				console.log("----Search Project" + at.tap[i].Name);
      				
      	   			contentString = contentString + '<a href=\'http://10.220.30.129:8080/Dashboard/AppDetails.jsp?prj='+at.tap[i].Name +'\' target=\'_blank\')>'+at.tap[i].Name ;
              		contentString = contentString + '</a><br>';
              		
              		counter++;
              		
          			headingString = "<p style = 'text-align: center;'><b>" + counter + " Match found!</b></p>"; 
          			document.getElementById("msgBoard").innerHTML = headingString + contentString; 
          		
          			if(ctl == i+1)
              		{
              			headingString = "<p style = 'text-align: center;'><b>" + counter + " Match found!</b></p>"; 
              			document.getElementById("msgBoard").innerHTML = headingString + contentString + 
		        				"<br>" +
		        				"<input type = 'button' value = 'Clear Content' id = 'clearMsgBoard' onClick = 'clearContent();'>";
              			
              			return;
              		}
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
			   	
				if(i%2 == 0)
				{
			   		contentString = '<a style = "color: #FF3399;" href=\'http://10.220.30.129:8080/Dashboard/AppDetails.jsp?prj='+at.tap[i].Name +'\' target=\'_blank\')>'+at.tap[i].Name ;
			   		document.getElementById("msgBoard").innerHTML = document.getElementById("msgBoard").innerHTML + contentString + '</a><br>';
				}
				else
				{
			   		contentString = '<a style = "color: #0066CC;" href=\'http://10.220.30.129:8080/Dashboard/AppDetails.jsp?prj='+at.tap[i].Name +'\' target=\'_blank\')>'+at.tap[i].Name ;
			   		document.getElementById("msgBoard").innerHTML = document.getElementById("msgBoard").innerHTML + contentString + '</a><br>';
				}
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


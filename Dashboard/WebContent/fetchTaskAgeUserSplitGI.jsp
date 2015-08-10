<script type="text/javascript">
var adtHttp;
var t;


function displayTaskAgeUserSplitIndividual(taskname, ownername, ranges) 
{
	console.log("Entering displayTaskAgeUserSplitIndividual()");
	
	 adtHttp = GetXmlHttpObject();
	 
	if (adtHttp == null) {
	  alert ("Browser does not support HTTP Request");
	  return;} 
	
	 var url = "TaskAgeUserSplitIndividual_JSON.jsp?taskname="+taskname+"&ownername="+ownername+"&ranges="+ranges;
	 adtHttp.onreadystatechange = TaskAgeUserSplitGIStateChanged;
	 adtHttp.open("GET",url,true);
	 adtHttp.send(null);
	console.log("Exiting displayTaskAgeUserSplitIndividual()");
}

function displayTaskAgeUserSplitGroup(taskname, ownername, ranges) 
{
	console.log("Entering displayTaskAgeUserSplitGroup()");
	
	 adtHttp = GetXmlHttpObject();
	 
	if (adtHttp == null) {
	  alert ("Browser does not support HTTP Request");
	  return;} 
	
	 var url = "TaskAgeUserSplitGroup_JSON.jsp?taskname="+taskname+"&ownername="+ownername+"&ranges="+ranges;
	 adtHttp.onreadystatechange = TaskAgeUserSplitGIStateChanged;
	 adtHttp.open("GET",url,true);
	 adtHttp.send(null);
	console.log("Exiting displayTaskAgeUserSplitGroup()");
}

function moveTheSpan()
{
	console.log("Inside moveTheSpan()...");
	
	var tooltipSpan = document.getElementById('taskUserSplitSpanId');
	
	var mouseX = thisX;
	var mouseY = thisY;
	
	/*
	$('#msgBoard').mousemove( function(e) {
	   mouseX = e.pageX; 
	   mouseY = e.pageY;
	});  
	$(".classForHoverEffect").mouseover(function(){
	  $('#DivToShow').css({'top':mouseY,'left':mouseX}).fadeIn('slow');
	});
	*/
	
	
	
/*	document.getElementById('msgBoard').onmousemove = function (e) {
		
		mouseX = e.offsetX;
		mouseY = e.offsetY;
	    
//	    mouseX = e.clientX;
//	    mouseY = e.clientY;
		console.log("---------------------------------");
		console.log(mouseX);
		console.log(mouseY);
		console.log("---------------------------------");
	};
*/	
	console.log("---------------------------------");
	console.log(mouseX);
	console.log(mouseY);
	console.log("---------------------------------");
	
	    tooltipSpan.style.top = mouseX + 'px';
	    tooltipSpan.style.left = mouseY + 'px';
	    
	
	
	
}

function TaskAgeUserSplitGIStateChanged() 
{ 	
	console.log("Entering TaskAgeUserSplitGIStateChanged()");
	if (adtHttp.readyState == 4 || adtHttp.readyState=="complete")
	{
		var at = eval('(' + adtHttp.responseText + ')');
		
		var ctl = at.taskAgeUserSplitInside.length;
		
	
		console.log(at.taskAgeUserSplitInside.length);
		
		console.log("INSIDE TaskAgeUserSplitGIStateChanged() of loop");
	
		var contentString = null;
		//document.getElementById("taskUserSplitSpanId").innerHTML = null;
		//moveTheSpan();		
		for (i=0; i <ctl; i++ ) 
		{
			if(at.taskAgeUserSplitInside[i].typeIs == "Individual")
			{
				if(i == 0)
				{	
					
					//contentString = "<span>" + at.taskAgeUserSplitInside[i].prj + "</span><br>";
					
					contentString = '<a style = "color: white;" href=\'http://10.220.30.129:8080/Dashboard/AppDetails.jsp?prj=' +
					at.taskAgeUserSplitInside[i].prj +
							'\' target=\'_blank\')>'+at.taskAgeUserSplitInside[i].prj + "<br>";
				
				}
				else if(i > 0)
				{
						contentString = contentString + 
						'<a style = "color: white;" href=\'http://10.220.30.129:8080/Dashboard/AppDetails.jsp?prj=' +
						at.taskAgeUserSplitInside[i].prj +
						'\' target=\'_blank\')>'+at.taskAgeUserSplitInside[i].prj + "<br>";
				}
			}
			else if(at.taskAgeUserSplitInside[i].typeIs == "Group")
			{
				if(i == 0)
				{	
					
					//contentString = "<span>" + at.taskAgeUserSplitInside[i].prj + "</span><br>";
					
					contentString = '<a style = "color: white;" href=\'http://10.220.30.129:8080/Dashboard/AppDetails.jsp?prj=' +
					at.taskAgeUserSplitInside[i].prj +
							'\' target=\'_blank\')>'+at.taskAgeUserSplitInside[i].prj + "<br>";
				
				}
				else if(i > 0)
				{
						contentString = contentString + 
						'<a style = "color: white;" href=\'http://10.220.30.129:8080/Dashboard/AppDetails.jsp?prj=' +
						at.taskAgeUserSplitInside[i].prj +
						'\' target=\'_blank\')>'+at.taskAgeUserSplitInside[i].prj + "<br>";
				}
			}
			else
			{
				//hope it never gets here, because it shouldn't
				alert("Inside unwanted else inside fetchTaskAgeUserSplitGI.jsp");				
			}
			
			// printing general detail respective of click in console
			console.log("i is: " + i);
			console.log("at.taskAgeUserSplitInside[i].typeIs: " + at.taskAgeUserSplitInside[i].typeIs);
			console.log("at.taskAgeUserSplitInside[i].prj: " + at.taskAgeUserSplitInside[i].prj);
		}
		document.getElementById("taskUserSplitSpanId").style.fontSize = "8pt";
		document.getElementById("taskUserSplitSpanId").style.textAlign = "left";
		
		document.getElementById("taskUserSplitSpanId").innerHTML = contentString;
	//	document.getElementById("taskUserSplitSpanId").innerHTML = contentString;
	//	document.getElementsByClassName('taskUserSplitSpanId').style.display = 'block';
		console.log("----------------------------------");
		console.log(contentString);
		console.log("----------------------------------");
		
	}
	
	console.log("Exiting TaskAgeUserSplitStateChanged()");
}
</script>
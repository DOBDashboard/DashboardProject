<%-- 
*For loading the Time to Permit breakdown for self cert projects
--%>

<script type="text/javascript">

var adtHttp;
var t;

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


function moveTheSpanNot()
{
	console.log("Inside moveTheSpan()...");
	
	document.getElementById("taskUserSplitSpanId").style.display = "none"; 	
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
					document.getElementById("msgBoard").style.overflowY = "none";
					contentString =	
						
						"<div id = 'taskUserSplitSpanId' style = 'height: 100px; font-size: 14pt'> Click on the clickable links below to get started!</div>" +
			
						
						"<table id = 'taskbyAgeUserSpanTable' style ='outline: thin solid;'>" + 
							"<thead>"+
								'<tr style ="text-align: center"><th style="width: 240px" colspan = 7><b>' + at.taskAgeUserSplit[0].clickedThis + "</b></th></tr>" +
							"</thead>" +
							"<thead>" +	
								"<tr>" + 
									'<th style="width: 100px">Owner</th>'+ 
									'<th style="width: 20px">Total</th>'+
									'<th style="width: 13px">0-15</th>'+
									'<th style="width: 13px">16-30</th>'+
									'<th style="width: 13px">31-50</th>'+
									'<th style="width: 14px">51-100</th>'+
									'<th style="width: 15px">101+</th>'+ 
								"</tr>" + 
							"</thead>" +
							
							"<tbody id = 'taskUserSplitSpanIdBody'>";
				}
				
				contentString = contentString + 
							'<tr style = "background-color: white;">' + 
							'<td style = "align: center; font-size: 8pt, width: 145px;">' + at.taskAgeUserSplit[i].userName.substring(2) + '</td><td style="width: 23px">';
								
				if(at.taskAgeUserSplit[i].ct != "null")
				{
					contentString = contentString + at.taskAgeUserSplit[i].ct;
				}
				
				contentString = contentString + '</td>';
				
				
				if(at.taskAgeUserSplit[i].ftn != "null")
				{
    	    		if(at.taskAgeUserSplit[i].userName[0] == "P")
    	    		{
    	    			if(i == 0)
    	    			{
    	    				
    	    				contentString = contentString + '<td style= "width: 14px">' + 

								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
								 
									"onClick='displayTaskAgeUserSplitIndividual(\"" + 
									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
									"\", \"0-15\");' value='" + 
									at.taskAgeUserSplit[i].ftn + "'>" + at.taskAgeUserSplit[i].ftn +
								"</label>" +
								
							"</td>"; 
    	    			}
    	    			else
    	    			{
    	    				contentString = contentString + '<td style="width: 14px">' + 
    							
    								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
    							
										"onClick='displayTaskAgeUserSplitIndividual(\"" + 
    									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
    									"\", \"0-15\");' value='" + 
    									at.taskAgeUserSplit[i].ftn + "'>" + at.taskAgeUserSplit[i].ftn +
    								"</label>" +
    								
    							"</td>"; 
    	    			}

    	    			console.log(contentString);
    	    			
    	    			console.log("---Clicked this: " + at.taskAgeUserSplit[i].clickedThis);
    	    			console.log("---ftn is: " + at.taskAgeUserSplit[i].ftn);
    	    			
    	    			console.log("Inside fifteen-------------------------");
    	    		}	
    	    		else if(at.taskAgeUserSplit[i].userName[0] == "G")
    	    		{
    	    			if(i == 0)
    	    			{
    	    				
    	    				contentString = contentString + '<td style="width: 14px">' + 
						
							
								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
								
									"onClick='displayTaskAgeUserSplitGroup(\"" + 
									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
									"\", \"0-15\");' value='" + 
									at.taskAgeUserSplit[i].ftn + "'>" + at.taskAgeUserSplit[i].ftn +
								"</label>" +
								
							"</td>"; 
    	    			}
    	    			else
    	    			{
    	    				contentString = contentString + '<td style="width: 14px">' + 
    						
    								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
    							
										"onClick='displayTaskAgeUserSplitGroup(\"" + 
    									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
    									"\", \"0-15\");' value='" + 
    									at.taskAgeUserSplit[i].ftn + "'>" + at.taskAgeUserSplit[i].ftn +
    								"</label>" +
    								
    							"</td>"; 
    	    			}
								
								
						
    	    			console.log(contentString);
    	    			
    	    			console.log("---Clicked this: " + at.taskAgeUserSplit[i].clickedThis);
    	    			console.log("---ftn is: " + at.taskAgeUserSplit[i].ftn);
    	    			
    	    			console.log("Inside fifteen-------------------------");
    	    		}
    	    		else
    	    		{
    	    			alert("Error! Shouldn't have gotten here!");
    	    		}
				}
				else
				{
					contentString = contentString + '<td style="width: 14px"></td>';
				}
				
				
				if(at.taskAgeUserSplit[i].thirty != "null")
				{

					if(at.taskAgeUserSplit[i].userName[0] == "P")
    	    		{
    	    			if(i == 0)
    	    			{
    	    				
    	    				contentString = contentString + '<td style="width: 14px">' + 
						
							
								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 

									"onClick='displayTaskAgeUserSplitIndividual(\"" + 
									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
									"\", \"16-30\");' value='" + 
									at.taskAgeUserSplit[i].thirty + "'>" + at.taskAgeUserSplit[i].thirty +
								"</label>" +
								
							"</td>"; 
    	    			}
    	    			else
    	    			{
    	    				contentString = contentString + '<td style="width: 14px">' + 
 
    							
    								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
 
										"onClick='displayTaskAgeUserSplitIndividual(\"" + 
    									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
    									"\", \"16-30\");' value='" + 
    									at.taskAgeUserSplit[i].thirty + "'>" + at.taskAgeUserSplit[i].thirty +
    								"</label>" +
    								
    							"</td>"; 
    	    			}
    	    			
								
								
						
    	    			console.log(contentString);
    	    			
    	    			console.log("---Clicked this: " + at.taskAgeUserSplit[i].clickedThis);
    	    			console.log("---ftn is: " + at.taskAgeUserSplit[i].thirty);
    	    			
    	    			console.log("Inside thirty-------------------------");
    	    		}
					else if(at.taskAgeUserSplit[i].userName[0] == "G")
    	    		{
    	    			if(i == 0)
    	    			{
    	    				
    	    				contentString = contentString + '<td style="width: 14px">' + 
						
							
								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 

									"onClick='displayTaskAgeUserSplitGroup(\"" + 
									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
									"\", \"16-30\");' value='" + 
									at.taskAgeUserSplit[i].thirty + "'>" + at.taskAgeUserSplit[i].thirty +
								"</label>" +
								
							"</td>"; 
    	    			}
    	    			else
    	    			{
    	    				contentString = contentString + '<td style="width: 14px">' + 
 
    								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 

										"onClick='displayTaskAgeUserSplitGroup(\"" + 
    									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
    									"\", \"16-30\");' value='" + 
    									at.taskAgeUserSplit[i].thirty + "'>" + at.taskAgeUserSplit[i].thirty +
    								"</label>" +
    								
    							"</td>"; 
    	    			}
    	    			
    	    			console.log(contentString);
    	    			
    	    			console.log("---Clicked this: " + at.taskAgeUserSplit[i].clickedThis);
    	    			console.log("---ftn is: " + at.taskAgeUserSplit[i].thirty);
    	    			
    	    			console.log("Inside thirty-------------------------");
    	    		}
					else
    	    		{
    	    			alert("Error! Shouldn't have gotten here!");
    	    		}
				}
				else
				{
					contentString = contentString + '<td style="width: 14px"></td>';
				}
				
				if(at.taskAgeUserSplit[i].fifty != "null")
				{

					if(at.taskAgeUserSplit[i].userName[0] == "P")
    	    		{
    	    			if(i == 0)
    	    			{
    	    				
    	    				contentString = contentString + '<td style="width: 14px">' + 
						
							
								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 

									"onClick='displayTaskAgeUserSplitIndividual(\"" + 
									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
									"\", \"31-50\");' value='" + 
									at.taskAgeUserSplit[i].fifty + "'>" + at.taskAgeUserSplit[i].fifty +
								"</label>" +
								
							"</td>"; 
    	    			}
    	    			else
    	    			{
    	    				contentString = contentString + '<td style="width: 14px">' + 

    								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
    							
										"onClick='displayTaskAgeUserSplitIndividual(\"" + 
    									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
    									"\", \"31-50\");' value='" + 
    									at.taskAgeUserSplit[i].fifty + "'>" + at.taskAgeUserSplit[i].fifty +
    								"</label>" +
    								
    							"</td>"; 
    	    			}
    	    			
								
								
						
    	    			console.log(contentString);
    	    			
    	    			console.log("---Clicked this: " + at.taskAgeUserSplit[i].clickedThis);
    	    			console.log("---ftn is: " + at.taskAgeUserSplit[i].fifty);
    	    			
    	    			console.log("Inside fifty-------------------------");
    	    		}
					else if(at.taskAgeUserSplit[i].userName[0] == "G")
    	    		{
    	    			if(i == 0)
    	    			{
    	    				
    	    				contentString = contentString + '<td style="width: 14px">' + 
						
							
								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
						 
									"onClick='displayTaskAgeUserSplitGroup(\"" + 
									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
									"\", \"31-50\");' value='" + 
									at.taskAgeUserSplit[i].fifty + "'>" + at.taskAgeUserSplit[i].fifty +
								"</label>" +
								
							"</td>"; 
    	    			}
    	    			else
    	    			{
    	    				contentString = contentString + '<td style="width: 14px">' + 
    							
    								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 

										"onClick='displayTaskAgeUserSplitGroup(\"" + 
    									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
    									"\", \"31-50\");' value='" + 
    									at.taskAgeUserSplit[i].fifty + "'>" + at.taskAgeUserSplit[i].fifty +
    								"</label>" +
    								
    							"</td>"; 
    	    			}
    	    			
								
								
						
    	    			console.log(contentString);
    	    			
    	    			console.log("---Clicked this: " + at.taskAgeUserSplit[i].clickedThis);
    	    			console.log("---ftn is: " + at.taskAgeUserSplit[i].fifty);
    	    			
    	    			console.log("Inside fifty-------------------------");
    	    		}
					else
    	    		{
    	    			alert("Error! Shouldn't have gotten here!");
    	    		}
				}
				else
				{
					contentString = contentString + '<td style="width: 14px"></td>';
				}			
				
				if(at.taskAgeUserSplit[i].hundred != "null")
				{

					if(at.taskAgeUserSplit[i].userName[0] == "P")
    	    		{
    	    			if(i == 0)
    	    			{
    	    				
    	    				contentString = contentString + '<td style="width: 14px">' + 
						
							
								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
 
									"onClick='displayTaskAgeUserSplitIndividual(\"" + 
									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
									"\", \"51-100\");' value='" + 
									at.taskAgeUserSplit[i].hundred + "'>" + at.taskAgeUserSplit[i].hundred +
								"</label>" +
								
							"</td>"; 
    	    			}
    	    			else
    	    			{
    	    				contentString = contentString + '<td style="width: 14px">' + 
 
    							
    								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 

										"onClick='displayTaskAgeUserSplitIndividual(\"" + 
    									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
    									"\", \"51-100\");' value='" + 
    									at.taskAgeUserSplit[i].hundred + "'>" + at.taskAgeUserSplit[i].hundred +
    								"</label>" +
    								
    							"</td>"; 
    	    			}
								
								
						
    	    			console.log(contentString);
    	    			
    	    			console.log("---Clicked this: " + at.taskAgeUserSplit[i].clickedThis);
    	    			console.log("---ftn is: " + at.taskAgeUserSplit[i].hundred);
    	    			
    	    			console.log("Inside hundred-------------------------");
    	    		}
					else if(at.taskAgeUserSplit[i].userName[0] == "G")
    	    		{
    	    			if(i == 0)
    	    			{
    	    				
    	    				contentString = contentString + '<td style="width: 14px">' + 
						
							
								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 

									"onClick='displayTaskAgeUserSplitGroup(\"" + 
									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
									"\", \"51-100\");' value='" + 
									at.taskAgeUserSplit[i].hundred + "'>" + at.taskAgeUserSplit[i].hundred +
								"</label>" +
								
							"</td>"; 
    	    			}
    	    			else
    	    			{
    	    				contentString = contentString + '<td style="width: 14px">' + 
						
    								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 

										"onClick='displayTaskAgeUserSplitGroup(\"" + 
    									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
    									"\", \"51-100\");' value='" + 
    									at.taskAgeUserSplit[i].hundred + "'>" + at.taskAgeUserSplit[i].hundred +
    								"</label>" +
    								
    							"</td>"; 
    	    			}
								
								
						
    	    			console.log(contentString);
    	    			
    	    			console.log("---Clicked this: " + at.taskAgeUserSplit[i].clickedThis);
    	    			console.log("---ftn is: " + at.taskAgeUserSplit[i].hundred);
    	    			
    	    			console.log("Inside hundred-------------------------");
    	    		}
					else
    	    		{
    	    			alert("Error! Shouldn't have gotten here!");
    	    		}
				}
				else
				{
					contentString = contentString + '<td style="width: 14px"></td>';
				}
				
				if(at.taskAgeUserSplit[i].hplus != "null")
				{

					if(at.taskAgeUserSplit[i].userName[0] == "P")
    	    		{
    	    			if(i == 0)
    	    			{
    	    				
    	    				contentString = contentString + '<td style="width: 15px">' + 
						
							
								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 

									"onClick='displayTaskAgeUserSplitIndividual(\"" + 
									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
									"\", \"101-1000\");' value='" + 
									at.taskAgeUserSplit[i].hplus + "'>" + at.taskAgeUserSplit[i].hplus +
								"</label>" +
								
							"</td>"; 
    	    			}
    	    			else
    	    			{
    	    				contentString = contentString + '<td style="width: 15px">' + 

    								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
    					
										"onClick='displayTaskAgeUserSplitIndividual(\"" + 
    									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
    									"\", \"101-1000\");' value='" + 
    									at.taskAgeUserSplit[i].hplus + "'>" + at.taskAgeUserSplit[i].hplus +
    								"</label>" +
    								
    							"</td>"; 
    	    			}
								
								
						
    	    			console.log(contentString);
    	    			
    	    			console.log("---Clicked this: " + at.taskAgeUserSplit[i].clickedThis);
    	    			console.log("---ftn is: " + at.taskAgeUserSplit[i].hplus);
    	    			
    	    			console.log("Inside hplus-------------------------");
    	    		}
					else if(at.taskAgeUserSplit[i].userName[0] == "G")
    	    		{
    	    			if(i == 0)
    	    			{
    	    				
    	    				contentString = contentString + '<td style="width: 15px">' + 
						
							
								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 

									"onClick='displayTaskAgeUserSplitGroup(\"" + 
									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
									"\", \"101-1000\");' value='" + 
									at.taskAgeUserSplit[i].hplus + "'>" + at.taskAgeUserSplit[i].hplus +
								"</label>" +
								
							"</td>"; 
    	    			}
    	    			else
    	    			{
    	    				contentString = contentString + '<td style="width: 15px">' + 

    								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
    					
										"onClick='displayTaskAgeUserSplitGroup(\"" + 
    									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
    									"\", \"101-1000\");' value='" + 
    									at.taskAgeUserSplit[i].hplus + "'>" + at.taskAgeUserSplit[i].hplus +
    								"</label>" +
    								
    							"</td>"; 
    	    			}
								
								
						
    	    			console.log(contentString);
    	    			
    	    			console.log("---Clicked this: " + at.taskAgeUserSplit[i].clickedThis);
    	    			console.log("---ftn is: " + at.taskAgeUserSplit[i].hplus);
    	    			
    	    			console.log("Inside hplus-------------------------");
    	    		}
					else
    	    		{
    	    			alert("Error! Shouldn't have gotten here!");
    	    		}
				}
				else
				{
					contentString = contentString + '<td style="width: 15px"></td>';
				}
				
			}

			document.getElementById("msgBoard").innerHTML = contentString + 
				"</tbody></table>";
		}
	}
	console.log("Exiting TaskAgeUserSplitStateChanged()");
}
</script>


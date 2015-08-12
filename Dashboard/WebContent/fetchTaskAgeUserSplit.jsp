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
	//alert("Inside moveTheSpanNot()...");
	
	//var tooltipSpan = document.getElementById('taskUserSplitSpanId');
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
						"<div id = 'taskUserSplitSpanId' style = 'text-align: center; font-size: 14pt;'>Click on the clickable links below to get started!</div>" +
						"<div>" + 
						"<table id = 'innerTable' style = 'overflow-y: auto; height: 100%; outline: thin solid; width: 100%;'>" + 
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
							'<td style = "align: center; font-size:8pt;"><b>' + at.taskAgeUserSplit[i].userName.substring(2) + '</b></td><td>';
								
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
    	    				
    	    				contentString = contentString + '<td>' + 
						
							
								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
								//	"onmouseout= 'moveTheSpanNot();'" + 
									"onClick='displayTaskAgeUserSplitIndividual(\"" + 
									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
									"\", \"0-15\");' value='" + 
									at.taskAgeUserSplit[i].ftn + "'>" + at.taskAgeUserSplit[i].ftn +
								"</label>" +
								
							"</td>"; 
    	    			}
    	    			else
    	    			{
    	    				contentString = contentString + '<td>' + 
    						//	"<div id = 'taskUserSplitSpanDiv'>" + 
    							
    								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
    							//		"onmouseout= 'moveTheSpanNot();'" +
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
    	    				
    	    				contentString = contentString + '<td>' + 
						
							
								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
								//	"onmouseout= 'moveTheSpanNot();'" + 
									"onClick='displayTaskAgeUserSplitGroup(\"" + 
									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
									"\", \"0-15\");' value='" + 
									at.taskAgeUserSplit[i].ftn + "'>" + at.taskAgeUserSplit[i].ftn +
								"</label>" +
								
							"</td>"; 
    	    			}
    	    			else
    	    			{
    	    				contentString = contentString + '<td>' + 
    						//	"<div id = 'taskUserSplitSpanDiv'>" + 
    							
    								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
    							//		"onmouseout= 'moveTheSpanNot();'" +
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
					contentString = contentString + '<td></td>';
				}
				
				//contentString = contentString + '<td>';
				
				if(at.taskAgeUserSplit[i].thirty != "null")
				{
					//contentString = contentString + at.taskAgeUserSplit[i].thirty;
					
					if(at.taskAgeUserSplit[i].userName[0] == "P")
    	    		{
    	    			if(i == 0)
    	    			{
    	    				
    	    				contentString = contentString + '<td>' + 
						
							
								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
								//	"onmouseout= 'moveTheSpanNot();'" + 
									"onClick='displayTaskAgeUserSplitIndividual(\"" + 
									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
									"\", \"16-30\");' value='" + 
									at.taskAgeUserSplit[i].thirty + "'>" + at.taskAgeUserSplit[i].thirty +
								"</label>" +
								
							"</td>"; 
    	    			}
    	    			else
    	    			{
    	    				contentString = contentString + '<td>' + 
    						//	"<div id = 'taskUserSplitSpanDiv'>" + 
    							
    								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
    							//		"onmouseout= 'moveTheSpanNot();'" +
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
    	    				
    	    				contentString = contentString + '<td>' + 
						
							
								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
								//	"onmouseout= 'moveTheSpanNot();'" + 
									"onClick='displayTaskAgeUserSplitGroup(\"" + 
									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
									"\", \"16-30\");' value='" + 
									at.taskAgeUserSplit[i].thirty + "'>" + at.taskAgeUserSplit[i].thirty +
								"</label>" +
								
							"</td>"; 
    	    			}
    	    			else
    	    			{
    	    				contentString = contentString + '<td>' + 
    						//	"<div id = 'taskUserSplitSpanDiv'>" + 
    							
    								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
    							//		"onmouseout= 'moveTheSpanNot();'" +
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
					contentString = contentString + '<td></td>';
				}
				
				//contentString = contentString + '<td>';
				
				if(at.taskAgeUserSplit[i].fifty != "null")
				{
					//contentString = contentString + at.taskAgeUserSplit[i].fifty;
					if(at.taskAgeUserSplit[i].userName[0] == "P")
    	    		{
    	    			if(i == 0)
    	    			{
    	    				
    	    				contentString = contentString + '<td>' + 
						
							
								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
								//	"onmouseout= 'moveTheSpanNot();'" + 
									"onClick='displayTaskAgeUserSplitIndividual(\"" + 
									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
									"\", \"31-50\");' value='" + 
									at.taskAgeUserSplit[i].fifty + "'>" + at.taskAgeUserSplit[i].fifty +
								"</label>" +
								
							"</td>"; 
    	    			}
    	    			else
    	    			{
    	    				contentString = contentString + '<td>' + 
    						//	"<div id = 'taskUserSplitSpanDiv'>" + 
    							
    								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
    							//		"onmouseout= 'moveTheSpanNot();'" +
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
    	    				
    	    				contentString = contentString + '<td>' + 
						
							
								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
								//	"onmouseout= 'moveTheSpanNot();'" + 
									"onClick='displayTaskAgeUserSplitGroup(\"" + 
									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
									"\", \"31-50\");' value='" + 
									at.taskAgeUserSplit[i].fifty + "'>" + at.taskAgeUserSplit[i].fifty +
								"</label>" +
								
							"</td>"; 
    	    			}
    	    			else
    	    			{
    	    				contentString = contentString + '<td>' + 
    						//	"<div id = 'taskUserSplitSpanDiv'>" + 
    							
    								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
    							//		"onmouseout= 'moveTheSpanNot();'" +
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
					contentString = contentString + '<td></td>';
				}
				
				
				//contentString = contentString + '</td><td>';				
				
				if(at.taskAgeUserSplit[i].hundred != "null")
				{
					//contentString = contentString + at.taskAgeUserSplit[i].hundred;
					if(at.taskAgeUserSplit[i].userName[0] == "P")
    	    		{
    	    			if(i == 0)
    	    			{
    	    				
    	    				contentString = contentString + '<td>' + 
						
							
								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
								//	"onmouseout= 'moveTheSpanNot();'" + 
									"onClick='displayTaskAgeUserSplitIndividual(\"" + 
									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
									"\", \"51-100\");' value='" + 
									at.taskAgeUserSplit[i].hundred + "'>" + at.taskAgeUserSplit[i].hundred +
								"</label>" +
								
							"</td>"; 
    	    			}
    	    			else
    	    			{
    	    				contentString = contentString + '<td>' + 
    						//	"<div id = 'taskUserSplitSpanDiv'>" + 
    							
    								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
    							//		"onmouseout= 'moveTheSpanNot();'" +
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
    	    				
    	    				contentString = contentString + '<td>' + 
						
							
								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
								//	"onmouseout= 'moveTheSpanNot();'" + 
									"onClick='displayTaskAgeUserSplitGroup(\"" + 
									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
									"\", \"51-100\");' value='" + 
									at.taskAgeUserSplit[i].hundred + "'>" + at.taskAgeUserSplit[i].hundred +
								"</label>" +
								
							"</td>"; 
    	    			}
    	    			else
    	    			{
    	    				contentString = contentString + '<td>' + 
    						//	"<div id = 'taskUserSplitSpanDiv'>" + 
    							
    								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
    							//		"onmouseout= 'moveTheSpanNot();'" +
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
					contentString = contentString + '<td></td>';
				}
				
				//contentString = contentString + '</td><td>';
				
				if(at.taskAgeUserSplit[i].hplus != "null")
				{
					//contentString = contentString + at.taskAgeUserSplit[i].hplus;
					if(at.taskAgeUserSplit[i].userName[0] == "P")
    	    		{
    	    			if(i == 0)
    	    			{
    	    				
    	    				contentString = contentString + '<td>' + 
						
							
								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
								//	"onmouseout= 'moveTheSpanNot();'" + 
									"onClick='displayTaskAgeUserSplitIndividual(\"" + 
									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
									"\", \"101-1000\");' value='" + 
									at.taskAgeUserSplit[i].hplus + "'>" + at.taskAgeUserSplit[i].hplus +
								"</label>" +
								
							"</td>"; 
    	    			}
    	    			else
    	    			{
    	    				contentString = contentString + '<td>' + 
    						//	"<div id = 'taskUserSplitSpanDiv'>" + 
    							
    								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
    							//		"onmouseout= 'moveTheSpanNot();'" +
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
    	    				
    	    				contentString = contentString + '<td>' + 
						
							
								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
								//	"onmouseout= 'moveTheSpanNot();'" + 
									"onClick='displayTaskAgeUserSplitGroup(\"" + 
									at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
									"\", \"101-1000\");' value='" + 
									at.taskAgeUserSplit[i].hplus + "'>" + at.taskAgeUserSplit[i].hplus +
								"</label>" +
								
							"</td>"; 
    	    			}
    	    			else
    	    			{
    	    				contentString = contentString + '<td>' + 
    						//	"<div id = 'taskUserSplitSpanDiv'>" + 
    							
    								"<label id = 'taskUserSplitSpanDiv' style='cursor: pointer;' " + 
    							//		"onmouseout= 'moveTheSpanNot();'" +
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
					contentString = contentString + '<td></td>';
				}
				
				//contentString = contentString + '</td></tr>';	
			}
		//	document.getElementById("msgBoard").style.height = "75%";
			document.getElementById("msgBoard").innerHTML = contentString + 
				"</table></div>";
		}
	}
	console.log("Exiting TaskAgeUserSplitStateChanged()");
}
</script>


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
		var ctl = at.taskAgeForOwnerIndividual.length;
		
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
//					document.getElementById("msgBoard").style.outline = "thin solid";
					document.getElementById("msgBoard").style.border = "2px solid #598080";
					document.getElementById("msgBoard").style.overflowY = "none";
					contentString = 
						"<div id = 'taskAgeForOwnerIndividualSpanId' style = 'text-align: center; font-size:12pt;'>Click on the clickable links below to get started!</div>" +
						"<div>" + 
							"<table id = 'innerTable' style = 'overflow-y: auto; height: 100%; width: 99%; font-size:8pt;'>" + 
								"<tr style = 'text-align: center;'>" + 
									"<td style = 'align: center; font-size:8pt;' colspan = 7>" +
										"<b>" + at.taskAgeForOwnerIndividual[0].nameOfClicked + "</b>" + 
									"</td>" + 
								"</tr>" + 
								
								"<tr>" +
									"<td style = 'width: 100%; overflow: hidden; text-overflow: ellipsis;'>Task</td><td>Total</td><td>0-15</td><td>16-30</td><td>31-50</td><td>51-100</td><td>101+</td>" +
								"</tr>";
				}
				
				if(at.taskAgeForOwnerIndividual[i].taskName.toUpperCase() === ("CertifiedCorrectionsResubmittalReview").toUpperCase())
				{
	    	    	contentString = contentString + 
					'<tr style = "background-color: white;">' + 
						'<td style = "align: center; font-size:8pt; white-space: nowrap;">' +
							'<div style = " width: 25px;  over-flow: hidden; text-overflow: ellipsis;" title = "CertifiedCorrectionsResubmittalReview">CertCorrResub</div>' + 
						"</td>" +
						"<td>";
				}    	    
				else if(at.taskAgeForOwnerIndividual[i].taskName.toUpperCase() === ("CertifiedCorrectionsReview").toUpperCase())
				{
					contentString = contentString + 
					'<tr style = "background-color: white;">' + 
						'<td style = "align: center; font-size:8pt; white-space: nowrap;">' +
							'<div style = " width: 25px;  over-flow: hidden; text-overflow: ellipsis;" title = "CertifiedCorrectionsReview">CertCorrRev</div>' + 
						"</td>" +
						"<td>";
				}
				else if(at.taskAgeForOwnerIndividual[i].taskName.toUpperCase() === ("PrescreenResubmittalReview").toUpperCase())
				{
					contentString = contentString + 
					'<tr style = "background-color: white;">' + 
						'<td style = "align: center; font-size:8pt; white-space: nowrap;">' +
							'<div style = " width: 25px;  over-flow: hidden; text-overflow: ellipsis;" title = "PrescreenResubmittalReview">PreResubRev</div>' + 
						"</td>" +
						"<td>";
				}
				else if(at.taskAgeForOwnerIndividual[i].taskName.toUpperCase() === ("SelfCertificationResubmit").toUpperCase())
				{
					contentString = contentString + 
					'<tr style = "background-color: white;">' + 
						'<td style = "align: center; font-size:8pt; white-space: nowrap;">' +
							'<div style = " width: 25px;  over-flow: hidden; text-overflow: ellipsis;" title = "SelfCertificationResubmit">SelfCertResb</div>' + 
						"</td>" +
						"<td>";
				}
				else
				{
					contentString = contentString + 
									'<tr style = "background-color: white;">' + 
										'<td style = "align: center; font-size:8pt; white-space: nowrap;">' +
											'<div style = " width: 25px;  over-flow: hidden; text-overflow: ellipsis;">' +	at.taskAgeForOwnerIndividual[i].taskName + "</div>" + 
										"</td>" +
										"<td>";
				}
				
				if(at.taskAgeForOwnerIndividual[i].ct != "null")
				{
					contentString = contentString + at.taskAgeForOwnerIndividual[i].ct;
								
				}
				
				contentString = contentString + 
									'</td>';
				
				if(at.taskAgeForOwnerIndividual[i].ftn != "null")
				{
   	    			if(i == 0)
   	    			{
   	    				
   	    				contentString = contentString + 
   	    							'<td>' + 
										"<label id = 'taskAgeForOwnerIndividualSplitSpanDiv' style='cursor: pointer;' " + 
										//	"onmouseout= 'moveTheSpanNot();'" + 
										//	"onClick='taskAgeForOwnerIndividual(\"" + 
										//	at.taskAgeForOwnerIndividual[i].clickedThis + "\", \"" + at.taskAgeForOwnerIndividual[i].userName.substring(2)  + 
										//	"\", \"0-15\");' value='" + 
										//	at.taskAgeForOwnerIndividual[i].ftn + "'>" + at.taskAgeForOwnerIndividual[i].ftn +
											">" + at.taskAgeForOwnerIndividual[i].ftn +
										"</label>" +
									"</td>"; 
   	    			}
   	    			else
   	    			{
   	    				contentString = contentString + 
   	    							'<td>' + 
		   							//	"<div id = 'taskUserSplitSpanDiv'>" + 
		   							
		   								"<label id = 'taskAgeForOwnerIndividualSplitSpanDiv' style='cursor: pointer;' " + 
		   							//		"onmouseout= 'moveTheSpanNot();'" +
									//		"onClick='taskAgeForOwnerIndividual(\"" + 
		   							//		at.taskAgeForOwnerIndividual[i].clickedThis + "\", \"" + at.taskAgeForOwnerIndividual[i].userName.substring(2)  + 
		   							//		"\", \"0-15\");' value='" + 
		   							//		at.taskAgeForOwnerIndividual[i].ftn + "'>" + at.taskAgeForOwnerIndividual[i].ftn +
		   									">" + at.taskAgeForOwnerIndividual[i].ftn +
		   								"</label>" +		
   									"</td>"; 
   	    			}			
				}
				else
				{
					contentString = contentString + 
									'<td>' + 
									'</td>';
				}
				
				if(at.taskAgeForOwnerIndividual[i].thirty != "null")
				{
   	    			if(i == 0)
   	    			{
   	    				contentString = contentString + 
   	    							'<td>' + 
										"<label id = 'taskAgeForOwnerIndividualSplitSpanDiv' style='cursor: pointer;' " + 
										//	"onmouseout= 'moveTheSpanNot();'" + 
										//	"onClick='taskAgeForOwnerIndividual(\"" + 
										//	at.taskAgeForOwnerIndividual[i].clickedThis + "\", \"" + at.taskAgeForOwnerIndividual[i].userName.substring(2)  + 
										//	"\", \"16-30\");' value='" + 
										//	at.taskAgeForOwnerIndividual[i].thirty + "'>" + at.taskAgeForOwnerIndividual[i].thirty +
										">" + at.taskAgeForOwnerIndividual[i].thirty +
										"</label>" +										
									"</td>"; 
   	    			}
   	    			else
   	    			{
   	    				contentString = contentString + '<td>' + 
   						//	"<div id = 'taskUserSplitSpanDiv'>" + 
   							
   								"<label id = 'taskAgeForOwnerIndividualSplitSpanDiv' style='cursor: pointer;' " + 
   							//		"onmouseout= 'moveTheSpanNot();'" +
							//		"onClick='taskAgeForOwnerIndividual(\"" + 
   							//		at.taskAgeForOwnerIndividual[i].clickedThis + "\", \"" + at.taskAgeForOwnerIndividual[i].userName.substring(2)  + 
   							//		"\", \"16-30\");' value='" + 
   							//		at.taskAgeForOwnerIndividual[i].thirty + "'>" + at.taskAgeForOwnerIndividual[i].thirty +
   									">" + at.taskAgeForOwnerIndividual[i].thirty +
   								"</label>" +
   							"</td>"; 
   	    			}
   	    			
   	    			console.log("Inside thirty-------------------------");
   	    		}
				else
				{
					contentString = contentString + 
							'<td>' + 
							'</td>';
				}
				
				if(at.taskAgeForOwnerIndividual[i].fifty != "null")
				{
   	    			if(i == 0)
   	    			{
   	    				contentString = contentString + 
   	    					'<td>' + 
								"<label id = 'taskAgeForOwnerIndividualSplitSpanDiv' style='cursor: pointer;' " + 
								//	"onmouseout= 'moveTheSpanNot();'" + 
								//	"onClick='displayTaskAgeUserSplitIndividual(\"" + 
								//	at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
								//	"\", \"31-50\");' value='" + 
								//	at.taskAgeUserSplit[i].fifty + "'>" + at.taskAgeUserSplit[i].fifty +
								">" + at.taskAgeForOwnerIndividual[i].fifty +
								"</label>" +
							"</td>"; 
   	    			}
   	    			else
   	    			{
   	    				contentString = contentString + '<td>' + 
   						//	"<div id = 'taskUserSplitSpanDiv'>" + 
   							
   								"<label id = 'taskAgeForOwnerIndividualSplitSpanDiv' style='cursor: pointer;' " + 
   								//		"onmouseout= 'moveTheSpanNot();'" +
								//	"onClick='displayTaskAgeUserSplitIndividual(\"" + 
   								//	at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
   								//	"\", \"31-50\");' value='" + 
   								//	at.taskAgeUserSplit[i].fifty + "'>" + at.taskAgeUserSplit[i].fifty +
   								">" + at.taskAgeForOwnerIndividual[i].fifty +
   								"</label>" +
   							"</td>"; 
   	    			}
   	    			console.log("Inside fifty-------------------------");
				}
				else
				{
					contentString = contentString + 
							'<td>' + 
							'</td>';
				}
				
				if(at.taskAgeForOwnerIndividual[i].hundred != "null")
				{
   	    			if(i == 0)
   	    			{	
   	    				contentString = contentString + 
   	    					'<td>' + 
								"<label id = 'taskAgeForOwnerIndividualSplitSpanDiv' style='cursor: pointer;' " + 
								//	"onmouseout= 'moveTheSpanNot();'" + 
								//	"onClick='displayTaskAgeUserSplitIndividual(\"" + 
								//	at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
								//	"\", \"51-100\");' value='" + 
								//	at.taskAgeUserSplit[i].hundred + "'>" + at.taskAgeUserSplit[i].hundred +
								">" + at.taskAgeForOwnerIndividual[i].hundred +
								"</label>" +		
							"</td>"; 
   	    			}
   	    			else
   	    			{
   	    				contentString = contentString + 
   	    					'<td>' + 
   								"<label id = 'taskAgeForOwnerIndividualSplitSpanDiv' style='cursor: pointer;' " + 
	   							//		"onmouseout= 'moveTheSpanNot();'" +
								//		"onClick='displayTaskAgeUserSplitIndividual(\"" + 
	   							//		at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
	   							//		"\", \"51-100\");' value='" + 
	   							//		at.taskAgeUserSplit[i].hundred + "'>" + at.taskAgeUserSplit[i].hundred +
	   							">" + at.taskAgeForOwnerIndividual[i].hundred +	
	   							"</label>" +
   							"</td>"; 
   	    			}
   	    			console.log("Inside hundred-------------------------");
				}
				else
				{
					contentString = contentString + 
							'<td>' +
							'</td>';
				}
				
				if(at.taskAgeForOwnerIndividual[i].hplus != "null")
				{
   	    			if(i == 0)
   	    			{
   	    				
   	    				contentString = contentString + 
   	    					'<td>' + 
								"<label id = 'taskAgeForOwnerIndividualSplitSpanDiv' style='cursor: pointer;' " + 
								//	"onmouseout= 'moveTheSpanNot();'" + 
								//	"onClick='displayTaskAgeUserSplitIndividual(\"" + 
								//	at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
								//	"\", \"101-1000\");' value='" + 
								//	at.taskAgeUserSplit[i].hplus + "'>" + at.taskAgeUserSplit[i].hplus +
								">" + at.taskAgeForOwnerIndividual[i].hplus +	
								"</label>" +
							"</td>"; 
   	    			}
   	    			else
   	    			{
   	    				contentString = contentString + 
   	    					'<td>' + 
   								"<label id = 'taskAgeForOwnerIndividualSplitSpanDiv' style='cursor: pointer;' " + 
   							//		"onmouseout= 'moveTheSpanNot();'" +
								//	"onClick='displayTaskAgeUserSplitIndividual(\"" + 
   								//	at.taskAgeUserSplit[i].clickedThis + "\", \"" + at.taskAgeUserSplit[i].userName.substring(2)  + 
   								//	"\", \"101-1000\");' value='" + 
   								//	at.taskAgeUserSplit[i].hplus + "'>" + at.taskAgeUserSplit[i].hplus +
   								">" + at.taskAgeForOwnerIndividual[i].hplus +	
   								"</label>" +
   							"</td>"; 
   	    			}
    	    		console.log("Inside hplus-------------------------");	
				}
				else
				{
					contentString = contentString + '<td></td>';
				}
				
				document.getElementById("msgBoard").innerHTML = contentString + 
								"</table>" + 
							"</div>";
			}
		}
		console.log("ownerByTaskAgeStateChanged()");
	}
}

</script>

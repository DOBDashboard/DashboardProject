<%-- 
*For loading the Time to Permit breakdown for self cert projects

--%>


	
<script type="text/javascript">

var adtHttp;
var t;


function displayOwnerByTask() 
{
	console.log("Entering displayownerByTask()");
	//document.getElementById("ownerByTaskDiv").innerHTML = null;
		
	 adtHttp = GetXmlHttpObject();
	 
	if (adtHttp == null) {
	  alert ("Browser does not support HTTP Request");
	  return;} 
	
	 var url = "ownerByTask_JSON.jsp";
	 adtHttp.onreadystatechange = ownerByTaskStateChanged;
	 adtHttp.open("GET",url,true);
	 adtHttp.send(null);
	console.log("Exiting displayownerByTask()");
}
 


function ownerByTaskStateChanged() 
{ 	
	console.log("Entering ownerByTaskStateChanged()");
	if (adtHttp.readyState == 4 || adtHttp.readyState=="complete") {

		var at = eval('(' + adtHttp.responseText + ')');
		var ctl = at.ownerByTask.length;		
	
		var contentString = ""; 
		
		contentString = contentString + "<table id = 'ownerByTaskAgeTable' CELLSPACING='0' CELLPADDING='0' valign = 'top' align = 'center' > " +
										"<thead><tr><th colspan = 10 align= 'center'" + "style='width:1000px'> <b> Task Split by Owner Name </b> </th></tr>" +
										"</thead>" +
										"<thead>" +
											"<tr style = 'background-color: #666666; color: white;'>" +
												'<th class = "ownersByTaskAgeHeaderTH" style="width: 145px"><font size="2"><b>Owner</b></font></th>' +
												'<th class = "ownersByTaskAgeHeaderTH"><font size="2"><b>Total</b></font></th>' +
												'<th class = "ownersByTaskAgeHeaderTH" style="width: 16px"><font size="2"><b>0-4</b></font></th>' +
												'<th class = "ownersByTaskAgeHeaderTH" style="width: 21px"><font size="2"><b>5-10</b></font></th>' +
												'<th class = "ownersByTaskAgeHeaderTH" style="width: 27px"><font size="2"><b>11-15</b></font></th>' +
												'<th class = "ownersByTaskAgeHeaderTH" style="width: 28px"><font size="2"><b>16-20</b></font></th>' +
												'<th class = "ownersByTaskAgeHeaderTH" style="width: 28px"><font size="2"><b>21-30</b></font></th>' +
												'<th class = "ownersByTaskAgeHeaderTH" style="width: 28px"><font size="2"><b>31-50</b></font></th>' +
												'<th class = "ownersByTaskAgeHeaderTH" style="width: 34px"><font size="2" style="width: 15px"><b>51-100</b></font></th>' +
												'<th class = "ownersByTaskAgeHeaderTH" style="width: 32px"><font size="2"><b>101+</b></font></th>' +
											"</tr>" +
										"</thead>" +
										"<tbody id = 'ownerByTaskAgeTableBody'>";
		
		
		for (i=0; i <ctl; i++ ) 
		{    	       
   	    	if(i%2 == 0)
   	    	{
   	    		contentString = contentString + "<tr style = 'background-color: white;'><td>" ;
   	    	}
   	    	else
  	    	{
   	    		contentString = contentString + "<tr style = 'background-color: #B2B2B2;'><td>" ;
  	    	}
   	       	    
    	    if(at.ownerByTask[i].typeOfTeam == "P" || at.ownerByTask[i].typeOfTeam == "p")
    	    {    	    	
    	    	if(at.ownerByTask[i].taskname != "null")
       			{

       	    		contentString = contentString + 
      				"<label  onmouseover='' style='cursor: pointer;'  onClick= 'displayTaskAgeForOwnerIndividual(\"" + at.ownerByTask[i].taskname +"\");' value='" +
      				at.ownerByTask[i].taskname + "'>" + at.ownerByTask[i].taskname + "</label>";     				
       	    	}
        	    
        	    contentString = contentString + '</td><td style="width:31px">'; //end of Owner column and start of Total column
        	    
        	    if(at.ownerByTask[i].ct != "null")
       			{
       	    		contentString = contentString + at.ownerByTask[i].ct;
       	    	}
        	    
        	    contentString = contentString + '</td><td style="width:15px">';//end of Total column and start of 0-4 column
    	    	
    	    	
    	
    	    	if(at.ownerByTask[i].zeroTo4 != "null")
      	    	{
      	    		contentString = contentString + 
      	    				"<label  onmouseover='' style='cursor: pointer;'  onClick='displayPrjsOwnerIndividualTask(\"" + at.ownerByTask[i].taskname +
      	    				"\", \"0-4\");' value='" +
      	    				at.ownerByTask[i].zeroTo4 + "'>" + at.ownerByTask[i].zeroTo4 + "</label>"; 
      	    	}
        	    
        	    contentString = contentString + '</td><td style="width:21px">'; //end of 0-4 column and start of 5-10 column
        	    
        	    if(at.ownerByTask[i].fiveTo10 != "null")
        	    {
        	    	contentString = contentString + 
      				"<label  onmouseover='' style='cursor: pointer;'  onClick='displayPrjsOwnerIndividualTask(\"" + at.ownerByTask[i].taskname +
      				"\", \"5-10\");' value='" +
      				at.ownerByTask[i].fiveTo10 + "'>" + at.ownerByTask[i].fiveTo10+ "</label>"; 
      	    	}
        	    
        	    contentString = contentString + '</td><td style="width:27px">';//end of 5-10 column and start of 11-15 column
        	    
        	    if(at.ownerByTask[i].elevenTo15 != "null")
        	    {
        	    	contentString = contentString + 
      				"<label  onmouseover='' style='cursor: pointer;'  onClick='displayPrjsOwnerIndividualTask(\"" + at.ownerByTask[i].taskname +
      				"\", \"11-15\");' value='" +
      				at.ownerByTask[i].elevenTo15 + "'>" + at.ownerByTask[i].elevenTo15+ "</label>";
      			}
        	    
        	    contentString = contentString + '</td><td style="width:28px">';//end of 11-15 column and start of 16-20 column
        	    
        	    if(at.ownerByTask[i].sixteenTo20 != "null")
        	    {
        	    	contentString = contentString + 
      				"<label  onmouseover='' style='cursor: pointer;'  onClick='displayPrjsOwnerIndividualTask(\"" + at.ownerByTask[i].taskname +
      				"\", \"16-20\");' value='" +
      				at.ownerByTask[i].sixteenTo20 + "'>" + at.ownerByTask[i].sixteenTo20+ "</label>";
      			}
        	    
        	    contentString = contentString + '</td><td style="width:28px">';//end of 16-20 column and start of 21-30 column
        	    
        	    if(at.ownerByTask[i].twentyoneTo30 != "null")
        	    {
        	    	contentString = contentString + 
      				"<label  onmouseover='' style='cursor: pointer;'  onClick='displayPrjsOwnerIndividualTask(\"" + at.ownerByTask[i].taskname +
      				"\", \"21-30\");' value='" +
      				at.ownerByTask[i].twentyoneTo30 + "'>" + at.ownerByTask[i].twentyoneTo30+ "</label>";
        	    }
        	            	    
        	    contentString = contentString + '</td><td style="width:28px">';//end of 21-30 column and start of 31-50 column
        	    		
        	    if(at.ownerByTask[i].thirtyoneTo50 != "null")
        	    {
        	    	contentString = contentString + 
      				"<label  onmouseover='' style='cursor: pointer;'  onClick='displayPrjsOwnerIndividualTask(\"" + at.ownerByTask[i].taskname +
      				"\", \"31-50\");' value='" +
      				at.ownerByTask[i].thirtyoneTo50 + "'>" + at.ownerByTask[i].thirtyoneTo50+ "</label>";
      			}	
        	    
        	    contentString = contentString + '</td><td style="width:34px">';//end of 31-50 column and start of 51-100 column
        	    
        	    if(at.ownerByTask[i].fiftyoneTo100 != "null")
        	    {
        	    	contentString = contentString + 
      				"<label  onmouseover='' style='cursor: pointer;'  onClick='displayPrjsOwnerIndividualTask(\"" + at.ownerByTask[i].taskname +
      				"\", \"51-100\");' value='" +
      				at.ownerByTask[i].fiftyoneTo100 + "'>" + at.ownerByTask[i].fiftyoneTo100+ "</label>";
        	    }
        	    
        	    contentString = contentString + '</td><td style="width:15px">';//end of 51-100 column and start of 100+ column
        	    
        	    if(at.ownerByTask[i].hundredandonePlus != "null")
        	    {
        	    	contentString = contentString + 
      				"<label  onmouseover='' style='cursor: pointer;'  onClick='displayPrjsOwnerIndividualTask(\"" + at.ownerByTask[i].taskname +
      				"\", \"101-1000\");' value='" +
      				at.ownerByTask[i].hundredandonePlus + "'>" + at.ownerByTask[i].hundredandonePlus+ "</label>";
        	    }   
    	    	
    	    }
    	    else
    	    {
    	    	if(at.ownerByTask[i].taskname != "null")
       			{
       	   // 		contentString = contentString + at.ownerByTask[i].taskname;
       	    		
       	    		
       	    		contentString = contentString + 
      				"<label  onmouseover='' style='cursor: pointer;'  onClick= 'displayTaskAgeForOwnerGroup(\"" + at.ownerByTask[i].taskname +"\");' value='" +
      				at.ownerByTask[i].taskname + "'>" + at.ownerByTask[i].taskname + "</label>";
       	    		
       	    
       	    		
       	    	}
        	    
        	    contentString = contentString + "</td><td>";
        	    
        	    if(at.ownerByTask[i].ct != "null")
       			{
       	    		contentString = contentString + at.ownerByTask[i].ct;
       	    	}
        	    
        	    contentString = contentString + "</td><td>";
    	    	
    	 
    	    	if(at.ownerByTask[i].zeroTo4 != "null")
      	    	{
      	    		contentString = contentString + 
   	    				"<label  onmouseover='' style='cursor: pointer;'  onClick='displayPrjsOwnerGroupTask(\"" + at.ownerByTask[i].taskname +
   	    				"\", \"0-4\");' value='" +
   	    				at.ownerByTask[i].zeroTo4 + "'>" + at.ownerByTask[i].zeroTo4 + "</label>"; 
      	    	}
        	    
        	    contentString = contentString + "</td><td>";
        	    
        	    if(at.ownerByTask[i].fiveTo10 != "null")
        	    {
        	    	contentString = contentString + 
	      				"<label  onmouseover='' style='cursor: pointer;'  onClick='displayPrjsOwnerGroupTask(\"" + at.ownerByTask[i].taskname +
	      				"\", \"5-10\");' value='" +
	      				at.ownerByTask[i].fiveTo10 + "'>" + at.ownerByTask[i].fiveTo10+ "</label>"; 
      	    	}
        	    
        	    contentString = contentString + "</td><td>";
        	    
        	    if(at.ownerByTask[i].elevenTo15 != "null")
        	    {
        	    	contentString = contentString + 
	      				"<label  onmouseover='' style='cursor: pointer;'  onClick='displayPrjsOwnerGroupTask(\"" + at.ownerByTask[i].taskname +
	      				"\", \"11-15\");' value='" +
	      				at.ownerByTask[i].elevenTo15 + "'>" + at.ownerByTask[i].elevenTo15+ "</label>";
      			}
        	    
        	    contentString = contentString + "</td><td>";
        	    
        	    if(at.ownerByTask[i].sixteenTo20 != "null")
        	    {
        	    	contentString = contentString + 
	      				"<label  onmouseover='' style='cursor: pointer;'  onClick='displayPrjsOwnerGroupTask(\"" + at.ownerByTask[i].taskname +
	      				"\", \"16-20\");' value='" +
	      				at.ownerByTask[i].sixteenTo20 + "'>" + at.ownerByTask[i].sixteenTo20+ "</label>";
      			}
        	    
        	    contentString = contentString + "</td><td>";
        	    
        	    if(at.ownerByTask[i].twentyoneTo30 != "null")
        	    {
        	    	contentString = contentString + 
	      				"<label  onmouseover='' style='cursor: pointer;'  onClick='displayPrjsOwnerGroupTask(\"" + at.ownerByTask[i].taskname +
	      				"\", \"21-30\");' value='" +
	      				at.ownerByTask[i].twentyoneTo30 + "'>" + at.ownerByTask[i].twentyoneTo30+ "</label>";
        	    }
        	    
        	    contentString = contentString + "</td><td>";
        	    		
        	    if(at.ownerByTask[i].thirtyoneTo50 != "null")
        	    {
        	    	contentString = contentString + 
	      				"<label  onmouseover='' style='cursor: pointer;'  onClick='displayPrjsOwnerGroupTask(\"" + at.ownerByTask[i].taskname +
	      				"\", \"31-50\");' value='" +
	      				at.ownerByTask[i].thirtyoneTo50 + "'>" + at.ownerByTask[i].thirtyoneTo50+ "</label>";
      			}	
        	    
        	    contentString = contentString + "</td><td>";
        	    
        	    if(at.ownerByTask[i].fiftyoneTo100 != "null")
        	    {
        	    	contentString = contentString + 
	      				"<label  onmouseover='' style='cursor: pointer;'  onClick='displayPrjsOwnerGroupTask(\"" + at.ownerByTask[i].taskname +
	      				"\", \"51-100\");' value='" +
	      				at.ownerByTask[i].fiftyoneTo100 + "'>" + at.ownerByTask[i].fiftyoneTo100+ "</label>";
        	    }
        	    
        	    contentString = contentString + "</td><td>";
        	    
        	    if(at.ownerByTask[i].hundredandonePlus != "null")
        	    {
        	    	contentString = contentString + 
	      				"<label  onmouseover='' style='cursor: pointer;'  onClick='displayPrjsOwnerGroupTask(\"" + at.ownerByTask[i].taskname +
	      				"\", \"101-1000\");' value='" +
	      				at.ownerByTask[i].hundredandonePlus + "'>" + at.ownerByTask[i].hundredandonePlus+ "</label>";
        	    }  
    	    	
    	    }
    	    
    	    
		}
		document.getElementById("ownerByTaskAgeDiv").innerHTML = contentString + "</tbody></table>";	
 	}
	
	console.log("Exiting ownerByTaskStateChanged()");
}

</script>

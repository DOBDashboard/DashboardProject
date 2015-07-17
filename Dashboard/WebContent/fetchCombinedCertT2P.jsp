<%-- 
*For loading the Time to Permit breakdown for self cert projects

--%>

<head>
	
<script type="text/javascript">

var adtHttp;
var t;


function displayTasksCC() 
{
console.log("inside displayTasksCC()");
	document.getElementById("combinedCertAverageDiv").innerHTML = null;
		
		 adtHttp = GetXmlHttpObject();
		 

		 
		if (adtHttp == null) {
		  alert ("Browser does not support HTTP Request");
		  return;} 
		
		 var url = "combinedCertT2P_JSON.jsp";
		 adtHttp.onreadystatechange = T2PCCstateChanged;
		 adtHttp.open("GET",url,true);
		 adtHttp.send(null);

 
 }
 


function T2PCCstateChanged() { 
	
	console.log("T2PSC State changed!!");
	if (adtHttp.readyState == 4 || adtHttp.readyState=="complete") {

		var at = eval('(' + adtHttp.responseText + ')');
		var ctl = at.t2pcc.length;		
		var t2p_cc = 0;

		var contentString = "<table id = 'combinedCertAverageTable' bgcolor='99CCFF' border = 'show' CELLPADDING='0' CELLSPACING='0' valign = 'top' align = 'center'>" + 
				"<tr><td colspan = 4 align=center><b>Combined Cert Average Times</b></td></tr><tr style = 'background-color: #333333; color: white;'><td><b>Task</b></td><td><b>Avg Time</b></td><td><b>#Projects</b></td><td><b>T2P</b></td></tr>";
		
		for (i=0; i <ctl; i++ ) 
		{    	    
    	    if (parseInt(at.t2pcc[i].ordr)%2 == 0) 
    	    { 
    	    	contentString = contentString + "<tr bgcolor='FF8C00'> <td>" ;
    	    } 
    	    else 
    	    { 
    	    	if(i%2 == 0)
    	    	{
    	    		contentString = contentString + "<tr style = 'background-color: white;'><td>" ;
    	    	}
    	    	else
   	    		{
    	    		contentString = contentString + "<tr style = 'background-color: #B2B2B2;'><td>" ;
   	    		}
    	    }  

    	    if(at.t2pcc[i].taskname.toUpperCase() === ("PrescreenResubmittalReview").toUpperCase())
			{
    	    	contentString = contentString + "Pres. Resubm. Review";
			}    	    
			else if(at.t2pcc[i].taskname.toUpperCase() === ("Upload CertifiedCorrections").toUpperCase())
			{
				contentString = contentString +"Upload Cert. Corrections";
			}
			else if(at.t2pcc[i].taskname.toUpperCase() === ("CertifiedCorrectionsReview").toUpperCase())
			{
				contentString = contentString +"Cert. Corrections Review";
			}
			else if(at.t2pcc[i].taskname.toUpperCase() === ("CertifiedCorrectionsResubmittalReview").toUpperCase())
			{
				contentString = contentString + "Cert. Corrections Resubm. Review";
			}
			else if(at.t2pcc[i].taskname.toUpperCase() === ("SelfCertificationCorrectionComplete").toUpperCase())
			{
				contentString = contentString +"Self Cert. Corrections Comp.";
			}
			else
			{
				contentString = contentString + at.t2pcc[i].taskname;
			}
    	       	    
    	    contentString = contentString + "</td><td>"+at.t2pcc[i].avgtm+"</td><td>" +at.t2pcc[i].ct+"</td> <td>"+at.t2pcc[i].t2p+"</td></tr>";
			
    	    console.log("BEFORE " + t2p_cc);
    	    t2p_cc = t2p_cc + Number.parseInt(at.t2pcc[i].t2p, 10); 
    	    console.log(at.t2pcc[i].t2p);
    	    console.log("AFTER" + t2p_cc);
    
    	    
		}
		console.log(t2p_cc);
		document.getElementById("combinedCertAverageDiv").innerHTML = contentString + "	<tr><td colspan=4 bgcolor='1E90FF'> Combined SPR Time to Permit :" + Math.round(t2p_cc) + " days</td> </tr></table>";
	
 	}
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

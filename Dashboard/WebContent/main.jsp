<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Department of Buildings Dashboard</title>

<link rel = "stylesheet" href = "stylePage.css">

<script type = "text/javascript" src = "jquery-1.11.3.js"></script>
<script src="Chart.js"></script>
 
<script>
	
    function showHideLinkOnClickFunction()
    {	
    	var showHideTable = document.getElementById("quickStatisticsTable");
    	
    	if(showHideTable.style.display == 'none')
   		{
    		showHideTable.style.display = 'block';	
   		}
    	else
   		{
   			showHideTable.style.display = 'none';
   		}
    }
    
    function displaySearchResult()
    {
		var searchThisProject = document.getElementById("searchThisForUserInputId").value;
    	searchProject(searchThisProject);       	
    }

//Funtion remote button selection to display tables in Average Tesk Time table
   	
    
   	function table_selected()
    {
        var table1Selected = document.getElementById("table1Button").checked;
        var table2Selected = document.getElementById("table2Button").checked;
        var table3Selected = document.getElementById("table3Button").checked;
        
        var table1 = document.getElementById("selfCertAverageTimesDiv");
        var table2 = document.getElementById("sprNonSelfCertAverageTimesDiv");
        var table3 = document.getElementById("combinedCertAverageDiv");
        
     	if(table1Selected == true && table2Selected == false && table3Selected == false)
        {
            table1.style.display = 'block';
            table2.style.display = 'none'; 
            table3.style.display = 'none';
            console.log("beforesc main script");
          //  displayTasksSC();
            console.log("aftersc main script");
        }
        else if(table1Selected == false && table2Selected == false && table3Selected == true)
        {
            table1.style.display = 'none';
            table2.style.display = 'none';
            table3.style.display = 'block';
            console.log("ccbefore main script");
          //  displayTasksCC();
            console.log("ccafter main script");
        }
        else
        {
            table1.style.display = 'none';
            table2.style.display = 'block';
            table3.style.display = 'none';
            console.log("sprbefore main script");
         //   displayTasksSPR();
            console.log("sprafter main script ");
            
        }
           
    }
    
	function help_button_clicked()
	{
		var table1 = document.getElementById("taskCountDiv");
	    var table2 = document.getElementById("taskByAgeDiv");
	    var table3 = document.getElementById("ownerByTaskAgeDiv");
	    var picture = document.getElementById("ownerTutorialPictureDIV");
	    
	    var sumOfAllTableSelected = document.getElementById("taskCountTableButton").checked;
        var taskSplitByAgeTableSelected = document.getElementById("taskByAgeTableButton").checked;
        var ownerByTaskAgeTableButton = document.getElementById("ownerByTaskAgeTableButton").checked;
	    
	    console.log("Inside help_button_clicked()");
	   
	   if(table1.style.display == "block" || table2.style.display == "block" || table3.style.display == "block")  // any of them are checked
	   {
		   console.log("Inside help_button_clicked()...if()");
		   table1.style.display = 'none';
	        table2.style.display = 'none'; 
	        table3.style.display = 'none';
	        picture.style.display = 'block';
			document.getElementById("msgBoard").innerHTML = '';
	        document.getElementById("taskCountTableButton").checked = false;
            document.getElementById("taskByAgeTableButton").checked = false;
            document.getElementById("ownerByTaskAgeTableButton").checked = false;
	    }
		else if(sumOfAllTableSelected == false && taskSplitByAgeTableSelected == false && ownerByTaskAgeTableButton == false) // first load
	   {
		   console.log("Inside help_button_clicked()...if()");
		   table1.style.display = 'none';
	        table2.style.display = 'none'; 
	        table3.style.display = 'none';
	        picture.style.display = 'block';

	        document.getElementById("taskCountTableButton").checked = false;
            document.getElementById("taskByAgeTableButton").checked = false;
            document.getElementById("taskCountTableButton").checked = false;
	   }
	   else
		{
		   ; // it shouldn't get here
		}
	   console.log("Exiting help_button_clicked()");
	}

    //Funtion to display the different tables selected in Task Queue Split table
    function task_table_selected()
    {
    	var sumOfAllTableSelected = document.getElementById("taskCountTableButton").checked;
        var taskSplitByAgeTableSelected = document.getElementById("taskByAgeTableButton").checked;
        var ownerByTaskAgeTableButton = document.getElementById("ownerByTaskAgeTableButton").checked;
         
        var table1 = document.getElementById("taskCountDiv");
        var table2 = document.getElementById("taskByAgeDiv");
        var table3 = document.getElementById("ownerByTaskAgeDiv");
        var picture = document.getElementById("ownerTutorialPictureDIV");
        
        
        if(sumOfAllTableSelected == false && taskSplitByAgeTableSelected == false && ownerByTaskAgeTableButton == false)
        {
            table1.style.display = 'none';
            table2.style.display = 'none'; 
            table3.style.display = 'none';
            picture.style.display = 'block'; 
            document.getElementById("taskCountTableButton").checked = false;
            document.getElementById("taskByAgeTableButton").checked = false;
            document.getElementById("taskCountTableButton").checked = false;
            console.log("before all false");
            //displayTaskCount();
            console.log("after all false");
        }
        else if(sumOfAllTableSelected == true && taskSplitByAgeTableSelected == false && ownerByTaskAgeTableButton == false)
        {
            table1.style.display = 'block';
            table2.style.display = 'none'; 
            table3.style.display = 'none';
            picture.style.display = 'none'; 
            console.log("before taskCount");
            //displayTaskCount();
            console.log("after taskCount");
        }
        else if(sumOfAllTableSelected == false && taskSplitByAgeTableSelected == true && ownerByTaskAgeTableButton == false)
        {
            table1.style.display = 'none';
            table2.style.display = 'block'; 
            table3.style.display = 'none';
            picture.style.display = 'none'; 
            console.log("before taskByAge");
            //displayTaskByAge();
            console.log("after taskByAge");
      	}
        else
        {
            table1.style.display = 'none';
            table2.style.display = 'none';
            table3.style.display = 'block';
            picture.style.display = 'none'; 
   		}  
    }
	
    function display_main_chart(whichChart)
    {
    	var receivedVsIssuedChart = document.getElementById("receivedVsIssuedChartDIV");
    		
    	var sampleChart = document.getElementById("sampleChartDIV");
    	
    	if(whichChart == 0)
    	{
    		sampleChart.style.display = "none";
    		receivedVsIssuedChart.style.display = "block";
    		var ctx = document.getElementById("canvas").getContext("2d");
    		window.myLine = new Chart(ctx).Line(lineChartData, {
    			 scaleOverride: true, scaleStartValue: 0, scaleStepWidth: 120, scaleSteps: 10});
    		
    	}
    	else if(whichChart == 1)
    	{
    		receivedVsIssuedChart.style.display = "none";
    		sampleChart.style.display = "block";
    		var ctx2 = document.getElementById("canvas2").getContext("2d");
    		window.myLine = new Chart(ctx2).Line(lineChartData2, {
    			 scaleOverride: true, scaleStartValue: 0, scaleStepWidth: 3, scaleSteps: 10});
    	}
    	else
    	{
    		;
    	}
    }

</script>
</head>

<body>
<div id = "centerDIV">
<table id = "mainBackgroundTable"  align = "center">
	<tr> 
		<td>
			<div style = "padding-left: 5px; padding-top: 5px; float: left;">
				<img alt="" height= 70 width=70 src="img/city_logo.jpg">
			</div>
			
			<div style = "align: center; float: left; padding-left: 100px;">
				<h2 style="padding-left: 265px; margin:0; padding-bottom:5px; padding-top: 5px;">City of Chicago</h2>
				<h2 style = "padding-left: 45px; margin:0; padding-bottom:0;">Department of Buildings Permits and Inspections Dashboard</h2>
			</div>
			
			<div style = "padding-left: 80px;  padding-top: 5px; float: left;">
				<img alt="" height= 70 width=160 src="img/dob_logo_full.jpg">
			</div>
			
		</td>
	</tr>	
	
	<tr style = "height: 3px; width: 100%;">
		<td style = "content:' ';  display:block; border:1px solid black; background-color: black;"></td>
	</tr>
	
	<tr>
		<td style = "content: ' ';"></td>
	<tr>
	
	<tr> 
		<td  colspan=3 align = left bgcolor = "#FFF0E0" valign = center > <jsp:include page="h7_main.jsp" /></td>
	</tr>	
	    
	<tr>
		<td  colspan=3 align = left bgcolor = "#FFF0E0" valign = center > <jsp:include page="main_charts.jsp" /></td>
	<tr>		
			
	</tr>
	
	<tr> 
		<td colspan=3 align = left bgcolor = "#FFF0E0" valign = center > <jsp:include page="pdox_times.jsp" /></td>
	</tr> 
	

	<tr style = "background-color: #FFF0E0;">
		<td>
			<p style = "text-align: center;">
				<a href = "http://www.cityofchicago.org/buildings" title = "DOB">Departments of Buildings</a> ||  
				<a href = "http://10.220.30.129:8080/Dashboard/main.jsp" title = "Home">Dashboard</a>
			</p>
		</td>
	</tr>
</table>
</div>
	<script>
	
   
	
	$(document).ready(function() {
		   
		   $('#table3Button').click();
		   $('#helpIconButton').click();
		   $('#permitApplicationVsPermitIssuedChartButton').click();
		});	
	</script>
</body>

</html>

<!-- End of File -->
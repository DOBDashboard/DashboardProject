<%@ page contentType="text/html" %>
<%@ page import="dashboard.*" %>


<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>

<%
response.setHeader("Cache-Control","no-cache"); // HTTP 1.1
response.setHeader("Pragma","no-cache"); // HTTP 1.0
response.setDateHeader ("Expires", 0); // prevents caching at the Proxy cache
%>

<% 
String x[][] = dashboard.DatabaseManager.permitApplicationReceived(); //pdox-SQL Server DBMS
String z[][] = dashboard.DatabaseManager.permitIssued(); // hansen-Oracle DBMS
String[] yrIndex= new String[12];
yrIndex[0] = "Jan";
yrIndex[1] = "Feb";
yrIndex[2] = "Mar";
yrIndex[3] = "Apr";
yrIndex[4] = "May";
yrIndex[5] = "Jun";
yrIndex[6] = "Jul";
yrIndex[7] = "Aug";
yrIndex[8] = "Sept";
yrIndex[9] = "Oct";
yrIndex[10] = "Nov";
yrIndex[11] = "Dec";

%>

<div id = "overallStatisticsDataChartDIV">
<form autocomplete="off">



<table id = "chartTable" style = "background-color: #FFFAF6; border-style: groove; border-color: #FFFAF6; border-width: 1px;">
<tr id = "chartButtonTrId" style = "background-color: #FFFAF6;">
	<td colspan = 2; style = "text-align: right;">
		<button type="button"
			    id = "permitApplicationVsPermitIssuedChartButton"
			    onmouseover = '' style = "cursor: pointer; background-color: #E3E3E3; color: black;"
			    onClick = "display_main_chart(0);"><img src = "img/barGraphIcon" style = "vertical-align: middle;  width: 20px; height: 15px;"> Received vs. Issued</button>
	
		<button type="button"
			    id = "sampleChartButton"
			    onmouseover = '' style = "cursor: pointer; background-color: #E3E3E3; color: black;"
		        onClick = "display_main_chart(1);"><img src = "img/barGraphIcon" style = "vertical-align: middle; width: 20px; height: 15px;"> Sample Chart</button>
		
		<button type="button"
			    id = "sampleChart2Button"
			    onmouseover = '' style = "cursor: pointer; background-color: #E3E3E3; color: black;"
		        onClick = "display_main_chart(2);"><img src = "img/barGraphIcon" style = "vertical-align: middle; width: 20px; height: 15px;"> Sample Pie Chart</button>
		
	</td>
</tr>

<tr style = "height: 1px; width: 100%;">
	<td style = "content:' '; display:block; border:#CCC8C5; background-color: #CCC8C5; border-radius: 25px;"></td>
</tr>

<tr>
<td>
<div id = "receivedVsIssuedChartDIV" style = "display: block;">
	<table id = "overallStatisticsDataChartTable">
		<tr>
			<td style = "text-align: center;" colspan = 2>
				<b>Permit Application Received vs. Permit Issued</b>
			</td>
		</tr>
		<tr>
			<td>						
    			<div>
					<canvas id="canvas" style = "width: 100%; height:200px;"></canvas>
				</div>


				<script>
				
				<%//Java code for splitting the "yyyy/mm" and displaying it as "Mon 'YY"
				
				String[] mmYYarray = new String[24];
				
				
				int a = 0;
				int b = 0;
				int i = 0;
				String mon = new String();
				
				for(i = 0 ; i < 24; i++){
					
					//getting YY
					a = Integer.parseInt(x[i][2]);
					a = a - 2000;
					
					//getting Mon
					b = Integer.parseInt(x[i][3]) - 1;
					mon = yrIndex[b];
					
					mmYYarray[i] = mon + " '" + Integer.toString(a);
				}
				

			%>
			
		
				//var randomScalingFactor = function(){ return Math.round(Math.random()*100)};
				var lineChartData = {
						labels : [
								    "<%=mmYYarray[0]%>", "<%=mmYYarray[1]%>", "<%=mmYYarray[2]%>", "<%=mmYYarray[3]%>" , "<%=mmYYarray[4]%>",		
								    "<%=mmYYarray[5]%>", "<%=mmYYarray[6]%>", "<%=mmYYarray[7]%>", "<%=mmYYarray[8]%>", "<%=mmYYarray[9]%>",
								    "<%=mmYYarray[10]%>", "<%=mmYYarray[11]%>", "<%=mmYYarray[12]%>", "<%=mmYYarray[13]%>", "<%=mmYYarray[14]%>",
								    "<%=mmYYarray[15]%>", "<%=mmYYarray[16]%>", "<%=mmYYarray[17]%>", "<%=mmYYarray[18]%>", "<%=mmYYarray[19]%>",
								    "<%=mmYYarray[20]%>", "<%=mmYYarray[21]%>", "<%=mmYYarray[22]%>", "<%=mmYYarray[23]%>" ],
					datasets : [
						{
							label: "My First dataset",
							fillColor : "rgba(220,220,220,0.2)",
							strokeColor : "#9933FF",
							pointColor : "#CC99FF",
							
							pointStrokeColor : "#fff",
							pointHighlightFill : "#fff",
							pointHighlightStroke : "#CC99FF",
							data : [
								<%=x[0][1]%>, <%=x[1][1]%>, <%=x[2][1]%>, <%=x[3][1]%>, <%=x[4][1]%>,
								<%=x[5][1]%>, <%=x[6][1]%>, <%=x[7][1]%>, <%=x[8][1]%>, <%=x[9][1]%>,
								<%=x[10][1]%>, <%=x[11][1]%>, <%=x[12][1]%>, <%=x[13][1]%>, <%=x[14][1]%>,
								<%=x[15][1]%>, <%=x[16][1]%>, <%=x[17][1]%>, <%=x[18][1]%>, <%=x[19][1]%>,
								<%=x[20][1]%>, <%=x[21][1]%>, <%=x[22][1]%>, <%=x[23][1]%>]
						},
						{
							label: "My Second dataset",
							fillColor : "rgba(220,220,220,0.2)",
							strokeColor : "#FF0000",
							pointColor : "#FFB2B2",
							
							pointStrokeColor : "#fff",
							pointHighlightFill : "#fff",
							pointHighlightStroke : "#FFB2B2",
							data: [0,0,<%=z[0][1]%>, <%=z[1][1]%>, <%=z[2][1]%>, <%=z[3][1]%>, <%=z[4][1]%>,
									<%=z[5][1]%>, <%=z[6][1]%>, <%=z[7][1]%>, <%=z[8][1]%>, <%=z[9][1]%>,
									<%=z[10][1]%>, <%=z[11][1]%>, <%=z[12][1]%>, <%=z[13][1]%>, <%=z[14][1]%>,
									<%=z[15][1]%>, <%=z[16][1]%>, <%=z[17][1]%>, <%=z[18][1]%>, <%=z[19][1]%>,
									<%=z[20][1]%>, <%=z[21][1]%>]
						}
					]
				}
				
				</script>
				
			</td>
			<td style = "width: 75px; margin: 0; padding: 0; top: 0; left: 0;  border-spacing: 0px;">
				<ul class="legend">
				    <li><span class="applicationReceivedKey"></span>&nbsp;Application</li>
				    
				    <li><span class="permitIssuedKey"></span>&nbsp;Issued</li>
				</ul>
			</td>
		</tr>
	</table>
</div>

<div id = "sampleChartDIV" style = "display: none;">
	<table id = "sampleChartTable">
		<tr>
			<td style = "text-align: center;" colspan = 2>
				<b>Sample Chart</b>
			</td>
		</tr>
		<tr>
			<td>						
    			<div style="padding-right: 5px;">
					<canvas id="canvas2" style = "width: 100%; height:200px;"></canvas>
				</div>


				<script>
	
				//var randomScalingFactor = function(){ return Math.round(Math.random()*100)};
				var lineChartData2 = {
						labels : [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21],
					datasets : [
						{
							label: "Sample Chart Label 1",
							fillColor : "#9CBABA",
							
							data : [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21]
						},
						{
							label: "Sample Chart Label 1",
							fillColor : "yellow",
							
							data: [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
						}
					]
				}
				
				</script>
				
			</td>
			<td style = "width: 75px; margin: 0; padding: 0; top: 0; left: 0;  border-spacing: 0px;">
				<ul class="legend">
				    <li><span class="applicationReceivedKey"></span>&nbsp;First</li>
				    
				    <li><span class="permitIssuedKey"></span>&nbsp;Second</li>
				</ul>
			</td>
		</tr>
		
		
	</table>
</div>

<div id = "sampleChart2DIV" style = "display: none;">
	<table id = "sampleChart2Table">
		<tr>
			<td style = "text-align: center; ">
				<b>Sample Chart 2</b>
			</td>
			<td style = "text-align: center;">
				<b>Sample Chart 2B</b>
			</td>
		</tr>
		
		<tr style = "align: center;">
			<td>						
    			<div style="padding-right: 5px;">
					<canvas id="canvas3" style = "width: 50%; height:200px;"></canvas>
				</div>
			
				<script>
					var lineChartData3 = [
	                      {
	                          value: 25,
	                          label: 'Java',
	                          color: '#811BD6'
	                       },
	                       {
	                          value: 10,
	                          label: 'Scala',
	                          color: '#9CBABA'
	                       },
	                       {
	                          value: 30,
	                          label: 'PHP',
	                          color: '#D18177'
	                       },
	                       {
	                          value : 35,
	                          label: 'HTML',
	                          color: '#6AE128'
	                       }
	                    ];
	
			</script>				
			<!-- 
			<td style = "width: 75px; margin: 0; padding: 0; top: 0; left: 0;  border-spacing: 0px;">
				<ul class="legend">
				    <li><span class="applicationReceivedKey"></span>&nbsp;SampleLegendTop</li>
				    
				    <li><span class="permitIssuedKey"></span>&nbsp;SampleLegendBottom</li>
				</ul>
			</td>
			-->	
			<td>
				<div style="padding-right: 5px;">
					<canvas id="canvas3.2" style = "width: 50%; height:200px;"></canvas>
				</div>
			</td>
			<!-- 
			<td style = "width: 75px; margin: 0; padding: 0; top: 0; left: 0;  border-spacing: 0px;">
				<ul class="legend">
				    <li><span class="applicationReceivedKey"></span>&nbsp;SampleLegendTop</li>
				    
				    <li><span class="permitIssuedKey"></span>&nbsp;SampleLegendBottom</li>
				</ul>
			</td>
			-->
		</tr>
		
		
	</table>
</div>

</td>
</tr>

</table>
</form>
</div>




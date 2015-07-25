<%@ page contentType="text/html" %>
<%@ page import="dashboard.*" %>


<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>

<% 
String x[][] = dashboard.DatabaseManager.permitApplicationReceived(); 
String z[][] = dashboard.DatabaseManager.permitIssued();
%>

<div id = "overallStatisticsDataChartDIV">
<form>
<table style = "border: 1px solid black;">
<tr id = "chartButtonTrId" style = "background-color: #FFFFD1;">
	<td colspan = 2; style = "text-align: center;">
		<input type = "button"
			   value = "Received vs. Issued"
			   id = "permitApplicationVsPermitIssuedChartButton"
			   onmouseover = '' style = "cursor: pointer; background-color: #33CCFF; color: black;"
			   onClick = "display_main_chart(0);">
	
		<input type = "button"
			   value = "Sample Chart"
			   id = "sampleChartButton"
			   onmouseover = '' style = "cursor: pointer; background-color: #33ffad; color: black;"
			   onClick = "display_main_chart(1);">
	</td>
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
	
				//var randomScalingFactor = function(){ return Math.round(Math.random()*100)};
				var lineChartData = {
						labels : [
							'<%=x[0][0]%>', '<%=x[1][0]%>', '<%=x[2][0]%>', '<%=x[3][0]%>' , '<%=x[4][0]%>',		
							'<%=x[5][0]%>', '<%=x[6][0]%>', '<%=x[7][0]%>', '<%=x[8][0]%>', '<%=x[9][0]%>',
							'<%=x[10][0]%>', '<%=x[11][0]%>', '<%=x[12][0]%>', '<%=x[13][0]%>', '<%=x[14][0]%>',
							'<%=x[15][0]%>', '<%=x[16][0]%>', '<%=x[17][0]%>', '<%=x[18][0]%>', '<%=x[19][0]%>',
							'<%=x[20][0]%>'],
					datasets : [
						{
							label: "My First dataset",
							fillColor : "rgba(220,220,220,0.2)",
							strokeColor : "#9933FF",
							pointColor : "#CC99FF",
							
							pointStrokeColor : "#fff",
							pointHighlightFill : "#fff",
							pointHighlightStroke : "CC99FF",
							data : [
								<%=x[0][1]%>, <%=x[1][1]%>, <%=x[2][1]%>, <%=x[3][1]%>, <%=x[4][1]%>,
								<%=x[5][1]%>, <%=x[6][1]%>, <%=x[7][1]%>, <%=x[8][1]%>, <%=x[9][1]%>,
								<%=x[10][1]%>, <%=x[11][1]%>, <%=x[12][1]%>, <%=x[13][1]%>, <%=x[14][1]%>,
								<%=x[15][1]%>, <%=x[16][1]%>, <%=x[17][1]%>, <%=x[18][1]%>, <%=x[19][1]%>,
								<%=x[20][1]%>]
						},
						{
							label: "My Second dataset",
							fillColor : "rgba(151,187,205,0.2)",
							strokeColor : "#FF0000",
							pointColor : "#FFB2B2",
							pointStrokeColor : "#fff",
							pointHighlightFill : "#fff",
							pointHighlightStroke : "#FFB2B2",
							data: [<%=z[0][1]%>, <%=z[1][1]%>, <%=z[2][1]%>, <%=z[3][1]%>, <%=z[4][1]%>,
									<%=z[5][1]%>, <%=z[6][1]%>, <%=z[7][1]%>, <%=z[8][1]%>, <%=z[9][1]%>,
									<%=z[10][1]%>, <%=z[11][1]%>, <%=z[12][1]%>, <%=z[13][1]%>, <%=z[14][1]%>,
									<%=z[15][1]%>, <%=z[16][1]%>, <%=z[17][1]%>, <%=z[18][1]%>, <%=z[19][1]%>,
									<%=z[20][1]%>]
						}
					]
				}
				
				</script>
				
			</td>
			<td style = "width: 75px; margin: 0; padding: 0; top: 0; left: 0;  border-spacing: 0px;">
				<ul class="legend">
				    <li><span class="applicationReceivedKey"></span>&nbsp;Received</li>
				    
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
							fillColor : "rgba(220,220,220,0.2)",
							strokeColor : "#9933FF",
							pointColor : "#CC99FF",
							
							pointStrokeColor : "#fff",
							pointHighlightFill : "#fff",
							pointHighlightStroke : "CC99FF",
							data : [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21]
						},
						{
							label: "Sample Chart Label 1",
							fillColor : "rgba(151,187,205,0.2)",
							strokeColor : "#FF0000",
							pointColor : "#FFB2B2",
							pointStrokeColor : "#fff",
							pointHighlightFill : "#fff",
							pointHighlightStroke : "#FFB2B2",
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
</td>
</tr>

</table>
</form>
</div>
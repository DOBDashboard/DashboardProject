<%@ page contentType="text/html" %>
<%@ page import="dashboard.*" %>


<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>

<% String x[][] = dashboard.DatabaseManager.permitApplicationReceived(); 
out.println(x[0][0]);
out.println(x[0][1]);
%>
<% String z[][] = dashboard.DatabaseManager.permitIssued();
out.println(z[0][0]);
out.println(z[0][1]);%>

<div id = "overallStatisticsDataChartDIV">
	<table id = "overallStatisticsDataChartTable">
		<tr>
			<td>						
    			<div style="padding-right: 5px;">
					<canvas id="canvas" style = "width: 90%; height:200px;"></canvas>
				</div>


				<script>

					console.log(<%=z[0][0]%>);
					console.log(<%=z[1][0]%>);
					console.log(<%=z[2][0]%>);
					console.log(<%=z[3][0]%>);
					console.log(<%=z[4][0]%>);
					console.log(<%=z[5][0]%>);
					console.log(<%=z[6][0]%>);
					console.log(<%=z[7][0]%>);
					console.log(<%=z[8][0]%>);
					console.log(<%=z[9][0]%>);
					console.log(<%=z[10][0]%>);
					console.log(<%=z[11][0]%>);
					console.log(<%=z[12][0]%>);
					console.log(<%=z[13][0]%>);
					console.log(<%=z[14][0]%>);
					console.log(<%=z[15][0]%>);
					console.log(<%=z[16][0]%>);

					
				//var randomScalingFactor = function(){ return Math.round(Math.random()*100)};
				var lineChartData = {
					labels : [
							'<%=x[0][0]%>', <%=x[1][0]%>, <%=x[2][0]%>, <%=x[3][0]%>,<%=x[4][0]%>,		
							<%=x[5][0]%>, <%=x[6][0]%>, <%=x[7][0]%>, <%=x[8][0]%>, <%=x[9][0]%>,
							<%=x[10][0]%>, <%=x[11][0]%>, <%=x[12][0]%>, <%=x[13][0]%>, <%=x[14][0]%>,
							<%=x[15][0]%>, <%=x[16][0]%>, <%=x[17][0]%>, <%=x[18][0]%>, <%=x[19][0]%>,
							<%=x[20][0]%>],
					datasets : [
						{
							label: "My First dataset",
							fillColor : "rgba(220,220,220,0.2)",
							strokeColor : "rgba(220,220,220,1)",
							pointColor : "rgba(220,220,220,1)",
							pointStrokeColor : "#fff",
							pointHighlightFill : "#fff",
							pointHighlightStroke : "rgba(220,220,220,1)",
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
							strokeColor : "rgba(151,187,205,1)",
							pointColor : "rgba(151,187,205,1)",
							pointStrokeColor : "#fff",
							pointHighlightFill : "#fff",
							pointHighlightStroke : "rgba(151,187,205,1)",
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
		</tr>
	</table>
</div>


<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@ page import="java.util.*"%>

<% String c[] = dashboard.DatabaseManager.getT2P(); 
DateFormat formatter=new SimpleDateFormat("yyyy-MM-dd");
StringTokenizer st=new StringTokenizer(c[1],"-");
StringTokenizer st2=new StringTokenizer(c[2],"-");

String year1=st.nextToken();
String month1=st.nextToken();
String date1=st.nextToken();

String year2=st2.nextToken();
String month2=st2.nextToken();
String date2=st2.nextToken();
%>




<div id = "detailedStatisticsDIV">
<form>
	<table id = "detailedStatisticsTable" style = "background-color: #FFFAF6; border-style: groove; border-color: #FFFAF6; border-width: 1px;">
		<tr>
			<td colspan = "2">
					
					<b>Time To Permit:</b> <b><%=c[0]%></b> days for SPR permits issued between 
	
					<input style = " height: 22px;" type = "date" id = "startDateInput" value = "<%=year1%>-<%=month1%>-<%=(date1).substring(0,2)%>"/>	
					and
					<input style = " height: 22px;" type = "date" id = "startDateInput" value = "<%=year2%>-<%=month2%>-<%=(date2).substring(0,2)%>"/>
					<input style = "height: 22px;" type = "submit" value = "Go!" id = "submit"/>	
				
			</td>
		</tr>
		
		<tr>
			<td>
				<b>Number of Permits issued:</b> <b><%=c[3]%></b> 
		 		and <b>Avg Applicant Time:</b> <b><%=c[13]%></b> days
			</td>	
			
			<td style = "text-align: right;">
				<input type = "button" id = "showMoreH7Button" onclick = "showHideLinkOnClickFunction()" value = "Show More">
			</td>
		</tr>
	</table>



	<div id = "quickStatisticsDIV">
		<table id = "quickStatisticsTable" style = "display: none;">
			<tr>
				<td rowspan = "2" style = "align: center; text-align: center;">
					Number of Permits By Days To Permit
					
					<div>
						<canvas id="canvasTop" style = "width: 100%; height:200px;"></canvas>
					</div>	
	
					<script>			
					var barData = {
						    labels: ['0-10', '10-20', '20-50', '50-100', '100-200', '200-400', '400+'],
						    datasets: [
						        {
						            label: 'Quick Statistics Table',
						            fillColor: '#A3FF75',
						            data: [<%=c[12]%>, <%=c[11]%>,<%=c[10]%>, <%=c[9]%>, <%=c[8]%>, <%=c[7]%>, <%=c[6]%>]
						        }
						        
						    ]
						};
		
					
					</script>					
				</td>	
				
				<td valign = "top" >
					<table style = "border-style: groove; border-color: #FFFAF6; border-width: 1px; align: left;">
						<tr>
							<td colspan = 2 style = "text-align: center;">
								Quick Statistics
							</td>
						</tr>
						
						<tr>
							<td><b>Slowest Permit</b></td>
							<td><%=c[4]%> days</td>
						</tr>
						
						<tr>
							<td><b>Fastest Permit</b></td>
							<td><%=c[5]%> days</td>
						</tr>
					</table>
					</td>
				
			</tr>
		
			<tr>
				
			</tr>
		</table>
	</div>
	</form>
</div>

<div id = "searchProjectsDIV">
	<form onsubmit = "displaySearchResult(); return false" autocomplete="off">
		<table id = "searchProjectsTable" style = "border-style: groove; border-color: #FFFAF6; border-width: 1px;">
			<tr style = "height: 10px; cellspacing: 0;">
				<td style = "font-size: 12px; color: black;"><b>Project Lookup</b></td>
				
				<td style = "width: 10%; height: 15px; align: right;">
					<div class="searchTitle" style = "cursor: pointer; font-size: 12px; color: white;" onmouseover = "">
						<img src="img/helpIconBlue.png" title = "Click for Help" alt="helpIcon" id = "searchHelpButton"  
						onmouseover = '' style = " -webkit-filter: grayscale(100%);  cursor: pointer; width: 20px; height: 14px; padding: 0;">		
					
					    <div class="descriptionToolBox">
					    	e.g.<br>
					    	"000111222 N Lake St"<br>
					    	"000111222"<br>
						</div>
					</div>
				</td>
			</tr>
			
			<tr>
				<td colspan = 2>
					<input id = "searchThisForUserInputId"type = "text" value = "" style = "width: 99%;">
					<br>
					<input id = "searchButton" type = "button" value = "Search" onclick = "displaySearchResult()" tabIndex = "-1">
				</td>
			</tr>
		</table>
	</form>
</div>

<!-- End of File -->
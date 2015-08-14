package dashboard;


import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Hashtable;

import javax.naming.*;

import java.util.*;

import javax.sql.DataSource;

public class DatabaseManager  {

	  private static Exception error;
	  private static String message;
	  
	  
	  public static String[] getT2P() throws Exception{
		    Context ctx = null;
		   	Statement stmt = null;
		   	Connection conn = null;
			ResultSet rs = null;
		      error = null;
		      String c[] = new String [30];
			      
		      try {
		    	  ctx = new InitialContext();
		            DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/H7");
				  conn = ds.getConnection();
				  stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
				  stmt.execute("select round(avg(a.issdttm-t.EPLAN_FOLDER_DATE)) t2p, sysdate-14 startDt, sysdate endDt, count(*) permits, round(max(a.issdttm-t.EPLAN_FOLDER_DATE)) slowest, " 
+ " round(min(a.issdttm-t.EPLAN_FOLDER_DATE)) fastest, COUNT(case when (a.issdttm-t.EPLAN_FOLDER_DATE) > 400 then '1' end) t400 , COUNT(case when (a.issdttm-t.EPLAN_FOLDER_DATE) BETWEEN 200 AND 400 then '1' end) t200 ,"
+ " COUNT(case when (a.issdttm-t.EPLAN_FOLDER_DATE) BETWEEN 100 AND 200 then '1' end) t100 , COUNT(case when (a.issdttm-t.EPLAN_FOLDER_DATE) BETWEEN 50 AND 100 then '1' end) t50 ," 
+ " COUNT(case when (a.issdttm-t.EPLAN_FOLDER_DATE) BETWEEN 20 AND 50 then '1' end) t20 , COUNT(case when (a.issdttm-t.EPLAN_FOLDER_DATE) BETWEEN 10 AND 20 then '1' end) t10 ,"
+ " COUNT(case when (a.issdttm-t.EPLAN_FOLDER_DATE) < 10 then '1' end) t0 ,"
+ " round(avg(t.TIME_WITH_APPLICANT)) apltime from  AVOLVE.PROJDOX_TIME_TO_PERMIT t inner join imsv7.apbldg a on t.apno = a.apno where a.issdttm is not null and a.ISSDTTM > sysdate-14"); 
				  rs = stmt.getResultSet(); 
		         rs.first();

			     c[0] = rs.getString("T2P");
			     c[1] = rs.getString("startdt");
			     c[2] = rs.getString("enddt");
			     c[3] = rs.getString("permits");
			     c[4] = rs.getString("slowest");
			     c[5] = rs.getString("fastest");
			     c[6] = rs.getString("t400");
			     c[7] = rs.getString("t200");
			     c[8] = rs.getString("t100");
			     c[9] = rs.getString("t50");
			     c[10] = rs.getString("t20");
			     c[11] = rs.getString("t10");
			     c[12] = rs.getString("t0");
			     c[13] = rs.getString("apltime");
			     
		      } catch (SQLException e) {
		         error = e;
		         message = "get apdefnkey failed";
		      } catch (NamingException e) {
		    	  message ="  a failure occurred";
	    	  }
	      finally {
		    try {
		    	ctx.close();
		         stmt.close();
				 conn.close(); 
		    	 rs.close();
		    }
		    catch (Exception e) {
		    	 message ="  a failure occurred";
		    	}
		    }              

		      return c;
		       
		   }
	   
	   public static String[][] getT2P_SPR_SelfCert() throws Exception{ 
		    Context ctx = null;
		   	Statement stmt = null;
		   	Connection conn = null;
			ResultSet rs = null;
		      error = null;
		      String c[][] = null;
		      Double d[] = null;
		      double avg_tot =0;
		      int projects =0;
			  double t2p;
			  
		      try {
		    	  ctx = new InitialContext();
		            DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/pdox");
				  conn = ds.getConnection();
				  stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
				  stmt.execute("select a.taskname, cast(avg(tm) as numeric (36,2) ) avgtm, count(*) ct, case  a.taskname when 'UploadConfirmation' then 2 when 'AssignPM' then 3 "
				  		+ " when 'SelfCertificationReview' then 5 when 'SelfCertificationCorrectionComplete' then 6 when 'SelfCertificationResubmit' then 7 else 9 end  ordr from ( " +
"select t.objectid, t.taskname, sum(datediff(hh, t.datecreated, t.DateUpdated)+ 0.0)/24 tm from " +
"(select p.projectid OBJECTID from projects p inner join flowinstances f on p.ProjectID = f.ParentEntityID where p.Status like 'Approved - Self Cert' and f.RuntimeStatus like 'Complete' and " + 
"f.FlowInstanceName not like 'Zoning%' and f.flowinstancename not like '%DS%' and f.flowinstancename not like '%Developer%' and f.dateupdated between GETDATE()-14 and GETDATE()) a inner join " + 
"flowtasks t on a.ObjectID = t.ObjectID inner join flowinstances f on t.flowinstanceid = f.flowinstanceid " + 
 "where f.FlowInstanceName not like 'Zoning%' and f.flowinstancename not like '%DS%' and f.flowinstancename not like '%Developer%' and t.taskstatus like 'Complete'" +
 "group by t.objectid, t.taskname) a group by a.taskname order by ordr"); 
				  rs = stmt.getResultSet(); 
				  rs.last(); 
				  c = new String [rs.getRow()][5]; 
				  d = new Double [rs.getRow()]; 

				  rs.beforeFirst();
		         int i = 0;
		         while (rs.next()){ 
			     c[i][0] = rs.getString("taskname");
			     c[i][1] = rs.getString("avgtm");
			     c[i][2] = rs.getString("ct");
			     c[i][4] = rs.getString("ordr");
			     d[i] =  Double.parseDouble(c[i][1]) *  Double.parseDouble(c[i][2]);
			    if(c[i][0].equals("UploadConfirmation")){projects= Integer.parseInt(c[i][2]);}
			     i++;
		         }
			     
		      } catch (SQLException e) {
		         error = e;
		         message = "get apdefnkey failed";
		      } catch (NamingException e) {
		    	  message ="  a failure occurred";
	    	  }
	      finally {
		    try {
		    	ctx.close();
		         stmt.close();
				 conn.close(); 
		    	 rs.close();
		    }
		    catch (Exception e) {
		    	 message ="  a failure occurred";
		    	}
		    }  
      
for (int k =0; k < d.length; k++ ){
	avg_tot = avg_tot + d[k];
}

	
t2p = avg_tot/projects;
for (int p =0; p < d.length; p++ ){
	c[p][3] = Double.toString( Math.round( ((d[p]/avg_tot)*t2p)*100.0 )/100.0  );
}

		      return c;
		       
		   }

	   
	   public static String[][] getT2P_SPR_NonSelfCert() throws Exception{
		    Context ctx = null;
		   	Statement stmt = null;
		   	Connection conn = null;
			ResultSet rs = null;
		      error = null;
		      String c[][] = null;
		      Double d[] = null;
		      double avg_tot =0;
		      int projects =0;
			  double t2p;
			  
		      try {
		    	  ctx = new InitialContext();
		            DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/pdox");
				  conn = ds.getConnection();
				  stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
				  stmt.execute("select a.taskname, cast(avg(tm) as numeric (36,2) ) avgtm, count(*) ct, case  a.taskname when 'UploadConfirmation' then 2 "
				  		+ "when 'AssignPM' then 3 when 'PreScreenReview' then 5 when 'PrescreenResubmittal' then 6 when 'PrescreenResubmittalReview' then "
				  		+ " 7 when 'BeginReview' then 9 when 'DepartmentReview' then 11 when 'ReviewQA' then 13 when 'ReviewComplete' then 15 when "
				  		+ " 'ApplicantResubmit' then 16 when 'ResubmitReceived' then 17 when 'UploadCertifiedCorrections' then 18 when "
				  		+ "'CertifiedCorrectionsReview' then 19 when 'CertifiedCorrectionsResubmittal' then 20 when 'CertifiedCorrectionsResubmittalReview' "
				  		+ " then 21 when 'UploadFinalDocumentation' then 22 when  'BatchStamps_Final' then 23 else 25 end ordr from ( " +
"select t.objectid, t.taskname, sum(datediff(hh, t.datecreated, t.DateUpdated)+ 0.0)/24 tm from " +
"(select p.projectid OBJECTID from projects p inner join flowinstances f on p.ProjectID = f.ParentEntityID where p.Status like 'Approved' and f.RuntimeStatus like 'Complete' and "+ 
"f.FlowInstanceName not like 'Zoning%' and f.flowinstancename not like '%DS%' and f.flowinstancename not like '%Developer%' and f.dateupdated between GETDATE()-14 and GETDATE()) a inner join " + 
"flowtasks t on a.ObjectID = t.ObjectID inner join flowinstances f on t.flowinstanceid = f.flowinstanceid " + 
"where f.FlowInstanceName not like 'Zoning%' and f.flowinstancename not like '%DS%' and f.flowinstancename not like '%Developer%' and t.taskstatus like 'Complete'" +
"group by t.objectid, t.taskname) a group by a.taskname order by ordr"); 
				  rs = stmt.getResultSet(); 
				  rs.last(); 
				  c = new String [rs.getRow()][5]; 
				  d = new Double [rs.getRow()]; 
				  rs.beforeFirst();
		         int i = 0;
		         while (rs.next()){ 
			     c[i][0] = rs.getString("taskname");
			     c[i][1] = rs.getString("avgtm");
			     c[i][2] = rs.getString("ct");
			     c[i][4] = rs.getString("ordr");
			     d[i] =  Double.parseDouble(c[i][1]) *  Double.parseDouble(c[i][2]);
				    if(c[i][0].equals("UploadConfirmation")){projects= Integer.parseInt(c[i][2]);}
			     i++;
		         }
			     
		      } catch (SQLException e) {
		         error = e;
		         message = "get apdefnkey failed";
		      } catch (NamingException e) {
		    	  message ="  a failure occurred";
	    	  }
	      finally {
		    try {
		    	ctx.close();
		         stmt.close();
				 conn.close(); 
		    	 rs.close();
		    }
		    catch (Exception e) {
		    	 message ="  a failure occurred";
		    	}
		    }    
		      
		      for (int k =0; k < d.length; k++ ){
		    		avg_tot = avg_tot + d[k];
		    	}

		    		
		    	t2p = avg_tot/projects;
		    	for (int p =0; p < d.length; p++ ){
		    		c[p][3] = Double.toString( Math.round( ((d[p]/avg_tot)*t2p)*100.0 )/100.0  );
		    	}
		      
		      
		      return c;
		       
		   }
	   
	   /* @param: none
	    *
	    * Method that stores the result of the task split performed from database
	    * to and 2-d array. The task split are broken down into 8 separate age groups.
	    * 
	    */
	   public static String[][] getQueueAgeSplit() throws Exception
	   {	   
		   Statement stmt = null;
		   ResultSet rs = null;
		   Connection conn = null;
		   
		   Context ctx = null;
		   error = null;
		   
		   String taskTimeTable[][] = null;
		   
		   try
		   {
			   ctx = new InitialContext();
			   DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/pdox");
			   conn = ds.getConnection();
			   stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			   stmt.execute("select z.taskname, sum(z.tasks) ct, sum(case when z.dif between 0 and 4 then z.tasks end )'0To4', sum(case when z.dif between 5 and 10 then z.tasks end) '5To10', " +
			   			    "sum(case when z.dif between 11 and 15 then z.tasks end) '11To15' , sum(case when z.dif between 16 and 20 then z.tasks end) '16To20' , sum(case when z.dif between 21 and 30 then z.tasks end) '21To30', " +
							"sum(case when z.dif between 31 and 50 then z.tasks end) '31To50' , sum(case when z.dif between 51 and 100 then z.tasks end) '51To100' , sum(case when z.dif > 100 then z.tasks end) '101+' " +
							"from ( " +
							"select t.TaskName, count( p.ProjectID) tasks, datediff(dd, t.DateCreated,getdate())  dif " +
							"from flowtasks t inner join FlowInstances f on t.FlowInstanceID = f.flowinstanceid " +
							"inner join projects p on f.ParentEntityID = p.ProjectID inner join groups g  on t.AssocEntityID = g.GroupID where t.TaskStatus in ('Accepted', 'Pending') and f.RuntimeStatus " +
							"not in ('Complete', 'Terminated') and p.archived = 0  and p.Status not like 'Approved' and g.Name not like 'Applicant' " +
							"group by t.TaskName, datediff(dd, t.DateCreated,getdate()) ) z group by z.taskname order by 1");
			   
			   rs = stmt.getResultSet(); 
			   rs.last(); 
			   taskTimeTable = new String [rs.getRow()][16]; 
			   
			   rs.beforeFirst();
			   
			   int i = 0;
			   
			   while (rs.next())
			   { 
				   taskTimeTable[i][0] = rs.getString("taskname");
				   taskTimeTable[i][1] = rs.getString("ct");
				   taskTimeTable[i][2] = rs.getString("0To4");
				   taskTimeTable[i][3] = rs.getString("5To10");
				   taskTimeTable[i][4] = rs.getString("11To15");
				   taskTimeTable[i][5] = rs.getString("16To20");
				   taskTimeTable[i][6] = rs.getString("21To30");
				   taskTimeTable[i][7] = rs.getString("31To50");
				   taskTimeTable[i][8] = rs.getString("51To100");
				   taskTimeTable[i][9] = rs.getString("101+");
				   
				   i++;
			   }
		   }
		   catch(SQLException e) 
		   {
			   error = e;
			   message = "get apdefnkey failed";
		   } 
		   catch(NamingException e) 
		   {
			   message = "a failure occurred";
		   }
		   finally 
		   {
			   try 
			   {
				   ctx.close();
				   stmt.close();
				   conn.close();
				   rs.close();
			   }
			   catch(Exception e) 
			   {
				   message ="  a failure occurred";
			   }
		   }
		   
		   return taskTimeTable;
	   }
	   
	   /* @param: none
	    *
	    * Method that stores the result of the task split performed from database
	    * to and 2-d array. The task split are broken down into 8 separate age groups.
	    * 
	    */
	   public static String[][] getQueueOwnerByTaskAge() throws Exception
	   {	   
		   Statement stmt = null;
		   ResultSet rs = null;
		   Connection conn = null;
		   
		   Context ctx = null;
		   error = null;
		   
		   String taskTimeTable[][] = null;
		   
		   try
		   {
			   ctx = new InitialContext();
			   DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/pdox");
			   conn = ds.getConnection();
			   stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			   
			   stmt.execute("select case when Z.ct2 = 1 then z.name2 when z.name IS null then z.grp when z.name IS not null and z.taskstatus like 'Pending' and ct2 > 1 then z.grp else Z.name end name,  sum(Z.ct) ct, sum(case when z.dif between 0 and 4 then z.ct end )'0To4', sum(case when z.dif between 5 and 10 then z.ct end) '5To10', " +
							"sum(case when z.dif between 11 and 15 then z.ct end) '11To15' , sum(case when z.dif between 16 and 20 then z.ct end) '16To20' , sum(case when z.dif between 21 and 30 then z.ct end) '21To30', " +
							"sum(case when z.dif between 31 and 50 then z.ct end) '31To50' , sum(case when z.dif between 51 and 100 then z.ct end) '51To100' , sum(case when z.dif > 100 then z.ct end) '101+' , case when Z.ct2 = 1 then 'P' when z.name IS null then 'G' else 'P' end gp " +
							"from ( " +
							"select p.name prj, g.name grp, u.FirstName+' '+u.LastName name, datediff(dd, t.DateCreated,getdate())  dif, count(distinct t.flowtaskid) ct, max(u2.FirstName+' '+u2.LastName) name2, COUNT(u2.firstname) ct2, t.TaskStatus " +
							"from flowtasks t inner join FlowInstances f on t.FlowInstanceID = f.flowinstanceid " +
							"inner join projects p on f.ParentEntityID = p.ProjectID inner join groups g  on t.AssocEntityID = g.GroupID left join Users u on t.UpdatedBy = u.userid left join Groups_Users gs on g.GroupID = gs.GroupID " +
							"left join Users u2 on gs.UserID = u2.UserID " +
							"where t.TaskStatus in ('Accepted', 'Pending') and f.RuntimeStatus " +
							"not in ('Complete', 'Terminated') and p.archived = 0  and p.Status not like 'Approved' and g.Name not like 'Applicant'  and p.Archived = 0 " +
							"group by  p.name, g.Name, u.FirstName+' '+u.LastName, datediff(dd, t.DateCreated,getdate()) , t.TaskStatus ) z " +
							"group by  case when Z.ct2 = 1 then 'P' when z.name IS null then 'G' else 'P' end, case when Z.ct2 = 1 then z.name2 when z.name IS null then z.grp when z.name IS not null and z.taskstatus like 'Pending' and ct2 > 1 then z.grp else Z.name end " +
							"order by 2 desc;");
			   /*
			   stmt.execute("select case when Z.ct2 = 1 then z.name2 when z.name IS null then z.grp else Z.name end name,  sum(Z.ct) ct, sum(case when z.dif between 0 and 4 then z.ct end )'0To4', sum(case when z.dif between 5 and 10 then z.ct end) '5To10', " +
					   "sum(case when z.dif between 11 and 15 then z.ct end) '11To15' , sum(case when z.dif between 16 and 20 then z.ct end) '16To20' , sum(case when z.dif between 21 and 30 then z.ct end) '21To30',  " +
					   "sum(case when z.dif between 31 and 50 then z.ct end) '31To50' , sum(case when z.dif between 51 and 100 then z.ct end) '51To100' , sum(case when z.dif > 100 then z.ct end) '101+' , case when Z.ct2 = 1 then 'P' when z.name IS null then 'G' else 'P' end gp " +
					   "from ( " +
					   "select p.name prj, g.name grp, u.FirstName+' '+u.LastName name, datediff(dd, t.DateCreated,getdate())  dif, count(distinct t.flowtaskid) ct, max(u2.FirstName+' '+u2.LastName) name2, COUNT(u2.firstname) ct2  " +
					   "from flowtasks t inner join FlowInstances f on t.FlowInstanceID = f.flowinstanceid " +
					   "inner join projects p on f.ParentEntityID = p.ProjectID inner join groups g  on t.AssocEntityID = g.GroupID left join Users u on t.UpdatedBy = u.userid left join Groups_Users gs on g.GroupID = gs.GroupID " +
					   "left join Users u2 on gs.UserID = u2.UserID "+
					   "where t.TaskStatus in ('Accepted', 'Pending') and f.RuntimeStatus "+
					   "not in ('Complete', 'Terminated') and p.archived = 0  and p.Status not like 'Approved' and g.Name not like 'Applicant'  and p.Archived = 0 "+
					   "group by  p.name, g.Name, u.FirstName+' '+u.LastName, datediff(dd, t.DateCreated,getdate())  ) z "+
					   "group by  case when Z.ct2 = 1 then 'P' when z.name IS null then 'G' else 'P' end, case when Z.ct2 = 1 then z.name2 when z.name IS null then z.grp else Z.name end "+
					   "order by 2 desc;");
			   */
			   rs = stmt.getResultSet(); 
			   rs.last(); 
			   taskTimeTable = new String [rs.getRow()][11]; 
			   
			   rs.beforeFirst();
			   
			   int i = 0;
			   
			   while (rs.next())
			   { 
				   taskTimeTable[i][0] = rs.getString("name");
				   taskTimeTable[i][1] = rs.getString("ct");
				   taskTimeTable[i][2] = rs.getString("0To4");
				   taskTimeTable[i][3] = rs.getString("5To10");
				   taskTimeTable[i][4] = rs.getString("11To15");
				   taskTimeTable[i][5] = rs.getString("16To20");
				   taskTimeTable[i][6] = rs.getString("21To30");
				   taskTimeTable[i][7] = rs.getString("31To50");
				   taskTimeTable[i][8] = rs.getString("51To100");
				   taskTimeTable[i][9] = rs.getString("101+");
				   taskTimeTable[i][10] = rs.getString("gp");
				   
				   i++;
			   }
		   }
		   catch(SQLException e) 
		   {
			   error = e;
			   message = "get apdefnkey failed";
		   } 
		   catch(NamingException e) 
		   {
			   message = "a failure occurred";
		   }
		   finally 
		   {
			   try 
			   {
				   ctx.close();
				   stmt.close();
				   conn.close();
				   rs.close();
			   }
			   catch(Exception e) 
			   {
				   message ="  a failure occurred";
			   }
		   }
		   
		   return taskTimeTable;
	   }
	   
	   
	   // SPR_NonSelfCert() 
	   // updated code
	   // public static String[][] getT2P_SPR_NonSelfCert() throws Exception
	   public static String[][] getT2P_All() throws Exception{
		    Context ctx = null;
		   	Statement stmt = null;
		   	Connection conn = null;
			ResultSet rs = null;
		      error = null;
		      String c[][] = null;
		      Double d[] = null;
		      double avg_tot =0;
		      int projects =0;
			  double t2p;
			  
		      try {
		    	  ctx = new InitialContext();
		            DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/pdox");
				  conn = ds.getConnection();
				  stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
				  stmt.execute("select a.taskname, cast(avg(tm) as numeric (36,2) ) avgtm, count(*) ct, case  a.taskname when 'UploadConfirmation' then 2 "
				  		+ "when 'AssignPM' then 3 when 'PreScreenReview' then 5 when 'PrescreenResubmittal' then 6 when 'PrescreenResubmittalReview' then "
				  		+ " 7 when 'BeginReview' then 9 when 'DepartmentReview' then 11 when 'ReviewQA' then 13 when 'ReviewComplete' then 15 when "
				  		+ " 'ApplicantResubmit' then 16 when 'ResubmitReceived' then 17 when 'UploadCertifiedCorrections' then 18 when "
				  		+ "'CertifiedCorrectionsReview' then 19 when 'CertifiedCorrectionsResubmittal' then 20 when 'CertifiedCorrectionsResubmittalReview' "
				  		+ " then 21 when 'UploadFinalDocumentation' then 22 when  'BatchStamps_Final' then 23 else 25 end ordr from ( " +
"select t.objectid, t.taskname, sum(datediff(hh, t.datecreated, t.DateUpdated)+ 0.0)/24 tm from " +
"(select p.projectid OBJECTID from projects p inner join flowinstances f on p.ProjectID = f.ParentEntityID where p.Status like 'Approved%' and f.RuntimeStatus like 'Complete' and "+ 
"f.FlowInstanceName not like 'Zoning%' and f.flowinstancename not like '%DS%' and f.flowinstancename not like '%Developer%' and f.dateupdated between GETDATE()-14 and GETDATE()) a inner join " + 
"flowtasks t on a.ObjectID = t.ObjectID inner join flowinstances f on t.flowinstanceid = f.flowinstanceid " + 
"where f.FlowInstanceName not like 'Zoning%' and f.flowinstancename not like '%DS%' and f.flowinstancename not like '%Developer%' and t.taskstatus like 'Complete'" +
"group by t.objectid, t.taskname) a group by a.taskname order by ordr"); 
				  rs = stmt.getResultSet(); 
				  rs.last(); 
				  c = new String [rs.getRow()][5]; 
				  d = new Double [rs.getRow()]; 
				  rs.beforeFirst();
		         int i = 0;
		         while (rs.next()){ 
			     c[i][0] = rs.getString("taskname");
			     c[i][1] = rs.getString("avgtm");
			     c[i][2] = rs.getString("ct");
			     c[i][4] = rs.getString("ordr");
			     d[i] =  Double.parseDouble(c[i][1]) *  Double.parseDouble(c[i][2]);
				    if(c[i][0].equals("UploadConfirmation")){projects= Integer.parseInt(c[i][2]);}
			     i++;
		         }
			     
		      } catch (SQLException e) {
		         error = e;
		         message = "get apdefnkey failed";
		      } catch (NamingException e) {
		    	  message ="  a failure occurred";
	    	  }
	      finally {
		    try {
		    	ctx.close();
		         stmt.close();
				 conn.close(); 
		    	 rs.close();
		    }
		    catch (Exception e) {
		    	 message ="  a failure occurred";
		    	}
		    }    
		      
		      for (int k =0; k < d.length; k++ ){
		    		avg_tot = avg_tot + d[k];
		    	}

		    		
		    	t2p = avg_tot/projects;
		    	for (int p =0; p < d.length; p++ ){
		    		c[p][3] = Double.toString( Math.round( ((d[p]/avg_tot)*t2p)*100.0 )/100.0  );
		    	}
		      
		      
		      return c;
		       
		   }
	   
	   
	   public static String[] getQueue() throws Exception{
		    Context ctx = null;
		   	Statement stmt = null;
		   	Connection conn = null;
			ResultSet rs = null;
		      error = null;
		      String p[] = new String [3];
			      
		      try {
		    	  ctx = new InitialContext();
		            DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/pdox");
				  conn = ds.getConnection();
				  stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
				  stmt.execute("select count(distinct p.ProjectID) projects, count( p.ProjectID) tasks from flowtasks t inner join FlowInstances f on t.FlowInstanceID = f.flowinstanceid inner join projects p on f.ParentEntityID = p.ProjectID inner join groups g  on t.AssocEntityID = g.GroupID where t.TaskStatus in ('Accepted', 'Pending') and f.RuntimeStatus not in ('Complete', 'Terminated') and p.archived = 0  and p.Status not like 'Approved' and g.Name not like 'Applicant'"); 
				  //stmt.execute("select * from projects");
				  rs = stmt.getResultSet(); 
		         rs.first();

			     p[0] = rs.getString("projects");
			     p[1] = rs.getString("tasks");
			     
		      } catch (SQLException e) {
		         error = e;
		         message = "get apdefnkey failed";
		      } catch (NamingException e) {
		    	  message ="  a failure occurred";
	    	  }
	      finally {
		    try {
		    	ctx.close();
		         stmt.close();
				 conn.close(); 
		    	 rs.close();
		    }
		    catch (Exception e) {
		    	 message ="  a failure occurred";
		    	}
		    }              

		      return p;
		       
		   }
	   
	   public static String[][] getWorkflowQueue() throws Exception{
		    Context ctx = null;
		   	Statement stmt = null;
		   	Connection conn = null;
			ResultSet rs = null;
		      error = null;
		      String p[][] = new String [3][3];
			      
		      try {
		    	  ctx = new InitialContext();
		            DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/pdox");
				  conn = ds.getConnection();
				  stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
				  stmt.execute("select (case  f.FlowInstanceName when 'DS Workflow' then 'Developer Services' when 'DS Workflow V2' then 'Developer Services'  when 'SPR Main Workflow V3' then 'SPR' when 'SPRReviewV3' then 'SPR' " +
						  "when 'Start_Standard_PlanReview' then 'SPR'  when 'ZoningReviewV3' then 'Zoning' else f.FlowInstanceName end) flowname, count(distinct p.ProjectID) projects, count( p.ProjectID) tasks from flowtasks t inner join FlowInstances f on t.FlowInstanceID = f.flowinstanceid " +
						  "inner join projects p on f.ParentEntityID = p.ProjectID inner join groups g  on t.AssocEntityID = g.GroupID where t.TaskStatus in ('Accepted', 'Pending') and f.RuntimeStatus " +
						  "not in ('Complete', 'Terminated') and p.archived = 0  and p.Status not like 'Approved' and g.Name not like 'Applicant' " +
						  "group by (case  f.FlowInstanceName when 'DS Workflow' then 'Developer Services' when 'DS Workflow V2' then 'Developer Services'  when 'SPR Main Workflow V3' then 'SPR'  " +
								  "when 'SPRReviewV3' then 'SPR' when 'Start_Standard_PlanReview' then 'SPR' when 'ZoningReviewV3' then 'Zoning' else f.FlowInstanceName end)"); 
				  //stmt.execute("select * from projects");
				  rs = stmt.getResultSet(); 
		         //rs.first();
				  int i = 0;
		         while  (rs.next()) { 
			     p[i][0] = rs.getString("flowname");
			     p[i][1] = rs.getString("projects");
			     p[i][2] = rs.getString("tasks");
			     i++;
		         }
		      } catch (SQLException e) {
		         error = e;
		         message = "get apdefnkey failed";
		      } catch (NamingException e) {
		    	  message ="  a failure occurred";
	    	  }
	      finally {
		    try {
		    	ctx.close();
		         stmt.close();
				 conn.close(); 
		    	 rs.close();
		    }
		    catch (Exception e) {
		    	 message ="  a failure occurred";
		    	}
		    }              

		      return p;
		       
		   }
	   
	   public static String[][] getPdoxTasksQueue() throws Exception{
		    Context ctx = null;
		   	Statement stmt = null;
		   	Connection conn = null;
			ResultSet rs = null;
		      error = null;
		      String p[][] = null;
			      
		      try {
		    	  ctx = new InitialContext();
		            DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/pdox");
				  conn = ds.getConnection();
				  stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
				  stmt.execute("select taskname, sum(case flowname when 'SPR' then tasks end) SPR,  sum(case flowname when 'Developer Services' then tasks end) DS, sum(case flowname when 'Zoning' then tasks end) Zoning from ("+
"select t.TaskName, (case  f.FlowInstanceName when 'DS Workflow' then 'Developer Services' when 'DS Workflow V2' then 'Developer Services'  when 'SPR Main Workflow V3' then 'SPR' when 'SPRReviewV3' "+
"then 'SPR' when 'Start_Standard_PlanReview' then 'SPR'  when 'ZoningReviewV3' then 'Zoning' else f.FlowInstanceName end) flowname,  count( p.ProjectID) tasks "+
"from flowtasks t inner join FlowInstances f on t.FlowInstanceID = f.flowinstanceid "+
"inner join projects p on f.ParentEntityID = p.ProjectID inner join groups g  on t.AssocEntityID = g.GroupID where t.TaskStatus in ('Accepted', 'Pending') and f.RuntimeStatus "+
"not in ('Complete', 'Terminated') and p.Status not like 'Approved' and g.Name not like 'Applicant' "+
"group by t.TaskName, (case  f.FlowInstanceName when 'DS Workflow' then 'Developer Services' when 'DS Workflow V2' then 'Developer Services'  when 'SPR Main Workflow V3' then 'SPR'  "+
"when 'SPRReviewV3' then 'SPR' when 'Start_Standard_PlanReview' then 'SPR' when 'ZoningReviewV3' then 'Zoning' else f.FlowInstanceName end)) a group by a.taskname"); 
				  //stmt.execute("select * from projects");
				  rs = stmt.getResultSet(); 
				  rs.last(); 
				  p = new String [rs.getRow()][4]; 
				  rs.beforeFirst();
				  int i = 0;
		         while  (rs.next()) { 
			     p[i][0] = rs.getString("taskname");
			     p[i][1] = rs.getString("SPR");
			     p[i][2] = rs.getString("DS");
			     p[i][3] = rs.getString("Zoning");
			     i++;
		         }
		      } catch (SQLException e) {
		         error = e;
		         message = "get apdefnkey failed";
		      } catch (NamingException e) {
		    	  message ="  a failure occurred";
	    	  }
	      finally {
		    try {
		    	ctx.close();
		         stmt.close();
				 conn.close(); 
		    	 rs.close();
		    }
		    catch (Exception e) {
		    	 message ="  a failure occurred";
		    	}
		    }              

		      return p;
		       
		   }
	   
	   //SPR Different table
	   public static String[][] getPdoxTasksQueueSPR() throws Exception{
		    Context ctx = null;
		   	Statement stmt = null;
		   	Connection conn = null;
			ResultSet rs = null;
		      error = null;
		      String p[][] = null;
			      
		      try {
		    	  ctx = new InitialContext();
		            DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/pdox");
				  conn = ds.getConnection();
				  stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
				  stmt.execute("select taskname, sum(case flowname when 'SPR' then tasks end) SPR,  sum(case flowname when 'Developer Services' then tasks end) DS, sum(case flowname when 'Zoning' then tasks end) Zoning from ("+
"select t.TaskName, (case  f.FlowInstanceName when 'DS Workflow' then 'Developer Services' when 'DS Workflow V2' then 'Developer Services'  when 'SPR Main Workflow V3' then 'SPR' when 'SPRReviewV3' "+
"then 'SPR' when 'Start_Standard_PlanReview' then 'SPR'  when 'ZoningReviewV3' then 'Zoning' else f.FlowInstanceName end) flowname,  count( p.ProjectID) tasks "+
"from flowtasks t inner join FlowInstances f on t.FlowInstanceID = f.flowinstanceid "+
"inner join projects p on f.ParentEntityID = p.ProjectID inner join groups g  on t.AssocEntityID = g.GroupID where t.TaskStatus in ('Accepted', 'Pending') and f.RuntimeStatus "+
"not in ('Complete', 'Terminated') and p.archived = 0  and p.Status not like 'Approved' and g.Name not like 'Applicant' "+
"group by t.TaskName, (case  f.FlowInstanceName when 'DS Workflow' then 'Developer Services' when 'DS Workflow V2' then 'Developer Services'  when 'SPR Main Workflow V3' then 'SPR'  "+
"when 'SPRReviewV3' then 'SPR' when 'Start_Standard_PlanReview' then 'SPR' when 'ZoningReviewV3' then 'Zoning' else f.FlowInstanceName end)) a group by a.taskname"); 
				  //stmt.execute("select * from projects");
				  rs = stmt.getResultSet(); 
				  rs.last(); 
				  p = new String [rs.getRow()][4]; 
				  rs.beforeFirst();
				  int i = 0;
		         while  (rs.next()) { 
			     p[i][0] = rs.getString("taskname");
			     p[i][1] = rs.getString("SPR");
			     p[i][2] = rs.getString("DS");
			     p[i][3] = rs.getString("Zoning");
			     i++;
		         }
		      } catch (SQLException e) {
		         error = e;
		         message = "get apdefnkey failed";
		      } catch (NamingException e) {
		    	  message ="  a failure occurred";
	    	  }
	      finally {
		    try {
		    	ctx.close();
		         stmt.close();
				 conn.close(); 
		    	 rs.close();
		    }
		    catch (Exception e) {
		    	 message ="  a failure occurred";
		    	}
		    }              

		      return p;
		       
		   }
	   
	   
	   /* @param: none
	    *
	    * Method that return the names of projects which meets the parameters (Task Name and Task's Age with City). Returned as a
	    * 2-d array showing the Project name, Task Name, ProjectID, and Task Age 
	    * 
	    */
	   public static String[][] getPrjNameForTaskAndAge(String tname, int age1, int age2) throws Exception
	   {	   
		   Statement stmt = null;
		   ResultSet rs = null;
		   Connection conn = null;
		   
		   Context ctx = null;
		   error = null;
		   
		   String projectNameTable[][] = null;
		   
		   try
		   {
			   ctx = new InitialContext();
			   DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/pdox");
			   conn = ds.getConnection();
			   stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			   stmt.execute("select p.name,  t.TaskName,  p.ProjectID, datediff(dd, t.DateCreated,getdate())  dif " +
					   " from flowtasks t inner join FlowInstances f on t.FlowInstanceID = f.flowinstanceid " +
					   " inner join projects p on f.ParentEntityID = p.ProjectID inner join groups g  on t.AssocEntityID = g.GroupID where t.TaskStatus in " +
					   " ('Accepted', 'Pending') and f.RuntimeStatus " +
					   " not in ('Complete', 'Terminated') and p.archived = 0  and p.Status not like 'Approved' and g.Name not like 'Applicant' " +
					   " and TaskName like '"+ tname + "' and datediff(dd, t.DateCreated,getdate()) between "+ age1 + " and "+ age2 );
			   
			   rs = stmt.getResultSet(); 
			   rs.last(); 
			   projectNameTable = new String [rs.getRow()][4]; 
			   
			   rs.beforeFirst();
			   
			   int i = 0;
			   
			   while (rs.next())
			   { 
				   projectNameTable[i][0] = rs.getString("name");
				   projectNameTable[i][1] = rs.getString("TaskName");
				   projectNameTable[i][2] = rs.getString("ProjectID");
				   projectNameTable[i][3] = rs.getString("dif");
				   i++;
			   }
		   }
		   catch(SQLException e) 
		   {
			   error = e;
			   message = "get apdefnkey failed";
		   } 
		   catch(NamingException e) 
		   {
			   message = "a failure occurred";
		   }
		   finally 
		   {
			   try 
			   {
				   ctx.close();
				   stmt.close();
				   conn.close();
				   rs.close();
			   }
			   catch(Exception e) 
			   {
				   message ="  a failure occurred";
			   }
		   }
		   
		   return projectNameTable;
	   }
	   
	   /* @param: none
	    *
	    * Method that return the names of projects which meets the parameters (Task Name and Task's Age with City). Returned as a
	    * 2-d array showing the Project name, Task Name, ProjectID, and Task Age 
	    * 
	    */
	   public static String[][] getPrjActivityDetails(String pname) throws Exception
	   {	   
		   Statement stmt = null;
		   ResultSet rs = null;
		   Connection conn = null;
		   
		   Context ctx = null;
		   error = null;
		   
		   String projectNameTable[][] = null;
		   
		   try
		   {
			   ctx = new InitialContext();
			   DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/pdox");
			   conn = ds.getConnection();
			   stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			   stmt.execute("select p.Name, fi.FlowInstanceName, ft.TaskName, ft.TaskStatus, convert(varchar, ft.DateCreated, 101) as 'DateCreated', convert(varchar, ft.DateUpdated, 101) as 'DateUpdated', " +
					   " g.name as GroupName, u.FirstName+' '+u.LastName as TaskUser, r1.reviewcycle as 'ReviewCycle', f2.Days as 'CompletedDays', p.archived, p.ProjectID " +
					   " from Projects p inner join flowinstances fi on p.ProjectID = fi.ParentEntityID " + 
					   " inner join FlowTasks ft on fi.FlowInstanceID = ft.FlowInstanceID left join groups g on ft.AssocEntityID = g.GroupID and ft.AssocEntityTypeID = 5  " +
					   " left join Users u on ft.UpdatedBy = u.UserID " +
					   " left join (select distinct FlowTaskID, ReviewCycle, FlowInstanceID from ReportTaskReviewSummary group by flowtaskid, FlowInstanceID, ReviewCycle) r1 on ft.FlowTaskID = r1.FlowTaskID " + 
					   " inner join (select ft2.flowtaskid, (case when ft2.taskstatus like 'Complete' then DATEDIFF(DD, ft2.datecreated, ft2.dateupdated) else null end) Days from FlowTasks ft2) f2 " +
					   " on ft.flowtaskid = f2.flowtaskid where p.Name like '%"+pname+"%' order by fi.FlowInstanceName, ft.DateCreated asc;");
			   
			   rs = stmt.getResultSet(); 
			   rs.last(); 
			   projectNameTable = new String [rs.getRow()][12]; 
			   
			   rs.beforeFirst();
			   
			   int i = 0;
			   
			   while (rs.next())
			   { 
				   projectNameTable[i][0] = rs.getString("Name");
				   projectNameTable[i][1] = rs.getString("FlowInstanceName");
				   projectNameTable[i][2] = rs.getString("TaskName");
				   projectNameTable[i][3] = rs.getString("TaskStatus");
				   projectNameTable[i][4] = rs.getString("DateCreated");
				   projectNameTable[i][5] = rs.getString("DateUpdated");
				   projectNameTable[i][6] = rs.getString("GroupName");
				   projectNameTable[i][7] = rs.getString("TaskUser");
				   projectNameTable[i][8] = rs.getString("ReviewCycle");
				   projectNameTable[i][9] = rs.getString("CompletedDays");
				   projectNameTable[i][10] = rs.getString("archived");
				   projectNameTable[i][11] = rs.getString("ProjectID");
				   i++;
			   }
		   }
		   catch(SQLException e) 
		   {
			   error = e;
			   message = "get apdefnkey failed";
		   } 
		   catch(NamingException e) 
		   {
			   message = "a failure occurred";
		   }
		   finally 
		   {
			   try 
			   {
				   ctx.close();
				   stmt.close();
				   conn.close();
				   rs.close();
			   }
			   catch(Exception e) 
			   {
				   message ="  a failure occurred";
			   }
		   }
		   
		   return projectNameTable;
	   }
	   
	   
	   public static String[][] getPrjNameForOwnerTaskAndAgeWithG(String tname, int age1, int age2) throws Exception
	   {	   
		   Statement stmt = null;
		   ResultSet rs = null;
		   Connection conn = null;
		   
		   Context ctx = null;
		   error = null;
		   
		   String projectNameTable[][] = null;
		   
		   try
		   {
			   ctx = new InitialContext();
			   DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/pdox");
			   conn = ds.getConnection();
			   stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			   stmt.execute("select p.name prj, g.name grp, u.FirstName+' '+u.LastName name, datediff(dd, t.DateCreated,getdate())  dif, count(distinct t.flowtaskid) ct, max(u2.FirstName+' '+u2.LastName) name2, COUNT(u2.firstname) ct2 " +
							"from flowtasks t inner join FlowInstances f on t.FlowInstanceID = f.flowinstanceid " +
							"inner join projects p on f.ParentEntityID = p.ProjectID inner join groups g  on t.AssocEntityID = g.GroupID left join Users u on t.UpdatedBy = u.userid left join Groups_Users gs on g.GroupID = gs.GroupID " +
							"left join Users u2 on gs.UserID = u2.UserID " +
							"where t.TaskStatus in ('Accepted', 'Pending') and f.RuntimeStatus " +
							"not in ('Complete', 'Terminated') and p.archived = 0  and p.Status not like 'Approved' and g.Name not like 'Applicant'  and p.Archived = 0 and u.LastName is null and g.Name like '" + tname + "' and " +
							"datediff(dd, t.DateCreated,getdate()) between " + age1 + " and " + age2 + " " +
							"group by  p.name, g.Name, u.FirstName+' '+u.LastName, datediff(dd, t.DateCreated,getdate()) ");
			   	
			   rs = stmt.getResultSet(); 
			   rs.last(); 
			   projectNameTable = new String [rs.getRow()][2]; 
			   
			   rs.beforeFirst();
			   
			   int i = 0;
			   
			   while (rs.next())
			   { 
				   projectNameTable[i][0] = rs.getString("prj");
				   projectNameTable[i][1] = rs.getString("grp");
				   i++;
			   }
		   }
		   catch(SQLException e) 
		   {
			   error = e;
			   message = "get apdefnkey failed";
		   } 
		   catch(NamingException e) 
		   {
			   message = "a failure occurred";
		   }
		   finally 
		   {
			   try 
			   {
				   ctx.close();
				   stmt.close();
				   conn.close();
				   rs.close();
			   }
			   catch(Exception e) 
			   {
				   message ="  a failure occurred";
			   }
		   }
		   
		   return projectNameTable;
	   }
	   
	   public static String[][] getPrjNameForOwnerTaskAndAgeWithP(String tname, int age1, int age2) throws Exception
	   {	   
		   Statement stmt = null;
		   ResultSet rs = null;
		   Connection conn = null;
		   
		   Context ctx = null;
		   error = null;
		   
		   String projectNameTable[][] = null;
		   
		   try
		   {
			   ctx = new InitialContext();
			   DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/pdox");
			   conn = ds.getConnection();
			   stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			   stmt.execute("select a.* from ( " +
							"select p.name prj, g.name grp, u.FirstName+' '+u.LastName name, datediff(dd, t.DateCreated,getdate())  dif, count(distinct t.flowtaskid) ct, max(u2.FirstName+' '+u2.LastName) name2, COUNT(u2.firstname) ct2 " +
							"from flowtasks t inner join FlowInstances f on t.FlowInstanceID = f.flowinstanceid " +
							"inner join projects p on f.ParentEntityID = p.ProjectID inner join groups g  on t.AssocEntityID = g.GroupID left join Users u on t.UpdatedBy = u.userid left join Groups_Users gs on g.GroupID = gs.GroupID " + 
							"left join Users u2 on gs.UserID = u2.UserID " +
							"where t.TaskStatus in ('Accepted', 'Pending') and f.RuntimeStatus " +
							"not in ('Complete', 'Terminated') and p.archived = 0  and p.Status not like 'Approved' and g.Name not like 'Applicant'  " +
							"group by  p.name, g.Name, u.FirstName+' '+u.LastName, datediff(dd, t.DateCreated,getdate()) ) a " + 
							"where (a.name like '" + tname + "%' or a.name2 like '" + tname + "%') and a.dif between " + age1 + " and " + age2);
			   
			   
		
			   	
			   
			   /*
			    
			     
			     select a.* from (
select p.name prj, g.name grp, u.FirstName+' '+u.LastName name, datediff(dd, t.DateCreated,getdate())  dif, count(distinct t.flowtaskid) ct, max(u2.FirstName+' '+u2.LastName) name2, COUNT(u2.firstname) ct2 
from flowtasks t inner join FlowInstances f on t.FlowInstanceID = f.flowinstanceid 
inner join projects p on f.ParentEntityID = p.ProjectID inner join groups g  on t.AssocEntityID = g.GroupID left join Users u on t.UpdatedBy = u.userid left join Groups_Users gs on g.GroupID = gs.GroupID 
left join Users u2 on gs.UserID = u2.UserID 
where t.TaskStatus in ('Accepted', 'Pending') and f.RuntimeStatus 
not in ('Complete', 'Terminated') and p.archived = 0  and p.Status not like 'Approved' and g.Name not like 'Applicant'  
group by  p.name, g.Name, u.FirstName+' '+u.LastName, datediff(dd, t.DateCreated,getdate()) ) a 
where (a.name like 'Pamela%' or a.name2 like 'Pamela%') and a.dif between 0 and 4
			   
			    */
			   
			   rs = stmt.getResultSet(); 
			   rs.last(); 
			   projectNameTable = new String [rs.getRow()][2]; 
			   
			   rs.beforeFirst();
			   
			   int i = 0;
			   
			   while (rs.next())
			   { 
				   projectNameTable[i][0] = rs.getString("prj");
				   projectNameTable[i][1] = rs.getString("grp");
				   i++;
			   }
		   }
		   catch(SQLException e) 
		   {
			   error = e;
			   message = "get apdefnkey failed";
		   } 
		   catch(NamingException e) 
		   {
			   message = "a failure occurred";
		   }
		   finally 
		   {
			   try 
			   {
				   ctx.close();
				   stmt.close();
				   conn.close();
				   rs.close();
			   }
			   catch(Exception e) 
			   {
				   message ="  a failure occurred";
			   }
		   }
		   
		   return projectNameTable;
	   }
	   
	   
	   
	   public static String[][] getTaskAgeForOwnerGroup(String groupName) throws Exception
	   {	   
		   Statement stmt = null;
		   ResultSet rs = null;
		   Connection conn = null;
		   
		   Context ctx = null;
		   error = null;
		   
		   String projectNameTable[][] = null;
		   
		   try
		   {
			   ctx = new InitialContext();
			   DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/pdox");
			   conn = ds.getConnection();
			   stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			   
			   stmt.execute("select v.taskname groupName, count(v.projectid) tasks from ( " +
					   "select p.projectid, t.TaskName taskName, count( p.ProjectID) tasks , count(gs.UserID) uct " +
					   "from flowtasks t inner join FlowInstances f on t.FlowInstanceID = f.flowinstanceid " +
					   "inner join projects p on f.ParentEntityID = p.ProjectID inner join groups g  on t.AssocEntityID = g.GroupID " +
					   "inner join Groups_Users gs on g.GroupID = gs.GroupID " +
					   "where t.TaskStatus in ('Pending') and f.RuntimeStatus " +
					   "not in ('Complete', 'Terminated') and p.archived = 0  and p.Status not like 'Approved' and " +
					   "g.name like '" + groupName + "' group by p.projectid, t.TaskName) v where uct <> 1 group by v.taskname;");
			    
			   rs = stmt.getResultSet(); 
			   rs.last(); 
			   projectNameTable = new String [rs.getRow()][2]; 
			   
			   rs.beforeFirst();
			   
			   int i = 0;
			   
			   while (rs.next())
			   { 
				   projectNameTable[i][0] = rs.getString("groupName");
				   projectNameTable[i][1] = rs.getString("tasks");
				   i++;
			   }
		   }
		   catch(SQLException e) 
		   {
			   error = e;
			   message = "get apdefnkey failed";
		   } 
		   catch(NamingException e) 
		   {
			   message = "a failure occurred";
		   }
		   finally 
		   {
			   try 
			   {
				   ctx.close();
				   stmt.close();
				   conn.close();
				   rs.close();
			   }
			   catch(Exception e) 
			   {
				   message ="  a failure occurred";
			   }
		   }
		   
		   return projectNameTable;
	   }
	   
	  
	   public static String[][] getTaskAgeForOwnerIndividual(String ownerName) throws Exception
	   {	   
		   Statement stmt = null;
		   ResultSet rs = null;
		   Connection conn = null;
		   
		   Context ctx = null;
		   error = null;
		   
		   String projectNameTable[][] = null;
		   
		   try
		   {
			   ctx = new InitialContext();
			   DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/pdox");
			   conn = ds.getConnection();
			   stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			   
			  // 8/12 update
			   stmt.execute("select z.taskname ownerName, count(*) totalTasks, " +
							"sum(case when z.dif between 0 and 15 then z.ct end ) ftn, sum(case when z.dif between 16 and 30 then z.ct end) thirty , sum(case when z.dif between 31 and 50 then z.ct end) fifty, " + 
							"sum(case when z.dif between 51 and 100 then z.ct end) hundrd , sum(case when z.dif > 100 then z.ct end) hplus " +
							"from ( " +
							"select p.name prj, t.taskname, g.name grp, u.FirstName+' '+u.LastName name, datediff(dd, t.DateCreated,getdate())  dif, count(distinct t.flowtaskid) ct, max(u2.FirstName+' '+u2.LastName) name2, " +
							"COUNT(u2.firstname) ct2 , t.taskstatus " +
							"from flowtasks t inner join FlowInstances f on t.FlowInstanceID = f.flowinstanceid " +
							"inner join projects p on f.ParentEntityID = p.ProjectID inner join groups g  on t.AssocEntityID = g.GroupID left join Users u on t.UpdatedBy = u.userid left join Groups_Users gs on " +
							"g.GroupID = gs.GroupID " +
							"left join Users u2 on gs.UserID = u2.UserID " +
							"where t.TaskStatus in ('Accepted', 'Pending') and f.RuntimeStatus " +
							"not in ('Complete', 'Terminated') and p.archived = 0  and p.Status not like 'Approved' and g.Name not like 'Applicant'  and p.Archived = 0 " + 
							"group by  p.name, t.taskname, g.Name, u.FirstName+' '+u.LastName, datediff(dd, t.DateCreated,getdate()), t.taskstatus ) z where (ct2 = 1 and name2 like '" + ownerName + "') or " +
							"(name like '" + ownerName + "'  and taskstatus like 'Accepted') " +
							"group  by z.taskname;");
/*			   
			   stmt.execute("select z.taskname ownerName, count(*) tasks from ( " +
						   "select p.name prj, t.taskname, g.name grp, u.FirstName+' '+u.LastName name, datediff(dd, t.DateCreated,getdate())  dif, count(distinct t.flowtaskid) ct, max(u2.FirstName+' '+u2.LastName) name2, " +
						   "COUNT(u2.firstname) ct2 , t.taskstatus " +
						   "from flowtasks t inner join FlowInstances f on t.FlowInstanceID = f.flowinstanceid " +
						   "inner join projects p on f.ParentEntityID = p.ProjectID inner join groups g  on t.AssocEntityID = g.GroupID left join Users u on t.UpdatedBy = u.userid left join Groups_Users gs on " +
						   "g.GroupID = gs.GroupID " +
						   "left join Users u2 on gs.UserID = u2.UserID " +
						   "where t.TaskStatus in ('Accepted', 'Pending') and f.RuntimeStatus " +
						   "not in ('Complete', 'Terminated') and p.archived = 0  and p.Status not like 'Approved' and g.Name not like 'Applicant'  and p.Archived = 0 " +
						   "group by  p.name, t.taskname, g.Name, u.FirstName+' '+u.LastName, datediff(dd, t.DateCreated,getdate()), t.taskstatus ) z where (ct2 = 1 and name2 like '" + ownerName + "') or " +
						   "(name like '" + ownerName + "'  and taskstatus like 'Accepted') " +
						   "group  by z.taskname;");
*/

/*			   
			   stmt.execute("select z.taskname ownerName, count(*) tasks from ( " +
							"select p.name prj, t.taskname, g.name grp, u.FirstName+' '+u.LastName name, datediff(dd, t.DateCreated,getdate())  dif, count(distinct t.flowtaskid) ct, max(u2.FirstName+' '+u2.LastName) name2, COUNT(u2.firstname) ct2  " +
							"from flowtasks t inner join FlowInstances f on t.FlowInstanceID = f.flowinstanceid " +
							"inner join projects p on f.ParentEntityID = p.ProjectID inner join groups g  on t.AssocEntityID = g.GroupID left join Users u on t.UpdatedBy = u.userid left join Groups_Users gs on g.GroupID = gs.GroupID " +
							"left join Users u2 on gs.UserID = u2.UserID " +
							"where t.TaskStatus in ('Accepted', 'Pending') and f.RuntimeStatus " +
							"not in ('Complete', 'Terminated') and p.archived = 0  and p.Status not like 'Approved' and g.Name not like 'Applicant'  and p.Archived = 0  " +
							"group by  p.name, t.taskname, g.Name, u.FirstName+' '+u.LastName, datediff(dd, t.DateCreated,getdate()) ) z where ct2 = 1 and   (name like '" + ownerName + "' or name2 like '" + ownerName + "') " +
							"group  by z.taskname;");
	*/		 
			  
			   rs = stmt.getResultSet(); 
			   rs.last(); 
			   projectNameTable = new String [rs.getRow()][7]; 
			   
			   rs.beforeFirst();
			   
			   int i = 0;
			   
			   while (rs.next())
			   { 
				   projectNameTable[i][0] = rs.getString("ownerName");
				   projectNameTable[i][1] = rs.getString("totalTasks");
				   projectNameTable[i][2] = rs.getString("ftn");
				   projectNameTable[i][3] = rs.getString("thirty");
				   projectNameTable[i][4] = rs.getString("fifty");
				   projectNameTable[i][5] = rs.getString("hundrd");
				   projectNameTable[i][6] = rs.getString("hplus");
				   
				   i++;
			   }
		   }
		   catch(SQLException e) 
		   {
			   error = e;
			   message = "get apdefnkey failed";
		   } 
		   catch(NamingException e) 
		   {
			   message = "a failure occurred";
		   }
		   finally 
		   {
			   try 
			   {
				   ctx.close();
				   stmt.close();
				   conn.close();
				   rs.close();
			   }
			   catch(Exception e) 
			   {
				   message ="  a failure occurred";
			   }
		   }
		   
		   return projectNameTable;
	   }
	   
	   // getTaskAgeUserSplit
	   public static String[][] getTaskAgeUserSplit(String taskName) throws Exception
	   {	   
		   Statement stmt = null;
		   ResultSet rs = null;
		   Connection conn = null;
		   
		   Context ctx = null;
		   error = null;
		   
		   String projectNameTable[][] = null;
		   
		   try
		   {
			   ctx = new InitialContext();
			   DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/pdox");
			   conn = ds.getConnection();
			   stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			   stmt.execute("select a.name, sum(ct) ct, sum(a.a) ftn, sum(a.b) thirty, sum (a.c) fifty, sum(a.d) hundred, sum(a.e) hplus from ( " +
							"select case when Z.ct2 = 1 then 'P-'+z.name2 when z.name IS null then 'G-'+z.grp else 'P-'+Z.name end name, count(*) ct, " +
							"sum(case when z.dif between 0 and 15 then z.ct end ) a, sum(case when z.dif between 16 and 30 then z.ct end) b , sum(case when z.dif between 31 and 50 then z.ct end) c,  " +
							"sum(case when z.dif between 51 and 100 then z.ct end) d , sum(case when z.dif > 100 then z.ct end) e " +
							"from ( select p.name prj, t.taskname, g.name grp, u.FirstName+' '+u.LastName name, datediff(dd, t.DateCreated,getdate())  dif, count(distinct t.flowtaskid) ct, max(u2.FirstName+' '+u2.LastName) name2, COUNT(u2.firstname) ct2 " +
							"from flowtasks t inner join FlowInstances f on t.FlowInstanceID = f.flowinstanceid  " +
							"inner join projects p on f.ParentEntityID = p.ProjectID inner join groups g  on t.AssocEntityID = g.GroupID left join Users u on t.UpdatedBy = u.userid left join Groups_Users gs on g.GroupID = gs.GroupID " +
							"left join Users u2 on gs.UserID = u2.UserID where t.TaskStatus in ('Accepted', 'Pending') and f.RuntimeStatus " +
							"not in ('Complete', 'Terminated') and p.archived = 0  and p.Status not like 'Approved' and g.Name not like 'Applicant'  and p.Archived = 0  and t.TaskName like '" + taskName + "' group by " +
							"p.name, t.taskname, g.Name, u.FirstName+' '+u.LastName, datediff(dd, t.DateCreated,getdate()) ) z " +
							"group  by case when Z.ct2 = 1 then 'P-'+z.name2 when z.name IS null then 'G-'+z.grp else 'P-'+Z.name end, dif) a group by  a.name order by ct desc");

							
			 /* stmt.execute("select a.name, sum(ct) ct, sum(a.a) ftn, sum(a.b) thirty, sum (a.c) fifty, sum(a.d) hundred, sum(a.e) hplus from ( " +
" select case when Z.ct2 = 1 then z.name2 when z.name IS null then z.grp else Z.name end name, count(*) ct, " +
" sum(case when z.dif between 0 and 15 then z.ct end ) a, sum(case when z.dif between 16 and 30 then z.ct end) b , sum(case when z.dif between 31 and 50 then z.ct end) c,  " +
" sum(case when z.dif between 51 and 100 then z.ct end) d , sum(case when z.dif > 100 then z.ct end) e " +
" from ( select p.name prj, t.taskname, g.name grp, u.FirstName+' '+u.LastName name, datediff(dd, t.DateCreated,getdate())  dif, count(distinct t.flowtaskid) ct, max(u2.FirstName+' '+u2.LastName) name2, COUNT(u2.firstname) ct2 " +
" from flowtasks t inner join FlowInstances f on t.FlowInstanceID = f.flowinstanceid  " +
" inner join projects p on f.ParentEntityID = p.ProjectID inner join groups g  on t.AssocEntityID = g.GroupID left join Users u on t.UpdatedBy = u.userid left join Groups_Users gs on g.GroupID = gs.GroupID " +
" left join Users u2 on gs.UserID = u2.UserID " +
" where t.TaskStatus in ('Accepted', 'Pending') and f.RuntimeStatus " +
" not in ('Complete', 'Terminated') and p.archived = 0  and p.Status not like 'Approved' and g.Name not like 'Applicant'  and p.Archived = 0  and t.TaskName like '"+taskName+"' group by " +
" p.name, t.taskname, g.Name, u.FirstName+' '+u.LastName, datediff(dd, t.DateCreated,getdate()) ) z " +
" group  by case when Z.ct2 = 1 then z.name2 when z.name IS null then z.grp else Z.name end, dif) a group by  a.name order by ct desc"); 
			 
			  */
			   rs = stmt.getResultSet(); 
			   rs.last(); 
			   projectNameTable = new String [rs.getRow()][7]; 
			   
			   rs.beforeFirst();
			   
			   int i = 0;
			   
			   while (rs.next())
			   { 
				   projectNameTable[i][0] = rs.getString("name");
				   projectNameTable[i][1] = rs.getString("ct");
				   projectNameTable[i][2] = rs.getString("ftn");
				   projectNameTable[i][3] = rs.getString("thirty");
				   projectNameTable[i][4] = rs.getString("fifty");
				   projectNameTable[i][5] = rs.getString("hundred");
				   projectNameTable[i][6] = rs.getString("hplus");
				   i++;
			   }
		   }
		   catch(SQLException e) 
		   {
			   error = e;
			   message = "get apdefnkey failed";
		   } 
		   catch(NamingException e) 
		   {
			   message = "a failure occurred";
		   }
		   finally 
		   {
			   try 
			   {
				   ctx.close();
				   stmt.close();
				   conn.close();
				   rs.close();
			   }
			   catch(Exception e) 
			   {
				   message ="  a failure occurred";
			   }
		   }
		   
		   return projectNameTable;
	   }
	   
	   public static String[][] getTaskAgeUserSplitIndividual(String taskName, String ownerName, int range1, int range2) throws Exception
	   {	   
		   Statement stmt = null;
		   ResultSet rs = null;
		   Connection conn = null;
		   
		   Context ctx = null;
		   error = null;
		   
		   String projectNameTable[][] = null;
		   
		   try
		   {
			   ctx = new InitialContext();
			   DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/pdox");
			   conn = ds.getConnection();
			   stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);

			   stmt.execute("select prj, taskname, grp, name, dif, ct, name2, ct2 from ( " +
							"select p.name prj, t.taskname, g.name grp, u.FirstName+' '+u.LastName name, datediff(dd, t.DateCreated,getdate())  dif, count(distinct t.flowtaskid) ct, max(u2.FirstName+' '+u2.LastName) name2, " +
							"COUNT(u2.firstname) ct2 " +
							"from flowtasks t inner join FlowInstances f on t.FlowInstanceID = f.flowinstanceid " + 
							"inner join projects p on f.ParentEntityID = p.ProjectID inner join groups g  on t.AssocEntityID = g.GroupID left join Users u on t.UpdatedBy = u.userid left join Groups_Users gs on g.GroupID = gs.GroupID " +
							"left join Users u2 on gs.UserID = u2.UserID " +
							"where t.TaskStatus in ('Accepted', 'Pending') and f.RuntimeStatus " +
							"not in ('Complete', 'Terminated') and p.archived = 0  and p.Status not like 'Approved' and g.Name not like 'Applicant'  and p.Archived = 0  and t.TaskName like '" + taskName + "' " +
							"and datediff(dd, t.DateCreated,getdate()) between " + range1 + " and " + range2 + " " +
							"group by  p.name, t.taskname, g.Name, u.FirstName+' '+u.LastName, datediff(dd, t.DateCreated,getdate()) ) a where " +
							"name like '" + ownerName+ "' or (name2 like '" + ownerName+ "' and ct2 =1) ;");
			   
			   rs = stmt.getResultSet(); 
			   rs.last(); 
			   projectNameTable = new String [rs.getRow()][1]; 
			   
			   rs.beforeFirst();
			   
			   int i = 0;
			   String temp;
			   
			   while (rs.next())
			   { 
				   projectNameTable[i][0] = rs.getString("prj");
				   temp = rs.getString("prj");
				   i++;
			   }
		   }
		   catch(SQLException e) 
		   {
			   error = e;
			   message = "get apdefnkey failed";
		   } 
		   catch(NamingException e) 
		   {
			   message = "a failure occurred";
		   }
		   finally 
		   {
			   try 
			   {
				   ctx.close();
				   stmt.close();
				   conn.close();
				   rs.close();
			   }
			   catch(Exception e) 
			   {
				   message ="  a failure occurred";
			   }
		   }
		   
		   return projectNameTable;
	   }
	   
	   public static String[][] getTaskAgeUserSplitGroup(String taskName, String ownerName, int range1, int range2) throws Exception
	   {	   
		   Statement stmt = null;
		   ResultSet rs = null;
		   Connection conn = null;
		   
		   Context ctx = null;
		   error = null;
		   
		   String projectNameTable[][] = null;
		   
		   try
		   {
			   ctx = new InitialContext();
			   DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/pdox");
			   conn = ds.getConnection();
			   stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			   stmt.execute("select a.* from ( " +
							"select p.name prj, t.taskname, g.name grp, u.FirstName+' '+u.LastName name, datediff(dd, t.DateCreated,getdate())  dif, count(distinct t.flowtaskid) ct, max(u2.FirstName+' '+u2.LastName) name2, COUNT(u2.firstname) ct2 " +
							"from flowtasks t inner join FlowInstances f on t.FlowInstanceID = f.flowinstanceid " +
							"inner join projects p on f.ParentEntityID = p.ProjectID inner join groups g  on t.AssocEntityID = g.GroupID left join Users u on t.UpdatedBy = u.userid left join Groups_Users gs on g.GroupID = gs.GroupID " +
							"left join Users u2 on gs.UserID = u2.UserID " +
							"where t.TaskStatus in ('Accepted', 'Pending') and f.RuntimeStatus " +
							"not in ('Complete', 'Terminated') and p.archived = 0  and p.Status not like 'Approved' and g.Name not like 'Applicant'  and p.Archived = 0  and t.TaskName like '" + taskName  +"' " +
							"group by " +
							"p.name, t.taskname, g.Name, u.FirstName+' '+u.LastName, datediff(dd, t.DateCreated,getdate()) ) a where " +
							"dif between " + range1 + " and " + range2 + " and  ct2 > 1 and name is null and grp like '" + ownerName + "'");

			   rs = stmt.getResultSet(); 
			   rs.last(); 
			   projectNameTable = new String [rs.getRow()][1]; 
			   
			   rs.beforeFirst();
			   
			   int i = 0;
			   
			   while (rs.next())
			   { 
				   projectNameTable[i][0] = rs.getString("prj");
				   i++;
			   }
		   }
		   catch(SQLException e) 
		   {
			   error = e;
			   message = "get apdefnkey failed";
		   } 
		   catch(NamingException e) 
		   {
			   message = "a failure occurred";
		   }
		   finally 
		   {
			   try 
			   {
				   ctx.close();
				   stmt.close();
				   conn.close();
				   rs.close();
			   }
			   catch(Exception e) 
			   {
				   message ="  a failure occurred";
			   }
		   }
		   
		   return projectNameTable;
	   }
	   
	   public static String[][] searchProject(String searchName) throws Exception
	   {	   
		   Statement stmt = null;
		   ResultSet rs = null;
		   Connection conn = null;
		   
		   Context ctx = null;
		   error = null;
		   	
		   String projectNameTable[][] = null;
		   
		   try
		   {
			   ctx = new InitialContext();
			   DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/pdox");
			   conn = ds.getConnection();
			   stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			   
			   stmt.execute("select TOP 100 name from projects where name like '%" + searchName + "%';");
			 
			  
			   rs = stmt.getResultSet(); 
			   rs.last(); 
			   projectNameTable = new String [rs.getRow()][1]; 
			   
			   rs.beforeFirst();
			   
			   int i = 0;
			   
			   String temp;
			   while (rs.next())
			   { 
				   temp = rs.getString("name");
				   projectNameTable[i][0] = rs.getString("name");
				   i++;
			   }
		   }
		   catch(SQLException e) 
		   {
			   error = e;
			   message = "get apdefnkey failed";
		   } 
		   catch(NamingException e) 
		   {
			   message = "a failure occurred";
		   }
		   finally 
		   {
			   try 
			   {
				   ctx.close();
				   stmt.close();
				   conn.close();
				   rs.close();
			   }
			   catch(Exception e) 
			   {
				   message ="  a failure occurred";
			   }
		   }
		   
		   return projectNameTable;
	   }
	   
	   public static String[][] permitApplicationReceived() throws Exception
	   {
		    Context ctx = null;
		   	Statement stmt = null;
		   	Connection conn = null;
			ResultSet rs = null;
		      error = null;
		      String c[][] = null;
			      
		      try {
		    	  ctx = new InitialContext();
		            DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/pdox");
				  conn = ds.getConnection();
				  stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
				  stmt.execute("select CONVERT(varchar(12),DATEPART(year, createdate) )+ '/' + CONVERT(varchar(12), DATEPART(m, createdate)) dt, count(*) ct, DATEPART(year, createdate) yr, DATEPART(m, createdate) m " +
							   "from projects where createdate between DATEADD(month, -24, CONVERT(varchar(12), DATEPART(m, getdate()))+'/01/'+CONVERT(varchar(12), DATEPART(year, getdate())) ) and " +
							   "CONVERT(varchar(12), DATEPART(m, getdate()))+'/01/'+CONVERT(varchar(12), DATEPART(year, getdate())) group by " +
							   "CONVERT(varchar(12),DATEPART( year, createdate) )+ '/' + CONVERT(varchar(12), DATEPART(m, createdate)), DATEPART(year, createdate), DATEPART(m, createdate)  order by  yr, m;"); 
				  rs = stmt.getResultSet();  
				   rs.last(); 
				   
				   c = new String [rs.getRow()][4]; 
				   
				   rs.beforeFirst();
				   int i = 0;
				
				   while (rs.next())
				   { 
					   c[i][0] = rs.getString("dt");
					   c[i][1] = rs.getString("ct");
					   c[i][2] = rs.getString("yr");
					   c[i][3] = rs.getString("m");
					    
					   
					 
					   i++;
				   }
			     
			
		      } catch (SQLException e) {
		         error = e;
		         message = "get apdefnkey failed";
		      } catch (NamingException e) {
		    	  message ="  a failure occurred";
	    	  }
	      finally {
		    try {
		    	ctx.close();
		         stmt.close();
				 conn.close(); 
		    	 rs.close();
		    }
		    catch (Exception e) {
		    	 message ="  a failure occurred";
		    	}
		    }              

		      return c;
		       
		   }
	  
	   public static String[][] permitIssued() throws Exception{
		    Context ctx = null;
		   	Statement stmt = null;
		   	Connection conn = null;
			ResultSet rs = null;
		      error = null;
		      String c[][] = null;
			      
		      try {
		    	  ctx = new InitialContext();
		            DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/H7");
				  conn = ds.getConnection();
				  stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
				  stmt.execute("select to_char(b.issdttm, 'yyyy/mm') dt, count(*) ct from avolve.PROJDOX_TIME_TO_PERMIT t inner join imsv7.apbldg b on t.apno = b.apno where b.issdttm between to_date( EXTRACT(month FROM sysdate)||'/01/'||to_char(to_number(EXTRACT(year FROM sysdate))-2), 'mm/dd/yyyy') and to_date( EXTRACT(month FROM sysdate)||'/01/'||EXTRACT(year FROM sysdate), 'mm/dd/yyyy') group by to_char(b.issdttm, 'yyyy/mm') order by 1"); 
				  rs = stmt.getResultSet();  
				   rs.last(); 
				   
				   c = new String [rs.getRow()][2]; 
				   
				   rs.beforeFirst();
				   int i = 0;
				   
				   while (rs.next())
				   { 
					   c[i][0] = rs.getString("dt");
					   c[i][1] = rs.getString("ct");
					   
					   i++;
				   }
			    
			     
		      } catch (SQLException e) {
		         error = e;
		         message = "get apdefnkey failed";
		      } catch (NamingException e) {
		    	  message ="  a failure occurred";
	    	  }
	      finally {
		    try {
		    	ctx.close();
		         stmt.close();
				 conn.close(); 
		    	 rs.close();
		    }
		    catch (Exception e) {
		    	 message ="  a failure occurred";
		    	}
		    }              

		      return c;
		       
		   }
	   

	  
	   
}

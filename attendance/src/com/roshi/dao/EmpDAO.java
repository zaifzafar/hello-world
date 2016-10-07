package com.roshi.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;
import com.roshi.standalone.Employee;
import com.roshi.standalone.EmployeeCalendar;

@Component
public class EmpDAO {
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public EmpDAO(DataSource dataSource){
		jdbcTemplate=new JdbcTemplate(dataSource);
	}
	
	public String getEmpDBPass(Employee employee)
	{
		String pass=null;
		
		try {
			pass=this.jdbcTemplate.queryForObject("SELECT emppass FROM employee WHERE empname=?", String.class,employee.getEmpName());
			
		} catch (Exception e) {
			System.out.println("Exception - EmpDAO,checkUserExist () " + e);
		}
		
		return pass;
		
	}
	 public int getEmpCount()
	 {
		 return 1;
	 }

	 public String empGetTime(int empId, int month, int year)
	 {
		 int result=0;
		 String previpusPresentDate= "";
		 String currentPresentDate="";
		 String msg="";
		 int counter=0;
		 try{
		
			result= this.jdbcTemplate.update("INSERT INTO TIME_ZONE(empId,starttime)  values(?,CURRENT_TIMESTAMP)",empId);	
			result =this.jdbcTemplate.update("UPDATE employee SET status=? WHERE empID=?","start",empId);			
			counter= this.jdbcTemplate.queryForObject("select count(month) from attendance WHERE empId=? AND month=? AND year=? " ,Integer.class, empId, month, year);
			
			
			if(counter <= 0)
			{
				result=this.jdbcTemplate.update("INSERT INTO attendance(empId,present,month,year) VALUES(?,extract(day from sysdate),extract(month from sysdate),extract(year from sysdate))",empId);				
				result=this.jdbcTemplate.update("update attendance set approve='no' WHERE empId=? AND month=? AND year=?", empId,month,year);
			}
			else
			{
				previpusPresentDate=this.jdbcTemplate.queryForObject("SELECT present FROM attendance WHERE empId=? AND month=? AND year=? ", String.class, empId, month, year);
								
				currentPresentDate=this.jdbcTemplate.queryForObject("SELECT extract(day from sysdate) from attendance WHERE empId=? AND month=? AND year=?", String.class, empId, month, year);
				
				int count=currentPresentDate.length();
				if(count==2)
				{
					
					String day=previpusPresentDate.length() > 2 ? previpusPresentDate.substring(previpusPresentDate.length() -2):previpusPresentDate;
					
					if(day .equals(currentPresentDate))
					{ 
					}
					else
					{
						result=this.jdbcTemplate.update("update attendance set present=? WHERE empId=? AND month=? AND year=? ",(previpusPresentDate+","+currentPresentDate), empId, month, year);
						result=this.jdbcTemplate.update("UPDATE attendance SET approve='no' WHERE empId=? AND month=? AND year=?", empId, month, year);
					}
					
				}	//result=this.jdbcTemplate.update("update attendance set present=? WHERE empId=?",(previpusPresentDate+","+currentPresentDate),id);
				else if(count == 1)
				{
					if(previpusPresentDate.substring(previpusPresentDate.length()-1).equals(currentPresentDate))
					{
						
					}
					else
					{
						result=this.jdbcTemplate.update("update attendance set present=? WHERE empId=? AND month=? AND year=?",(previpusPresentDate+","+currentPresentDate), empId, month, year);
					}
				}
			
			} 
			if(result > 0)
				msg="Successfully Start";
			else
				msg="Error Occur";
		 	}catch(Exception e)
			 {
				 System.out.println("Exception-EmpDAO,empGetTime()"+e);
			 }
		 return msg;
	 }
	 
	 public String stopEmpTime(int empid)
	 {
		 int result=0;
		 String msg="";
		 int id=0;
		 try{
			 	id=this.jdbcTemplate.queryForObject("SELECT MAX(id) FROM TIME_ZONE WHERE empId=?",Integer.class,empid);
				result = this.jdbcTemplate.update("UPDATE TIME_ZONE SET stoptime=CURRENT_TIMESTAMP where empid=? AND id=? ",empid,id);
				if(result>0)
					
					result = this.jdbcTemplate.update("UPDATE employee SET status='stop' WHERE empID=? ",empid);
			 	if(result>0)
			 		msg = "Successfully Stop";
			 	else
			 		msg = "Error Occured";		 			 		
		 }catch(Exception e)
		 	{
		 		System.out.println("Exception-EmpDAO,stopEmpTime() " +e);
		 	}
		 return msg;		 		 
	 }
	
  public Employee getEmployeeID(Employee employee)
   {
	   Employee emp = new Employee();
	   try
	   {
		  emp = (Employee)this.jdbcTemplate.queryForObject("SELECT * FROM employee WHERE empname=?",new Object[]{employee.getEmpName()}, 
				  new RowMapper<Employee>() {
					public Employee mapRow(ResultSet rs, int rowNum) throws SQLException {
						Employee employee=new Employee();
						employee.setEmpId(rs.getInt("empId"));
						employee.setStatus(rs.getString("status"));
						employee.setRole(rs.getString("role"));
						
						return employee;
					}
				});
	   }
	   catch(Exception e)
	   {
		   System.out.println("Exception - EmpDAO,getEmployeeID() " +e);
	   }
	   return emp;	   
   }
  
  
  public List<Employee> getEmployeeList()
  {
	  List<Employee> employeeList=new ArrayList<Employee>();
	
	  try
	  {
		   employeeList=this.jdbcTemplate.query("SELECT t.id, e.empId,e.empName,t.startTime,t.stopTime,stopTime-startTime FROM employee e,TIME_ZONE t WHERE e.empId=t.empId ",
				   new RowMapper<Employee>(){
	
	  		public Employee mapRow(ResultSet rs, int rowNum) throws SQLException {
	  			Employee employee=new Employee();
	  			employee.setId(rs.getInt("id"));
	  			employee.setEmpId(rs.getInt("empId"));
	  			employee.setEmpName(rs.getString("empName"));
	  			employee.setStartTime(rs.getString("startTime"));
	  			employee.setStopTime(rs.getString("stopTime"));
	  			employee.setTimeDifference(rs.getString("stopTime-startTime"));
	  			return employee;
	  		}
	  	});
		   					
	  }catch(Exception e){
		  System.out.println("Exception - EmpDAO,getEmoloyeeDetails() "+e);
	  }
  	return employeeList;
  }
  
 public String deleteEmployeeTimeStamp(int id)
  {
	 int result=0;
	  String msg="";
	 try{
  		result= this.jdbcTemplate.update("DELETE FROM TIME_ZONE WhERE id=?",id);
  		if(result>0)
  			msg="Successfull Deleted";
  		else
  			msg="Error Occured";
	 }catch(Exception e){
		 System.out.println("Exception -EmpDAO,deleteEmployeeTimeStamp() "+e);
	 }
	 System.out.println(result);
  	  return msg;
  	  
  }
 
 public JSONObject employeeAttendance(int empID, int year, int month)
 {
	
	 JSONObject jEmployee = new JSONObject();
	 try{
		jEmployee=this.jdbcTemplate.queryForObject("SELECT * FROM attendance WHERE empid=? AND month= ? AND year= ?",
				new Object[]{empID, month+1, year},
				new RowMapper<JSONObject>() {
			
				public JSONObject mapRow(ResultSet rs, int rowNum) throws SQLException {
					
				JSONObject employee=new JSONObject();				
				employee.put("empId", rs.getInt("empId"));
				employee.put("year",  rs.getString("year"));
				employee.put("month", rs.getString("month"));
				employee.put("absent",rs.getString("absent"));
				employee.put("leave", rs.getString("leave"));
				employee.put("present", rs.getString("present"));
				employee.put("approve", rs.getString("approve"));
				return employee;							
			}
		});
		 
	 }catch(Exception e)
	 {
		 System.out.println("Exception -EmpDAO,employeeAttendance()" +e);
	 }
	return jEmployee;
	 
 }
 
 public List<Employee> getEmployeeIdList()
 {
	  List<Employee> employeeList=new ArrayList<Employee>();
	
	  try
	  {
		   employeeList=this.jdbcTemplate.query("SELECT * FROM employee",
			 new RowMapper<Employee>(){	
			   public Employee mapRow(ResultSet rs, int rowNum) throws SQLException {
	  			Employee employee=new Employee();
	  			employee.setEmpId(rs.getInt("empId"));
	  			return employee;
	  		}
	  	});
		   					
	  }catch(Exception e){
		  System.out.println("Exception - EmpDAO,getEmoloyeeDetails() "+e);
	  }
 	return employeeList;
 }
 
 public String applyLeave(int id, String leaveDay, int month,int year,String reason)
 {
	 String msg="";
	 int result=0;
	 int counter=0;
	 String previousLeave="";	 
	 try{
	 
	    counter= this.jdbcTemplate.queryForObject("select count(*) from attendance WHERE empId=? AND month=? AND year=?", Integer.class ,id, month, year);
	   
		if(counter <= 0)
		{
			result=this.jdbcTemplate.update("INSERT INTO attendance (empId,leave,month,year,reason) values(?,?,?,?,?)",id,leaveDay,month,year,reason);	
			 result=this.jdbcTemplate.update("UPDATE attendance SET approve='no' WHERE empId=? AND month=? AND year=?", id, month, year);
		}
		else
		{
			previousLeave=this.jdbcTemplate.queryForObject("SELECT leave FROM attendance WHERE empId=? AND month=? AND year=?", String.class, id, month, year);			
			result=this.jdbcTemplate.update("update attendance set leave=?,reason=? WHERE empId=? AND month=? AND year=?",(previousLeave+","+leaveDay), reason, id, month, year);
			result=this.jdbcTemplate.update("update attendance set approve='no' WHERE empId=? AND month=? AND year=?",id,month,year);
		}
		
		if(result >0)
				msg="yes";
			else 
				msg="no";
	 }
	 catch(Exception e)
	 {
		 System.out.println("Exception - EmpDAO,applyLeave()"+e);
	 }
	 return msg;
 }
 public List<EmployeeCalendar> leaveDetails()
 {
	 List<EmployeeCalendar> employeeList=new ArrayList<EmployeeCalendar>();
		
	  try
	  {
		   employeeList=this.jdbcTemplate.query("SELECT  e.empId,e.empName,a.leave,a.month,a.year,a.reason FROM employee e,attendance a WHERE e.empId=a.empId ",
				   new RowMapper<EmployeeCalendar>(){
	
	  		public EmployeeCalendar mapRow(ResultSet rs, int rowNum) throws SQLException {
	  			EmployeeCalendar eCalendar=new EmployeeCalendar();
	  			eCalendar.setEmpId(rs.getInt("empid"));
	  			eCalendar.setLeaveDay(rs.getString("leave"));
	  			eCalendar.setReason(rs.getString("reason"));
	  			eCalendar.setMonth(rs.getInt("month"));
	  			eCalendar.setYear(rs.getInt("year"));
	  			
	  			return eCalendar;
	  		}
	  	});
		   					
	  }catch(Exception e){
		  System.out.println("Exception - EmpDAO,getEmoloyeeDetails() "+e);
	  }
 	return employeeList;
 }
 
 public String approved(int id, int month, int year)
 {
	 
	 int result = 0;
	 String msg="";
	 try{
		 result=this.jdbcTemplate.update("UPDATE attendance SET approve='yes' WHERE empId=? AND MONTH=? AND YEAR=?", id, month, year);
		
		 if(result>=0)
			 msg="yes";
		 else
			 msg="no";
	 }catch(Exception e){
		 System.out.println("Exception - EmpDAO,approved() "+e);
	 }
	return msg;
 }
 
 public String notApproved(int id, int month, int year)
 {
	 int result=0;
	 String msg="";
	 try{
		 result=this.jdbcTemplate.update("UPDATE attendance SET approve='no' WHERE empId=? AND month=? AND year=?",id,month,year);
		System.out.println(result);
		 if(result>=0)
			 msg="yes";
		 else
			 msg="no";
	 }catch(Exception e){
		 System.out.println("Exception - EmpDAO,notApproved() "+e);
	 }
	return msg;

 }
 
public String absent( int empId, int month, int year)
 {
	 String allPresentDay="";
	 String allLeaveDay="";

		 allPresentDay=this.jdbcTemplate.queryForObject("SELECT present FROM attendance WHERE empId=? AND month=? AND year=? ", String.class,empId);
		 allLeaveDay=this.jdbcTemplate.queryForObject("SELECT leave FROM attendance WHERE empId=? AND month=? AND year=? ", String.class,empId);
		
		 
	 return null;

 }
}








/*JSONObject jEmployee = new JSONObject();
try{
	jEmployee=this.jdbcTemplate.queryForObject("SELECT * FROM attendance WHERE empid=? AND month= ? AND year= ?",
			new Object[]{empId, month+1, year},
			new RowMapper<JSONObject>() {
		
			public JSONObject mapRow(ResultSet rs, int rowNum) throws SQLException {
				
			JSONObject employee=new JSONObject();				
			employee.put("empId", rs.getInt("empId"));
			employee.put("year",  rs.getString("year"));
			employee.put("month", rs.getString("month"));
			employee.put("absent",rs.getString("absent"));
			employee.put("leave", rs.getString("leave"));
			employee.put("present", rs.getString("present"));
			employee.put("approve", rs.getString("approve"));
			return employee;							
		}
	});
	 
}catch(Exception e)
{
	 System.out.println("Exception -EmpDAO,employeeAttendance()" +e);
}
return jEmployee;*/


package com.roshi.service;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import com.roshi.dao.EmpDAO;
import com.roshi.standalone.Employee;
import com.roshi.standalone.EmployeeCalendar;

@Component
@Scope("session")
public class EmpService {
	
	@Autowired
	EmpDAO empDAO;

	public boolean isExistEmployee()
	{
		boolean result=false;
		if(empDAO.getEmpCount() > 0)
		{
			result= true;
		}
		return result;		
	}
	
	public boolean authenticateEmployee(Employee employee)
	{
		boolean result=false;
		if(empDAO.getEmpDBPass(employee).equalsIgnoreCase(employee.getEmpPass()))
		{
			result=true;
			
		}
		return result;
	}
		
	public String empGetTimes(int id, int month, int year ) {
		
		return empDAO.empGetTime(id,month,year);
	}
	
	public String stopEmpTimes(int empid ) {
		return empDAO.stopEmpTime(empid);
		 
	}
	
	public Employee getEmployeeID(Employee employee)
	{
		return empDAO.getEmployeeID(employee);
		 
	}

	public List<Employee> getEmployeeList() {
		
		return empDAO.getEmployeeList();
	}
	
	public String deleteEmployeeTimeStamp(int id)
	{
		return empDAO.deleteEmployeeTimeStamp(id);
	}
	
	
	public EmployeeCalendar employeeAttendance(int empID, int  iMonth, int iYear)     
	{
		List<Integer> absentList = new ArrayList<Integer>();
		List<Integer> presentList = new ArrayList<Integer>();
		List<Integer> leaveList = new ArrayList<Integer>();
		

		JSONObject employee=empDAO.employeeAttendance(empID, iYear, iMonth);
		
		
		String absent = employee.getString("absent").toString();
		String[] totalAbsent= absent.split(",");
		for(String abs: totalAbsent){
			if(!abs.equals("") && abs != null){
				absentList.add(Integer.parseInt(abs));
				
			}
		}
		String present=employee.getString("present").toString();
		String[] totalPresent=present.split(",");
		for(String pre: totalPresent){
			if(!pre.equalsIgnoreCase("") && pre!=null){
				presentList.add(Integer.parseInt(pre));
			}			
		}

		String leave=employee.get("leave").toString();
		String[] totalLeave=leave.split(",");
		for(String leav: totalLeave){
			if(!leav.equalsIgnoreCase("") && leav!=null){
				leaveList.add(Integer.parseInt(leav));
			}						
		}
		/*---------------------------------------------------------*/
		/* this code will return the current date, month and year*/
		 Calendar ca = new GregorianCalendar();
		 int iTDay=ca.get(Calendar.DATE); 
		 int iTYear=ca.get(Calendar.YEAR);
		 int iTMonth=ca.get(Calendar.MONTH);
				
		  if(iYear==0)
		 {
		      iYear=iTYear;
		      iMonth=iTMonth;
		 } 
		  
		  /* this code will return day of month , week, and total days in selected month */
		 GregorianCalendar cal = new GregorianCalendar (iYear, iMonth, 1); 
		
		 int days=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		 int weekStartDay=cal.get(Calendar.DAY_OF_WEEK);
		 
		 
		 cal = new GregorianCalendar (iYear, iMonth, days); 
		 int iTotalweeks=cal.get(Calendar.WEEK_OF_MONTH);
		 
		 
		 boolean sunday=cal.get(Calendar.DAY_OF_WEEK)== Calendar.SUNDAY;
		 
		 EmployeeCalendar empCal=new EmployeeCalendar();
		 empCal.setDays(days);
		 empCal.setiMonth(iMonth);
		 empCal.setiTDay(iTDay);
		 empCal.setiTMonth(iTMonth);
		 empCal.setiTotalweeks(iTotalweeks);
		 empCal.setiYear(iYear);
		 empCal.setiTYear(iTYear);
		 empCal.setWeekStartDay(weekStartDay);
		 empCal.setAbsent(absentList);
		 empCal.setPresent(presentList);
		 empCal.setLeave(leaveList);
		 empCal.setApprove(employee.getString("approve"));
		 empCal.setSunday(sunday);
		 return empCal;
		
	}
	
	public List<Employee> getEmployeeIdList() {
		
		return empDAO.getEmployeeIdList();
	}
	
	public EmployeeCalendar leaveCalendar(int empID )
	{
		int  iMonth=0; 
		int iYear=0;
		/*---------------------------------------------------------*/
		/* this code will return the current date, month and year*/
		 Calendar ca = new GregorianCalendar();
		 int iTDay=ca.get(Calendar.DATE); 
		 int iTYear=ca.get(Calendar.YEAR);
		 int iTMonth=ca.get(Calendar.MONTH);
				
		  if(iYear==0)
		 {
		      iYear=iTYear;
		      iMonth=iTMonth;
		 } 
		  
		  /* this code will return day of month , week, and total days in selected month */
		 GregorianCalendar cal = new GregorianCalendar (iYear, iMonth, 1); 
		
		 int days=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		 int weekStartDay=cal.get(Calendar.DAY_OF_WEEK);
		// int lastDate=cal.getActualMaximum(Calendar.DATE);
		 boolean sunday=cal.get(Calendar.DAY_OF_WEEK)== Calendar.SUNDAY;
		 
		 cal = new GregorianCalendar (iYear, iMonth, days); 
		 int iTotalweeks=cal.get(Calendar.WEEK_OF_MONTH);
		
		 EmployeeCalendar empCal=new EmployeeCalendar();
		 empCal.setDays(days);
		 empCal.setiMonth(iMonth);
		 empCal.setiTDay(iTDay);
		 empCal.setiTMonth(iTMonth);
		 empCal.setiTotalweeks(iTotalweeks);
		 empCal.setiYear(iYear);
		 empCal.setiTYear(iTYear);
		 empCal.setWeekStartDay(weekStartDay);
		 empCal.setSunday(sunday);
		 return empCal;
	}
	
	public EmployeeCalendar applyLeave(int empId, String leaveDay , int  iMonth, int iYear, String reason)
	{
	
		empDAO.applyLeave(empId, leaveDay, iMonth, iYear,reason);
		
		 EmployeeCalendar empCal=new EmployeeCalendar();		
		 empCal.setiMonth(iMonth);				
		 empCal.setiYear(iYear);
		 empCal.setLeaveDay(leaveDay);
		 empCal.setReason(reason);
		 return empCal;
	}
	
	public List<EmployeeCalendar> leaveDetails()
	{
		return empDAO.leaveDetails();
	}
	
	public String approved(int id,int month, int year)
	{
		return empDAO.approved(id, month, year);
	}
	
	public String notApproved(int id,int month, int year)
	{
		return empDAO.notApproved(id, month ,year);
	}
	
	
	public String absent(int empId, int month, int year){
		
	
		return empDAO.absent(empId, month, year);
		
	}
	
}



package com.roshi.controller;


import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.roshi.service.EmpService;
import com.roshi.standalone.EmployeeCalendar;


@Controller
@Scope("session")
public class EmployeeController {
	
	@Autowired
	EmpService empService;
	
	@RequestMapping(value = "/startTime")
	public @ResponseBody String startTime(HttpSession session, Model model, @RequestParam("month") int month, @RequestParam("year") int year) {
		
		model.addAttribute("msg", empService.empGetTimes(Integer.parseInt(session.getAttribute("ID").toString()),month,year));
		model.addAttribute("status", "stop");
		return "start";
	}
	
	@RequestMapping(value = "/stopTime")
	public  @ResponseBody String stopTime(HttpSession session, Model model ) {
		model.addAttribute("msg", empService.stopEmpTimes(Integer.parseInt(session.getAttribute("ID").toString())));		
		model.addAttribute("status", "start");
		return "stop";
	}
	
	
	@RequestMapping(value="/deleteEmpDetails")
	public @ResponseBody String deleteEmployeeTimeStamp(@RequestParam("id") int id,Model model)
	{
		model.addAttribute("employeeList",empService.getEmployeeList());
		return empService.deleteEmployeeTimeStamp(id);
		
	}
	/*@RequestMapping(value="/empHome")
	public ModelAndView empHome( HttpSession session,@ModelAttribute Employee employee)
	{
		
		ModelAndView model=new ModelAndView("employeePage");
		
		return model;
	}*/
	
	@RequestMapping(value = "/time" )
	public ModelAndView time(HttpSession session) {
		ModelAndView model = new ModelAndView("adminPage");
		model.addObject("employeeList",empService.getEmployeeList());
		return model;
	}
	
	@RequestMapping(value = "/viewAttendance" )
	public ModelAndView viewAttendance(HttpSession session ) {
		ModelAndView model = new ModelAndView("simpleAdminCalendar");
		model.addObject("employeeIDList",empService.getEmployeeIdList());
		
		return model;
	}
	
	@RequestMapping(value="/getDetails")
	public ModelAndView attendanceDetailsAdmin(HttpSession session,  @RequestParam("empId") int empID,  @RequestParam("iMonth") int month, @RequestParam("iYear") int year)
	{		
		ModelAndView model= new ModelAndView("viewEmpAttendanceAdmin");
		
		model.addObject("empDetails",empService.employeeAttendance(empID, month,year));	
		return model;
	}
	
	
	@RequestMapping(value="/viewEmpAttendance")
	public ModelAndView viewEmpAttendance(HttpSession session)
	{
		ModelAndView model=new ModelAndView("simpleEmpCalendar");
		return model;
		
	}
	
	
	@RequestMapping(value="/getEmpDetails")
	public ModelAndView attendanceEmpDetails(HttpSession session, @RequestParam("iMonth") int month, @RequestParam("iYear") int year)
	{		
		ModelAndView model= new ModelAndView("viewEmpAttendanceEmployee");
		model.addObject("empDetails",empService.employeeAttendance(Integer.parseInt(session.getAttribute("ID").toString()), month, year));	
		return model;
	}
	
	@RequestMapping(value="/leaveCalendar")
	public ModelAndView leaveCalendar(HttpSession session)
	{		
		ModelAndView model= new ModelAndView("leaveCalendar");		
		model.addObject("leaveDetails",empService.leaveCalendar(Integer.parseInt(session.getAttribute("ID").toString())));	
		return model;
	}
	
	@RequestMapping(value="/applyLeave")
	public @ResponseBody EmployeeCalendar applyLeave(HttpSession session,@RequestParam("leaveDay") String leaveDay, @RequestParam("month") int month, @RequestParam("year") int year,@RequestParam("reason") String reason)
	
	{	
		System.out.println(month+" "+year+" "+leaveDay+" "+reason+"");
		return empService.applyLeave((Integer.parseInt(session.getAttribute("ID").toString())), leaveDay, month, year, reason);
	}
	
	@RequestMapping(value="/approveLeave")
	public ModelAndView approveLeave()
	{
		ModelAndView model=new ModelAndView("approveLeave");
		model.addObject("leaveList",empService.leaveDetails());
		return model;
	}
	
	@RequestMapping(value="/approve")
	public @ResponseBody String approve(HttpSession session, @RequestParam("empID") int id, @RequestParam("month") int month, @RequestParam("year") int year, Model model)
	{	
		return empService.approved(id,month,year);
	}
	
	@RequestMapping(value="/notapprove")
	public @ResponseBody String notApprove(HttpSession session, @RequestParam("empID") int id, @RequestParam("month") int month, @RequestParam("year") int year)
	{
		return empService.notApproved(id, month, year);
	}	
}	
	
	
	



















	
	/*@RequestMapping(value="/approve")
	public ModelAndView approve(HttpSession session,int id)
	{
		ModelAndView model=new ModelAndView("approveLeave");
		model.addObject(empService.approved(id));
		model.addObject("leaveList",empService.leaveDetails());
		return model;
	}*/


/*@RequestMapping(value="/approve")
public @ResponseBody List<EmployeeCalendar> approve(HttpSession session, int id, int month,int year, Model model)
{
	model.addAttribute(empService.approved(id, month, year));		
	return empService.leaveDetails();
}*/

/*@RequestMapping(value="/notapprove")
public ModelAndView notApprove(HttpSession session, int id, int month, int year)
{
	
	ModelAndView model=new ModelAndView("approveLeave");
	model.addObject(empService.notApproved(id, month, year));
	model.addObject("leaveList",empService.leaveDetails());
	return model;
}	*/

/*@RequestMapping(value="/approveLeave")
public ModelAndView approveLeave()
{
	ModelAndView model=new ModelAndView("approveLeave");
	model.addObject("leaveList",empService.leaveDetails());
	return model;
}*/

/*@RequestMapping(value="/applyLeave")
public ModelAndView applyLeave(HttpSession session,@RequestParam("leaveDay") String leaveDay, @RequestParam("iMonth") int month, @RequestParam("iYear") int year,@RequestParam("LeaveReason") String reason)
{	
	ModelAndView model= new ModelAndView("success");		
	model.addObject("empDetails",empService.applyLeave(Integer.parseInt(session.getAttribute("ID").toString()), leaveDay, month, year, reason));	
	
	return model;
}*/


/*@RequestMapping(value="/applyLeave")
public @ResponseBody String applyLeave(HttpSession session,@RequestParam("leaveDay") String leaveDay, @RequestParam("iMonth") int month, @RequestParam("iYear") int year,@RequestParam("LeaveReason") String reason)
{	
//	ModelAndView model= new ModelAndView("success");		
//	model.addObject("empDetails",empService.applyLeave(Integer.parseInt(session.getAttribute("ID").toString()), leaveDay, month, year, reason));	
	
	return "";// empService.applyLeave(Integer.parseInt(session.getAttribute("ID").toString()), leaveDay, month, year, reason);
}*/


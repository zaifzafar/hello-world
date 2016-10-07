package com.roshi.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.roshi.service.EmpService;
import com.roshi.standalone.Employee;

@Controller
@Scope("session")
public class CommanController {
	
	@Autowired
	EmpService empService;
	
	
	@RequestMapping(value = "/")
	public ModelAndView root() {
		ModelAndView model = new ModelAndView("login");
		return model;
	}
	
	@RequestMapping(value = "/login",method=RequestMethod.POST)
	public ModelAndView auth(@ModelAttribute Employee employee,HttpSession session)
	{
		ModelAndView model=null;

		
		if(empService.isExistEmployee())
		{
			if(empService.authenticateEmployee(employee))
			{
				
				Employee emp = empService.getEmployeeID(employee);
				
				
				switch(emp.getRole())
				{
				
					case "employee" :
					{
													
							model=new ModelAndView("employeePage");
							session.setAttribute("ID",emp.getEmpId());
							model.addObject("status",emp.getStatus());
						break;
					}
						
					case "admin":
					{
						model=new ModelAndView("adminPage");						
						model.addObject("employeeList",empService.getEmployeeList());						
						break;
					}
					default:
					{
						 model=new ModelAndView("loginError");
					}
				}
				
			}
			else model=new ModelAndView("loginError");

		}
		else model=new ModelAndView("loginError");
		return model;
	}
	
	@RequestMapping(value = "/logout" )
	public ModelAndView stopTime(HttpSession session) {
		session.invalidate();
		ModelAndView model = new ModelAndView("login");
		return model;
	}

}
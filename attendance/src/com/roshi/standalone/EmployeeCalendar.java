package com.roshi.standalone;

import java.util.List;

public class EmployeeCalendar {
	private int iTDay;
	private int iTYear;
	private int iTMonth;
	private int days;
	private int weekStartDay;
	private int iTotalweeks;
	private int iMonth;
	private int iYear;
	
	private List<Integer> present;
	private List<Integer> absent;
	private List<Integer> leave;
	private int month;
	private int year;
	
	private String leaveDay;
	private String reason;
	private int empId;
	private String empName;
	private String approve;
	
	private boolean sunday;
	private int lastDate;
	
	
	public int getiTDay() {
		return iTDay;
	}
	public void setiTDay(int iTDay) {
		this.iTDay = iTDay;
	}
	public int getiTYear() {
		return iTYear;
	}
	public void setiTYear(int iTYear) {
		this.iTYear = iTYear;
	}
	public int getiTMonth() {
		return iTMonth;
	}
	public void setiTMonth(int iTMonth) {
		this.iTMonth = iTMonth;
	}
	public int getDays() {
		return days;
	}
	public void setDays(int days) {
		this.days = days;
	}
	public int getWeekStartDay() {
		return weekStartDay;
	}
	public void setWeekStartDay(int weekStartDay) {
		this.weekStartDay = weekStartDay;
	}
	public int getiTotalweeks() {
		return iTotalweeks;
	}
	public void setiTotalweeks(int iTotalweeks) {
		this.iTotalweeks = iTotalweeks;
	}
	public int getiMonth() {
		return iMonth;
	}
	public void setiMonth(int iMonth) {
		this.iMonth = iMonth;
	}
	public int getiYear() {
		return iYear;
	}
	public void setiYear(int iYear) {
		this.iYear = iYear;
	}
	public List<Integer> getPresent() {
		return present;
	}
	public void setPresent(List<Integer> present) {
		this.present = present;
	}
	public List<Integer> getAbsent() {
		return absent;
	}
	public void setAbsent(List<Integer> absent) {
		this.absent = absent;
	}
	public List<Integer> getLeave() {
		return leave;
	}
	public void setLeave(List<Integer> leave) {
		this.leave = leave;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}

	public String getLeaveDay() {
		return leaveDay;
	}
	public void setLeaveDay(String leaveDay) {
		this.leaveDay = leaveDay;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getApprove() {
		return approve;
	}
	public void setApprove(String approve) {
		this.approve = approve;
	}
	public boolean isSunday() {
		return sunday;
	}
	public void setSunday(boolean sunday) {
		this.sunday = sunday;
	}
	public int getLastDate() {
		return lastDate;
	}
	public void setLastDate(int lastDate) {
		this.lastDate = lastDate;
	}
	
	
	
	
	
	
	
	
	

}

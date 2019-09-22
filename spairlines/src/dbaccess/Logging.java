package dbaccess;

// public class
public class Logging {
	
	// declare variables
	private int loggingID;
	private String adminID;
	private String status;
	private String dateAndTime;
	
	// all getters and setters
	public int getLoggingID() {
		return loggingID;
	}
	
	public void setLoggingID(int loggingID) {
		this.loggingID = loggingID;
	}
	
	public String getAdminID() {
		return adminID;
	}
	
	public void setAdminID(String adminID) {
		this.adminID = adminID;
	}
	
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getDateAndTime() {
		return dateAndTime;
	}
	
	public void setDateAndTime(String dateAndTime) {
		this.dateAndTime = dateAndTime;
	}
	
}

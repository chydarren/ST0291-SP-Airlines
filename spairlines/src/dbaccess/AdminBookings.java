package dbaccess;

//public class
public class AdminBookings {
	
	// declare variables 
	private int flight_bk_id;
	private int flightschedule_id;
	private String bk_seatType;
	private int bk_noOfSeats;
	private String firstname;
	private String lastname;
	private String email;
	
	// all getters and setters
	public int getflight_bk_id(){
		return flight_bk_id;
	}
	
	public void setflight_bk_id(int flight_bk_id){
		this.flight_bk_id = flight_bk_id;
	}
	
	public int getflightschedule_id(){
		return flightschedule_id;
	}
	
	public void setflightschedule_id(int flightschedule_id){
		this.flightschedule_id = flightschedule_id;
	}
	
	public String getbk_seatType(){
		return bk_seatType;
	}
	
	public void setbk_seatType(String bk_seatType){
		this.bk_seatType = bk_seatType;
	}
	
	public int getbk_noOfSeats(){
		return bk_noOfSeats;
	}
	
	public void setbk_noOfSeats(int bk_noOfSeats){
		this.bk_noOfSeats = bk_noOfSeats;
	}
	
	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
}


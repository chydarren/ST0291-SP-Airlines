package dbaccess;

// public class
public class Bk_flight {
	
	// declare variables 
	private int flight_bk_id;
	private int flightschedule_id;
	private String bk_seatType;
	private int bk_noOfSeats; 
	
	public Bk_flight(){
		super();
	}
	
	// public set constructor
	public Bk_flight(int flight_bk_id, int flightschedule_id, String bk_seatType, int bk_noOfSeats){
		super();
		this.flight_bk_id = flight_bk_id;
		this.flightschedule_id = flightschedule_id; 
		this.bk_seatType = bk_seatType;
		this.bk_noOfSeats = bk_noOfSeats; 
	}

	// all getters and setters  
	public int getFlight_bk_id() {
		return flight_bk_id;
	}

	public void setFlight_bk_id(int flight_bk_id) {
		this.flight_bk_id = flight_bk_id;
	}

	public int getFlightschedule_id() {
		return flightschedule_id;
	}

	public void setFlightschedule_id(int flightschedule_id) {
		this.flightschedule_id = flightschedule_id;
	}

	public String getBk_seatType() {
		return bk_seatType;
	}

	public void setBk_seatType(String bk_seatType) {
		this.bk_seatType = bk_seatType;
	}

	public int getBk_noOfSeats() {
		return bk_noOfSeats;
	}

	public void setBk_noOfSeats(int bk_noOfSeats) {
		this.bk_noOfSeats = bk_noOfSeats;
	}
	
}

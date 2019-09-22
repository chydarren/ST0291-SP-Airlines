package dbaccess; 

// public class
public class Bk_guest {
	
	// declare variables 
	private String guest_salutation;
	private String guest_firstname;
	private String guest_lastname;
	private String guest_passportno;
	private int booking_ref_id;
	
	public Bk_guest(){
		super();
	}
	
	// public set constructor 
	public Bk_guest(String guest_salutation, String guest_firstname, String guest_lastname, String guest_passportno, int booking_ref_id){
		super();
		this.guest_salutation = guest_salutation;
		this.guest_firstname = guest_firstname;
		this.guest_lastname = guest_lastname;
		this.guest_passportno = guest_passportno; 
		this.booking_ref_id = booking_ref_id; 
	}

	// all getters and setters
	public String getGuest_salutation() {
		return guest_salutation;
	}

	public void setGuest_salutation(String guest_salutation) {
		this.guest_salutation = guest_salutation;
	}

	public String getGuest_firstname() {
		return guest_firstname;
	}

	public void setGuest_firstname(String guest_firstname) {
		this.guest_firstname = guest_firstname;
	}

	public String getGuest_lastname() {
		return guest_lastname;
	}

	public void setGuest_lastname(String guest_lastname) {
		this.guest_lastname = guest_lastname;
	}

	public String getGuest_passportno() {
		return guest_passportno;
	}

	public void setGuest_passportno(String guest_passportno) {
		this.guest_passportno = guest_passportno;
	}

	public int getBooking_ref_id() {
		return booking_ref_id;
	}

	public void setBooking_ref_id(int booking_ref_id) {
		this.booking_ref_id = booking_ref_id;
	}
	
}
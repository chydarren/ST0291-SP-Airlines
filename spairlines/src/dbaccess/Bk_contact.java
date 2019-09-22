package dbaccess;

// public class
public class Bk_contact {
	
	// declare variables 
	private int booking_ref_id;
	private String contact_email;
	private int contact_tel_ctry;
	private int contact_tel_area;
	private String contact_tel_hp;
	private int departure_flightbk_id;
	private int arrival_flightbk_id;
	private int payment_id; 
	
	public Bk_contact(){
		super();
	}
	
	// public set constructor 
	public Bk_contact(int booking_ref_id, String contact_email, int contact_tel_ctry, int contact_tel_area, String contact_tel_hp,
			int departure_flightbk_id, int arrival_flightbk_id, int payment_id){
		super();
		this.booking_ref_id = booking_ref_id;
		this.contact_email = contact_email;
		this.contact_tel_ctry = contact_tel_ctry;
		this.contact_tel_area = contact_tel_area; 
		this.contact_tel_hp = contact_tel_hp;
		this.departure_flightbk_id = departure_flightbk_id;
		this.arrival_flightbk_id = arrival_flightbk_id; 
		this.payment_id = payment_id; 
	}

	// all getters and setters
	public int getBooking_ref_id() {
		return booking_ref_id;
	}

	public void setBooking_ref_id(int booking_ref_id) {
		this.booking_ref_id = booking_ref_id;
	}

	public String getContact_email() {
		return contact_email;
	}

	public void setContact_email(String contact_email) {
		this.contact_email = contact_email;
	}

	public int getContact_tel_ctry() {
		return contact_tel_ctry;
	}

	public void setContact_tel_ctry(int contact_tel_ctry) {
		this.contact_tel_ctry = contact_tel_ctry;
	}

	public int getContact_tel_area() {
		return contact_tel_area;
	}

	public void setContact_tel_area(int contact_tel_area) {
		this.contact_tel_area = contact_tel_area;
	}

	public String getContact_tel_hp() {
		return contact_tel_hp;
	}

	public void setContact_tel_hp(String contact_tel_hp) {
		this.contact_tel_hp = contact_tel_hp;
	}

	public int getDeparture_flightbk_id() {
		return departure_flightbk_id;
	}

	public void setDeparture_flightbk_id(int departure_flightbk_id) {
		this.departure_flightbk_id = departure_flightbk_id;
	}

	public int getArrival_flightbk_id() {
		return arrival_flightbk_id;
	}

	public void setArrival_flightbk_id(int arrival_flightbk_id) {
		this.arrival_flightbk_id = arrival_flightbk_id;
	}

	public int getPayment_id() {
		return payment_id;
	}

	public void setPayment_id(int payment_id) {
		this.payment_id = payment_id;
	}
	
}

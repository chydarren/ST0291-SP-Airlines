package dbaccess;

//public class 
public class Bk_promotion {

	// declare variables 
	private int promotion_id;
	private String promotion_startdate;
	private String promotion_enddate;
	private String promotion_departure_country;
	private String promotion_arrival_country;
	private String seat_type;
	private Long cabin_cost;
	
	public Bk_promotion(){
		super();
	}
	
	// public set constructor
	public Bk_promotion(int promotion_id, String promotion_startdate, String promotion_enddate, String promotion_departure_country, String promotion_arrival_country,
			String seat_type, Long cabin_cost){
		super();
		this.promotion_id = promotion_id;
		this.promotion_startdate = promotion_startdate;
		this.promotion_enddate = promotion_enddate;
		this.promotion_departure_country = promotion_departure_country;
		this.promotion_arrival_country = promotion_arrival_country;
		this.seat_type = seat_type;
		this.cabin_cost = cabin_cost;
	}

	// all getters and setters
	public int getPromotion_id() {
		return promotion_id;
	}

	public void setPromotion_id(int promotion_id) {
		this.promotion_id = promotion_id;
	}

	public String getPromotion_startdate() {
		return promotion_startdate;
	}

	public void setPromotion_startdate(String promotion_startdate) {
		this.promotion_startdate = promotion_startdate;
	}

	public String getPromotion_enddate() {
		return promotion_enddate;
	}

	public void setPromotion_enddate(String promotion_enddate) {
		this.promotion_enddate = promotion_enddate;
	}

	public String getPromotion_departure_country() {
		return promotion_departure_country;
	}

	public void setPromotion_departure_country(String promotion_departure_country) {
		this.promotion_departure_country = promotion_departure_country;
	}

	public String getPromotion_arrival_country() {
		return promotion_arrival_country;
	}

	public void setPromotion_arrival_country(String promotion_arrival_country) {
		this.promotion_arrival_country = promotion_arrival_country;
	}

	public String getSeat_type() {
		return seat_type;
	}

	public void setSeat_type(String seat_type) {
		this.seat_type = seat_type;
	}

	public Long getCabin_cost() {
		return cabin_cost;
	}

	public void setCabin_cost(Long cabin_cost) {
		this.cabin_cost = cabin_cost;
	}
	
}

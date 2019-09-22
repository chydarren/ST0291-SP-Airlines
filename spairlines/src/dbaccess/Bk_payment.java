package dbaccess;

// public class 
public class Bk_payment {
	
	// declare variables 
	private int payment_id;
	private String payment_card_holder; 
	private String payment_card_no; 
	private String payment_card_expdate;  
	private int payment_card_cvv;
	private String payment_addr_address;
	private String payment_addr_postcode;
	private String payment_addr_residence;
	private String payment_addr_city;
	private String payment_addr_state;
	private Long payment_total_cost; 
	
	public Bk_payment(){
		super();
	}
	
	// public set constructor 
	public Bk_payment(int payment_id, String payment_card_holder, String payment_card_no, String payment_card_expdate, int payment_card_cvv,
			String payment_addr_address, String payment_addr_postcode, String payment_addr_residence, String payment_addr_city, 
			String payment_addr_state, Long payment_total_cost){
		super();
		this.payment_id = payment_id;
		this.payment_card_holder = payment_card_holder;
		this.payment_card_no = payment_card_no;
		this.payment_card_expdate = payment_card_expdate;
		this.payment_card_cvv = payment_card_cvv;
		this.payment_addr_address = payment_addr_address;
		this.payment_addr_postcode = payment_addr_postcode;
		this.payment_addr_residence = payment_addr_residence;
		this.payment_addr_city = payment_addr_city;
		this.payment_addr_state = payment_addr_state; 
		this.payment_total_cost = payment_total_cost; 
	}
	
	// all getters and setters 
	public int getPayment_id() {
		return payment_id;
	}

	public void setPayment_id(int payment_id) {
		this.payment_id = payment_id;
	}

	public String getPayment_card_holder() {
		return payment_card_holder;
	}

	public void setPayment_card_holder(String payment_card_holder) {
		this.payment_card_holder = payment_card_holder;
	}

	public String getPayment_card_no() {
		return payment_card_no;
	}

	public void setPayment_card_no(String payment_card_no) {
		this.payment_card_no = payment_card_no;
	}

	public String getPayment_card_expdate() {
		return payment_card_expdate;
	}

	public void setPayment_card_expdate(String payment_card_expdate) {
		this.payment_card_expdate = payment_card_expdate;
	}

	public int getPayment_card_cvv() {
		return payment_card_cvv;
	}

	public void setPayment_card_cvv(int payment_card_cvv) {
		this.payment_card_cvv = payment_card_cvv;
	}

	public String getPayment_addr_address() {
		return payment_addr_address;
	}

	public void setPayment_addr_address(String payment_addr_address) {
		this.payment_addr_address = payment_addr_address;
	}

	public String getPayment_addr_postcode() {
		return payment_addr_postcode;
	}

	public void setPayment_addr_postcode(String payment_addr_postcode) {
		this.payment_addr_postcode = payment_addr_postcode;
	}

	public String getPayment_addr_residence() {
		return payment_addr_residence;
	}

	public void setPayment_addr_residence(String payment_addr_residence) {
		this.payment_addr_residence = payment_addr_residence;
	}

	public String getPayment_addr_city() {
		return payment_addr_city;
	}

	public void setPayment_addr_city(String payment_addr_city) {
		this.payment_addr_city = payment_addr_city;
	}

	public String getPayment_addr_state() {
		return payment_addr_state;
	}

	public void setPayment_addr_state(String payment_addr_state) {
		this.payment_addr_state = payment_addr_state;
	}
	
	public Long getPayment_total_cost(){
		return payment_total_cost;
	}
	
	public void setPayment_total_cost(Long payment_total_cost){
		this.payment_total_cost = payment_total_cost; 
	}
	
}

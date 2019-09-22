package dbaccess;

//public class 
public class Bk_welcome {
	
	// declare variables 
	private int flightschedule_id;
	private int aircraft_id;
	private String aircraft_flightno;
	private String departure_airport;
	private char departure_terminal;
	private String departure_country;
	private String departure_city;
	private String arrival_airport;
	private char arrival_terminal;
	private String arrival_country;
	private String arrival_city;
	private long cabin_cost;
	private String departure_datetime;
	private String arrival_datetime;
	private String flight_time;
	private String departure_IATA;
	private String arrival_IATA;
	
	// all getters and setters 
	public int getFlightschedule_id() {
		return flightschedule_id;
	}
	
	public void setFlightschedule_id(int flightschedule_id) {
		this.flightschedule_id = flightschedule_id;
	}
	
	public int getAircraft_id() {
		return aircraft_id;
	}
	
	public void setAircraft_id(int aircraft_id) {
		this.aircraft_id = aircraft_id;
	}
	
	public String getAircraft_flightno() {
		return aircraft_flightno;
	}
	
	public void setAircraft_flightno(String aircraft_flightno) {
		this.aircraft_flightno = aircraft_flightno;
	}
	
	public String getDeparture_airport() {
		return departure_airport;
	}
	
	public void setDeparture_airport(String departure_airport) {
		this.departure_airport = departure_airport;
	}
	
	public char getDeparture_terminal() {
		return departure_terminal;
	}
	
	public void setDeparture_terminal(char departure_terminal) {
		this.departure_terminal = departure_terminal;
	}
	
	public String getDeparture_country() {
		return departure_country;
	}
	
	public void setDeparture_country(String departure_country) {
		this.departure_country = departure_country;
	}
	
	public String getDeparture_city() {
		return departure_city;
	}
	
	public void setDeparture_city(String departure_city) {
		this.departure_city = departure_city;
	}
	
	public String getArrival_airport() {
		return arrival_airport;
	}
	
	public void setArrival_airport(String arrival_airport) {
		this.arrival_airport = arrival_airport;
	}
	
	public char getArrival_terminal() {
		return arrival_terminal;
	}
	
	public void setArrival_terminal(char arrival_terminal) {
		this.arrival_terminal = arrival_terminal;
	}
	
	public String getArrival_country() {
		return arrival_country;
	}
	
	public void setArrival_country(String arrival_country) {
		this.arrival_country = arrival_country;
	}
	
	public String getArrival_city() {
		return arrival_city;
	}
	
	public void setArrival_city(String arrival_city) {
		this.arrival_city = arrival_city;
	}
	
	public long getCabin_cost() {
		return cabin_cost;
	}
	
	public void setCabin_cost(long cabin_cost) {
		this.cabin_cost = cabin_cost;
	}
	
	public String getDeparture_datetime() {
		return departure_datetime;
	}
	
	public void setDeparture_datetime(String departure_datetime) {
		this.departure_datetime = departure_datetime;
	}
	
	public String getArrival_datetime() {
		return arrival_datetime;
	}
	
	public void setArrival_datetime(String arrival_datetime) {
		this.arrival_datetime = arrival_datetime;
	}
	
	public String getFlight_time() {
		return flight_time;
	}
	
	public void setFlight_time(String flight_time) {
		this.flight_time = flight_time;
	}
	
	public String getDeparture_iata(){
		return departure_IATA;
	}
	
	public void setDeparture_iata(String departure_IATA){
		this.departure_IATA = departure_IATA;
	}
	
	public String getArrival_iata(){
		return arrival_IATA;
	}
	
	public void setArrival_iata(String arrival_IATA){
		this.arrival_IATA = arrival_IATA;
	}
	
}

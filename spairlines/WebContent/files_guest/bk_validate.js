// ============================================ modal and submission ============================================ // 
// confirm guest modal 
function confirmGuestModal() {
    if (checkGuestForm() != false) {
        $('#myModal').modal();
    }
}

// check guest form 
function checkGuestForm(){
	var results=[];
	results[0]=checkFormSalutation();
	results[1]=checkFormLastname();
	results[2]=checkFormPassportno();
	
	if(results[0]==false || results[1]==false || results[2]==false){
		return false; 
	}
}

// confirm contact modal 
function confirmContactModal() {
    if (checkContactForm() != false) {
        $('#myModal').modal();
    }
}

// check contact form 
function checkContactForm(){
	var results=[];
	results[0]=checkFormSalutation();
	results[1]=checkFormLastname();
	results[2]=checkFormPassportno();
	results[3]=checkFormEmail();
	results[4]=checkFormTel(); 
	
	if(results[0]==false || results[1]==false || results[2]==false || results[3]==false || results[4]==false){
		return false; 
	}
}

//confirm payment modal 
function confirmPaymentModal() {
    if (checkPaymentForm() != false) {
        $('#paymentModal').modal();
    }
}

// check payment form
function checkPaymentForm(){
	var results=[];
	results[0]=checkFormCardHolderName();
	results[1]=checkFormCardNumber();
	results[2]=checkFormExpiryDate();
	results[3]=checkFormCVV();
	results[4]=checkFormAddress(); 	
	results[5]=checkFormResidence();
	results[6]=checkFormPostalCode();
	results[7]=checkFormCity(); 
	results[8]=checkFormState(); 
	
	if(results[0]==false || results[1]==false || results[2]==false || results[3]==false || results[4]==false || 
		results[5]==false || results[6]==false || results[7]==false || results[8]==false){
			return false;
		}
}

// ============================================ guest_contact form ============================================ // 
// salutation (compulsory) 
function checkFormSalutation(){
	if(document.bookdata.guest_salutation.value == "") {
		document.bookdata.guest_salutation.focus();
		document.bookdata.guest_salutation.style.borderColor = "#cd6155";
		document.bookdata.guest_salutation.style.backgroundColor = "#fdedec";
		document.getElementById("guest_salutation_msg").innerHTML = "Please provide title.";
		return false;
	}else{
		document.bookdata.guest_salutation.style.borderColor = "";
		document.bookdata.guest_salutation.style.backgroundColor = "";
		document.getElementById("guest_salutation_msg").innerHTML = "";
	}
}

// first name (alphabets only) 
function checkFormFirstname(){
	if(/^[a-zA-Z ]*$/.test(document.bookdata.guest_firstname.value) != true){
		document.bookdata.guest_firstname.focus();
		document.bookdata.guest_firstname.style.borderColor = "#cd6155";
		document.bookdata.guest_firstname.style.backgroundColor = "#fdedec";
		document.getElementById("guest_firstname_msg").innerHTML = "Please provide valid first name with the letters of the English alphabet.";
		return false;
	}else{
		document.bookdata.guest_firstname.style.borderColor = "";
		document.bookdata.guest_firstname.style.backgroundColor = "";
		document.getElementById("guest_firstname_msg").innerHTML = "";
	}
}

// last name (compulsory, alphabets only) 
function checkFormLastname(){
	if(document.bookdata.guest_lastname.value == "" || (/^[a-zA-Z ]*$/.test(document.bookdata.guest_lastname.value) != true)){
		document.bookdata.guest_lastname.focus();
		document.bookdata.guest_lastname.style.borderColor = "#cd6155";
		document.bookdata.guest_lastname.style.backgroundColor = "#fdedec";
		document.getElementById("guest_lastname_msg").innerHTML = "Please provide valid last name with the letters of the English alphabet.";
		return false;
	}else{
		document.bookdata.guest_lastname.style.borderColor = "";
		document.bookdata.guest_lastname.style.backgroundColor = "";
		document.getElementById("guest_lastname_msg").innerHTML = "";
	}
}

// passport number (compulsory, alphabets and numbers only)
function checkFormPassportno(){
	if((document.bookdata.guest_passportno.value == "") || (/^[a-z0-9]+$/i.test(document.bookdata.guest_passportno.value) != true)) {
		document.bookdata.guest_passportno.focus();
		document.bookdata.guest_passportno.style.borderColor = "#cd6155";
		document.bookdata.guest_passportno.style.backgroundColor = "#fdedec";
		document.getElementById("guest_passportno_msg").innerHTML = "Please provide valid passport number with letters of the English alphabet and numbers only.";
		return false;
	}else{
		document.bookdata.guest_passportno.style.borderColor = "";
		document.bookdata.guest_passportno.style.backgroundColor = "";
		document.getElementById("guest_passportno_msg").innerHTML = "";
	}
}

// email (compulsory, email only) 
function checkFormEmail(){
	if((document.bookdata.contact_email.value == "") || (/\S+@\S+\.\S+/.test(document.bookdata.contact_email.value) != true)){
		document.bookdata.contact_email.focus();
		document.bookdata.contact_email.style.borderColor = "#cd6155";
		document.bookdata.contact_email.style.backgroundColor = "#fdedec";
		document.getElementById("contact_email_msg").innerHTML = "Please provide valid email address.";
		return false; 
	}else{
		document.bookdata.contact_email.style.borderColor = "";
		document.bookdata.contact_email.style.backgroundColor = "";
		document.getElementById("contact_email_msg").innerHTML = "";
	}
}

// phone (compulsory for country and contact, numbers only) 
function checkFormTel(){
	if((document.bookdata.contact_tel_ctry.value == "") || (document.bookdata.contact_tel_hp.value == "") || (/^\d+$/.test(document.bookdata.contact_tel_ctry.value) != true) || (/^\d+$/.test(document.bookdata.contact_tel_hp.value) != true) || (/^(\s*|\d+)$/.test(document.bookdata.contact_tel_area.value) != true)){
		document.bookdata.contact_tel_ctry.focus();
		document.bookdata.contact_tel_hp.focus();
		document.bookdata.contact_tel_area.focus();
		document.bookdata.contact_tel_ctry.style.borderColor = document.bookdata.contact_tel_hp.style.borderColor = document.bookdata.contact_tel_area.style.borderColor = "#cd6155";
		document.bookdata.contact_tel_ctry.style.backgroundColor = document.bookdata.contact_tel_hp.style.backgroundColor = document.bookdata.contact_tel_area.style.backgroundColor = "#fdedec";
		document.getElementById("contact_tel_msg").innerHTML = "Please provide valid contact number with numbers only .";
		return false;
	}else{
		document.bookdata.contact_tel_ctry.style.borderColor = document.bookdata.contact_tel_hp.style.borderColor = document.bookdata.contact_tel_area.style.borderColor = "";
		document.bookdata.contact_tel_ctry.style.backgroundColor = document.bookdata.contact_tel_hp.style.backgroundColor = document.bookdata.contact_tel_area.style.backgroundColor = "";
		document.getElementById("contact_tel_msg").innerHTML = "";
	}
} 

// ============================================ payment form ============================================ // 
// card holder's name (compulsory, alphabets only) 
function checkFormCardHolderName(){
	if((document.bookpayment.payment_card_holder.value == "") || (/^[a-zA-Z ]+$/.test(document.bookpayment.payment_card_holder.value) != true)){
		document.bookpayment.payment_card_holder.focus();
		document.bookpayment.payment_card_holder.style.borderColor = "#cd6155";
		document.bookpayment.payment_card_holder.style.backgroundColor = "#fdedec";
		document.getElementById("card_info_msg").innerHTML = "Please provide valid card information.";
		return false; 
	}else{
		document.bookpayment.payment_card_holder.style.borderColor = "";
		document.bookpayment.payment_card_holder.style.backgroundColor = "";
	}
	checkFormCardInfo();
}

// card number (compulsory, numbers only) 
function checkFormCardNumber(){
	if((document.bookpayment.payment_card_no.value == "") || (/^\d{16}$/.test(document.bookpayment.payment_card_no.value) != true)){
		document.bookpayment.payment_card_no.focus();
		document.bookpayment.payment_card_no.style.borderColor = "#cd6155";
		document.bookpayment.payment_card_no.style.backgroundColor = "#fdedec";
		document.getElementById("card_info_msg").innerHTML = "Please provide valid card information.";
		return false; 
	}else{
		document.bookpayment.payment_card_no.style.borderColor = "";
		document.bookpayment.payment_card_no.style.backgroundColor = "";
	}
	checkFormCardInfo();
}

//  expiry date (compulsory) 
function checkFormExpiryDate(){
	if(document.bookpayment.payment_card_expdate.value == ""){
		document.bookpayment.payment_card_expdate.focus();
		document.bookpayment.payment_card_expdate.style.borderColor = "#cd6155";
		document.bookpayment.payment_card_expdate.style.backgroundColor = "#fdedec";
		document.getElementById("card_info_msg").innerHTML = "Please provide valid card information.";
		return false;
	}else{
		document.bookpayment.payment_card_expdate.style.borderColor = "";
		document.bookpayment.payment_card_expdate.style.backgroundColor = "";
	}
	checkFormCardInfo();
}

// CVV (compulsory, numbers only) 
function checkFormCVV(){
	if(document.bookpayment.payment_card_cvv.value == "" || (/^\d+$/.test(document.bookpayment.payment_card_cvv.value) != true)){
		document.bookpayment.payment_card_cvv.focus();
		document.bookpayment.payment_card_cvv.style.borderColor = "#cd6155";
		document.bookpayment.payment_card_cvv.style.backgroundColor = "#fdedec";
		document.getElementById("card_info_msg").innerHTML = "Please provide valid card information.";
		return false;
	}else{
		document.bookpayment.payment_card_cvv.style.borderColor = "";
		document.bookpayment.payment_card_cvv.style.backgroundColor = "";
	}
	checkFormCardInfo();
}

// all card info correct
function checkFormCardInfo(){
	if(((document.bookpayment.payment_card_no.value != "") && (/^\d+$/.test(document.bookpayment.payment_card_no.value) == true)) &&
	((document.bookpayment.payment_card_holder.value != "") && (/^[a-zA-Z]+$/.test(document.bookpayment.payment_card_holder.value) == true)) &&
	(document.bookpayment.payment_card_expdate.value != "") && 
	(document.bookpayment.payment_card_cvv.value != "" || (/^\d+$/.test(document.bookpayment.payment_card_cvv.value) == true))){
		document.getElementById("card_info_msg").innerHTML = "";
	}
}

// full address (compulsory) 
function checkFormAddress(){
	if(document.bookpayment.payment_addr_address.value == ""){
		document.bookpayment.payment_addr_address.focus();
		document.bookpayment.payment_addr_address.style.borderColor = "#cd6155";
		document.bookpayment.payment_addr_address.style.backgroundColor = "#fdedec";
		document.getElementById("address_info_msg").innerHTML = "Please provide valid address information.";
		return false;
	}else{
		document.bookpayment.payment_addr_address.style.borderColor = "";
		document.bookpayment.payment_addr_address.style.backgroundColor = "";
	}
	checkFormAddressInfo()
}

// country/region (compulsory, alphabets only) 
function checkFormResidence(){
	if((document.bookpayment.payment_addr_residence.value == "") || (/^[a-zA-Z]+$/.test(document.bookpayment.payment_addr_residence.value) != true)){
		document.bookpayment.payment_addr_residence.focus();
		document.bookpayment.payment_addr_residence.style.borderColor = "#cd6155";
		document.bookpayment.payment_addr_residence.style.backgroundColor = "#fdedec";
		document.getElementById("address_info_msg").innerHTML = "Please provide valid address information.";
		return false;
	}else{
		document.bookpayment.payment_addr_residence.style.borderColor = "";
		document.bookpayment.payment_addr_residence.style.backgroundColor = "";
	}
	checkFormAddressInfo()
}

// city/town (compulsory, alphabets only)  
function checkFormCity(){
	if((document.bookpayment.payment_addr_city.value == "") || (/^[a-zA-Z]+$/.test(document.bookpayment.payment_addr_city.value) != true)){
		document.bookpayment.payment_addr_city.focus();
		document.bookpayment.payment_addr_city.style.borderColor = "#cd6155";
		document.bookpayment.payment_addr_city.style.backgroundColor = "#fdedec";
		document.getElementById("address_info_msg").innerHTML = "Please provide valid address information.";
		return false;
	}else{
		document.bookpayment.payment_addr_city.style.borderColor = "";
		document.bookpayment.payment_addr_city.style.backgroundColor = "";
	}
	checkFormAddressInfo()
}

// postal code (alphabets and numbers only) 
function checkFormPostalCode(){
	if(/^[a-zA-Z0-9]*$/.test(document.bookpayment.payment_addr_postcode.value) != true){
		document.bookpayment.payment_addr_postcode.focus();
		document.bookpayment.payment_addr_postcode.style.borderColor = "#cd6155";
		document.bookpayment.payment_addr_postcode.style.backgroundColor = "#fdedec";
		document.getElementById("address_info_msg").innerHTML = "Please provide valid address information.";
		return false;
	}else{
		document.bookpayment.payment_addr_postcode.style.borderColor = "";
		document.bookpayment.payment_addr_postcode.style.backgroundColor = "";
	}
	checkFormAddressInfo()
}

// state/province (alphabets only) 
function checkFormState(){
	if(/^[a-zA-Z]*$/.test(document.bookpayment.payment_addr_state.value) != true){
		document.bookpayment.payment_addr_state.focus();
		document.bookpayment.payment_addr_state.style.borderColor = "#cd6155";
		document.bookpayment.payment_addr_state.style.backgroundColor = "#fdedec";
		document.getElementById("address_info_msg").innerHTML = "Please provide valid address information.";
		return false;
	}else{
		document.bookpayment.payment_addr_state.style.borderColor = "";
		document.bookpayment.payment_addr_state.style.backgroundColor = "";
	}
	checkFormAddressInfo()
}

// all address info correct
function checkFormAddressInfo(){
	if((document.bookpayment.payment_addr_address.value != "") && 
	((document.bookpayment.payment_addr_residence.value != "") && (/^[a-zA-Z]+$/.test(document.bookpayment.payment_addr_residence.value) == true)) &&
	((document.bookpayment.payment_addr_city.value != "") && (/^[a-zA-Z]+$/.test(document.bookpayment.payment_addr_city.value) == true)) &&
	(/^[a-zA-Z0-9]*$/.test(document.bookpayment.payment_addr_postcode.value) == true) &&
	(/^[a-zA-Z]*$/.test(document.bookpayment.payment_addr_state.value) == true)){
		document.getElementById("address_info_msg").innerHTML = "";
	}
}


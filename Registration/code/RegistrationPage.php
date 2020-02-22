<?php 

class RegistrationPage extends Page 
{
	//Custom menu visibility
	public function CustomVisibility(){
		if(Member::currentUserID())
			return false;
		return true;
	}

}

class RegistrationPage_Controller extends Page_Controller 
{
	//Allow our form as an action
	private static $allowed_actions = array(
		'doRegister'
	);
	
	function init(){
		parent::init();
		Requirements::javascript('https://www.google.com/recaptcha/api.js');
	}
	
	//Submit the registration form
	function doRegister(){
		$data = $_POST;
		if($data['g-recaptcha-response'] == ''){
			$this->setMessage('danger', "Sorry, you must submit the captcha in order to register.");
			//Return back to form
			return $this->redirectBack();
		}
		
		//Check for existing member email address
		if($member = DataObject::get_one("Member", "`Email` = '". Convert::raw2sql($data['Email']) . "'")) 
		{
			$this->setMessage('danger', "Sorry, that email address already exists. Please choose another.");
			//Return back to form
			return $this->redirectBack();			
		}
		
		if($data['Password']['_Password'] != $data['Password']['_ConfirmPassword']){
			$this->setMessage('danger', "Passwords do not match.");
			//Return back to form
			return $this->redirectBack();
		}
		$member = new Member();
		$member->FirstName = $data['FirstName'];
		$member->Surname = $data['Surname'];
		$member->TradeUserName= $data['TradeUserName'];
		$member->Email = $data['Email'];
		$member->Password = $data['Password']['_Password'];
		$member->changePassword($data['Password']['_Password']);
		$member->PhoneNumber = $data['PhoneNumber'];
		$member->write();
		$member->logIn();
		//Send welcome email
		$email = new Email();
		$email
		->setTo($data['Email'])
		->setSubject("Welcome")
		->setTemplate('AccountCreatedWelcomeEmail');
		$email->send();
		
		if($data['PreSubmitTender'])
			return $this->redirect('/tender/submitTenderV2');
		$this->setMessage('success', 'Sign up successfull.If you are a Contractor you may like to enter additional profile details. <a href="/edit-profile/">Click here to enter these now</a>.');
		return $this->redirect('/home');
	}
	
	public function PreSubmitTender(){
		if(isset($_GET['submitTender']) && $_GET['submitTender']==1)
			return true;
		return false;
	}
}
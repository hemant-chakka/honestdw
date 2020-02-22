<?php
class CustomLoginForm extends MemberLoginForm {
	
	/**
	 * Login form handler method
	 *
	 * This method is called when the user clicks on "Log in"
	 *
	 * @param array $data Submitted data
	 */
	public function dologin($data) {
		if($this->performLogin($data)) {
			//$this->logInUserAndRedirect($data);
			if(isset($data['BackURL']))
				$this->controller->redirect($data['BackURL']);
			else 
				$this->controller->redirect('/home');
		} else {
			if(array_key_exists('Email', $data)){
				Session::set('SessionForms.MemberLoginForm.Email', $data['Email']);
				Session::set('SessionForms.MemberLoginForm.Remember', isset($data['Remember']));
			}
			
			if(isset($_REQUEST['BackURL'])) $backURL = $_REQUEST['BackURL'];
			else $backURL = null;
			
			if($backURL) Session::set('BackURL', $backURL);
			
			// Show the right tab on failed login
			$loginLink = Director::absoluteURL($this->controller->Link('login'));
			if($backURL) $loginLink .= '?BackURL=' . urlencode($backURL);
			$this->controller->redirect($loginLink . '#' . $this->FormName() .'_tab');
		}
	}
}
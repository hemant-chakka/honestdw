<?php

class MemberExtension extends DataExtension {
	
	private static $db = array(
			'PhoneNumber' => 'Varchar(50)',
			'AddressLine1' => 'Text',
			'AddressLine2' => 'Text',
			'City' => 'Varchar(100)',
			'State' => 'Varchar(100)',
			'PostCode' => 'Varchar(100)',
			'Country' => 'Varchar(100)',
			'AVCode' => 'Varchar(50)',
			'AVRequestDate' => 'SS_Datetime',
			'AVExpiryDate' => 'SS_Datetime',
			'AVSubmitted' => 'Boolean',
			'AddressVerified' => 'Boolean',
			'CategoriesInterested' => 'Text',
			'BusinessProfile' => 'Text',
			'RegionsWork' => 'Text',
			'Certifications' => 'Text',
			'HourlyRates' => 'Text',
			'TradeUserName' => 'Varchar(255)'
	);
	
	private static $has_one = array(
			
			'Logo' => 'Image'
			
	);
	
	private static $many_many = array(
			'Portfolios' => 'Image'
	);
	
	private static $summary_fields = [
			'PhoneNumber',
			'AVSubmitted',
			'AddressVerified',
			'Address',
			'AVCode',
			'AccountBalance',
			'Created'
	];
	
	private static $searchable_fields = [
			'AVSubmitted',
			'AddressVerified'
	];
	
	private static $field_labels = [
			'AVSubmitted' => 'Address Submitted',
			'AVCode' => 'Verification Code',
			'AccountBalance' => 'Account Balance',
			'Created' => 'Date Joined'
	];
	
	public function updateMemberFormFields(FieldList $fields) {
		$fields->push(new TextField('PhoneNumber', 'Phone number'));
	}
	
	public function updateCMSFields(FieldList $fields) {
		$balance = $this->AccountBalance();
		$memberId = $this->owner->ID;
		$fields->push(new LiteralField('Link', "<a href='/admin/payments/Payment?q%5BMemberID%5D=$memberId&action_search=Apply+Filter' target='_blank'>Click here to view users transaction history</a>"));
		
	}
	
	//Get user verification status
	public function Verified(){
		if(!$this->owner->AVSubmitted)
			return false;
		
		$expireDate = $this->owner->AVExpiryDate;
		if(time() >= strtotime($expireDate))
			return false;
		
		if(!$this->owner->AddressVerified)
				return false;
		
		return true;
	}
	//Get user average rating
	public function Rating(){
		$memberId = $this->owner->ID;
		return  DB::query("SELECT ROUND(AVG(Rating),0) FROM UserRating where RatedForID = $memberId")->value();
	}
	//Get the credit availed
	public function creditAvailed(){
		$memberId = $this->owner->ID;
		return  DB::query("SELECT SUM(Credit) FROM Payment where MemberID = $memberId")->value();
	}
	//Get the user account balance
	public function AccountBalance(){
		$balance = 10-$this->creditAvailed();
		return $balance;
	}
	//Get total number of ratings
	public function RatingCount(){
		$memberId = $this->owner->ID;
		$ratings = UserRating::get()->filter(array(
				'RatedForID' => $memberId
		));
		return $ratings->count();
	}
	//Check if a category selected
	public function SelectedCat($ID){
		$catInt = CategoriesInterested::get()->filter(array('CategoryID' => $ID,'MemberID' => Member::currentUserID()))->first();
		if($catInt)
			return 'selected';
		return '';
	}
	//Check if a region selected
	public function SelectedRegion($ID){
		if($this->owner->RegionsWork){
			$regions = unserialize($this->owner->RegionsWork);
			if(in_array($ID ,$regions))
				return 'selected';
		}
		return '';
	}
	//Get the default region
	public function DefaultRegion(){
		if($this->owner->State)
			return $this->owner->State;
		$tender = Tender::get()->filter(array(
			'ClientID' => Member::currentUserID(),
		))->sort('Created', 'DESC')->limit(1)->first();
		if($tender && $tender->State)
			return $tender->State;
		$location = Controller::curr()->getCurrentUserLocation();
		return $location['region_name'];
	}
	//Get the address string
	public function AddressString(){
		$address = array();
		if($this->owner->AddressLine1)
			$address[] = $this->owner->AddressLine1;
			
		if($this->owner->AddressLine2)
			$address[] = $this->owner->AddressLine2;
				
		if($this->owner->City)
			$address[] = $this->owner->City;
					
		if($this->owner->State)
			$address[] = $this->owner->State;
						
		if($this->owner->PostCode)
			$address[] = $this->owner->PostCode;
							
		if($this->owner->Country)
			$address[] = $this->owner->Country;
								
		$addressStr = '';
		foreach($address as $str){
			if($addressStr== '')
				$addressStr= $str;
			else
				$addressStr.= ",$str";
		}
								
		return $addressStr;
	}
}

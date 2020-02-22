<?php
class Tender extends DataObject {
	
	private static $db = array(
			'Title' => 'Varchar(255)',
			'Description' => 'Text',
			'AddressLine1' => 'Text',
			'AddressLine1Visible' => 'Boolean',
			'AddressLine2' => 'Text',
			'AddressLine2Visible' => 'Boolean',
			'City' => 'Varchar(100)',
			'CityVisible' => 'Boolean',
			'State' => 'Varchar(100)',
			'PostCode' => 'Varchar(100)',
			'Country' => 'Varchar(100)',
			'Latitude' => 'Float(10,6)',
			'Longitude' => 'Float(10,6)',
			'LacationRadius' => 'Float(10,6)',
			'ViewOnSite' => 'Boolean',
			'ViewOnSitePhone' => 'Varchar(30)',
			'PriceType' => 'Enum(array("ContractorToPropose","Fixed","Estimate"))',
			'TenderType' => 'Enum(array("Open","Closed"))',
			'AssessTenderControl' => 'Enum(array("PostEndDate","FirstInFirst"))',
			'StartDate' => 'SS_Datetime',
			'EndDate' => 'SS_Datetime',
			'EndDateNotify1' => 'Boolean',
			'EndDateNotify2' => 'Boolean',
			'Estimate' => 'Boolean',
			'ClientEstimate' => 'Float(10,2)',
			'CoverLetterRequired' => 'Boolean',
			'TenderDocRequired' => 'Boolean',
			'HealthSafetyPolicyRequired' => 'Boolean',
			'DrawingsRequired' => 'Boolean',
			'OthersRequired' => 'Boolean',
			'OthersText' => 'Varchar(150)',
			'ClientAdvertiseCost' => 'Float(10,2)',
			'Status' => 'Enum(array("Blank","Pending","Paid","Free","Fail","Cancel"))',
			'Stage' => 'Enum(array("Pending","Assess","Awarded","Archive"))'
			
	);
	
	private static $has_one = array(
			'Client' => 'Member',
			'Category' => 'Category',
			'ScheduleOfPrices' => "File",
			'Specifications' => "File",
			'Drawings' => "File",
			'TermsOfPayment' => "File",
			'StandardConditions' => "File",
			'SpecialConditions' => "File",
			'ConditionsOfTendering' => "File"

	);

	private static $has_many = array(
			'Submissions' => 'Submission',
			'Images'	=> 'TenderImage',
			'Videos'	=> 'TenderVideo'
	);
	
	private static $many_many = array(
			'ScheduleOfPricesV2' => "File",
			'SpecificationsV2' => "File",
			'DrawingsV2' => "File",
			'TermsOfPaymentV2' => "File",
			'StandardConditionsV2' => "File",
			'SpecialConditionsV2' => "File",
			'ConditionsOfTenderingV2' => "File"
	);

    private static $summary_fields = [
            'Title',
            'Description',
            'TenderType',
            'StartDate',
            'TendersCount',
    ];

	private static $searchable_fields = [
			'StartDate',
			'EndDate',
			'ClientID',
			'CategoryID',
			'Status',
			'Stage'
	];

	private static $field_labels = [
			'ClientID' => 'Client',
			'CategoryID' => 'Category',
            'TendersCount' => 'Tender Submissions',
	];

	public function getCMSFields() {
		$fields = parent::getCMSFields();
		$tenderRef = new ReadonlyField('ID','Tender Reference Number');
		$fields->addFieldToTab('Root.Main', $tenderRef,'Title');
		return $fields;
	}

	public function scaffoldSearchFields($_params = NULL){
		$fields = parent::scaffoldSearchFields();
		$cats = Category::get()->map()->toArray();
		$catDD = DropdownField::create('CategoryID', 'Category')->setSource($cats);
		$fields->replaceField('CategoryID', $catDD);
		return $fields;
	}
	// If current member watching this tender not yet submitted
	public function Watching(){
		$memberId = Member::currentUserID();
		$watching = Watching::get()->filter(array(
				'ContractorID' => $memberId,
				'TenderID' => $this->ID,
				'SubmissionID' => 0
		))->first();
		if($watching)
			return $watching;
		return false;
	}
	// If current member watching this tender
	public function WatchingV2(){
		$memberId = Member::currentUserID();
		$watching = Watching::get()->filter(array(
				'ContractorID' => $memberId,
				'TenderID' => $this->ID
		))->first();
		if($watching)
			return $watching;
		return false;
	}
	//Get if one of the additional info added
	public function AdditionalInfo(){
		if($this->ScheduleOfPricesV2()->count() > 0)
			return true;
		if($this->SpecificationsV2()->count() > 0)
			return true;
		if($this->DrawingsV2()->count() > 0)
			return true;
		if($this->TermsOfPaymentV2()->count() > 0)
			return true;
		if($this->StandardConditionsV2()->count() > 0)
			return true;
		if($this->SpecialConditionsV2()->count() > 0)
			return true;
		if($this->ConditionsOfTenderingV2()->count() > 0)
			return true;
		return false;
	}
	//Get the count of documents uploaded
	public function DocsUploadedCount(){
		$count = $this->ScheduleOfPricesV2()->count();
		$count += $this->SpecificationsV2()->count();
		$count += $this->DrawingsV2()->count();
		$count += $this->TermsOfPaymentV2()->count();
		$count += $this->StandardConditionsV2()->count();
		$count += $this->SpecialConditionsV2()->count();
		$count += $this->ConditionsOfTenderingV2()->count();
		return $count;
	}
	//Get if one of the required info requested
	public function RequiredInfo(){
		if($this->ScheduleOfPricesV2()->count() > 0)
			return true;
		if($this->CoverLetterRequired)
			return true;
		if($this->TenderDocRequired)
			return true;
		if($this->HealthSafetyPolicyRequired)
			return true;
		if($this->DrawingsRequired)
			return true;
		if($this->OthersRequired)
			return true;
		return false;
	}
	//Find if tender expired
	public function Expired(){
		if(strtotime($this->EndDate) < time())
			return true;
		return false;
	}
	//Get the submit price for the tender
	public function SubmitPrice(){
		$price = 1;
		if($this->Estimate)
			$price++;
		if($this->ScheduleOfPricesV2()->count() > 0)
			$price += $this->ScheduleOfPricesV2()->count();
		if($this->SpecificationsV2()->count() > 0)
			$price += $this->SpecificationsV2()->count();
		if($this->DrawingsV2()->count() > 0)
			$price += $this->DrawingsV2()->count();
		if($this->TermsOfPaymentV2()->count() > 0)
			$price += $this->TermsOfPaymentV2()->count();
		if($this->StandardConditionsV2()->count() > 0)
			$price += $this->StandardConditionsV2()->count();
		if($this->SpecialConditionsV2()->count() > 0)
			$price += $this->SpecialConditionsV2()->count();
		if($this->ConditionsOfTenderingV2()->count() > 0)
			$price += $this->ConditionsOfTenderingV2()->count();
		if($price > 1)
			 $price--;
		return $price;
	}
	//Get awarded submission
	public function SubmissionAwarded(){
		return Submission::get()->filter(array(
				'TenderID' => $this->ID,
				'Stage' => 'Awarded'
		))->first();
	}
	//Get archived submission
	public function SubmissionArchived(){
		return Submission::get()->filter(array(
				'TenderID' => $this->ID,
				'Stage' => 'Archive'
		))->first();
	}
	//Get submissions to be assessed
	public function SubmissionsAssess(){
		return $this->Submissions()->filter(array(
				'Status' => 'Paid',
				'Stage' => 'Assess',
		))->sort('Created','Desc');
	}
	//To find if member submitted tender
	public function TenderSubmitted(){
		return Submission::get()->filter(array(
				'TenderID' => $this->ID,
				'ContractorID' => Member::currentUserID()
		))->exclude(array(
			'Status' => 'Blank'	
		))->first();
	}
	
	public function HelpTip($inputName){
		
		return Controller::curr()->HelpTip($inputName);
		
	}
	//Get the address string
	public function AddressString(){
		$address = array();
		if($this->AddressLine1Visible)
			$address[] = $this->AddressLine1;
		
		if($this->AddressLine2Visible)
			$address[] = $this->AddressLine2;
			
		if($this->CityVisible)
			$address[] = $this->City;
			
		if($this->State)
			$address[] = $this->State;
			
		if($this->PostCode)
			$address[] = $this->PostCode;
			
		if($this->Country)
			$address[] = $this->Country;
		
		$addressStr = '';
		foreach($address as $str){
			if($addressStr== ''){
				if($this->revealAddress())
					$addressStr= $str;
				else
					$addressStr = 'xxxxxxx';
			}else{
				$addressStr.= ",$str";
			}
		}
		
		return $addressStr;
	}
	//View on site phone v2
	public function ViewOnSitePhoneV2(){
		if($this->revealPhone()){
			return $this->ViewOnSitePhone;
		}else{
			$phone = substr($this->ViewOnSitePhone, 5);
			return 'xxxxx'.$phone;
		}
	}
	//Get the region address string
	public function RegionAddressString(){
		$address = array();

		if($this->State)
			$address[] = $this->State;
						
		if($this->PostCode)
			$address[] = $this->PostCode;
						
		if($this->Country)
			$address[] = $this->Country;
								
		$addressStr = '';
		foreach($address as $str){
			if($addressStr== '')
				$addressStr= $str;
			else
				$addressStr.= ",$str";
		}
								
		return $addressStr;
	}
	//Get visible Latitude
	public function RegionLatitude(){
		$addressStr = str_replace(' ', '+', $this->RegionAddressString());
		$addressStr = str_replace(',', '+', $addressStr);
		$location = Controller::curr()->getLocation($addressStr);
		if($location)
			return $location['lat'];
		return false;
	}
	//Get visible Longitude
	public function RegionLongitude(){
		$addressStr = str_replace(' ', '+', $this->RegionAddressString());
		$addressStr = str_replace(',', '+', $addressStr);
		$location = Controller::curr()->getLocation($addressStr);
		if($location)
			return $location['lng'];
		return false;
	}
	//Find if region - only region is viewable
	public function IsRegion(){
		$region = true;
		if($this->AddressLine1Visible)
			$region = false;

		if($this->AddressLine2Visible)
			$region = false;

		return $region;
	}

    public function TendersCount() {
        return $this->Submissions()->count();
    }
    //Get the tender advertise cost
    public function getTenderAdvertiseCost(){
    	$config = SiteConfig::current_site_config();
    	$maxTenderCost = $config->MaxTenderCost;
    	return ($this->ClientAdvertiseCost > $maxTenderCost)? $maxTenderCost: $this->ClientAdvertiseCost;
    }
    //Find if address can be revealed for the current member
    public function revealAddress(){
    	if(!$this->AddressLine1 && !$this->AddressLine2)
    		return true;
    	if(!$this->AddressLine1Visible && !$this->AddressLine2Visible)
    		return true;
    	$member = Member::currentUser();
    	if(!$member)
    		return false;
    	if($this->ClientID == $member->ID)
    		return true;
    	$reveal = Reveal::get()->filter(array(
    			'ContractorID' => $member->ID,
    			'TenderID' => $this->ID
    	))->first();
    	if($reveal && $reveal->RevealAddress)
    		return true;
    	return false;
    }
    //Find if phone number can be revealed for the current member
    public function revealPhone(){
    	$member = Member::currentUser();
    	if(!$member)
    		return false;
    	if($this->ClientID == $member->ID)
    		return true;
    	$reveal = Reveal::get()->filter(array(
    		'ContractorID' => $member->ID,
    		'TenderID' => $this->ID
    	))->first();
    	if($reveal && $reveal->RevealPhone)
    		return true;
    	return false;
    }
    //Get reveal object
    public function Reveal(){
    	$member = Member::currentUser();
    	$reveal = Reveal::get()->filter(array(
    		'ContractorID' => $member->ID,
    		'TenderID' => $this->ID
    	))->first();
    	if($reveal)
    		return $reveal;
    	return false;
    }
}

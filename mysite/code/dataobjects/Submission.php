<?php
class Submission extends DataObject {
	
	private static $db = array(
			'PriceSubmitted' => 'Float(10,2)',
			'Clarifications' => 'Text',
			'SpecificationsRead' => "Boolean",
			'DrawingsRead' => "Boolean",
			'TermsOfPaymentRead' => "Boolean",
			'StandardConditionsRead' => "Boolean",
			'SpecialConditionsRead' => "Boolean",
			'ConditionsOfTenderingRead' => "Boolean",
			'ContractorTenderCost' => 'Float(10,2)',
			'Status' => 'Enum(array("Blank","Pending","Paid","Free","Fail","Cancel"))',
			'Stage' => 'Enum(array("Pending","Assess","Awarded","Archive"))',
			'ContractAwarded' => "Boolean"
			
	);
	
	private static $has_one = array(
			'Contractor' => 'Member',
			'Client' => 'Member',
			'Tender' => 'Tender',
			'ScheduleOfPrices' => 'File',
			'CoverLetter' => 'File',
			'TenderDocument' => 'File',
			'HealthSafetyPolicy' => 'File',
			'Drawings' => 'File',
			'OtherDocument' => 'File',
			'Quote' => 'File'
	);
	
	private static $many_many = array(
			'ScheduleOfPricesV2' => "File",
			'CoverLetterV2' => 'File',
			'TenderDocumentV2' => 'File',
			'HealthSafetyPolicyV2' => 'File',
			'DrawingsV2' => 'File',
			'OtherDocumentV2' => 'File',
			'QuoteV2' => 'File'
	);
	
	//Get if one of the additional info added
	public function AdditionalInfo(){
		if($this->ScheduleOfPricesV2()->count() > 0)
			return true;
		if($this->CoverLetterV2()->count() > 0)
			return true;
		if($this->TenderDocumentV2()->count() > 0)
			return true;
		if($this->HealthSafetyPolicyV2()->count() > 0)
			return true;
		if($this->DrawingsV2()->count() > 0)
			return true;
		if($this->OtherDocumentV2()->count() > 0)
			return true;
		return false;
	}
	
	public function ViewDocsSubmitted(){
		if($this->Tender()->AssessTenderControl == 'FirstInFirst')
			return true;
		if($this->Tender()->Expired())
			return true;
		return false;
	}
	//Winning tender
	public function WonTender(){
		return Submission::get()->filter(array(
				'TenderID' => $this->TenderID,
				'Stage' => 'Awarded'
		))->first();
		
	}
	
	//Subtract two numbers
	public function Subtract($var1,$var2){
		
		return $var1-$var2;
		
	}
	//Get all questions & answers
	public function getQuestionsAndAnswers($tenderId,$contId=null,$bq=false){
		$tender = Tender::get()->byID($tenderId);
		if(!$tender)
			return false;
		$clientId = $tender->ClientID;
		$memberId = Member::currentUserID();
		if($bq && ($clientId == $memberId)){
			$filter = array(
					'TenderID' => $tenderId,
					'Status' => 0
			);
			if($contId)
				$filter['ContractorID'] = $contId;
			$blankQuestion = QuestionAndAnswer::get()->filter($filter)->where('Question IS NULL')->first();
		
			if(!$blankQuestion){
				$blankQuestion = new QuestionAndAnswer();
				$blankQuestion->TenderID = $tenderId;
				if($contId)
					$blankQuestion->ContractorID= $contId;
				$blankQuestion->write();
			}
		}
		
		if($contId == null){
			$qas = QuestionAndAnswer::get()
			->filter(
					array(
							'TenderID' => $tenderId
					));
			
			if(!$bq){
				$qas = $qas->filter(array('Status' => 1));
			}
			
			$qas = $qas->sort('Created', 'DESC');
			
			return $qas;
		}
		
		$qas = QuestionAndAnswer::get()
		->filter(
				array(
						'TenderID' => $tenderId
				))->filterAny(
						array(
								'ContractorID' => $contId,
								'Public' => 1
						));
				
		if(!$bq){
			$qas = $qas->filter(array('Status' => 1));
		}
		
		$qas = $qas->sort('Created', 'DESC');
		
		return $qas;
		
	}
	//Generate a Question and Answer ID and put in session
	public function QandAID(){
		$key = $this->TenderID.'-'.$this->ID;
		$qandaIds = Session::get('QandAIDArr');
		$qandaIds = unserialize($qandaIds);
		if($qandaIds){
			if (array_key_exists($key,$qandaIds)){
				return $qandaIds[$key];
			}else{
				$qanda = new QuestionAndAnswer();
				$qanda->Status = 0;
				$qanda->write();
				$qandaIds[$key] = $qanda->ID;
				Session::clear('QandAIDArr');
				$qandaIds = serialize($qandaIds);
				Session::set('QandAIDArr', $qandaIds);
				return $qanda->ID;
			}
		}else{
			$qandaIds = array();
			$qanda = new QuestionAndAnswer();
			$qanda->Status = 0;
			$qanda->write();
			$qandaIds[$key] = $qanda->ID;
			$qandaIds = serialize($qandaIds);
			Session::set('QandAIDArr', $qandaIds);
			return $qanda->ID;
		}
	}
	//Get a help tip corresponding to a form field
	public function HelpTip($inputName){
		
		return Controller::curr()->HelpTip($inputName);
		
	}
	//Get the rating of the contractor
	public function ConRating(){
		return UserRating::get()->filter(array(
				'SubmissionID' => $this->ID,
				'RatedForID' => $this->ContractorID
		))->first();
	}
	//Get the rating of the client
	public function ClientRating(){
		return UserRating::get()->filter(array(
				'SubmissionID' => $this->ID,
				'RatedForID' => $this->ClientID
		))->first();
	}
	//Get the submission cost
	public function getSubmissionCost(){
		$config = SiteConfig::current_site_config();
		$maxTenderCost = $config->MaxTenderCost;
		return ($this->ContractorTenderCost > $maxTenderCost)? $maxTenderCost: $this->ContractorTenderCost;
	}
	
}
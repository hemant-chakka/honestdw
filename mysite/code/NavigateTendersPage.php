<?php

class NavigateTendersPage extends Page {
	
	//get all awarded tenders
	public function getAwardedTenders(){
		$member = Member::currentUser();
		
		$tenders = Tender::get()->filter(array(
				'ClientID' => $member->ID,
				'Stage' => 'Awarded'
		))->sort(array(
				'Created'=>'DESC'
		));

		return $tenders;
	}
	//get all tenders to be assessed
	public function getToAssessTenders(){
		$date = new DateTime();
		$today = $date->format('Y-m-d H:i:s');
		$memberId = Member::currentUserID();
		return $tenders = Tender::get()->filter(array(
				'ClientID' => $memberId,
				'Status' => array('Paid','Free'),
				'Stage' => 'Assess'
		))->filterAny(array(
				'EndDate:LessThanOrEqual' => $today,
				'AssessTenderControl' => 'FirstInFirst'
		))->sort('Created','DESC');
	}
	//get all tenders in progress
	public function getInProgressTenders(){
		$date = new DateTime();
		$today = $date->format('Y-m-d H:i:s');
		$memberId = Member::currentUserID();
		return $tenders = Tender::get()->filter(array(
				'ClientID' => $memberId,
				'Status' => array('Paid','Free'),
				'Stage' => 'Assess',
				'EndDate:GreaterThan' => $today
		))->sort('Created','DESC');
		
	}
	//get all pending tenders
	public function getPendingTenders(){
		$member = Member::currentUser();
		
		$tenders = Tender::get()->filter(array(
				'ClientID' => $member->ID,
				'Status' => 'Pending'
		))->sort(array(
				'Created'=>'DESC'
		));
		
		return $tenders;
	}
	//get all archived tenders
	public function getArchivedTenders(){
		$member = Member::currentUser();
		
		$tenders = Tender::get()->filter(array(
				'ClientID' => $member->ID,
				'Stage' => 'Archive'
		))->sort(array(
				'Created'=>'DESC'
		));
		
		return $tenders;
	}
	//get all the watching tenders
	public function getWatching(){
		$member = Member::currentUser();
		return Watching::get()->filter(array(
				'ContractorID' => $member->ID
		))->sort('Created','DESC');
	}
	//get all won tenders
	public function getWonTenders(){
		$member = Member::currentUser();
		
		$submissions = Submission::get()->filter(array(
				'ContractorID' => $member->ID,
				'Stage' => 'Awarded'
		))->sort(array(
				'Created'=>'DESC'
		));
		
		return $submissions;
	}
	//get all lost tenders
	public function getLostTenders(){
		$member = Member::currentUser();
		$memberId = $member->ID;
		$results = DB::query("SELECT Submission.ID from Submission INNER JOIN Tender ON Submission.TenderID = Tender.ID
				WHERE Submission.ContractorID = $memberId AND Submission.Stage = 'Assess' AND Tender.Stage = 'Awarded'");
		
		$idArr = array();
		if($results){
			foreach ($results as $result){
				$idArr[] = $result['ID'];
			}
			
			return Submission::get()->byIDs($idArr)->sort('Created','DESC');
			
		}
		return false;
	}
	//get all won tenders that are archived
	public function getWonTendersArchive(){
		$member = Member::currentUser();
		
		$submissions = Submission::get()->filter(array(
				'ContractorID' => $member->ID,
				'Stage' => 'Archive'
		))->sort(array(
				'Created'=>'DESC'
		));
		
		return $submissions;
	}
	//get all submisions that are pending
	public function getPendingSubmissions(){
		$member = Member::currentUser();
		
		$submissions = Submission::get()->filter(array(
				'ContractorID' => $member->ID,
				'Status' => 'Pending'
		))->sort(array(
				'Created'=>'DESC'
		));
		
		return $submissions;
	}

}
class NavigateTendersPage_Controller extends Page_Controller {
	
	private static $allowed_actions = array(
			'awarded',
			'toassess',
			'inprogress',
			'archives',
			'watching',
			'won',
			'lost',
			'wonarchive',
			'pending',
			'submitpending',
			'searchUsers',
			'notifyUserClosedTender',
			'notifyGuestClosedTender',
			'rateContractor',
			'rateClient'
	);
	
	public function init()
	{
		parent::init();
		
		$minCloseDate = $this->minCloseDate();
		$maxCloseDate = $this->maxCloseDate();
		
		Requirements::customScript(<<<JS
				
			var minCloseDate = '$minCloseDate';
				
			var maxCloseDate = '$maxCloseDate';
				
				
JS
				);
		Requirements::css('themes/hdwork/css/uploadfile.css');
		Requirements::javascript('themes/hdwork/javascript/jquery.uploadfile.min.js');
		Requirements::javascript('mysite/js/navigate-tenders.js');
	}
	//Search users to notify closed tender
	public function searchUsers(){
		$data = $_POST;
		if(!$data['Keyword'] && !$data['Region']){
			$this->setMessage('danger', "Please enter alteast one of the fields 'Keyword' or 'Region'.");
			return $this->redirectBack();
		}
		$searchArr = array();
		
		if($keyword = $data['Keyword']){
			$searchArr['FirstName:PartialMatch'] = $keyword;
			$searchArr['Surname:PartialMatch'] = $keyword;
			$searchArr['TradeUserName:PartialMatch'] = $keyword;
			$searchArr['PhoneNumber:PartialMatch'] = $keyword;
		}
		
		if($region = $data['Region']){
			$searchArr['Address:PartialMatch'] = $region;
		}
		
		$members = Member::get()->filterAny($searchArr);
		Requirements::customScript(<<<JS

			$( document ).ready(function() {
  				$('#memberList').modal('show');
			});
				
JS
		);
		
		$data2 = array(
				'MemberList' => $members,
				'TenderID' => $data['TenderID']
		);
		
		return $this->customise($data2)->renderWith(array('NavigateTendersPage_inprogress','Page'));
	}
	// Notify a user about closed tender
	public function notifyUserClosedTender(){
		$data = $_REQUEST;
		$user = Member::get()->filter(array(
				'Email' => $data['email']
		))->first();
		$tender = Tender::get()->byID($data['tenderId']);
		$tenderTitle = $tender->Title;
		$tenderId = $data['tenderId'];
		//send email
		$email = new Email();
		$email
		->setTo($data['email'])
		->setSubject("Job for Pricing, Closed Tender: $tenderTitle, $tenderId")
		->setTemplate('JobForPricingCTEmail')
		->populateTemplate(new ArrayData(array(
				'Tender' => $tender
		)));
		if ($email->send()) {
			echo "The user is notified.";
		} else {
			echo "Email could not be sent, please try later.";
		}
		die();
	}
	// Notify a guest/admin about closed tender
	public function notifyGuestClosedTender(){
		$data = $_POST;
		if(!$data['Email'] && !$data['NamePhone']){
			$this->setMessage('danger', "Please enter alteast one of the fields 'Email' or 'Name & Phone'.");
			return $this->redirectBack();
		}
		$tender = Tender::get()->byID($data['TenderID']);
		//Send email
		if($emailAddress = $data['Email']){
			//send email
			$tenderTitle = $tender->Title;
			$tenderId = $data['tenderId'];
			$email = new Email();
			$email
			->setTo($emailAddress)
			->setSubject("Job for Pricing, Closed Tender: $tenderTitle, $tenderId")
			->setTemplate('JobForPricingCTEmail')
			->populateTemplate(new ArrayData(array(
					'Tender' => $tender
			)));
			if($email->send())
				$this->setMessage('success', "The guest has been notified.");
			else
				$this->setMessage('danger', "The guest could not be notified,try again.");
		}
		$curMember = Member::currentUser();
		if($data['NamePhone']){
			$email = new Email();
			$email
			->setFrom('admin@honestdayswork.nz')
			->setTo('admin@honestdayswork.nz')
			->setSubject('New Invitation')
			->setTemplate('NotifyAdminCTEmail')
			->populateTemplate(new ArrayData(array(
					'Contact' => $data['NamePhone'],
					'Tender' => $tender,
					'Member' => $curMember,
					'TenderUrl' => Director::absoluteBaseURL()."tender/view/".$tender->ID
			)));
			if($email->send())
				$this->setMessage('success', "The guest will be notified by Honest Days Work.");
			else
				$this->setMessage('danger', "Honest Days Work could not be notified,try again.");
		}
		return $this->redirect('/navigate-tenders/client/inprogress/');
	}
	//Rate Contractor
	public function rateContractor(){
		$data = $_POST;
		if(!$data['Rating']){
			$this->setMessage('danger', "Please rate the Contractor.");
			return $this->redirectBack();
		}
		$rating = new UserRating();
		$rating->Rating = $data['Rating'];
		if($data['Comment'])
			$rating->Comment= $data['Comment'];
		$rating->RatedByID = Member::currentUserID();
		$rating->RatedForID = $data['ContractorID'];
		$rating->TenderID = $data['TenderID'];
		$rating->SubmissionID= $data['SubmissionID'];
		$rating->write();
		$this->setMessage('success', "Rated the Contractor successfully,Thanks.");
		return $this->redirectBack();
	}
	//Rate Client
	public function rateClient(){
		$data = $_POST;
		if(!$data['Rating']){
			$this->setMessage('danger', "Please rate the Client.");
			return $this->redirectBack();
		}
		$rating = new UserRating();
		$rating->Rating = $data['Rating'];
		if($data['Comment'])
			$rating->Comment= $data['Comment'];
		$rating->RatedByID = Member::currentUserID();
		$rating->RatedForID = $data['ClientID'];
		$rating->TenderID = $data['TenderID'];
		$rating->SubmissionID= $data['SubmissionID'];
		$rating->write();
		$this->setMessage('success', "Rated the Client successfully,Thanks.");
		return $this->redirectBack();
	}
	

}

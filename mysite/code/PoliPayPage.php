<?php

class PoliPayPage extends Page {
	
}
class PoliPayPage_Controller extends Page_Controller {
	
	private static $allowed_actions = array(
			'pay',
			'success',
			'failure',
			'cancelled',
			'nudge'
	);
	
	public function init() {
		parent::init();
	}
	
	private static $url_handlers = array(
			'poli-pay/$Action/$ID' => 'pay',
	);
	
	public function pay(){
		$siteUrl = Director::absoluteBaseURL();
		$refId = $this->getRequest()->param('ID');
		if($_GET['payer'] == 'client'){
			$tender = Tender::get()->byID($refId);
			$amount = $tender->ClientAdvertiseCost;
			$successUrl = $siteUrl.'poli-pay/success?tenderId='.$refId;
			$failureUrl = $siteUrl.'poli-pay/failure?tenderId='.$refId;
			$cancelUrl = $siteUrl.'poli-pay/cancelled?tenderId='.$refId;
			$notifylUrl = $siteUrl.'poli-pay/nudge?tenderId='.$refId;
		}
		
		if($_GET['payer'] == 'contractor'){
			$submission = Submission::get()->byID($refId);
			$amount = $submission->ContractorTenderCost;
			$successUrl = $siteUrl.'poli-pay/success?submitId='.$refId;
			$failureUrl = $siteUrl.'poli-pay/failure?submitId='.$refId;
			$cancelUrl = $siteUrl.'poli-pay/cancelled?submitId='.$refId;
			$notifylUrl = $siteUrl.'poli-pay/nudge?submitId='.$refId;
		}
		
		if($_GET['payer'] == 'member'){
			$submission = Submission::get()->byID($refId);
			$member = Member::get()->byID($refId);
			$amount = $_GET['amount'];
			$successUrl = $siteUrl.'poli-pay/success?memberId='.$refId;
			$failureUrl = $siteUrl.'poli-pay/failure?memberId='.$refId;
			$cancelUrl = $siteUrl.'poli-pay/cancelled?memberId='.$refId;
			$notifylUrl = $siteUrl.'poli-pay/nudge?memberId='.$refId;
		}
		$sitePath = Director::baseFolder();
		
		$json_builder = "{
  			'Amount':'$amount',
  			'CurrencyCode':'NZD',
  			'MerchantReference':'$refId',
  			'MerchantHomepageURL':'$siteUrl',
  			'SuccessURL':'$successUrl',
  			'FailureURL':'$failureUrl',
  			'CancellationURL':'$cancelUrl',
  			'NotificationURL':'$notifylUrl'
		}";
		
		$auth = base64_encode('SS64007324:xQ9!6Eg!hXl$2');
		$header = array();
		$header[] = 'Content-Type: application/json';
		$header[] = 'Authorization: Basic '.$auth;
		
		$ch = curl_init("https://poliapi.apac.paywithpoli.com/api/v2/Transaction/Initiate");
		//See the cURL documentation for more information: http://curl.haxx.se/docs/sslcerts.html
		//We recommend using this bundle: https://raw.githubusercontent.com/bagder/ca-bundle/master/ca-bundle.crt
		curl_setopt( $ch, CURLOPT_CAINFO, $sitePath.DIRECTORY_SEPARATOR."ca-bundle.crt");
		curl_setopt( $ch, CURLOPT_SSLVERSION, CURL_SSLVERSION_TLSv1_2);
		curl_setopt( $ch, CURLOPT_HTTPHEADER, $header);
		curl_setopt( $ch, CURLOPT_HEADER, 0);
		curl_setopt( $ch, CURLOPT_POST, 1);
		curl_setopt( $ch, CURLOPT_POSTFIELDS, $json_builder);
		curl_setopt( $ch, CURLOPT_FOLLOWLOCATION, 0);
		curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1);
		$response = curl_exec( $ch );
		//echo 'error:' . curl_error($ch);
		curl_close ($ch);
		$json = json_decode($response, true);
		return $this->redirect($json["NavigateURL"]);
	}
	//Success handler
	public function success(){
		if(isset($_GET['tenderId']))
			$this->setMessage('success', 'Tender created/Payment made successfully');
		if(isset($_GET['submitId']))
			$this->setMessage('success', 'Tender submitted/Payment made successfully');
		if(isset($_GET['memberId']))
			$this->setMessage('success', 'Payment made successfully');
		$data = array('Title'=>'Payment Successfull');
		return $this->customise($data)->renderWith(array('Page','Page'));
	}
	//Failure handler
	public function failure(){
		if(isset($_GET['tenderId']))
			$this->setMessage('danger', 'Tender created,but Payment failed');
		if(isset($_GET['submitId']))
			$this->setMessage('danger', 'Tender submitted,but Payment failed');
		if(isset($_GET['memberId']))
			$this->setMessage('danger', 'Payment failed');
		$data = array('Title'=>'Payment Failed');
		return $this->customise($data)->renderWith(array('Page','Page'));
	}
	//Cancellation handler
	public function cancelled(){
		if(isset($_GET['tenderId']))
			$this->setMessage('danger', 'Tender created,but Payment cancelled');
		if(isset($_GET['submitId']))
			$this->setMessage('danger', 'Tender submitted,but Payment cancelled');
		if(isset($_GET['memberId']))
			$this->setMessage('danger', 'Payment cancelled');
		$data = array('Title'=>'Payment Cancelled');
		return $this->customise($data)->renderWith(array('Page','Page'));
	}
	//Notification handler
	public function nudge(){
		$sitePath = Director::baseFolder();
		//Get transaction details
		$token = $_POST["Token"];
		if(is_null($token)) {
			$token = $_GET["token"];
		}
		$auth = base64_encode('SS64007324:xQ9!6Eg!hXl$2');
		$header = array();
		$header[] = 'Authorization: Basic '.$auth;
		$ch = curl_init("https://poliapi.apac.paywithpoli.com/api/v2/Transaction/GetTransaction?token=".urlencode($token));
		//See the cURL documentation for more information: http://curl.haxx.se/docs/sslcerts.html
		//We recommend using this bundle: https://raw.githubusercontent.com/bagder/ca-bundle/master/ca-bundle.crt
		curl_setopt( $ch, CURLOPT_CAINFO, $sitePath.DIRECTORY_SEPARATOR."ca-bundle.crt");
		curl_setopt( $ch, CURLOPT_SSLVERSION, CURL_SSLVERSION_TLSv1_2);
		curl_setopt( $ch, CURLOPT_HTTPHEADER, $header);
		curl_setopt( $ch, CURLOPT_HEADER, 0);
		curl_setopt( $ch, CURLOPT_POST, 0);
		curl_setopt( $ch, CURLOPT_FOLLOWLOCATION, 0);
		curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1);
		$response = curl_exec( $ch );
		curl_close ($ch);
		$json = json_decode($response, true);
		
		if(isset($_GET['tenderId'])){
			$tenderId = $_GET['tenderId'];
			//Update/create database
			$tender = Tender::get()->byID($tenderId);
			if($json['TransactionStatusCode'] == 'Completed'){
				$tender->Status = 'Paid';
				$tender->Stage = 'Assess';
			}
			if($json['TransactionStatusCode'] == 'Failed')
				$tender->Status = 'Fail';
			if($json['TransactionStatusCode'] == 'Cancelled')
				$tender->Status = 'Cancel';
			$tender->write();
			if($json['TransactionStatusCode'] == 'Completed'){
				// Create a payment record credit for this tender
				$member = Member::get()->byID($tender->ClientID);
				$payment = new Payment();
				$payment->TransactionRef= 'Credit';
				$payment->Method = 'Credit';
				$payment->Credit = $tender->getTenderAdvertiseCost();
				$payment->MemberID = $member->ID;
				$payment->TenderID = $tender->ID;
				$payment->SubmissionID = 0;
				$payment->write();
				// Create a payment record for outstanding credit paid
				$payment = new Payment();
				$payment->Method = 'Credit';
				$payment->Credit = -($member->creditAvailed());
				$payment->MemberID = $tender->ClientID;
				$payment->TenderID = $tenderId;
				$payment->SubmissionID = 0;
				$payment->write();
				//Register the cron
				if($tender->TenderType == 'Open'){
					$cronJob = new CronJob();
					$cronJob->Cron = "NotifyContCron";
					$cronJob->Params = "$tenderId";
					$cronJob->Status = 1;
					$cronJob->write();
				}
			}
				
			$submitId = 0;
			$memberId = $tender->ClientID;
			$credit = $tender->getTenderAdvertiseCost();
			
		}

		if(isset($_GET['submitId'])){
			$submitId = $_GET['submitId'];
			//Update/create database
			$submission = Submission::get()->byID($submitId);
			if($json['TransactionStatusCode'] == 'Completed'){
				$submission->Status = 'Paid';
				$submission->Stage = 'Assess';
			}
			if($json['TransactionStatusCode'] == 'Failed')
				$submission->Status = 'Fail';
			if($json['TransactionStatusCode'] == 'Cancelled')
				$submission->Status = 'Cancel';
			$submission->write();
			if($json['TransactionStatusCode'] == 'Completed'){
				// Create a payment record credit for this tender
				$member = Member::get()->byID($submission->ContractorID);
				$payment = new Payment();
				$payment->TransactionRef= 'Credit';
				$payment->Method = 'Credit';
				$payment->Credit = $submission->getSubmissionCost();
				$payment->MemberID = $member->ID;
				$payment->TenderID = $submission->TenderID;
				$payment->SubmissionID = $submission->ID;
				$payment->write();
				// Create a payment record for outstanding credit paid
				$payment = new Payment();
				$payment->Method = 'Credit';
				$payment->Credit = -($member->creditAvailed());
				$payment->MemberID = $submission->ContractorID;
				$payment->TenderID = $submission->TenderID;
				$payment->SubmissionID = $submitId;
				$payment->write();
				//notify contractor
				$email = new Email();
				$email
				->setTo($submission->Contractor()->Email)
				->setSubject('Getting Work Priced')
				->setTemplate('TenderSubmittedEmail')
				->populateTemplate(new ArrayData(array(
						'Name' => $submission->Contractor()->Name
				)));
				$email->send();
				//notify client
				$email = new Email();
				$email
				->setTo($submission->Client()->Email)
				->setSubject('Getting Work Priced')
				->setTemplate('TenderSubmittedClientEmail')
				->populateTemplate(new ArrayData(array(
						'Name' => $submission->Contractor()->Name
				)));
				$email->send();
			}
			
			$tenderId = $submission->TenderID;
			$memberId = $submission->ContractorID;
			$credit = $submission->getSubmissionCost();
		}
		
		if(isset($_GET['memberId'])){
			if($json['TransactionStatusCode'] == 'Completed'){
				// Create a payment record
				$member = Member::get()->byID($_GET['memberId']);
				$payment = new Payment();
				$payment->TransactionRef= 'Credit';
				$payment->Method = 'Credit';
				$payment->Credit = -($json['AmountPaid']);
				$payment->MemberID = $member->ID;
				$payment->TenderID = 0;
				$payment->SubmissionID = 0;
				$payment->write();
			}
			$tenderId = 0;
			$submitId = 0;
			$memberId = $_GET['memberId'];
		}
		$payment = new Payment();
		$payment->TransactionRef= $json['TransactionRefNo'];
		$payment->Method = 'Polipay';
		$payment->MemberID = $memberId;
		$payment->TenderID = $tenderId;
		$payment->SubmissionID = $submitId;
		$payment->write();
	}
}

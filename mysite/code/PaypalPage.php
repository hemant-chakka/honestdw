<?php

class PaypalPage extends Page {
	
}
class PaypalPage_Controller extends Page_Controller {
	
	private static $allowed_actions = array(
			'success',
			'cancelled',
			'notify'
	);
	
	public function init() {
		parent::init();
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
	//Cancellation handler
	public function cancelled(){
		if(isset($_GET['tenderId']))
			$this->setMessage('danger', 'Tender created,but Payment cancelled');
		if(isset($_GET['submitId']))
			$this->setMessage('danger', 'Tender submitted,but Payment cancelled');
		if(isset($_GET['memberId']))
			$this->setMessage('danger', 'Payment is cancelled');
		$data = array('Title'=>'Payment Cancelled');
		return $this->customise($data)->renderWith(array('Page','Page'));
	}
	//Notifications handler
	public function notify(){
		if(isset($_GET['tenderId'])){
			$tenderId = $_GET['tenderId'];
			$payStatus = $_REQUEST['payment_status'];
			$txnId = $_REQUEST['txn_id'];
			//Update/create database
			$tender = Tender::get()->byID($tenderId);
			if($payStatus == 'Completed'){
				$tender->Status = 'Paid';
				$tender->Stage = 'Assess';
				$tender->write();
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
			if($payStatus == 'Denied'){
				$tender->Status = 'Fail';
				$tender->write();
			}
			// Create a payment record
			$payment = new Payment();
			$payment->TransactionRef= $txnId;
			$payment->Method = 'Paypal';
			$payment->MemberID = $tender->ClientID;
			$payment->TenderID = $tenderId;
			$payment->SubmissionID = 0;
			$payment->write();
		}
		
		if(isset($_GET['submitId'])){
			$submitId= $_GET['submitId'];
			$payStatus = $_REQUEST['payment_status'];
			$txnId = $_REQUEST['txn_id'];
			//Update/create database
			$submission= Submission::get()->byID($submitId);
			if($payStatus == 'Completed'){
				$submission->Status = 'Paid';
				$submission->Stage = 'Assess';
				$submission->write();
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
				->setTo($submission->Contractor()->Email)
				->setSubject('Getting Work Priced')
				->setTemplate('TenderSubmittedClientEmail')
				->populateTemplate(new ArrayData(array(
						'Name' => $submission->Client()->Name
				)));
				$email->send();
			}
			if($payStatus == 'Denied'){
				$submission->Status = 'Fail';
				$submission->write();
			}
			// Create a payment record
			$payment = new Payment();
			$payment->TransactionRef= $txnId;
			$payment->Method = 'Paypal';
			$payment->MemberID = $submission->ContractorID;
			$payment->TenderID = $submission->TenderID;
			$payment->SubmissionID = $submitId;
			$payment->write();
		}
		//Payment made by a member irrespective of any tender
		if(isset($_GET['memberId'])){
			$payStatus = $_REQUEST['payment_status'];
			$amount = $_REQUEST['mc_gross'];
			$txnId = $_REQUEST['txn_id'];
			$member = Member::get()->byID($_GET['memberId']);
			//Update/create database
			if($payStatus == 'Completed'){
				// Create a payment record for amount paid
				$payment = new Payment();
				$payment->TransactionRef= 'Credit';
				$payment->Method = 'Credit';
				$payment->Credit = -($amount);
				$payment->MemberID = $member->ID;
				$payment->TenderID = 0;
				$payment->SubmissionID = 0;
				$payment->write();
			}
			// Create a payment record
			$payment = new Payment();
			$payment->TransactionRef= $txnId;
			$payment->Method = 'Paypal';
			$payment->MemberID = $member->ID;
			$payment->TenderID = 0;
			$payment->SubmissionID = 0;
			$payment->write();
		}
	}
	
}

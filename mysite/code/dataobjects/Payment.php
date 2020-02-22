<?php
class Payment extends DataObject {
	
	private static $db = array(

			'Method' => 'Enum(array("Paypal","Polipay","Credit"))',
			'TransactionRef' => 'Varchar(255)',
			'Credit' => 'Float(10,2)'
	);
	
	private static $has_one = array(
			"Member" => "Member",
			"Tender" => "Tender",
			"Submission" => "Submission"
	);
	
	private static $summary_fields = array(
			'Member.Email',
			'Credit',
			'Created'
	);
	
	private static $searchable_fields = array(
			'MemberID'
	);
	
}